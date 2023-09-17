import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nahed_azkar/cubit/api_response.dart';
import 'package:nahed_azkar/cubit/home_cubit.dart';
import 'package:nahed_azkar/cubit/home_state.dart';
import 'package:nahed_azkar/screen/app/quran/quran_list.dart';
import 'package:quran/quran.dart' as quran;

import '../../../services/constant.dart';
import '../../../utils/helpers.dart';
import '../../../widget/app/copy_button.dart';
import '../../../widget/app/share_button.dart';

class SuraQuran extends StatelessWidget with Helpers {
  const SuraQuran({Key? key, required this.currentIndex}) : super(key: key);
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<HomeCubit>(context);
    return Scaffold(
      backgroundColor: MyConstant.myWhite,
      appBar: AppBar(
        clipBehavior: Clip.antiAlias,
        centerTitle: true,
        toolbarHeight: 90.h,
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
      body: SafeArea(
        child: ListView.separated(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
          shrinkWrap: true,
          separatorBuilder: (context, index) =>
              SizedBox(height: MediaQuery.of(context).size.height / 50),
          itemCount: quran.getVerseCount(currentIndex),
          itemBuilder: (context, index) {
            return Card(
              elevation: 8,
              shadowColor: MyConstant.myWhite,
              color: MyConstant.myWhite,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.h),
                side: BorderSide(
                  width: 0.1.h,
                  color: MyConstant.primaryColor,
                ),
              ),
              child: Column(
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.all(20.w),
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
                        textAlign: TextAlign.justify,
                        textDirection: TextDirection.ltr),
                  ),
                  Divider(
                      color: MyConstant.primaryColor,
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
                                "${quran.getVerse(currentIndex, index + 1, verseEndSymbol: true)} \n ${quran.getVerseTranslation(currentIndex, index + 1)} "),
                        CircleAvatar(
                          backgroundColor: MyConstant.primaryColor,
                          child: BlocBuilder<HomeCubit, HomeState>(
                              builder: (context, state) {
                            return state is RunAudioOfAyaLoading &&
                                    cubit.ayaIndex == index + 1
                                ? CircularProgressIndicator(
                                    color: MyConstant.myWhite)
                                : IconButton(
                                    onPressed: () async {
                                      cubit.changeAyaIndex(index + 1);
                                      bool status = await cubit.getAudioOfAya(
                                          suraNumber: currentIndex,
                                          ayaNumber: index + 1);
                                      if (!status) {
                                        // ignore: use_build_context_synchronously
                                        showSnackBar(context,
                                            massage: 'لا يوجد إتصال بالإنترنت',
                                            error: true);
                                      }
                                    },
                                    icon: Icon(Icons.play_arrow,
                                        color: MyConstant.myWhite));
                          }),
                        ),
                        CircleAvatar(
                          backgroundColor: MyConstant.primaryColor,
                          child: IconButton(
                              onPressed: () async {
                                ApiResponse apiResponse = await cubit.getTafsir(
                                    sura: currentIndex.toString(),
                                    aya: (index + 1).toString());
                                apiResponse.status
                                    // ignore: use_build_context_synchronously
                                    ? showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(25.w)),
                                          title: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'التفسير الميسر',
                                                style: TextStyle(
                                                    color: MyConstant
                                                        .primaryColor),
                                              ),
                                              Icon(FlutterIslamicIcons.islam,
                                                  color:
                                                      MyConstant.primaryColor)
                                            ],
                                          ),
                                          content: SingleChildScrollView(
                                            child: Text(apiResponse.message,
                                                style:
                                                    TextStyle(fontSize: 18.w)),
                                          ),
                                          backgroundColor: MyConstant.myWhite,
                                          actionsAlignment:
                                              MainAxisAlignment.spaceAround,
                                          actions: [
                                            ShareButton(
                                                text: apiResponse.message),
                                            CopyButton(
                                                textCopy: apiResponse.message,
                                                textMessage: 'تم نسخ الذكر'),
                                            IconButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                icon: Text('تم',
                                                    style: TextStyle(
                                                        color: Colors.red,
                                                        fontSize: 16.w,
                                                        fontWeight:
                                                            FontWeight.bold))),
                                          ],
                                        ),
                                      )
                                    // ignore: use_build_context_synchronously
                                    : showSnackBar(context,
                                        massage: apiResponse.message,
                                        error: !apiResponse.status);
                              },
                              icon: Icon(Icons.menu_book,
                                  color: MyConstant.myWhite)),
                        ),
                        ShareButton(
                          text: quran.getVerse(
                            currentIndex,
                            index + 1,
                            verseEndSymbol: true,
                          ),
                        ),
                      ],
                    ),
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
