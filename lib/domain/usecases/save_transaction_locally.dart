import 'package:dartz/dartz.dart';
import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';
import 'package:payment_app/core/errors/failures.dart';
import 'package:payment_app/core/errors/exceptions.dart';
import 'package:payment_app/domain/entities/transaction_entity.dart';
import 'package:payment_app/domain/repositories/transaction_repository.dart';

class SaveTransactionLocally {
  final TransactionRepository repository;
  SaveTransactionLocally(this.repository);

  Future<Either<Failure, Unit>> call(TransactionEntity transaction) async {
    try {
      final idempotencyKey = const Uuid().v4();
      final transactionWithIdempotency = transaction.copyWith(idempotencyKey: idempotencyKey);
      await repository.saveTransactionLocally(transactionWithIdempotency);
      return Right(unit);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(message: e.message));
    } on MaxPendingTransactionsException {
      return Left(MaxPendingTransactionsFailure());
    } catch (e) {
      return Left(GenericFailure(message: 'Error al guardar la transacción localmente'));
    }
  }
}