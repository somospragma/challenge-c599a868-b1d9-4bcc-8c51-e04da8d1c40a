import 'package:dartz/dartz.dart';
import 'package:payment_app/core/errors/failures.dart';
import 'package:payment_app/domain/entities/transaction_entity.dart';
import 'package:payment_app/domain/repositories/transaction_repository.dart';

class CheckTransactionIdempotency {
  final TransactionRepository repository;

  CheckTransactionIdempotency(this.repository);

  Future<Either<Failure, bool>> call(String idempotencyKey) async {
    try {
      final transaction = await repository.getTransactionByIdempotencyKey(idempotencyKey);
      if (transaction!= null) {
        return Right(true);
      } else {
        return Right(false);
      }
    } on DatabaseException catch (e) {
      return Left(InvalidDataFailure('Error de base de datos: ${e.message}'));
    } on Exception catch (e) {
      return Left(GenericFailure('Error inesperado: ${e.toString()}'));
    }
  }
}