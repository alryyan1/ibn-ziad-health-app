import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ibnziad/doctor_clinc.dart';
import 'labprices.dart';
import 'home.dart';
import 'main.dart';
import 'on-boarding/first_page.dart';
import 'clinics.dart';

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
    name: Clinics.route,
    page: () {
      return Clinics();
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
