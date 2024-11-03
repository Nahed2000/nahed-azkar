import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../services/constant.dart';
import '../../../data/story.dart';
import '../../../widget/custom_appbar.dart';
import 'story.dart';

class StoryCategories extends StatelessWidget with CustomsAppBar {
  const StoryCategories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyConstant.myWhite,
      appBar: settingsAppBar(context: context, title: 'قصص مختصرة'),
      body: ListView.separated(
        separatorBuilder: (context, index) => SizedBox(height: 20.h),
        padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 40.w),
        itemBuilder: (context, index) => GestureDetector(
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    StoryScreen(storyModel: DataOfStory.storyItem[index]),
              )),
          child: SizedBox(
            height: 100.h,
            child: Card(
              color: MyConstant.myWhite,
              elevation: 6,
              shadowColor: Colors.grey.shade100,
              shape: RoundedRectangleBorder(
                side: BorderSide(color: MyConstant.primaryColor, width: 0.2),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    DataOfStory.storyItem[index].name,
                    style: TextStyle(
                      fontSize: 16.h,
                      color: MyConstant.primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Icon(
                    Icons.menu_open,
                    color: MyConstant.primaryColor,
                    size: 30.h,
                  )
                ],
              ),
            ),
          ),
        ),
        itemCount: DataOfStory.storyItem.length,
      ),
    );
  }
}
