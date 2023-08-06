import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchQuran extends StatefulWidget {
  const SearchQuran({Key? key}) : super(key: key);

  @override
  State<SearchQuran> createState() => _SearchQuranState();
}

class _SearchQuranState extends State<SearchQuran> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(20.h),
    );
  }
}
