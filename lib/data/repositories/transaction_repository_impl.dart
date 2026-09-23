import 'package:dartz/dartz.dart';
import 'package:payment_app/core/errors/failures.dart';
import 'package:payment_app/domain/entities/transaction_entity.dart';
import 'package:payment_app/domain/repositories/transaction_repository.dart';
import 'package:payment_app/data/datasources/local/transaction_local_datasource.dart';
import 'package:payment_app/data/datasources/remote/transaction_remote_datasource.dart';

class TransactionRepositoryImpl implements TransactionRepository {
  final TransactionLocalDataSource _localDataSource;
  final TransactionRemoteDataSource _remoteDataSource;

  TransactionRepositoryImpl(this._localDataSource, this._remoteDataSource);

  @override
  Future<Either<Failure, void>> saveTransactionLocally(TransactionEntity transaction) async {
    // Implementar la lógica para guardar la transacción localmente
    return Right(null);
  }

  @override
  Future<Either<Failure, List<TransactionEntity>>> getPendingTransactions() async {
    // Implementar la lógica para obtener las transacciones pendientes
    return Right([]);
  }

  @override
  Future<Either<Failure, void>> syncPendingTransactions() async {
    // Implementar la lógica para sincronizar las transacciones pendientes
    return Right(null);
  }
}