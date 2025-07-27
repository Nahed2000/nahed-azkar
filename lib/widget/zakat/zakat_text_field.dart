import 'package:flutter/material.dart';

import '../../services/constant.dart';

class ZakatTextField extends StatelessWidget {
  const ZakatTextField({super.key, required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      child: TextField(
        controller: controller,
        keyboardType: const TextInputType.numberWithOptions(
            decimal: false, signed: false),
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.numbers),
          prefixIconColor: MyConstant.kPrimary,
          contentPadding: const EdgeInsets.all(20),
          filled: true,
          fillColor: MyConstant.kWhite,
          enabled: true,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: BorderSide.none),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: BorderSide.none),
        ),
      ),
    );
  }
}
