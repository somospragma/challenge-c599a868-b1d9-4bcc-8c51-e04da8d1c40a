import 'package:flutter_bloc/flutter_bloc.dart';
import 'transaction_event.dart';
import 'transaction_state.dart';
import 'package:dartz/dartz.dart';
import 'package:payment_app/core/errors/failures.dart';
import 'package:payment_app/domain/usecases/save_transaction_locally.dart';
import 'package:payment_app/domain/usecases/sync_pending_transactions.dart';
import 'package:payment_app/domain/usecases/get_pending_transactions.dart';
import 'package:payment_app/domain/usecases/check_transaction_idempotency.dart';
import 'package:payment_app/core/utils/idempotency_generator.dart';
import 'package:payment_app/core/network/connectivity_service.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final SaveTransactionLocally saveTransactionLocally;
  final SyncPendingTransactions syncPendingTransactions;
  final GetPendingTransactions getPendingTransactions;
  final CheckTransactionIdempotency checkTransactionIdempotency;
  final ConnectivityService connectivityService;
  final IdempotencyGenerator idempotencyGenerator;

  TransactionBloc({
    required this.saveTransactionLocally,
    required this.syncPendingTransactions,
    required this.getPendingTransactions,
    required this.checkTransactionIdempotency,
    required this.connectivityService,
    required this.idempotencyGenerator,
  }) : super(TransactionInitial());

  @override
  Stream<TransactionState> mapEventToState(TransactionEvent event) async* {
    if (event is SaveTransactionEvent) {
      yield* _mapSaveTransactionEventToState(event);
    } else if (event is SyncTransactionsEvent) {
      yield* _mapSyncTransactionsEventToState();
    } else if (event is GetTransactionsEvent) {
      yield* _mapGetTransactionsEventToState();
    } else if (event is CheckIdempotencyEvent) {
      yield* _mapCheckIdempotencyEventToState(event);
    }
  }

  Stream<TransactionState> _mapSaveTransactionEventToState(SaveTransactionEvent event) async* {
    final idempotencyKey = idempotencyGenerator.generateIdempotencyKey();
    final result = await saveTransactionLocally(event.transaction, idempotencyKey);
    yield result.fold(
      (failure) => TransactionError(message: failure.message),
      (success) => TransactionSaved(transaction: event.transaction),
    );
  }

  Stream<TransactionState> _mapSyncTransactionsEventToState() async* {
    if (!connectivityService.isConnected) {
      yield TransactionError(message: 'No hay conexión a Internet.');
      return;
    }

    final result = await syncPendingTransactions();
    yield result.fold(
      (failure) => TransactionError(message: failure.message),
      (success) => TransactionsSynced(transactions: success),
    );
  }

  Stream<TransactionState> _mapGetTransactionsEventToState() async* {
    final result = await getPendingTransactions();
    yield result.fold(
      (failure) => TransactionError(message: failure.message),
      (transactions) => TransactionsLoaded(transactions: transactions),
    );
  }

  Stream<TransactionState> _mapCheckIdempotencyEventToState(CheckIdempotencyEvent event) async* {
    final result = await checkTransactionIdempotency(event.idempotencyKey);
    yield result.fold(
      (failure) => TransactionError(message: failure.message),
      (isIdempotent) => IdempotencyChecked(isIdempotent: isIdempotent),
    );
  }
}