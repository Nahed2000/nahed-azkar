import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quran/quran.dart' as quran;

import '../../../services/constant.dart';

class QuranList extends StatelessWidget {
  const QuranList(this.currentIndex, {Key? key}) : super(key: key);
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    int numberOfSura = quran.getVerseCount(currentIndex);
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
        title: Text(
          quran.getSurahNameArabic(currentIndex),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(vertical: 10.w, horizontal: 13),
          children: [
            currentIndex == 1 || currentIndex == 9
                ? const SizedBox()
                : Text(quran.basmala,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: MyConstant.primaryColor, fontSize: 30.sp)),
            SizedBox(height: 10.h),
            RichText(
              textAlign: TextAlign.justify,
              text: TextSpan(
                children: List.generate(
                  numberOfSura,
                  (index) => TextSpan(
                      text: quran.getVerse(currentIndex, index + 1,
                          verseEndSymbol: true),
                      style:
                          TextStyle(color: MyConstant.myBlack, fontSize: 22.w)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
