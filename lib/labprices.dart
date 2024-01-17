import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:ibnziad/export.dart';
import 'package:http/http.dart' as http;
import 'package:ibnziad/labTestController.dart';
import 'package:ibnziad/main_test.dart';

class LabPrices extends StatefulWidget {
  const LabPrices({super.key});
  static const route = '/labprices';

  @override
  State<LabPrices> createState() => _LabPricesState();
}

class _LabPricesState extends State<LabPrices> {
  List<MainTest> list = [];
  bool init = false;

  @override
  Widget build(BuildContext context) {
    Get.put(LabTestController());
    var labCollection =
        FirebaseFirestore.instance.collection('tests').withConverter<MainTest>(
      fromFirestore: (snapshot, _) {
        return MainTest.fromJson(snapshot.data());
      },
      toFirestore: (test, _) {
        return test.toJson();
      },
    );
    labCollection.snapshots().listen((qsn) {
      print(qsn);
    });

    Future<void> updatePrice(
        String docid, editedPrice, MainTest selectedMainTest) {
      return labCollection
          .doc(docid)
          .update({'price': int.parse(editedPrice)}).then((value) {
        //success
        Get.snackbar(
            messageText: Text(
              'تمت العمليه بنجاح',
              textAlign: TextAlign.center,
            ),
            titleText: Icon(Icons.check_circle_outlined),
            snackPosition: SnackPosition.BOTTOM,
            'نجاح',
            'تمت  العمليه بنجاح');
        //update list in memory
        // setState(() {
        //   list = list.map((e) {
        //     if (e.id == selectedMainTest.id) {
        //       print('code run');
        //       e.price = int.parse(editedPrice);
        //       return e;
        //     } else {
        //       return e;
        //     }
        //   }).toList();
        // });
      });
    }

    var controller = Get.find<LabTestController>();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('أسعار المعمل'.tr),
      ),
      body: Container(
        padding: EdgeInsets.all(5),
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                  labelStyle: TextStyle(color: Colors.black),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white)),
                  focusColor: Colors.white,
                  border: OutlineInputBorder(),
                  label: Text('بحث'.tr),
                  suffixIcon: Icon(Icons.search)),
              onChanged: (value) {
                var filtered = controller.sourceList.where((maintest) {
                  return maintest.name
                      .toLowerCase()
                      .contains(value.toLowerCase());
                }).toList();
                print(filtered);
                controller.updateList(filtered);
              },
            ),
            StreamBuilder(
              stream: labCollection.orderBy('id').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('error occured');
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (init == false) {
                  controller.list =
                      snapshot.data!.docs.map((qshot) => qshot.data()).toList();

                  print('list init');
                  print(list);
                }
                init = true;

                controller.list = snapshot.data!.docs.map((qsn) {
                  return qsn.data();
                }).toList();
                controller.sourceList = controller.list;

                return GetBuilder<LabTestController>(builder: (controller) {
                  return TestList(
                      list: controller.list,
                      labCollection: labCollection,
                      update: updatePrice);
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

class TestList extends StatefulWidget {
  Function update;
  TestList({
    super.key,
    required this.list,
    required this.labCollection,
    required this.update,
  });

  final List<MainTest> list;
  final CollectionReference<MainTest> labCollection;

  @override
  State<TestList> createState() => _TestListState();
}

class _TestListState extends State<TestList> {
  @override
  Widget build(BuildContext context) {
    //   var controller = Get.put(LabTestController());
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        primary: false,
        itemCount: widget.list.length,
        itemBuilder: (context, index) {
          var maintest = widget.list[index];
          print('device locale ');
          print(Get.locale);
          print('get locale ');

          print(Get.deviceLocale);
          var testname = Get.locale == Locale('ar', 'US')
              ? maintest.translation
              : maintest.name;

          return Slidable(
              // Specify a key if the Slidable is dismissible.
              key: UniqueKey(),

              // The start action pane is the one at the left or the top side.
              startActionPane: ActionPane(
                // A motion is a widget used to control how the pane animates.
                motion: const ScrollMotion(),
                children: [
                  Flexible(
                    child: Container(
                      color: Colors.red,
                      child: IconButton(
                          onPressed: () {}, icon: Icon(Icons.delete)),
                    ),
                  )
                ],
                // A pane can dismiss the Slidable.
                dismissible: DismissiblePane(onDismissed: () {
                  widget.labCollection
                      .where('id', isEqualTo: maintest.id)
                      .get()
                      .then((querysnapshots) {
                    querysnapshots.docs.forEach((test) {
                      widget.labCollection
                          .doc(querysnapshots.docs[0].id)
                          .delete();
                    });
                  });
                }),
              ),

              // The child of the Slidable is what the user sees when the
              // component is not dragged.
              child: ListTile(
                title: Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          testname,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      Expanded(
                          child: IconButton(
                              onPressed: () {
                                Get.defaultDialog(
                                    middleText: maintest.terms,
                                    titleStyle: TextStyle(color: Colors.black));
                              },
                              icon: Icon(Icons.info)))
                    ],
                  ),
                ),
                trailing: SizedBox(
                    width: 100,
                    child: TextFormField(
                      style: TextStyle(
                          fontSize: 23,
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontWeight: FontWeight.bold),
                      decoration: InputDecoration(focusColor: Colors.white),
                      onFieldSubmitted: (editedPrice) {
                        widget.labCollection
                            .where('id', isEqualTo: maintest.id)
                            .get()
                            .then((qshots) {
                          var id = qshots.docs[0].id;
                          var selectedMainTest = qshots.docs[0].data();

                          Get.showOverlay(
                              loadingWidget: Center(
                                child: CircularProgressIndicator(),
                              ),
                              asyncFunction: () {
                                return widget.update(
                                    id, editedPrice, selectedMainTest);
                              });
                        });
                      },
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      initialValue: maintest.price.toString(),
                    )),
              ));
        },
      ),
    );
  }
}
