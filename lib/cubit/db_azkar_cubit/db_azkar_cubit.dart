import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../db/controller/azkary_db_controller.dart';
import '../../model/db/azkary_db.dart';
import 'db_azkar_state.dart';

class DbAzkarCubit extends Cubit<DbAzkarState> {
  DbAzkarCubit() : super(InitialAzkarState());

  List<UserAzkar> listAzkar = [];

  //change size of text
  double sizeText = 18.sp;

  final AzkaryDbController _dbController = AzkaryDbController();

  // my azkar list
  void read() async {
    emit(LoadingAzkarState());
    listAzkar = await _dbController.read();
    emit(ReadAzkarState());
  }

  Future<bool> create({required UserAzkar userAzkar}) async {
    int newRowId = await _dbController.create(userAzkar);
    if (newRowId != 0) {
      userAzkar.id = newRowId;
      listAzkar.add(userAzkar);
      emit(CreateAzkarState());
    }
    return newRowId != 0;
  }

  Future<bool> delete(int index) async {
    bool deleted = await _dbController.delete(listAzkar[index].id);
    if (deleted) {
      listAzkar.removeAt(index);
      emit(DeleteAzkarState());
    }
    return deleted;
  }

  Future<bool> update({required UserAzkar userAzkar}) async {
    bool updated = await _dbController.update(userAzkar);
    if (updated) {
      int index = listAzkar.indexWhere((element) => element.id == userAzkar.id);
      if (index != 1) {
        listAzkar[index] = userAzkar;
        emit(UpdateAzkarState());
      }
    }
    return updated;
  }
}
