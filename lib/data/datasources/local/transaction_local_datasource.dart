import 'package:dartz/dartz.dart';
import 'package:drift/drift.dart';
import 'package:payment_app/core/errors/exceptions.dart';
import 'package:payment_app/core/errors/failures.dart';
import 'package:payment_app/data/models/transaction_model.dart';
import 'package:payment_app/data/datasources/local/database_helper.dart';

abstract class TransactionLocalDatasource {
  Future<Either<Failure, Unit>> saveTransaction(TransactionModel transaction);
  Future<Either<Failure, List<TransactionModel>>> getPendingTransactions();
  Future<Either<Failure, Unit>> updateTransactionSyncStatus(TransactionModel transaction);
  Future<Either<Failure, bool>> checkTransactionIdempotency(String idempotencyKey);
}

class TransactionLocalDatasourceImpl implements TransactionLocalDatasource {
  final DatabaseHelper databaseHelper;

  TransactionLocalDatasourceImpl(this.databaseHelper);

  @override
  Future<Either<Failure, Unit>> saveTransaction(TransactionModel transaction) async {
    try {
      await databaseHelper.database.into(transactionModel).insert(transaction);
      return Right(unit);
    } catch (e) {
      return Left(DatabaseFailure('Failed to save transaction'));
    }
  }

  @override
  Future<Either<Failure, List<TransactionModel>>> getPendingTransactions() async {
    try {
      final transactions = await databaseHelper.database.select(transactionModel).where((tbl) => tbl.syncStatus.equals('pending')).get();
      return Right(transactions);
    } catch (e) {
      return Left(DatabaseFailure('Failed to get pending transactions'));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateTransactionSyncStatus(TransactionModel transaction) async {
    try {
      await databaseHelper.database.update(transactionModel).replace(transaction.copyWith(syncStatus: 'synced'));
      return Right(unit);
    } catch (e) {
      return Left(DatabaseFailure('Failed to update transaction sync status'));
    }
  }

  @override
  Future<Either<Failure, bool>> checkTransactionIdempotency(String idempotencyKey) async {
    try {
      final transaction = await databaseHelper.database.select(transactionModel).where((tbl) => tbl.idempotencyKey.equals(idempotencyKey)).getSingleOrNull();
      return Right(transaction!= null);
    } catch (e) {
      return Left(DatabaseFailure('Failed to check transaction idempotency'));
    }
  }
}