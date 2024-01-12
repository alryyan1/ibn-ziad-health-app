import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'main_icon.dart';
import 'package:get/get.dart';
import 'add_clinic.dart';
class Settings extends StatelessWidget {
  const Settings({super.key});
  static const route = '/settings';

  @override
  Widget build(BuildContext context) {
    List<Widget> boxes = [
      MainIcon(
          picture: SvgPicture.asset('assets/svgs/add_test.svg',
              width: 50, height: 50),
          name: 'اضافه فحص'.tr,
          page: '/addtest'),
      MainIcon(
          name: 'عياده جديده'.tr,
          picture: SvgPicture.asset('assets/svgs/add_clinic.svg',
              width: 50, height: 50),
          page: AddClinic.route),
      MainIcon(
          name: 'اللغه'.tr,
          picture: SvgPicture.asset('assets/svgs/settings.svg',
              width: 50, height: 50),
          page: '/lang'),
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text('الاعدادات'.tr),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
            child: GridView.builder(
          itemCount: boxes.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 2 / 1.5,
              crossAxisCount: 2,
              mainAxisSpacing: 15,
              crossAxisSpacing: 15),
          itemBuilder: (context, index) {
            return boxes[index];
          },
        )),
      ),
    );
  }
}
