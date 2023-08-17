import 'package:flutter/material.dart';
import 'package:nahed_azkar/services/constant.dart';
import 'package:nahed_azkar/widget/custom_appbar.dart';

class SearchQuran extends StatefulWidget {
  const SearchQuran({Key? key}) : super(key: key);

  @override
  State<SearchQuran> createState() => _SearchQuranState();
}

class _SearchQuranState extends State<SearchQuran> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyConstant.myWhite,
      appBar: customAppBar(context, 'ابحث في القرآن', bnbar: false),
      body: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [],
      ),
    );
  }
}
