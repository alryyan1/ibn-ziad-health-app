import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ibnziad/add_test.dart';
import 'labprices.dart';
import 'home.dart';
import 'main.dart';
import 'on-boarding/first_page.dart';
import 'clinics.dart';
import 'settings.dart';
import 'add_clinic.dart';
import 'contact-us.dart';
import 'language.dart';

ThemeData theme = ThemeData().copyWith(
  dropdownMenuTheme:
      DropdownMenuThemeData(textStyle: TextStyle(color: Colors.white)),
  inputDecorationTheme:
      InputDecorationTheme(labelStyle: TextStyle(color: Colors.white)),
  appBarTheme: AppBarTheme(
      backgroundColor: Colors.lightGreen,
      titleTextStyle: TextStyle(fontFamily: 'Tajawal-Regular', fontSize: 20)),
  scaffoldBackgroundColor: Color.fromARGB(255, 31, 143, 57),
  textTheme: TextTheme(
    displayLarge: TextStyle(color: Colors.black),
    headlineLarge: TextStyle(color: Colors.black),
    labelLarge: TextStyle(color: Colors.black),
    bodyLarge: TextStyle(color: Colors.black),
    titleSmall: TextStyle(color: Colors.black),
    titleMedium: TextStyle(color: Colors.black),
    headlineSmall: TextStyle(color: Colors.black),
    bodySmall: TextStyle(color: Colors.black),
    bodyMedium: TextStyle(fontSize: 18),
    displaySmall: TextStyle(fontFamily: 'Cairo-Regular'),
  ),
);

List<GetPage> pages = [
  GetPage(
    name: AddClinic.route,
    page: () {
      return AddClinic();
    },
  ),
  GetPage(
    name: AddTest.route,
    page: () {
      return AddTest();
    },
  ),
  GetPage(
    name: Settings.route,
    page: () {
      return Settings();
    },
  ),
  GetPage(
    name: Clinics.route,
    page: () {
      return Clinics();
    },
  ),
  GetPage(
    name: LanguageSettings.route,
    page: () {
      return LanguageSettings();
    },
  ),
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
  GetPage(
    name: LabPrices.route,
    page: () {
      return LabPrices();
    },
  ),
  GetPage(
    name: ContactUs.route,
    page: () {
      return ContactUs();
    },
  ),
];

// const host = 'alphalab.eu.ngrok.io';
const schema = 'http';
// const host = '192.168.78.108';
const host = '192.168.43.230';
const api = "/projects/bootstraped/new/api.php";
const base = "/projects/bootstraped/new/";
const register_page = "/note_app/singup.php";
const lab_api = "/projects/bootstraped/new/App/Views/Api/lab.php";
const clinic_api = "/projects/bootstraped/new/App/Views/Api/clinic.php";
const clinic_report = "/projects/bootstraped/new/App/Reports/clinic_report.php";
