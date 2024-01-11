import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'home.dart';
import 'main.dart';
import 'on-boarding/first_page.dart';

ThemeData theme = ThemeData().copyWith(
  appBarTheme: AppBarTheme(
      backgroundColor: Colors.lightGreen,
      titleTextStyle: TextStyle(fontFamily: 'Tajawal-Regular', fontSize: 20)),
  scaffoldBackgroundColor: Color.fromARGB(255, 31, 143, 57),
  textTheme: TextTheme(
    displaySmall: TextStyle(fontFamily: 'Cairo-Regular'),
  ),
);

List<GetPage> pages = [
  GetPage(
    name: '/home',
    page: () {
      return Home();
    },
  ),
  GetPage(
    name: '/onBoarding',
    page: () {
      return OnBoarding();
    },
  ),
  GetPage(
    name: '/first',
    page: () {
      return First();
    },
  ),
];
