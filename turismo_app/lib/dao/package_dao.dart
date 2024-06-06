import 'package:sqflite/sqlite_api.dart';
import 'package:turismo_app/database/app_database.dart';
import 'package:turismo_app/models/package.dart';

class PackageDao {
  insert(Package package) async {
    Database database = await AppDatabase().openDb();
    await database.insert(AppDatabase().tableName, package.toMap());
  }

  delete(Package package) async {
    Database database = await AppDatabase().openDb();
    await database.delete(AppDatabase().tableName,
        where: "id = ?", whereArgs: [package.id]);
  }

  Future<bool> isFavorite(Package package) async {
    Database database = await AppDatabase().openDb();
    List maps = await database.query(AppDatabase().tableName,
        where: "id = ?", whereArgs: [package.id]);
    return maps.isNotEmpty;
  }

  Future<List> fetchAll() async {
    Database database = await AppDatabase().openDb();
    List maps = await database.query(AppDatabase().tableName);
    return maps.map((map) => FavoritePackage.fromMap(map)).toList();
  }
}
