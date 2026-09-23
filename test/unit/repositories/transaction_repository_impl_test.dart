import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:payment_app/core/errors/failures.dart';
import 'package:payment_app/data/models/transaction_model.dart';
import 'package:payment_app/data/repositories/transaction_repository_impl.dart';
import 'package:payment_app/data/datasources/local/transaction_local_datasource.dart';
import 'package:payment_app/data/datasources/remote/transaction_remote_datasource.dart';

import 'mocks/mock_transaction_local_datasource.dart';
import 'mocks/mock_transaction_remote_datasource.dart';

@GenerateMocks([TransactionLocalDatasource, TransactionRemoteDatasource])
void main() {
  late MockTransactionLocalDatasource localDatasource;
  late MockTransactionRemoteDatasource remoteDatasource;
  late TransactionRepositoryImpl repository;

  setUp(() {
    localDatasource = MockTransactionLocalDatasource();
    remoteDatasource = MockTransactionRemoteDatasource();
    repository = TransactionRepositoryImpl(localDatasource, remoteDatasource);
  });

  final tTransactionModel = TransactionModel(
    id: '1',
    amount: 100.0,
    recipient: 'Recipient Name',
    timestamp: DateTime.now().millisecondsSinceEpoch,
    syncStatus: 'pending',
    idempotencyKey: 'idempotency-key-123',
  );

  test('should save transaction locally when called', () async {
    when(localDatasource.saveTransactionLocally(tTransactionModel))
       .thenAnswer((_) async => Right(unit));

    final result = await repository.saveTransactionLocally(tTransactionModel);

    verify(localDatasource.saveTransactionLocally(tTransactionModel));
    expect(result, Right(unit));
  });

  test('should return a Failure when the local datasource fails', () async {
    when(localDatasource.saveTransactionLocally(tTransactionModel))
       .thenAnswer((_) async => Left(DatabaseException('Database error')));

    final result = await repository.saveTransactionLocally(tTransactionModel);

    verify(localDatasource.saveTransactionLocally(tTransactionModel));
    expect(result, Left(isA<DatabaseException>()));
  });

  test('should sync pending transactions when called', () async {
    when(localDatasource.getPendingTransactions())
       .thenAnswer((_) async => [tTransactionModel]);
    when(remoteDatasource.syncTransaction(tTransactionModel))
       .thenAnswer((_) async => Right(unit));
    when(localDatasource.updateTransactionSyncStatus(tTransactionModel, 'synced'))
       .thenAnswer((_) async => Right(unit));

    final result = await repository.syncPendingTransactions();

    verify(localDatasource.getPendingTransactions());
    verify(remoteDatasource.syncTransaction(tTransactionModel));
    verify(localDatasource.updateTransactionSyncStatus(tTransactionModel, 'synced'));
    expect(result, Right(unit));
  });

  test('should return a Failure when the remote datasource fails', () async {
    when(localDatasource.getPendingTransactions())
       .thenAnswer((_) async => [tTransactionModel]);
    when(remoteDatasource.syncTransaction(tTransactionModel))
       .thenAnswer((_) async => Left(ConnectionFailure('Connection error')));

    final result = await repository.syncPendingTransactions();

    verify(localDatasource.getPendingTransactions());
    verify(remoteDatasource.syncTransaction(tTransactionModel));
    expect(result, Left(isA<ConnectionFailure>()));
  });
}