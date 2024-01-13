import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:ibnziad/export.dart';
import 'package:http/http.dart' as http;
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
    var labCollection =
        FirebaseFirestore.instance.collection('tests').withConverter<MainTest>(
      fromFirestore: (snapshot, _) {
        return MainTest.fromJson(snapshot.data());
      },
      toFirestore: (test, _) {
        return test.toJson();
      },
    );

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('أسعار المعمل'.tr),
      ),
      body: Container(
        padding: EdgeInsets.all(15),
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
                var filtered = list.where((maintest) {
                  return maintest.name
                      .toLowerCase()
                      .contains(value.toLowerCase());
                }).toList();
                setState(() {
                  list = filtered;
                });
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
                  list =
                      snapshot.data!.docs.map((qshot) => qshot.data()).toList();
                }
                init = true;

                return Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    primary: false,
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      var maintest = list[index];

                      return Slidable(
                          // Specify a key if the Slidable is dismissible.
                          key: ValueKey(maintest.id.toString()),

                          // The start action pane is the one at the left or the top side.
                          startActionPane: ActionPane(
                            // A motion is a widget used to control how the pane animates.
                            motion: const ScrollMotion(),
                            children: [],
                            // A pane can dismiss the Slidable.
                            dismissible: DismissiblePane(onDismissed: () {
                              labCollection
                                  .where('id', isEqualTo: maintest.id)
                                  .get()
                                  .then((querysnapshots) {
                                querysnapshots.docs.forEach((test) {
                                  labCollection
                                      .doc(querysnapshots.docs[0].id)
                                      .delete();
                                });
                              });
                            }),
                          ),

                          // The child of the Slidable is what the user sees when the
                          // component is not dragged.
                          child: ListTile(
                            tileColor: index.isEven
                                ? Theme.of(context).scaffoldBackgroundColor
                                : Color.fromARGB(159, 115, 162, 103),
                            title: Text(
                              maintest.name,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Cairo-Regular',
                                  fontSize: 20),
                            ),
                            trailing: SizedBox(
                                width: 100,
                                child: TextFormField(
                                  onChanged: (value) {
                                    labCollection
                                        .where('id', isEqualTo: maintest.id)
                                        .get()
                                        .then((qshots) {
                                      var id = qshots.docs[0].id;
                                      labCollection
                                          .doc(id)
                                          .update({'price': int.parse(value)});
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
              },
            ),
          ],
        ),
      ),
    );
  }
}
