import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../services/constant.dart';
import '../../../data/story.dart';
import '../../../widget/custom_appbar.dart';
import 'story.dart';

class StoryCategories extends StatelessWidget {
  const StoryCategories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyConstant.myWhite,
      appBar: customAppBar(context, 'قصص مختصرة', bnbar: false),
      body: ListView.separated(
        separatorBuilder: (context, index) =>
            SizedBox(height: MediaQuery.of(context).size.height / 15),
        padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 40.w),
        itemBuilder: (context, index) => GestureDetector(
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    StoryScreen(storyModel: DataOfStory.storyItem[index]),
              )),
          child: Container(
            alignment: Alignment.center,
            height: 100.h,
            width: 5.w,
            decoration: BoxDecoration(
              color: MyConstant.myWhite,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: MyConstant.primaryColor, width: 3),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  DataOfStory.storyItem[index].name,
                  style: TextStyle(
                      fontSize: 16.h,
                      color: MyConstant.myBlack,
                      fontWeight: FontWeight.bold),
                ),
                Icon(
                  Icons.menu_open,
                  color: MyConstant.myBlack,
                  size: 30.h,
                )
              ],
            ),
          ),
        ),
        itemCount: DataOfStory.storyItem.length,
      ),
    );
  }
}
