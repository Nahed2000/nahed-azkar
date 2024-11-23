import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nahed_azkar/controller/api_controller.dart';
import 'package:nahed_azkar/services/constant.dart';
import 'package:nahed_azkar/widget/custom_appbar.dart';
import 'package:nahed_azkar/widget/settings/empty_column.dart';

import '../../../../model/reciters.dart';
import 'reciters_list.dart';

class RecitersSura extends StatefulWidget {
  const RecitersSura({Key? key}) : super(key: key);

  @override
  State<RecitersSura> createState() => _RecitersSuraState();
}

class _RecitersSuraState extends State<RecitersSura> with CustomsAppBar {
  @override
  void initState() {
    // TODO: implement initState
    future = ApiController().getReciters();
    super.initState();
  }

  late Future<List<Reciters>> future;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyConstant.kWhite,
      appBar: settingsAppBar(context: context, title: 'القرآن الصوتي'),
      body: FutureBuilder<List<Reciters>>(
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: MyConstant.kPrimary,
              ),
            );
          } else if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            return ListView.builder(
              itemBuilder: (context, index) => Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 7.h),
                child: ListTile(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            RecitersList(reciters: snapshot.data![index]),
                      )),
                  subtitle: Text(
                    ' رواية | ${snapshot.data![index].moshaf[0].name}',
                  ),
                  title: Text(
                    snapshot.data![index].name,
                    style: TextStyle(fontFamily: 'uthmanic',color: MyConstant.kPrimary),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.w),
                    side: BorderSide(
                      color: MyConstant.kPrimary,
                      width: 1,
                    ),
                  ),
                  leading: CircleAvatar(
                    radius: 20.w,
                    backgroundColor: MyConstant.kPrimary,
                    child: Text(
                      snapshot.data![index].letter,
                      style: TextStyle(fontFamily: 'uthmanic',
                        color: MyConstant.kWhite,
                        fontSize: 20.sp,
                      ),
                    ),
                  ),
                ),
              ),
              physics: const BouncingScrollPhysics(),
              itemCount: snapshot.data!.length,
            );
          }
          return const Center(
            child: EmptyColumn(
              title: 'الرجاء التحقق من الإنترنت',
            ),
          );
        },
        future: future,
      ),
    );
  }
}
