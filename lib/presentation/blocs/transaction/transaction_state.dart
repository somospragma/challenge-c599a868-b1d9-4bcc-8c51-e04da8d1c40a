import 'package:payment_app/domain/entities/transaction_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:dartz/dartz.dart';
import 'package:payment_app/core/errors/failures.dart';

abstract class TransactionState extends Equatable {
  const TransactionState();

  @override
  List<Object> get props => [];
}

class TransactionInitial extends TransactionState {
  const TransactionInitial();
}

class TransactionSaved extends TransactionState {
  final TransactionEntity transaction;

  const TransactionSaved({required this.transaction});

  @override
  List<Object> get props => [transaction];
}

class TransactionsSynced extends TransactionState {
  final List<TransactionEntity> transactions;

  const TransactionsSynced({required this.transactions});

  @override
  List<Object> get props => [transactions];
}

class TransactionsLoaded extends TransactionState {
  final List<TransactionEntity> transactions;

  const TransactionsLoaded({required this.transactions});

  @override
  List<Object> get props => [transactions];
}

class TransactionError extends TransactionState {
  final String message;

  const TransactionError({required this.message});

  @override
  List<Object> get props => [message];
}

class IdempotencyChecked extends TransactionState {
  final bool isIdempotent;

  const IdempotencyChecked({required this.isIdempotent});

  @override
  List<Object> get props => [isIdempotent];
}