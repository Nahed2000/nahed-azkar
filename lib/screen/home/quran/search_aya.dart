import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nahed_azkar/cubit/home_cubit/home_cubit.dart';
import 'package:nahed_azkar/services/constant.dart';
import 'package:nahed_azkar/utils/helpers.dart';
import 'package:nahed_azkar/widget/custom_appbar.dart';
import '../../../cubit/home_cubit/home_state.dart';
import '../../../widget/app/service/copy_button.dart';
import '../../../widget/app/service/share_button.dart';

class SearchAya extends StatefulWidget {
  const SearchAya({Key? key}) : super(key: key);

  @override
  State<SearchAya> createState() => _SearchAyaState();
}

class _SearchAyaState extends State<SearchAya> with Helpers, CustomsAppBar {
  late TextEditingController searchController;

  @override
  void initState() {
    // TODO: implement initState
    searchController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<HomeCubit>(context);
    return Scaffold(
      backgroundColor: MyConstant.kWhite,
      appBar: settingsAppBar(context: context, title: 'ابحث في القرآن'),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SafeArea(
          child: BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              return Padding(
                padding: EdgeInsets.all(20.w),
                child: Column(
                  children: [
                    TextField(
                      style: TextStyle(color: MyConstant.kPrimary),
                      controller: searchController,
                      keyboardType: TextInputType.text,
                      cursorColor: MyConstant.kPrimary,
                      decoration: InputDecoration(
                        enabled: true,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.w),
                          borderSide: BorderSide(
                            color: MyConstant.kPrimary,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.w),
                          borderSide: BorderSide(
                            color: MyConstant.kPrimary,
                          ),
                        ),
                        suffixIcon: const Icon(Icons.search),
                        suffixIconColor: MyConstant.kPrimary,
                        hintText: 'أبحث عن أية',
                        hintStyle: TextStyle(
                          fontFamily: 'uthmanic',
                          color: MyConstant.kPrimary,
                          fontSize: 16.sp,
                        ),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    ElevatedButton(
                      onPressed: () async {
                        var connectivityResult =
                            await Connectivity().checkConnectivity();
                        if (connectivityResult
                            .contains(ConnectivityResult.none)) {
                          // ignore: use_build_context_synchronously
                          showSnackBar(context,
                              message: 'لا يوجد اتصال بالإنترنت', error: true);
                        } else {
                          cubit.getSearchOfAya(
                              searchText: searchController.text);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: MyConstant.kPrimary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.w),
                          ),
                          minimumSize: Size(double.infinity, 50.h)),
                      child: Text(
                        'بحث',
                        style: TextStyle(
                          fontFamily: 'uthmanic',
                          color: MyConstant.kWhite,
                          fontSize: 16.sp,
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Visibility(
                      replacement: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.image_aspect_ratio,
                            size: 100.h,
                            color: MyConstant.kPrimary,
                          ),
                          Text(
                            'الرجاء ادخل الاية او كلمة',
                            style: TextStyle(
                              fontFamily: 'uthmanic',
                              fontSize: 16.sp,
                              color: MyConstant.kPrimary,
                            ),
                          ),
                        ],
                      ),
                      visible: state is GetSearchOfAyaLoading ||
                          cubit.searchListResult.isNotEmpty,
                      child: state is GetSearchOfAyaLoading
                          ? Center(
                              child: CircularProgressIndicator(
                                color: MyConstant.kPrimary,
                              ),
                            )
                          : (state is GetSearchOfAya &&
                                  cubit.searchListResult.isNotEmpty)
                              ? ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return Container(
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.all(20.h),
                                      decoration: BoxDecoration(
                                          color: MyConstant.kWhite,
                                          borderRadius:
                                              BorderRadius.circular(18),
                                          border: Border.all(
                                            width: 2,
                                            color: MyConstant.kPrimary,
                                          )),
                                      child: Column(
                                        children: [
                                          Text(cubit.searchListResult[index],
                                              style: TextStyle(
                                                  fontFamily: 'uthmanic',
                                                  fontSize: cubit.sizeText,
                                                  color: MyConstant.kBlack),
                                              textAlign: TextAlign.justify),
                                          SizedBox(height: 5.h),
                                          Divider(
                                              color: MyConstant.kPrimary,
                                              thickness: 3),
                                          SizedBox(height: 5.h),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              CopyButton(
                                                  textCopy: cubit
                                                      .searchListResult[index],
                                                  textMessage: 'تم نسخ الذكر'),
                                              ShareButton(
                                                  text: cubit
                                                      .searchListResult[index]),
                                              CircleAvatar(
                                                radius: 20.h,
                                                backgroundColor:
                                                    MyConstant.kPrimary,
                                                child: Text(
                                                  '${index + 1}',
                                                  style: TextStyle(
                                                      fontFamily: 'uthmanic',
                                                      color:
                                                          MyConstant.kWhite),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                  itemCount: cubit.searchListResult.length,
                                )
                              : const SizedBox(),
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
