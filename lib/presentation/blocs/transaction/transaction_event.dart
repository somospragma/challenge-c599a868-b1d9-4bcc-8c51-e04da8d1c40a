import 'package:payment_app/domain/entities/transaction_entity.dart';
import 'package:equatable/equatable.dart';

abstract class TransactionEvent extends Equatable {
  const TransactionEvent();

  @override
  List<Object> get props => [];
}

class SaveTransactionEvent extends TransactionEvent {
  final TransactionEntity transaction;

  const SaveTransactionEvent(this.transaction);

  @override
  List<Object> get props => [transaction];
}

class SyncTransactionsEvent extends TransactionEvent {
  const SyncTransactionsEvent();
}

class GetTransactionsEvent extends TransactionEvent {
  const GetTransactionsEvent();
}

class CheckIdempotencyEvent extends TransactionEvent {
  final String idempotencyKey;

  const CheckIdempotencyEvent(this.idempotencyKey);

  @override
  List<Object> get props => [idempotencyKey];
}