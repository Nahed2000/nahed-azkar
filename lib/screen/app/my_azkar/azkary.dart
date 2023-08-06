import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nahed_azkar/cubit/home_cubit.dart';
import 'package:nahed_azkar/cubit/home_state.dart';
import 'package:nahed_azkar/screen/app/my_azkar/add_zker.dart';
import 'package:nahed_azkar/services/constant.dart';

import '../../../utils/helpers.dart';
import '../../../widget/app/copy_button.dart';
import '../../../widget/app/share_button.dart';

class Azkary extends StatefulWidget {
  const Azkary({super.key});

  @override
  State<Azkary> createState() => _AzkaryState();
}

class _AzkaryState extends State<Azkary> with Helpers {
  @override
  void initState() {
    // TODO: implement initState
    BlocProvider.of<HomeCubit>(context, listen: false).read();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<HomeCubit>(context);
    return Scaffold(
      backgroundColor: MyConstant.myWhite,
      appBar: AppBar(
        backgroundColor: MyConstant.primaryColor,
        clipBehavior: Clip.antiAlias,
        toolbarHeight: 90.h,
        iconTheme: const IconThemeData(color: Colors.white),
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios)),
        shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(25)),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const AddZker()));
              },
              icon: const Icon(Icons.create)),
        ],
        title:
            const Text('أذكاري الخاصة', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
        if (state is LoadingAzkarState) {
          return const Center(child: CircularProgressIndicator());
        } else if (cubit.listAzkar.isNotEmpty) {
          return ListView.separated(
            padding: EdgeInsets.all(20.h),
            itemBuilder: (context, index) => InkWell(
              onTap: () => setState(() {
                if (cubit.listAzkar[index].number > 0) {
                  cubit.listAzkar[index].number--;
                }
              }),
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(20.h),
                decoration: BoxDecoration(
                    color: MyConstant.myWhite,
                    borderRadius: BorderRadius.circular(18),
                    border:
                        Border.all(width: 1, color: MyConstant.primaryColor)),
                child: Column(
                  children: [
                    BlocBuilder<HomeCubit, HomeState>(
                      builder: (context, state) {
                        return Text(
                          cubit.listAzkar[index].title,
                          style: TextStyle(
                              fontSize:
                                  BlocProvider.of<HomeCubit>(context).sizeText,
                              color: MyConstant.myBlack),
                          textAlign: TextAlign.justify,
                        );
                      },
                    ),
                    SizedBox(height: 5.h),
                    Divider(color: MyConstant.primaryColor, thickness: 3),
                    SizedBox(height: 5.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          height: 45.h,
                          width: 80.w,
                          decoration: BoxDecoration(
                              color: MyConstant.primaryColor,
                              borderRadius: BorderRadius.circular(15.h)),
                          child: Text(
                            cubit.listAzkar[index].number != 0
                                ? 'عدد التكرار \n${cubit.listAzkar[index].number.toString()}'
                                : 'تم',
                            style: TextStyle(color: MyConstant.myWhite),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        CopyButton(
                            textCopy: cubit.listAzkar[index].title,
                            textMessage: 'تم نسخ الذكر'),
                        ShareButton(text: cubit.listAzkar[index].title),
                        IconButton(
                            onPressed: () async {
                              bool deleted = await cubit.delete(index);
                              String massage = deleted
                                  ? 'تم حذف الذكر بنجاح'
                                  : 'لم يتم حذف الذكر';
                              // ignore: use_build_context_synchronously
                              showSnackBar(context,
                                  massage: massage, error: !deleted);
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ))
                      ],
                    )
                  ],
                ),
              ),
            ),
            itemCount: cubit.listAzkar.length,
            separatorBuilder: (context, index) => SizedBox(height: 15.h),
          );
        } else {
          return InkWell(
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => const AddZker())),
            child: Container(
              color: MyConstant.myWhite,
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.warning, color: Colors.red, size: 120.h),
                  SizedBox(height: 5.h),
                  Text('لا يوجد اي أذكار خاصة بك , أضف الأن',
                      style: TextStyle(
                        color: MyConstant.primaryColor,
                        fontWeight: FontWeight.bold,
                      ))
                ],
              ),
            ),
          );
        }
      }),
    );
  }
}
