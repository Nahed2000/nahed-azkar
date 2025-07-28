import 'package:flutter/material.dart';

import '../../../../widget/app/item.dart';
import '../../../services/constant.dart';
import '../../../data/hadeth.dart';
import '../../../widget/custom_appbar.dart';
import 'hadeth_list.dart';

class AlHadethScreen extends StatelessWidget with CustomsAppBar {
  const AlHadethScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyConstant.kWhite,
      appBar: settingsAppBar(context: context, title: 'أحاديث نبوية شريفة'),
      body: GridView.builder(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(20),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 100, mainAxisExtent: 220),
        itemCount: 8,
        itemBuilder: (context, index) => GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HadethList(
                    dataOfHadeth: DataOfHadeth.hadethItem[index],
                  ),
                ),
              );
            },
            child: ItemsScreen(text: DataOfHadeth.hadethItem[index].title)),
      ),
    );
  }
}
