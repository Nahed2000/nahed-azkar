import 'package:nahed_azkar/database/db_operation.dart';
import 'package:nahed_azkar/database/db_controller.dart';
import 'package:nahed_azkar/model/azkar/azkary.dart';
import 'package:sqflite/sqflite.dart';

class AzkaryDbController implements DbOperation<UserAzkar> {
  //  CRUD -> Create - Read - Update - Delete
  Database database = DbController().database;

  @override
  Future<int> create(userAzkar) async {
    // TODO: implement create
    int newRowId = await database.insert('azkary', userAzkar.toMap());
    return newRowId;
  }

  @override
  Future<bool> delete(int id) async {
    int countOfDeleteRow =
        await database.delete('azkary', where: 'id = ?', whereArgs: [id]);
    return countOfDeleteRow == 1;
  }

  @override
  Future<List<UserAzkar>> read() async {
    // TODO: implement read
    List<Map<String, dynamic>> rows = await database.query('azkary');
    List<UserAzkar> azkary = rows.map((e) => UserAzkar.fromMap(e)).toList();
    return azkary;
  }

  @override
  Future<bool> update(userAzkar) async {
    // TODO: implement update
    int countOfDeleteRow = await database.update('azkary', userAzkar.toMap(),
        where: 'id = ?', whereArgs: [userAzkar.id]);
    return countOfDeleteRow == 1;
  }
}
