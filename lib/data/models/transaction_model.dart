import 'package:drift/drift.dart';
import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

part 'transaction_model.g.dart';

@DriftAccessor(tables: [Transactions])
class TransactionModel extends Table with EquatableMixin {
  @override
  Set<Column> get columns => {id, amount, recipient, timestamp, syncStatus, idempotencyKey};

  @primaryKey
  final id = text().clientDefault(() => const Uuid().v4());
  final amount = real();
  final recipient = text();
  final timestamp = integer();
  final syncStatus = text();
  final idempotencyKey = text();

  @override
  List<Object?> get props => [id, amount, recipient, timestamp, syncStatus, idempotencyKey];
}

class Transaction extends Table {
  TextColumn get id => text().clientDefault(() => const Uuid().v4());
  RealColumn get amount => real();
  TextColumn get recipient => text();
  IntegerColumn get timestamp => integer();
  TextColumn get syncStatus => text();
  @override
  Set<Column> get columns => {id, amount, recipient, timestamp, syncStatus};
}