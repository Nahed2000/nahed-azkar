import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../cubit/home_cubit/home_state.dart';
import '../../services/constant.dart';
import '../../cubit/home_cubit/home_cubit.dart';
import '../../widget/custom_appbar.dart';

class TasbihScreen extends StatelessWidget with CustomsAppBar {
  const TasbihScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<HomeCubit>(context);
    return Scaffold(
      backgroundColor: MyConstant.myWhite,
      appBar: settingsAppBar(
          context: context, title: 'سَبِّحِ ٱسۡمَ رَبِّكَ ٱلۡأَعۡلَى'),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return ListView(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            children: [
              SizedBox(height: MediaQuery.of(context).size.height / 40),
              Card(
                elevation: 4,
                shadowColor: Colors.grey.shade100,
                clipBehavior: Clip.antiAlias,
                color: MyConstant.myWhite,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.h),
                    side:
                        BorderSide(color: MyConstant.primaryColor, width: 0.1)),
                child: ListView(
                  padding: EdgeInsets.only(
                      top: 20.w, left: 15.h, bottom: 5.h, right: 5.h),
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  children: [
                    Text(
                      cubit.selectItemTasbih,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: MyConstant.myBlack,
                        fontSize: 18.h,
                      ),
                    ),
                    Align(
                        alignment: Alignment.bottomLeft,
                        child: PopupMenuButton<String>(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.h),
                            side: BorderSide(
                                color: MyConstant.primaryColor, width: 0.2),
                          ),
                          shadowColor: Colors.grey.shade100,
                          elevation: 4,
                          color: MyConstant.myWhite,
                          initialValue: cubit.selectItemTasbih,
                          itemBuilder: (context) {
                            return List.generate(
                              cubit.tasbihItem.length,
                              (index) => PopupMenuItem(
                                onTap: () {
                                  cubit.changeItemTasbih(
                                      cubit.tasbihItem[index][0],
                                      cubit.tasbihItem[index][1]);
                                  cubit.restartCount();
                                },
                                child: Text(
                                  cubit.tasbihItem[index][0],
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: MyConstant.primaryColor,
                                  ),
                                ),
                              ),
                            );
                          },
                          child: Text(
                            'تغيير',
                            style:
                                TextStyle(color: Colors.blue, fontSize: 16.sp),
                          ),
                        )),
                  ],
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 40),
              Container(
                  alignment: Alignment.center,
                  height: 200.h,
                  width: 200.w,
                  decoration: BoxDecoration(
                      color: MyConstant.myWhite,
                      shape: BoxShape.circle,
                      border: Border.all(
                          color: MyConstant.primaryColor, width: 0.8),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.shade200,
                            blurRadius: 10,
                            spreadRadius: 2),
                      ]),
                  child: Text(
                    cubit.countTasbih.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 35.sp, color: MyConstant.primaryColor),
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('العدد المطلوب : ${cubit.selectItemTasbihCount}',
                      style: TextStyle(
                          color: MyConstant.myBlack, fontSize: 15.sp)),
                  Text('اكملت : ${cubit.countTasbih}',
                      style: TextStyle(
                          color: MyConstant.myBlack, fontSize: 15.sp)),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Card(
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: MyConstant.primaryColor),
                        borderRadius: BorderRadius.circular(15.h)),
                    color: MyConstant.primaryColor,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 30.w, vertical: 10.h),
                      child: Text('الإجمالي',
                          style: TextStyle(
                              color: MyConstant.myWhite, fontSize: 15.sp)),
                    ),
                  ),
                  Card(
                    color: MyConstant.primaryColor,
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: MyConstant.primaryColor),
                        borderRadius: BorderRadius.circular(15.h)),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 30.w, vertical: 10.h),
                      child: Text(
                        cubit.totalTasbih.toString(),
                        style: TextStyle(
                            color: MyConstant.myWhite, fontSize: 15.sp),
                      ),
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    FloatingActionButton(
                      heroTag: "volume tag",
                      splashColor: Colors.red,
                      onPressed: () {
                        cubit.changeSound(!cubit.isSound);
                      },
                      backgroundColor: MyConstant.primaryColor,
                      child: cubit.isSound
                          ? Icon(
                              Icons.volume_up,
                              color: MyConstant.myWhite,
                            )
                          : Icon(
                              Icons.volume_off_sharp,
                              color: MyConstant.myWhite,
                            ),
                    ),
                    SizedBox(
                      height: 100.h,
                      width: 100.w,
                      child: FloatingActionButton(
                        heroTag: "increase tag",
                        onPressed: () {
                          cubit.changeCountTasbih();
                        },
                        backgroundColor: MyConstant.primaryColor,
                        child: Icon(
                          Icons.touch_app_outlined,
                          color: MyConstant.myWhite,
                          size: 50.sp,
                        ),
                      ),
                    ),
                    FloatingActionButton(
                        heroTag: "restart tag",
                        splashColor: Colors.red,
                        onPressed: () {
                          cubit.restartCount();
                        },
                        backgroundColor: MyConstant.primaryColor,
                        child: Icon(
                          Icons.restart_alt,
                          color: MyConstant.myWhite,
                        )),
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
