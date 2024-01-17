import 'package:ibnziad/export.dart';
import 'package:ibnziad/main_test.dart';

class LabTestController extends GetxController {
  List<MainTest> list = [];
  List<MainTest> sourceList = [];

  void updateList(newList) {
    list = newList;
    print(newList);
    update();
  }
}
