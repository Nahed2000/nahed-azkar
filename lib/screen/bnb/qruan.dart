import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quran/quran.dart' as quran;
import '../../services/constant.dart';
import '../app/quran/sura.dart';
import '../app/quran/sura_sound.dart';

class BNBarQuran extends StatelessWidget {
  const BNBarQuran({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(20),
        itemBuilder: (context, index) => Card(
            clipBehavior: Clip.antiAlias,
            elevation: 4,
            shadowColor: MyConstant.primaryColor,
            color: MyConstant.myWhite,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: const BorderSide(width: 0.01),
            ),
            child: ListTile(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            SuraQuran(currentIndex: index + 1))),
                hoverColor: MyConstant.primaryColor,
                title: Text(
                  quran.getSurahNameArabic(index + 1),
                  style: TextStyle(
                      color: MyConstant.primaryColor,
                      fontSize: 17.h,
                      fontWeight: FontWeight.w800),
                ),
                contentPadding: EdgeInsets.all(15.w),
                trailing: SizedBox(
                  width: 70.w,
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: MyConstant.myWhite,
                        child: Image.asset(
                            quran.getPlaceOfRevelation(index + 1) == 'Madinah'
                                ? 'assets/images/dome.png'
                                : 'assets/images/kaaba.png',
                            color: MyConstant.primaryColor),
                      ),
                      VerticalDivider(
                          width: 5.w,
                          thickness: 2,
                          color: MyConstant.primaryColor),
                      InkWell(
                        child: Icon(Icons.music_note_outlined,
                            size: 28.w, color: MyConstant.primaryColor),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SuraSound(
                                    index: index + 1,
                                    name: quran.getSurahNameArabic(index + 1)),
                              ));
                        },
                      )
                    ],
                  ),
                ),
                leading: CircleAvatar(
                    backgroundColor: MyConstant.primaryColor,
                    child: Text((index + 1).toString(),
                        style: TextStyle(
                            color: MyConstant.myWhite,
                            fontWeight: FontWeight.w800),
                        textAlign: TextAlign.center)),
                subtitle: Text(
                    'عدد الأيات ${quran.getVerseCount(index + 1)} || الجزء : ${quran.getJuzNumber(index + 1, 1)}',
                    style: TextStyle(
                        color: MyConstant.myBlack,
                        fontWeight: FontWeight.w800)))),
        separatorBuilder: (context, index) => SizedBox(height: 5.h),
        itemCount: quran.totalSurahCount);
  }
}
