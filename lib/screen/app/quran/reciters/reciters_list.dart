import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nahed_azkar/model/quran.dart';
import 'package:nahed_azkar/model/reciters.dart';
import 'package:nahed_azkar/services/constant.dart';
import 'package:nahed_azkar/utils/helpers.dart';
import 'package:nahed_azkar/widget/custom_appbar.dart';

import '../../../../cubit/home_cubit/home_cubit.dart';
import '../../../../cubit/home_cubit/home_state.dart';
import '../../../../widget/app/home/radios_buttons.dart';

class RecitersList extends StatefulWidget {
  const RecitersList({Key? key, required this.reciters}) : super(key: key);

  final Reciters reciters;

  @override
  State<RecitersList> createState() => _RecitersListState();
}

class _RecitersListState extends State<RecitersList>
    with Helpers, CustomsAppBar {
  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<HomeCubit>(context);

    var item = widget.reciters;
    List countItemList = widget.reciters.moshaf[0].surahList.split(',');
    List suraItem = [];
    for (int i = 0; i < QuranItems.names.length; i++) {
      for (int j = 0; j < countItemList.length; j++) {
        if (countItemList[j] == QuranItems.names[i][0]) {
          suraItem.add(QuranItems.names[i]);
        }
      }
    }
    return Scaffold(
      backgroundColor: MyConstant.myWhite,
      appBar: settingsAppBar(context: context, title: 'القارئ ${item.name}'),
      body: ListView.builder(
        padding: EdgeInsets.all(15.w),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              onTap: () => showModalBottomSheet(
                clipBehavior: Clip.antiAlias,
                context: context,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50.w),
                    topRight: Radius.circular(50.w),
                  ),
                ),
                builder: (context) => SizedBox(
                  height: 200.h,
                  child: BlocBuilder<HomeCubit, HomeState>(
                      builder: (context, state) {
                    return state is RunAudioOfAyaLoading
                        ? CircularProgressIndicator(color: MyConstant.myWhite)
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '${suraItem[index][1]}',
                                style: TextStyle(
                                  color: MyConstant.primaryColor,
                                  fontSize: 22.sp,
                                ),
                              ),
                              LinearProgressIndicator(
                                color: MyConstant.primaryColor,
                              ),
                              RadiosButtons(
                                icon: cubit.isRadioRun
                                    ? Icons.pause_sharp
                                    : Icons.play_arrow,
                                onPress: () async {
                                  if (cubit.isRadioRun) {
                                    cubit.stopRunQuranRecitersLoading();
                                  } else {
                                    bool status = await cubit.runQuranReciters(
                                        urlServer: item.moshaf[0].server,
                                        suraNumber:
                                            int.parse(suraItem[index][0]));
                                    !status
                                        // ignore: use_build_context_synchronously
                                        ? showSnackBar(context,
                                            message: 'لا يوجد إتصال بالإنترنت',
                                            error: true)
                                        : null;
                                  }
                                },
                              ),
                            ],
                          );
                  }),
                ),
              ),
              shape: RoundedRectangleBorder(
                  side: BorderSide(color: MyConstant.primaryColor, width: 1),
                  borderRadius: BorderRadius.circular(15.w)),
              leading: CircleAvatar(
                backgroundColor: MyConstant.primaryColor,
                child: Text(
                  (index + 1).toString(),
                  style: TextStyle(color: MyConstant.myWhite),
                ),
              ),
              title: Text(suraItem[index][1]),
              subtitle: Text(widget.reciters.moshaf[0].name),
            ),
          );
        },
        physics: const BouncingScrollPhysics(),
        itemCount: suraItem.length,
      ),
    );
  }
}
