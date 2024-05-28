import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class AppDatabase {
  final int version = 1;
  final String databaseName = "superhero.db";
  final String tableName = "heros";
  Database? db;

  Future<Database> openDb() async {
    db ??= await openDatabase(
      join(await getDatabasesPath(), databaseName),
      version: version,
      onCreate: (db, version) {
        String query =
            "create table $tableName (id text primary key, name text, full_name text, image text)";
        db.execute(query);
      },
    );
    return db as Database;
  }
}
