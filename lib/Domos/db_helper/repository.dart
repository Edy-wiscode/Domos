import 'package:my_app/Domos/db_helper/databaseconnection.dart';
import 'package:sqflite/sqflite.dart';

class Repository {
  late DatabaseConnection _databaseConnection;
  Repository() {
    _databaseConnection = DatabaseConnection();
  }

  static Database? _database;
  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    } else {
      _database = await _databaseConnection.setDatabase();
      return _database;
    }
  }

  // insérer des données dans la table
  insertData(table, data) async {
    var connection = await database;
    return await connection?.insert(table, data);
  }

  // lire toutes les données de la table
  readData(table) async {
    var connection = await database;
    return await connection?.query(table);
  }

  // Supprimer des données de la table
  deleteData(table, itemId) async {
    var connection = await database;
    return await connection?.rawDelete('DELETE FROM $table WHERE id = $itemId');
  }
}
