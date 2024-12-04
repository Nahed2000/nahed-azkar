import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nahed_azkar/storage/pref_controller.dart';
import 'package:nahed_azkar/utils/helpers.dart';
import 'package:nahed_azkar/widget/custom_appbar.dart';
import 'package:quran/quran.dart' as quran;

import '../../../cubit/home_cubit/home_cubit.dart';
import '../../../cubit/home_cubit/home_state.dart';
import '../../../services/constant.dart';

class SuraList extends StatefulWidget {
  const SuraList({Key? key, required this.currentIndex}) : super(key: key);
  final int currentIndex;

  @override
  State<SuraList> createState() => _SuraListState();
}

class _SuraListState extends State<SuraList> with CustomsAppBar, Helpers {
  late ScrollController scrollController;

  @override
  void initState() {
    PrefController().suraNumber == widget.currentIndex
        ? scrollController =
            ScrollController(initialScrollOffset: PrefController().pixels)
        : scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int numberOfSura = quran.getVerseCount(widget.currentIndex);
    return Scaffold(
      backgroundColor: MyConstant.kWhite,
      appBar: AppBar(
          leadingWidth: 80.w,
          iconTheme: const IconThemeData(color: Colors.white),
          elevation: 4,
          backgroundColor: MyConstant.kPrimary,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25),
            bottomRight: Radius.circular(25),
          )),
          leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back_ios)),
          actions: [
            IconButton(
                onPressed: () => Helpers.showTextChanger(context),
                icon: const Icon(Icons.text_fields)),
            SizedBox(width: 20.w),
          ],
          systemOverlayStyle:
              SystemUiOverlayStyle(statusBarColor: MyConstant.kPrimary)),
      body: ListView(
        controller: scrollController,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 13),
        children: [
          Container(
            clipBehavior: Clip.antiAlias,
            height: 90.h,
            alignment: Alignment.center,
            width: double.infinity,
            decoration: BoxDecoration(
              color: MyConstant.kWhite,
              image: DecorationImage(
                image: const AssetImage('assets/images/head_of_surah.png'),
                fit: BoxFit.cover,
                colorFilter:
                    ColorFilter.mode(MyConstant.kPrimary, BlendMode.color),
              ),
            ),
            child: Text(
              quran.getSurahNameArabic(widget.currentIndex),
              style: TextStyle(
                  fontFamily: 'uthmanic',
                  color: MyConstant.kPrimary,
                  fontSize: 23.sp),
            ),
          ),
          Visibility(
              visible: widget.currentIndex == 1 || widget.currentIndex == 9,
              replacement: Text(quran.basmala,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'uthmanic',
                      color: MyConstant.kPrimary,
                      fontSize: 30.sp)),
              child: const SizedBox()),
          const SizedBox(height: 20),
          SizedBox(height: 10.h),
          BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: RichText(
                  textDirection: TextDirection.rtl,
                  textAlign: TextAlign.justify,
                  text: TextSpan(
                    children: List.generate(
                      numberOfSura,
                      (index) => TextSpan(
                        children: [
                          TextSpan(
                              text: quran.getVerse(
                                  widget.currentIndex, index + 1)),
                          const TextSpan(text: ""),
                          TextSpan(
                            text: "﴿${index + 1}﴾",
                            style: TextStyle(
                                color: MyConstant.kPrimary,
                                fontWeight: FontWeight.bold),
                          ),
                          const TextSpan(text: "")
                        ],
                        style: TextStyle(
                          fontFamily: 'uthmanic',
                          color: MyConstant.kBlack,
                          fontSize:
                              BlocProvider.of<HomeCubit>(context).sizeText,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: MyConstant.kPrimary,
        onPressed: () {
          PrefController().saveSura(
              suraNumber: widget.currentIndex,
              pixels: scrollController.position.pixels);
          showSnackBar(context, message: 'تم الحفظ بنجاح ..');
        },
        child: const Icon(Icons.bookmark_outline, color: Colors.white),
      ),
    );
  }
}
