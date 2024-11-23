import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nahed_azkar/controller/api_controller.dart';
import 'package:nahed_azkar/cubit/db_aya_cubit/db_aya_cubit.dart';
import 'package:nahed_azkar/model/api_response.dart';
import 'package:nahed_azkar/model/db/aya_db.dart';
import 'package:nahed_azkar/screen/home/quran/sura_list.dart';
import 'package:quran/quran.dart' as quran;

import '../../../services/constant.dart';
import '../../../utils/helpers.dart';
import '../../../widget/app/service/copy_button.dart';
import '../../../widget/app/service/share_button.dart';
import '../../../widget/quran/quran_action_button.dart';
import '../../../widget/quran/tafser_aya.dart';

class Sura extends StatefulWidget {
  const Sura({Key? key, required this.currentIndex}) : super(key: key);
  final int currentIndex;

  @override
  State<Sura> createState() => _SuraState();
}

class _SuraState extends State<Sura> with Helpers {
  ApiController apiController = ApiController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyConstant.kWhite,
      appBar: AppBar(
        clipBehavior: Clip.antiAlias,
        centerTitle: true,
        toolbarHeight: 70.h,
        backgroundColor: MyConstant.kPrimary,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20))),
        iconTheme: IconThemeData(color: MyConstant.kWhite, size: 22),
        title: Text(quran.getSurahNameArabic(widget.currentIndex),
            style: TextStyle(fontFamily: 'uthmanic', color: MyConstant.kWhite)),
        leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, size: 22),
            onPressed: () => Navigator.pop(context)),
        actions: [
          QuranActionButton(
              widget: SuraList(currentIndex: widget.currentIndex),
              iconData: FlutterIslamicIcons.quran,
              suraNumber: widget.currentIndex,
              size: 32),
          const SizedBox(width: 50)
        ],
      ),
      body: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
        shrinkWrap: true,
        separatorBuilder: (context, index) =>
            SizedBox(height: MediaQuery.of(context).size.height / 50),
        itemCount: quran.getVerseCount(widget.currentIndex),
        itemBuilder: (context, index) {
          return Card(
            elevation: 8,
            shadowColor: MyConstant.kWhite,
            color: MyConstant.kWhite,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.h),
                side: BorderSide(width: 0.1.h, color: MyConstant.kPrimary)),
            child: Column(
              children: [
                ListTile(
                  contentPadding: EdgeInsets.all(20.w),
                  title: Text(quran.getVerse(widget.currentIndex, index + 1),
                      style: TextStyle(
                          fontFamily: 'uthmanic',
                          color: MyConstant.kBlack,
                          fontSize: 24),
                      textAlign: TextAlign.justify),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                          '\n${quran.getVerseTranslation(widget.currentIndex, index + 1)}\n',
                          style: TextStyle(
                              fontFamily: 'uthmanic',
                              color: MyConstant.kPrimary,
                              fontSize: 18),
                          textAlign: TextAlign.justify,
                          textDirection: TextDirection.ltr),
                      Text(
                          "${quran.getSurahNameArabic(widget.currentIndex)} : ${index + 1}"),
                    ],
                  ),
                ),
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
                              "${quran.getVerse(widget.currentIndex, index + 1, verseEndSymbol: true)} \n ${quran.getVerseTranslation(widget.currentIndex, index + 1)} "),
                      IconButton(
                          onPressed: () async {
                            bool saved =
                                await BlocProvider.of<DbAyaCubit>(context)
                                    .save(aya(index));
                            String message =
                                saved ? 'لقد تم الحفظ بنجاح' : 'فشل الحفظ';
                            showSnackBar(
                                // ignore: use_build_context_synchronously
                                context,
                                message: message,
                                error: !saved);
                          },
                          icon: Icon(Icons.bookmark_outline,
                              size: 28.w, color: MyConstant.kPrimary)),
                      CircleAvatar(
                        backgroundColor: MyConstant.kPrimary,
                        child: IconButton(
                            onPressed: () => getTafserOfAya(index),
                            icon: Icon(Icons.menu_book,
                                color: MyConstant.kWhite)),
                      ),
                      ShareButton(
                          text: quran.getVerse(widget.currentIndex, index + 1,
                              verseEndSymbol: true)),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  AyaDbModel aya(int index) {
    AyaDbModel ayaDbModel = AyaDbModel();
    ayaDbModel.ayaText = quran
        .getVerse(widget.currentIndex, index + 1, verseEndSymbol: true)
        .toString();
    ayaDbModel.ayaNumber = index + 1;
    ayaDbModel.suraName = quran.getSurahNameArabic(widget.currentIndex);
    return ayaDbModel;
  }

  void getTafserOfAya(int index) async {
    ApiResponse apiResponse = await apiController.getTafsir(
        sura: widget.currentIndex.toString(), aya: (index + 1).toString());
    apiResponse.status
        ? showDialog(
            // ignore: use_build_context_synchronously
            context: context,
            builder: (context) => TafserAya(apiResponse: apiResponse))
        // ignore: use_build_context_synchronously
        : showSnackBar(context,
            message: apiResponse.message, error: !apiResponse.status);
  }
}
