import 'package:flutter/material.dart';

mixin Helpers {

  void showSnackBar(BuildContext context,{required String massage,required bool error}){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(massage),
      backgroundColor: error ? Colors.red : Colors.green,
      dismissDirection: DismissDirection.horizontal,
      duration: const Duration(seconds: 3),
    ));
  }
}
