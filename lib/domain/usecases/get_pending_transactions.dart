import 'package:dartz/dartz.dart';
import 'package:payment_app/core/errors/failures.dart';
import 'package:payment_app/domain/entities/transaction_entity.dart';
import 'package:payment_app/domain/repositories/transaction_repository.dart';

class GetPendingTransactions {
  final TransactionRepository repository;
  GetPendingTransactions(this.repository);

  Future<Either<Failure, List<TransactionEntity>>> call() async {
    try {
      final pendingTransactions = await repository.getPendingTransactions();
      return Right(pendingTransactions);
    } catch (e) {
      return Left(GenericFailure(message: 'Error al obtener transacciones pendientes'));
    }
  }
}