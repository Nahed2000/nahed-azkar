import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nahed_azkar/cubit/db_aya_cubit/db_aya_state.dart';
import 'package:nahed_azkar/db/controller/quran_db_controller.dart';
import 'package:nahed_azkar/model/db/aya_db.dart';

class DbAyaCubit extends Cubit<DbAyaState> {
  DbAyaCubit() : super(InitialAyaState());

  QuranDbController quranDbController = QuranDbController();
  List<AyaDbModel> listAya = [];

  Future<void> read() async {
    listAya = await quranDbController.readAya();
    emit(ReadAyaState());
  }

  Future<bool> save(AyaDbModel aya) async {
    int result = await quranDbController.saveAya(aya);
    if (result != 0) {
      aya.id = result;
      listAya.add(aya);
      emit(CreateAyaState());
    }
    return result != 0;
  }

  Future<bool> deleteAya(int id) async {
    bool deleted = await quranDbController.deleteAya(id);
    if (deleted) {
      int index = listAya.indexWhere((element) => element.id == id);
      listAya.removeAt(index);
      emit(DeleteAyaState());
    }
    return deleted;
  }
}
