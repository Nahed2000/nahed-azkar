import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nahed_azkar/model/db/azkary_db.dart';
import 'package:nahed_azkar/services/constant.dart';

import '../../../cubit/db_azkar_cubit/db_azkar_cubit.dart';
import '../../../utils/helpers.dart';

class AddZker extends StatefulWidget {
  const AddZker({this.userAzkar, Key? key}) : super(key: key);
  final UserAzkar? userAzkar;

  @override
  State<AddZker> createState() => _AddZkerState();
}

class _AddZkerState extends State<AddZker> with Helpers {
  late TextEditingController _titleController;
  late TextEditingController _numberController;

  @override
  void initState() {
    // TODO: implement initState
    _numberController =
        TextEditingController(text: widget.userAzkar?.number.toString());
    _titleController = TextEditingController(text: widget.userAzkar?.title);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _numberController.dispose();
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: MyConstant.kWhite,
        appBar: AppBar(
            backgroundColor: MyConstant.kPrimary,
            elevation: 0,
            leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: () {
                  Navigator.pop(context);
                }),
            iconTheme: const IconThemeData(color: Colors.white),
            toolbarHeight: 100.h,
            shape: BeveledRectangleBorder(
                borderRadius: BorderRadius.circular(25.w)),
            title: const Text(
              'إضافة ذكر',
              style: TextStyle(fontFamily: 'ggess',color: Colors.white),
            ),
            centerTitle: true),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 15.h),
              Text(
                '﴿ فَاذْكُرُونِي أَذْكُرْكُمْ وَاشْكُرُوا لِي وَلَا تَكْفُرُونِ ﴾',
                style: TextStyle(fontFamily: 'ggess',
                    fontSize: 17.w,
                    fontWeight: FontWeight.bold,
                    color: MyConstant.kPrimary),
              ),
              SizedBox(height: 30.h),
              TextField(
                style: TextStyle(fontFamily: 'ggess',color: MyConstant.kBlack),
                controller: _titleController,
                keyboardType: TextInputType.text,
                cursorColor: MyConstant.kPrimary,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.title, color: MyConstant.kPrimary),
                  labelText: 'عنوان الذكر',
                  labelStyle: TextStyle(fontFamily: 'ggess',
                    fontSize: 16.w,
                    fontWeight: FontWeight.w600,
                    color: MyConstant.kPrimary,
                  ),
                  enabled: true,
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide:
                          BorderSide(color: MyConstant.kPrimary, width: 2)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide:
                          BorderSide(color: MyConstant.kPrimary, width: 2)),
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                style: TextStyle(fontFamily: 'ggess',color: MyConstant.kBlack),
                controller: _numberController,
                keyboardType: const TextInputType.numberWithOptions(
                    decimal: true, signed: true),
                decoration: InputDecoration(
                  prefixIcon:
                      Icon(Icons.numbers, color: MyConstant.kPrimary),
                  labelText: 'عدد التكرار',
                  labelStyle: TextStyle(fontFamily: 'ggess',
                      fontSize: 16.w,
                      fontWeight: FontWeight.w600,
                      color: MyConstant.kPrimary),
                  enabled: true,
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide:
                          BorderSide(color: MyConstant.kPrimary, width: 2)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide:
                          BorderSide(color: MyConstant.kPrimary, width: 2)),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async => await performSave(),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 40),
                  backgroundColor: MyConstant.kPrimary,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text('حفظ',
                    style: TextStyle(fontFamily: 'ggess',
                        fontSize: 16.w,
                        fontWeight: FontWeight.w600,
                        color: Colors.white)),
              ),
            ],
          ),
        ));
  }

  Future<void> performSave() async {
    if (checkSave()) {
      await save();
    }
  }

  bool checkSave() {
    if (_titleController.text.isNotEmpty && _numberController.text.isNotEmpty) {
      return true;
    }
    showSnackBar(context,
        message: 'الرجاء إدخال البيانات المطلوبة', error: true);
    return false;
  }

  Future<void> save() async {
    bool saved = isCreated()
        ? mounted
            ? await BlocProvider.of<DbAzkarCubit>(context, listen: false)
                .create(userAzkar: userAzkar)
            : false
        : mounted
            ? await BlocProvider.of<DbAzkarCubit>(context, listen: false)
                .update(userAzkar: userAzkar)
            : false;
    String massage = saved ? 'تم حفظ الذكر' : 'حدثت مشكلة, حاول مرة اخرى';
    if (mounted) {
      showSnackBar(context, message: massage, error: !saved);
      isCreated() ? clear() : Navigator.pop(context);
    }
  }

  bool isCreated() => widget.userAzkar == null;

  UserAzkar get userAzkar {
    UserAzkar userAzkar = UserAzkar();
    if (!isCreated()) {
      userAzkar.id = widget.userAzkar!.id;
    }
    userAzkar.title = _titleController.text;
    userAzkar.number = int.parse(_numberController.text);
    return userAzkar;
  }

  void clear() {
    _titleController.text = '';
    _numberController.text = '';
  }
}
