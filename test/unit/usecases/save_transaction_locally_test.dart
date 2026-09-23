import 'package:dartz/dartz.dart';
import 'package:drift/drift.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:payment_app/core/errors/failures.dart';
import 'package:payment_app/domain/entities/transaction_entity.dart';
import 'package:payment_app/domain/usecases/save_transaction_locally.dart';
import 'package:payment_app/data/repositories/transaction_repository_impl.dart';

import 'mocks/mock_transaction_repository.dart';

@GenerateMocks([TransactionRepositoryImpl])
void main() {
  late MockTransactionRepositoryImpl repository;
  late SaveTransactionLocally usecase;

  setUp(() {
    repository = MockTransactionRepositoryImpl();
    usecase = SaveTransactionLocally(repository);
  });

  final tTransactionEntity = TransactionEntity(
    id: '1',
    amount: 100.0,
    recipient: 'Recipient Name',
    timestamp: DateTime.now().millisecondsSinceEpoch,
    syncStatus: 'pending',
    idempotencyKey: 'idempotency-key-123',
  );

  test('should save transaction locally when called', () async {
    when(repository.saveTransactionLocally(tTransactionEntity))
       .thenAnswer((_) async => Right(unit));

    final result = await usecase(tTransactionEntity);

    verify(repository.saveTransactionLocally(tTransactionEntity));
    expect(result, Right(unit));
  });

  test('should return a Failure when the repository fails', () async {
    when(repository.saveTransactionLocally(tTransactionEntity))
       .thenAnswer((_) async => Left(DatabaseException('Database error')));

    final result = await usecase(tTransactionEntity);

    verify(repository.saveTransactionLocally(tTransactionEntity));
    expect(result, Left(isA<DatabaseException>()));
  });
}