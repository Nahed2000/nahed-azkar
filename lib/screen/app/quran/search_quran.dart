import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nahed_azkar/cubit/home_cubit.dart';
import 'package:nahed_azkar/services/constant.dart';
import 'package:nahed_azkar/utils/helpers.dart';
import 'package:nahed_azkar/widget/custom_appbar.dart';

import '../../../cubit/home_state.dart';
import '../../../widget/app/copy_button.dart';
import '../../../widget/app/share_button.dart';

class SearchQuran extends StatefulWidget {
  const SearchQuran({Key? key}) : super(key: key);

  @override
  State<SearchQuran> createState() => _SearchQuranState();
}

class _SearchQuranState extends State<SearchQuran> with Helpers {
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
      backgroundColor: MyConstant.myWhite,
      appBar: customAppBar(context, 'ابحث في القرآن', bnbar: false),
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
                      style:TextStyle(color: MyConstant.primaryColor) ,
                      controller: searchController,
                      keyboardType: TextInputType.text,
                      cursorColor: MyConstant.primaryColor,
                      decoration: InputDecoration(
                        enabled: true,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.w),
                          borderSide: BorderSide(
                            color: MyConstant.primaryColor,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.w),
                          borderSide: BorderSide(
                            color: MyConstant.primaryColor,
                          ),
                        ),
                        suffixIcon: const Icon(Icons.search),
                        suffixIconColor: MyConstant.primaryColor,
                        hintText: 'أبحث عن أية',
                        hintStyle: TextStyle(
                          color: MyConstant.primaryColor,
                          fontSize: 16.sp,
                        ),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    ElevatedButton(
                      onPressed: () async {
                        var connectivityResult =
                            await Connectivity().checkConnectivity();
                        if (connectivityResult == ConnectivityResult.none) {
                          // ignore: use_build_context_synchronously
                          showSnackBar(context,
                              massage: 'لا يوجد اتصال بالإنترنت', error: true);
                        } else {
                          cubit.getSearchOfAya(
                              searchText: searchController.text);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: MyConstant.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.w),
                          ),
                          minimumSize: Size(double.infinity, 50.h)),
                      child: Text(
                        'بحث',
                        style: TextStyle(
                          color: MyConstant.myWhite,
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
                            color: MyConstant.primaryColor,
                          ),
                          Text(
                            'الرجاء ادخل الاية او كلمة',
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: MyConstant.primaryColor,
                            ),
                          ),
                        ],
                      ),
                      visible: state is GetSearchOfAyaLoading ||
                          cubit.searchListResult.isNotEmpty,
                      child: state is GetSearchOfAyaLoading
                          ? Center(
                              child: CircularProgressIndicator(
                                color: MyConstant.primaryColor,
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
                                          color: MyConstant.myWhite,
                                          borderRadius:
                                              BorderRadius.circular(18),
                                          border: Border.all(
                                            width: 2,
                                            color: MyConstant.primaryColor,
                                          )),
                                      child: Column(
                                        children: [
                                          Text(cubit.searchListResult[index],
                                              style: TextStyle(
                                                  fontSize: cubit.sizeText,
                                                  color: MyConstant.myBlack),
                                              textAlign: TextAlign.justify),
                                          SizedBox(height: 5.h),
                                          Divider(
                                              color: MyConstant.primaryColor,
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
                                                    MyConstant.primaryColor,
                                                child: Text(
                                                  '${index + 1}',
                                                  style: TextStyle(
                                                      color:
                                                          MyConstant.myWhite),
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
