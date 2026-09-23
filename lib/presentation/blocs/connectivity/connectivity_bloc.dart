import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:payment_app/core/errors/failures.dart';
import 'package:payment_app/core/errors/exceptions.dart';
import 'package:payment_app/core/network/connectivity_service.dart';
import 'package:payment_app/core/utils/idempotency_generator.dart';
import 'package:payment_app/domain/usecases/sync_pending_transactions.dart';
import 'package:payment_app/domain/usecases/get_pending_transactions.dart';
import 'package:payment_app/domain/usecases/check_transaction_idempotency.dart';
import 'package:payment_app/domain/repositories/transaction_repository.dart';
import 'package:payment_app/lib/core/constants/app_constants.dart';
import 'connectivity_event.dart';
import 'connectivity_state.dart';

class ConnectivityBloc extends Bloc<ConnectivityEvent, ConnectivityState> {
  final ConnectivityService _connectivityService;
  final GetPendingTransactions _getPendingTransactions;
  final SyncPendingTransactions _syncPendingTransactions;
  final CheckTransactionIdempotency _checkTransactionIdempotency;
  final TransactionRepository _transactionRepository;
  final IdempotencyGenerator _idempotencyGenerator;
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  ConnectivityBloc({
    required ConnectivityService connectivityService,
    required GetPendingTransactions getPendingTransactions,
    required SyncPendingTransactions syncPendingTransactions,
    required CheckTransactionIdempotency checkTransactionIdempotency,
    required TransactionRepository transactionRepository,
    required IdempotencyGenerator idempotencyGenerator,
  })  : _connectivityService = connectivityService,
        _getPendingTransactions = getPendingTransactions,
        _syncPendingTransactions = syncPendingTransactions,
        _checkTransactionIdempotency = checkTransactionIdempotency,
        _transactionRepository = transactionRepository,
        _idempotencyGenerator = idempotencyGenerator,
        super(ConnectivityInitial()) {
    _connectivitySubscription = _connectivityService.connectivityStream.listen((connectivityResult) {
      if (connectivityResult == ConnectivityResult.none) {
        add(ConnectivityLost());
      } else {
        add(ConnectivityGained());
      }
    });
  }

  @override
  Stream<ConnectivityState> mapEventToState(ConnectivityEvent event) async* {
    if (event is ConnectivityGained) {
      yield* _handleConnectivityGained();
    } else if (event is ConnectivityLost) {
      yield ConnectivityOffline();
    }
  }

  Stream<ConnectivityState> _handleConnectivityGained() async* {
    yield ConnectivityChecking();
    final pendingTransactions = await _getPendingTransactions.execute();
    if (pendingTransactions.isRight()) {
      final transactions = pendingTransactions.getOrElse(() => []);
      for (final transaction in transactions) {
        final idempotencyCheck = await _checkTransactionIdempotency.execute(transaction.id);
        if (idempotencyCheck.isRight()) {
          await _syncPendingTransactions.execute(transaction);
        }
      }
    }
    yield ConnectivityOnline();
  }

  @override
  Future<void> close() {
    _connectivitySubscription.cancel();
    return super.close();
  }
}