import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class SpecialistController extends GetxController {
  List<Map> list = [];
  bool isLoading = true;
  updateList(newList) {
    list = newList;
    update();
  }

  int? selected;
  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    print('init started');
    var spcialistCollection =
        FirebaseFirestore.instance.collection('specialists');
    spcialistCollection.get().then((qshots) {
      list = qshots.docs.map((doc) {
        var document = doc.data();

        return document;
      }).toList();
      selected = list[0]['id'];
      update();
      isLoading = false;
    });
  }

  void updateSelected(int? value) {
    selected = value;
    update();
  }
}
