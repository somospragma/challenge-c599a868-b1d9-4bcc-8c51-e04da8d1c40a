import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:payment_app/core/errors/failures.dart';
import 'package:payment_app/domain/entities/transaction_entity.dart';

abstract class TransactionRepository {
  Future<Either<Failure, List<TransactionEntity>>> getPendingTransactions();
  Future<Either<Failure, Unit>> saveTransactionLocally(TransactionEntity transaction);
  Future<Either<Failure, Unit>> syncPendingTransactions();
  Future<Either<Failure, bool>> checkTransactionIdempotency(String idempotencyKey);

  void dispose();

  Future<Either<Failure, List<TransactionEntity>>> getTransactionsByStatus(SyncStatus status);
  Future<Either<Failure, TransactionEntity>> getTransactionById(String id);
  Future<Either<Failure, Unit>> updateTransactionStatus(TransactionEntity transaction);
  Future<Either<Failure, Unit>> deleteTransaction(String id);
  Future<Either<Failure, List<TransactionEntity>>> getExpiredTransactions();
  Future<Either<Failure, Unit>> retryFailedTransactions();
  Future<Either<Failure, List<TransactionEntity>>> getTransactionsByAmountRange(double minAmount, double maxAmount);
  Future<Either<Failure, List<TransactionEntity>>> getTransactionsByDateRange(int startDate, int endDate);
}