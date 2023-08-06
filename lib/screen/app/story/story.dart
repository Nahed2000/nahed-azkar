import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../widget/app/item.dart';
import '../../../services/constant.dart';
import '../../../model/story.dart';
import '../../../widget/custom_appbar.dart';
import 'story_list.dart';

class StoryScreen extends StatelessWidget {
  const StoryScreen({
    Key? key,
    required this.storyModel,
  }) : super(key: key);
  final StoryModel storyModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyConstant.myWhite,
      appBar: customAppBar(context, storyModel.name, bnbar: false),
      body: ListView.separated(
          padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 15.h),
          itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            StoryList(items: storyModel.listData[index]),
                      ));
                },
                child: ItemsScreen(text: storyModel.listData[index][0]),
              ),
          separatorBuilder: (context, index) => SizedBox(height: 15.h),
          itemCount: storyModel.listData.length),
    );
  }
}
