import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:payment_app/core/network/connectivity_service.dart';
import 'package:payment_app/di/injection_container.dart' as di;
import 'package:payment_app/domain/repositories/transaction_repository.dart';
import 'package:payment_app/domain/usecases/check_transaction_idempotency.dart';
import 'package:payment_app/domain/usecases/get_pending_transactions.dart';
import 'package:payment_app/domain/usecases/save_transaction_locally.dart';
import 'package:payment_app/domain/usecases/sync_pending_transactions.dart';
import 'package:payment_app/presentation/blocs/connectivity/connectivity_bloc.dart';
import 'package:payment_app/presentation/blocs/transaction/transaction_bloc.dart';
import 'package:payment_app/presentation/screens/payment_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const PaymentApp());
}

class PaymentApp extends StatelessWidget {
  const PaymentApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ConnectivityBloc(
            connectivityService: GetIt.instance<ConnectivityService>(),
          )..add(CheckConnectivity()),
        ),
        BlocProvider(
          create: (context) => TransactionBloc(
            saveTransactionLocally: GetIt.instance<SaveTransactionLocally>(),
            syncPendingTransactions: GetIt.instance<SyncPendingTransactions>(),
            getPendingTransactions: GetIt.instance<GetPendingTransactions>(),
            checkTransactionIdempotency: GetIt.instance<CheckTransactionIdempotency>(),
            transactionRepository: GetIt.instance<TransactionRepository>(),
          )..add(LoadPendingTransactions()),
        ),
      ],
      child: MaterialApp(
        title: 'Payment App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const PaymentScreen(),
      ),
    );
  }
}