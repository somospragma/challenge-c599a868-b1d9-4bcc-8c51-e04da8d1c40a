import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'sync_status.dart';

class TransactionEntity extends Equatable {
  final String id;
  final double amount;
  final String recipient;
  final int timestamp;
  final SyncStatus syncStatus;
  final String idempotencyKey;

  TransactionEntity({
    required this.id,
    required this.amount,
    required this.recipient,
    required this.timestamp,
    required this.syncStatus,
    required this.idempotencyKey,
  });

  @override
  List<Object?> get props => [id, amount, recipient, timestamp, syncStatus, idempotencyKey];

  TransactionEntity copyWith({
    String? id,
    double? amount,
    String? recipient,
    int? timestamp,
    SyncStatus? syncStatus,
    String? idempotencyKey,
  }) {
    return TransactionEntity(
      id: id?? this.id,
      amount: amount?? this.amount,
      recipient: recipient?? this.recipient,
      timestamp: timestamp?? this.timestamp,
      syncStatus: syncStatus?? this.syncStatus,
      idempotencyKey: idempotencyKey?? this.idempotencyKey,
    );
  }
}