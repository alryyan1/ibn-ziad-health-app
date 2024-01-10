import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnBoardPageController extends GetxController {
  int currentPage = 0;
  PageController pageController = PageController(initialPage: 0);

  void next() {
    currentPage += 1;
    pageController.animateToPage(currentPage,
        duration: const Duration(milliseconds: 300), curve: Curves.bounceIn);
  }
}
