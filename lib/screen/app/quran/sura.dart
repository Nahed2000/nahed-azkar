import 'package:flutter/material.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nahed_azkar/screen/app/quran/quran_list.dart';
import 'package:quran/quran.dart' as quran;

import '../../../services/constant.dart';
import '../../../widget/app/copy_button.dart';
import '../../../widget/app/share_button.dart';

class SuraQuran extends StatelessWidget {
  const SuraQuran({Key? key, required this.currentIndex}) : super(key: key);
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyConstant.myWhite,
      appBar: AppBar(
        clipBehavior: Clip.antiAlias,
        centerTitle: true,
        toolbarHeight: 75.h,
        backgroundColor: MyConstant.primaryColor,
        shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.circular(25.w),
        ),
        title: Text(quran.getSurahNameArabic(currentIndex)),
        leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.pop(context)),
        actions: [
          IconButton(
            onPressed: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => QuranList(currentIndex))),
            icon: const Icon(FlutterIslamicIcons.quran),
          ),
          const SizedBox(width: 10)
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(20.h),
        child: ListView.separated(
          shrinkWrap: true,
          separatorBuilder: (context, index) =>
              SizedBox(height: MediaQuery.of(context).size.height / 50),
          itemCount: quran.getVerseCount(currentIndex),
          itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(
                  color: MyConstant.myWhite,
                  borderRadius: BorderRadius.circular(15.h),
                  border: Border.all(color: MyConstant.primaryColor)),
              child: Column(
                children: [
                  ListTile(
                    title: Text(
                        quran.getVerse(currentIndex, index + 1,
                            verseEndSymbol: true),
                        style:
                            TextStyle(color: MyConstant.myBlack, fontSize: 24),
                        textAlign: TextAlign.justify),
                    subtitle: Text(
                        '\n${quran.getVerseTranslation(currentIndex, index + 1)}\n',
                        style: TextStyle(
                            color: MyConstant.primaryColor, fontSize: 18),
                        textAlign: TextAlign.justify),
                  ),
                  Divider(
                      color: MyConstant.primaryColor,
                      thickness: 3,
                      endIndent: 25.w,
                      indent: 25.w),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CopyButton(
                          textMessage: 'تم نسخ الأية',
                          textCopy:
                              "${quran.getVerse(currentIndex, index + 1, verseEndSymbol: true)} \n ${quran.getVerseTranslation(currentIndex, index + 1)} "),
                      ShareButton(
                        text: quran.getVerse(
                          currentIndex,
                          index + 1,
                          verseEndSymbol: true,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
