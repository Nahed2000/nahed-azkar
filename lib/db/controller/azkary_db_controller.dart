import 'package:nahed_azkar/db/db_controller.dart';
import 'package:nahed_azkar/model/db/azkary_db.dart';
import 'package:sqflite/sqflite.dart';

class AzkaryDbController {
  //  CRUD -> Create - Read - Update - Delete
  Database database = DbController().database;

  Future<int> create(userAzkar) async {
    int newRowId = await database.insert('azkary', userAzkar.toMap());
    return newRowId;
  }

  Future<bool> delete(int id) async {
    int countOfDeleteRow =
        await database.delete('azkary', where: 'id = ?', whereArgs: [id]);
    return countOfDeleteRow == 1;
  }

  Future<List<UserAzkar>> read() async {
    List<Map<String, dynamic>> rows = await database.query('azkary');
    List<UserAzkar> azkary = rows.map((e) => UserAzkar.fromMap(e)).toList();
    return azkary;
  }

  Future<bool> update(userAzkar) async {
    int countOfDeleteRow = await database.update('azkary', userAzkar.toMap(),
        where: 'id = ?', whereArgs: [userAzkar.id]);
    return countOfDeleteRow == 1;
  }
}
