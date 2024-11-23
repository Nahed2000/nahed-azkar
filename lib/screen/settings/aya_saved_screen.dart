import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nahed_azkar/cubit/db_aya_cubit/db_aya_cubit.dart';
import 'package:nahed_azkar/cubit/db_aya_cubit/db_aya_state.dart';
import 'package:nahed_azkar/services/constant.dart';
import 'package:nahed_azkar/utils/helpers.dart';
import 'package:nahed_azkar/widget/custom_appbar.dart';

import '../../widget/app/service/copy_button.dart';
import '../../widget/app/service/share_button.dart';

class AyaSavedScreen extends StatefulWidget {
  const AyaSavedScreen({super.key});

  @override
  State<AyaSavedScreen> createState() => _AyaSavedScreenState();
}

class _AyaSavedScreenState extends State<AyaSavedScreen>
    with CustomsAppBar, Helpers {
  @override
  void initState() {
    BlocProvider.of<DbAyaCubit>(context, listen: false).read();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<DbAyaCubit>(context);
    return Scaffold(
      backgroundColor: MyConstant.kWhite,
      appBar: settingsAppBar(title: 'الايات المحفوظة', context: context),
      body: BlocBuilder<DbAyaCubit, DbAyaState>(
        builder: (context, state) {
          if (cubit.listAya.isEmpty) {
            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(FlutterIslamicIcons.quran,
                    color: MyConstant.kPrimary, size: 100),
                const SizedBox(height: 20),
                Text('لا يوجد ايات محفوظة ..',
                    style: TextStyle(
                        fontFamily: 'ggess',
                        fontSize: 30,
                        color: MyConstant.kPrimary))
              ],
            ));
          } else {
            return ListView.builder(
              padding: const EdgeInsetsDirectional.all(20),
              physics: const BouncingScrollPhysics(),
              itemCount: cubit.listAya.length,
              itemBuilder: (context, index) => Card(
                elevation: 8,
                shadowColor: MyConstant.kWhite,
                color: MyConstant.kWhite,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.h),
                  side: BorderSide(
                    width: 0.1.h,
                    color: MyConstant.kPrimary,
                  ),
                ),
                child: Column(
                  children: [
                    ListTile(
                        contentPadding: EdgeInsets.all(20.w),
                        title: Text(cubit.listAya[index].ayaText,
                            style: TextStyle(
                                fontFamily: 'uthmanic',
                                color: MyConstant.kBlack,
                                fontSize: 24),
                            textAlign: TextAlign.justify),
                        subtitle: Text(
                            '${cubit.listAya[index].suraName} : ${cubit.listAya[index].ayaNumber}',
                            style: TextStyle(
                                fontFamily: 'uthmanic',
                                color: MyConstant.kPrimary,
                                fontSize: 18),
                            textAlign: TextAlign.justify,
                            textDirection: TextDirection.ltr)),
                    Divider(
                        color: MyConstant.kPrimary,
                        thickness: 3,
                        endIndent: 25.w,
                        indent: 25.w),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          CopyButton(
                              textMessage: 'تم نسخ الأية',
                              textCopy:
                                  "${cubit.listAya[index].ayaText} \n ${cubit.listAya[index].suraName} : ${cubit.listAya[index].ayaNumber} "),
                          IconButton(
                              onPressed: () async {
                                await delete(context, cubit, index);
                              },
                              icon: Icon(Icons.delete,
                                  size: 28.w, color: Colors.red)),
                          ShareButton(
                              text:
                                  "${cubit.listAya[index].ayaText} \n ${cubit.listAya[index].suraName} : ${cubit.listAya[index].ayaNumber} "),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Future<void> delete(BuildContext context, DbAyaCubit cubit, int index) async {
    bool delete = await BlocProvider.of<DbAyaCubit>(context, listen: false)
        .deleteAya(cubit.listAya[index].id);
    String message = delete ? 'لقد تم الحذف بنجاح' : 'فشل الحذف';
    showSnackBar(
        // ignore: use_build_context_synchronously
        context,
        message: message,
        error: !delete);
  }
}
