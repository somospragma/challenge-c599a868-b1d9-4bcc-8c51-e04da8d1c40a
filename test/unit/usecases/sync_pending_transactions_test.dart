import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:payment_app/core/errors/failures.dart';
import 'package:payment_app/domain/usecases/sync_pending_transactions.dart';
import 'package:payment_app/data/repositories/transaction_repository_impl.dart';

import 'mocks/mock_transaction_repository.dart';

@GenerateMocks([TransactionRepositoryImpl])
void main() {
  late MockTransactionRepositoryImpl repository;
  late SyncPendingTransactions usecase;

  setUp(() {
    repository = MockTransactionRepositoryImpl();
    usecase = SyncPendingTransactions(repository);
  });

  test('should sync pending transactions when called', () async {
    when(repository.syncPendingTransactions())
       .thenAnswer((_) async => Right(unit));

    final result = await usecase();

    verify(repository.syncPendingTransactions());
    expect(result, Right(unit));
  });

  test('should return a Failure when the repository fails', () async {
    when(repository.syncPendingTransactions())
       .thenAnswer((_) async => Left(ConnectionFailure('Connection error')));

    final result = await usecase();

    verify(repository.syncPendingTransactions());
    expect(result, Left(isA<ConnectionFailure>()));
  });
}