import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseConnection {
  Future<Database> setDatabase() async {
    var directory = await getApplicationDocumentsDirectory();
    var path = join(directory.path, 'alarmy_database.db');
    final db = await openDatabase(
      path,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE alarm_table(id INTEGER PRIMARY KEY, title TEXT, time TEXT)',
        );
      },
      version: 1,
    );
    return db;
  }
}
