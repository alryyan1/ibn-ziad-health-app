import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ibnziad/doctor_detail.dart';
import 'package:ibnziad/export.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class Clinics extends StatelessWidget {
  const Clinics({super.key});
  static const route = '/clinics';

  @override
  Widget build(BuildContext context) {
    var clinicsRef = FirebaseFirestore.instance.collection('clinics');
    return Scaffold(
        appBar: AppBar(
          title: Text('العيادات'),
        ),
        body: StreamBuilder(
          stream: clinicsRef.snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasError) {
              return Text('error was occured');
            }
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var data = snapshot.data!.docs[index].data();
                return Directionality(
                  textDirection: TextDirection.rtl,
                  child: InkWell(
                      onTap: () {
                        Get.to(DoctorDetails(
                          name: data['doctor_name'],
                          specialist_name: data['specialist_name'],
                          ismale: data['male'],
                        ));
                      },
                      child: Slidable(
                        startActionPane: ActionPane(
                            // A motion is a widget used to control how the pane animates.
                            motion: const ScrollMotion(),
                            children: [],
                            // A pane can dismiss the Slidable.
                            dismissible: DismissiblePane(onDismissed: () {
                              clinicsRef
                                  .where('id', isEqualTo: data['id'])
                                  .get()
                                  .then((querysnapshots) {
                                querysnapshots.docs.forEach((test) {
                                  clinicsRef
                                      .doc(querysnapshots.docs[0].id)
                                      .delete();
                                });
                              });
                            }),
                          ),
                        key: ValueKey(
                          data['id'].toString()
                        ),
                        child: Card(
                          child: ListTile(
                            trailing: IconButton(
                                onPressed: () {},
                                color: Colors.white,
                                icon: Icon(
                                  Icons.info,
                                )),
                            tileColor: Color.fromARGB(255, 104, 174, 105),
                            subtitle: Text(
                              data['specialist_name'],
                              style: TextStyle(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  fontFamily: 'Tajawal-Regular',
                                  fontSize: 20),
                            ),
                            title: Text(
                              data['doctor_name'],
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Cairo-Regular',
                                  fontSize: 23,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      )),
                );
              },
            );
          },
        ));
  }
}
