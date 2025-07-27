import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nahed_azkar/services/constant.dart';
import 'package:nahed_azkar/utils/helpers.dart';
import 'package:nahed_azkar/widget/custom_appbar.dart';
import 'package:nahed_azkar/widget/zakat/zakat_sub_title.dart';
import 'package:nahed_azkar/widget/zakat/zakat_text_field.dart';
import 'package:nahed_azkar/widget/zakat/zakat_title.dart';

class ZakatScreen extends StatefulWidget {
  const ZakatScreen({super.key});

  @override
  State<ZakatScreen> createState() => _ZakatScreenState();
}

class _ZakatScreenState extends State<ZakatScreen> with CustomsAppBar, Helpers {
  @override
  void initState() {
    // TODO: implement initState
    numController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    numController.dispose();
    super.dispose();
  }

  late TextEditingController numController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyConstant.kWhite,
      appBar: settingsAppBar(context: context, title: 'حاسبة الزكاة'),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.all(20.w),
        children: [
          const ZakatTitle(title: 'ملاحظة هامة :'),
          const ZakatSubTitle(
              subtitle:
                  'الزكاة تكون على المال الذي مر عليه عام هجري، فمثلاً اليوم رصيدك 100 الف والعام الماضي في مثل هذا اليوم كان رصيدك 70 الف فان الزكاة واجبة على المبلغ 70 الف.'),
          const SizedBox(height: 15),
          ZakatTextField(controller: numController),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () async => performCalculator(),
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25)),
                minimumSize: const Size(double.infinity, 50),
                backgroundColor: MyConstant.kPrimary),
            child: Text(
              'احسب',
              style: TextStyle(color: MyConstant.kWhite, fontSize: 20.sp),
            ),
          ),
          const SizedBox(height: 15),
          Visibility(
            visible: numberOfZakat != null,
            child: Text(
              'قيمة الزكاة هي : $numberOfZakat',
              style: const TextStyle(
                  fontSize: 16,
                  color: Colors.green,
                  fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 15),
          const ZakatTitle(title: 'طريقة حساب الزكاة :'),
          const ZakatSubTitle(
              subtitle:
                  """تتم عملية حساب الزكاة عن طريق ضرب قيمة المبلغ الخاص بالزكاة بنسبة الزكاة فمثلاً انت لديك 80000 ريال سعودي وتريد اخراج زكاة هذا المبلغ فان العملية الحسابية تكون كالتالي:

80000 * 0.025 = 2000
            """),
          const SizedBox(height: 15),
          const ZakatTitle(title: 'لمن تعطي الزكاة :'),
          const ZakatSubTitle(
              subtitle:
                  '1)الفقراء 2) المساكين 3) ابن السبيل 4) الغارمين 5) في سبيل الله 6) العاملون عليها'),
          const ZakatTitle(title: 'نصاب زكاة المال :'),
          const ZakatSubTitle(
              subtitle:
                  'ليس كل مال عليه زكاة، بل يجب أن يمضي على المال بحوزتك مدة عام كامل وأن تكون قيمته قد بلغت قيمة نصاب الزكاة، ونصاب زكاة المال يختلف من دولة إلى اخرى ومن عام إلى آخر، فمن اختصاص وزارة الأوقاف والشؤون الدينية في الدولة تحديد نصاب زكاة المال للمواطنين واصدار نشرة بهذا النصاب من وقت إلى آخر، فقد تكون قيمة المال المدخرة بحوزتك وبلغ عليها عام كامل لم تصل نصاب الزكاة في بلدك وبذلك فانت معفى من تزكية هذا المال.'),
          const SizedBox(height: 15),
        ],
      ),
    );
  }

  double? numberOfZakat;

  void performCalculator() async {
    if (checkData()) {
      await calculate();
    }
  }

  bool checkData() {
    if (numController.text.isNotEmpty) {
      return true;
    }
    showSnackBar(context, message: 'الرجاء ادخال قيمة', error: true);
    return false;
  }

  Future<void> calculate() async {
    try {
      setState(
          () => numberOfZakat = (double.parse(numController.text) * 0.025));
      showSnackBar(context, message: 'قيمة الزكاة هي : $numberOfZakat');
    } catch (e) {
      showSnackBar(context, message: 'الرجاء ادخل قيمة رقمية فقط', error: true);
    }
  }
}
