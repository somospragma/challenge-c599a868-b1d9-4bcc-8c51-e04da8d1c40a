import 'package:drift/drift.dart';
import 'package:drift/native/native_database.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:payment_app/data/models/transaction_model.dart';

class DatabaseHelper {
  late Database database;

  DatabaseHelper() {
    _initDatabase();
  }

  Future<void> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = p.join(dbPath, 'transactions.db');
    database = NativeDatabase(File(path));
  }
}