import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ibnziad/constants.dart';
import 'package:ibnziad/controllers/OnBoardPageController.dart';
import 'package:ibnziad/on-boarding/first_page.dart';
import 'package:ibnziad/on-boarding/second_page.dart';
import 'package:ibnziad/on-boarding/third_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        getPages: [
          GetPage(
              name: '/home',
              page: () {
                return OnBoarding();
              })
        ],
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: theme,
        initialRoute: '/home');
  }
}

class OnBoarding extends StatelessWidget {
  OnBoarding({super.key});
  var controller = Get.put(OnBoardPageController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: PageView(
        onPageChanged: (value) {
          controller.currentPage = value;
        },
        controller: controller.pageController,
        children: [First(), Second(), Third()],
      ),
    );
  }
}
