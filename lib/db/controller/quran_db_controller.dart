import 'package:nahed_azkar/db/db_controller.dart';
import 'package:nahed_azkar/model/db/aya_db.dart';
import 'package:sqflite/sqflite.dart';

class QuranDbController {
  Database database = DbController().database;

  Future<List<AyaDbModel>> readAya() async {
    List<Map<String, dynamic>> result = await database.query('aya');
    List<AyaDbModel> item = result.map((e) => AyaDbModel.fromMap(e)).toList();
    return item;
  }

  Future<int> saveAya(AyaDbModel aya) async {
    int newResult = await database.insert('aya', aya.toMap());
    return newResult;
  }

  Future<bool> deleteAya(int id) async {
    int deletedItem =
        await database.delete('aya', where: 'id = ?', whereArgs: [id]);
    return deletedItem == 1;
  }
}
