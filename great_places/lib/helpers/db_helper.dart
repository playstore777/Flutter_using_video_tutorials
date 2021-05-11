import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqlite_api.dart';

class DBHelper {
  static Future<Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(
      path.join(dbPath, 'great_places.db'),
// as places.db isn't working well, so now it is better to use great_places.db! (maybe the issue started when I used or whenvever I used chrome to test my app/run my app as web app!)
      onCreate: (db, version) {
        return db.execute(
            'CREATE TABLE IF NOT EXISTS user_places(id TEXT PRIMARY KEY, title TEXT, image TEXT)');
      },
      version:
          1, // tells about the version, to clearly open exact database! Maybe it is optional param!
    );
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await DBHelper.database();
    db.insert(
      table,
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DBHelper.database();
    return db.query(table);
  }
}
