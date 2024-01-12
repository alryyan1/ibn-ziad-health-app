import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ibnziad/labprices.dart';
import 'main_icon.dart';
import 'package:get/get.dart';
import 'clinics.dart';
class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> boxes = [
      MainIcon(
          name: 'قائمه التحاليل'.tr,
          picture: SvgPicture.asset(
            'assets/svgs/lab.svg',
            width: 50,
            height: 50,
          ),
          page: LabPrices.route),
      MainIcon(
        page: Clinics.route,
        name: 'العيادات'.tr,
        picture: SvgPicture.asset('assets/svgs/1.svg', width: 50, height: 50),
      ),
      MainIcon(
          name: 'المعرض'.tr,
          picture: SvgPicture.asset('assets/svgs/1.svg', width: 50, height: 50),
          page: '/prices'),
      MainIcon(
          picture: SvgPicture.asset('assets/svgs/contact.svg',
              width: 50, height: 50),
          name: 'تواصل معنا'.tr,
          page: '/prices'),
      MainIcon(
          name: 'العروض'.tr,
          picture: SvgPicture.asset('assets/svgs/1.svg', width: 50, height: 50),
          page: '/prices'),
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text('مركز ابن زياد الطبي'.tr),
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
