import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../db/table_create.dart';

class SqliteService {
  SqliteService._();

  static final SqliteService _instance = SqliteService._();

  factory SqliteService() => _instance;

  Database? _db;

  Database get DB => _db!;

  init([int? userId]) async {
    if (_db != null) {
      await _db!.close();
    }

    final databasePath = await getDatabasesPath();
    String path = '';
    if (userId == null) {
      path = join(databasePath, 'default.db');
    } else {
      path = join(databasePath, '${userId}.db');
    }

    await deleteDatabase(path);

    _db = await openDatabase(path, version: 1, onCreate: (db, i) async {
      await db.execute(patientsTableCreateSql +
          medicationStockTableCreateSql +
          medicationInventoryRecordsTableCreateSql +
          prescriptionsTableCreateSql +
          prescriptionDetailsTableCreateSql);
    });
  }
}
