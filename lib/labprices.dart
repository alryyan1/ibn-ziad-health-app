import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:ibnziad/export.dart';
import 'package:http/http.dart' as http;
import 'package:ibnziad/main_test.dart';

class LabPrices extends StatelessWidget {
  const LabPrices({super.key});
  static const route = '/labprices';

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

    void add() async {
      List<MainTest> tests = await MainTest.getMainTests();
      tests.forEach((test) {
        labCollection.add(test);
      });
    }

    void delete() {
      WriteBatch batch = FirebaseFirestore.instance.batch();
      labCollection.get().then((querysanpshots) {
        querysanpshots.docs.forEach((doc) {
          batch.delete(doc.reference);
        });
        batch.commit();
      });
    }

    print(labCollection);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('أسعار المعمل'),
      ),
      body: Container(
        child: StreamBuilder(
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

            return ListView.builder(
              shrinkWrap: true,
              primary: false,
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var data = snapshot.data!.docs[index].data();

                return Slidable(
                    // Specify a key if the Slidable is dismissible.
                    key: ValueKey(data.id.toString()),

                    // The start action pane is the one at the left or the top side.
                    startActionPane: ActionPane(
                      // A motion is a widget used to control how the pane animates.
                      motion: const ScrollMotion(),

                      // A pane can dismiss the Slidable.
                      dismissible: DismissiblePane(onDismissed: () {
                        labCollection
                            .where('id', isEqualTo: data.id)
                            .get()
                            .then((querysnapshots) {
                          querysnapshots.docs.forEach((test) {
                            labCollection
                                .doc(querysnapshots.docs[0].id)
                                .delete();
                          });
                        });
                      }),

                      // All actions are defined in the children parameter.
                      children: [
                        // A SlidableAction can have an icon and/or a label.
                        SlidableAction(
                          onPressed: (context) {},
                          backgroundColor: Color(0xFFFE4A49),
                          foregroundColor: Colors.white,
                          icon: Icons.delete,
                          label: 'Delete',
                        ),
                      ],
                    ),

                    // The child of the Slidable is what the user sees when the
                    // component is not dragged.
                    child: ListTile(
                      tileColor: index.isEven
                          ? Theme.of(context).scaffoldBackgroundColor
                          : Color.fromARGB(159, 115, 162, 103),
                      title: Text(data.name),
                      trailing: Text(data.price.toString()),
                    ));
              },
            );
          },
        ),
      ),
    );
  }
}
