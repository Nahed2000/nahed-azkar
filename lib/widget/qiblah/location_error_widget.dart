import 'package:flutter/material.dart';
import 'package:nahed_azkar/services/constant.dart';

class LocationErrorWidget extends StatelessWidget {
  final String? error;
  final Function? callback;

  const LocationErrorWidget({Key? key, this.error, this.callback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    const box = SizedBox(height: 32);
    const errorColor = Color(0xffb00020);

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const Icon(Icons.location_off, size: 150, color: errorColor),
          box,
          Text(
            error!,
            style:
                const TextStyle(color: errorColor, fontWeight: FontWeight.bold),
          ),
          box,
          ElevatedButton(
            onPressed: () {
              if (callback != null) callback!();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: MyConstant.primaryColor,
            ),
            child: const Text("تحديث"),
          )
        ],
      ),
    );
  }
}
