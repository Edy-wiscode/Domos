import 'package:flutter/material.dart';
import 'package:my_app/Domos/db_helper/databaseconnection.dart';
import 'package:sqflite/sqflite.dart';

import 'Domos/domos.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  late DatabaseConnection databaseconnection = DatabaseConnection();
  final database = databaseconnection.setDatabase();
  runApp(MyApp(
    database: database,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.database}) : super(key: key);
  final Future<Database> database;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Domos',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: Domos(title: 'Domos'));
  }
}
