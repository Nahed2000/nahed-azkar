import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbController {
  DbController._();

  static final DbController _instance = DbController._();

  factory DbController() {
    return _instance;
  }

  late Database database;

  Future<void> initDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, 'db.sql');
    database = await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: (db, version) async {
        await db.execute('CREATE TABLE azkary ('
            'iD INTEGER PRIMARY KEY AUTOINCREMENT,'
            'title TEXT,'
            'number INTEGER)');
        await db.execute('CREATE TABLE aya ('
            'id INTEGER PRIMARY KEY AUTOINCREMENT,'
            'aya_text TEXT,'
            'sura_name TEXT,'
            'aya_number INTEGER)');
      },
      onUpgrade: (db, oldVersion, newVersion) {},
      onDowngrade: (db, oldVersion, newVersion) {},
    );
  }
}
