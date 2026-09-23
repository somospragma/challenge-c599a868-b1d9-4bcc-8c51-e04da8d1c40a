import 'package:dartz/dartz.dart';
import 'package:payment_app/core/errors/failures.dart';
import 'package:payment_app/core/errors/exceptions.dart';
import 'package:payment_app/domain/entities/transaction_entity.dart';
import 'package:payment_app/domain/repositories/transaction_repository.dart';

class SyncPendingTransactions {
  final TransactionRepository repository;
  SyncPendingTransactions(this.repository);

  Future<Either<Failure, List<TransactionEntity>>> call() async {
    try {
      final pendingTransactions = await repository.getPendingTransactions();
      for (var transaction in pendingTransactions) {
        await repository.syncTransaction(transaction);
      }
      return Right(pendingTransactions);
    } on ConnectionException catch (e) {
      return Left(ConnectionFailure(message: e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, code: e.statusCode));
    } on SyncLatencyException catch (e) {
      return Left(SyncLatencyFailure(message: e.message, actualLatency: e.actualLatency));
    } catch (e) {
      return Left(GenericFailure(message: 'Error al sincronizar transacciones pendientes'));
    }
  }
}