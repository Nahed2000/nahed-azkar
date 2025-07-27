import 'package:flutter/material.dart';

class ZakatTitle extends StatelessWidget {
  const ZakatTitle({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
          color: Colors.red, fontSize: 24, fontWeight: FontWeight.bold),
    );
  }
}
