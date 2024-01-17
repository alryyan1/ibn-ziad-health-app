import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AddSpecialist extends StatefulWidget {
  static const route = '/addspecialist';
  AddSpecialist({super.key});

  @override
  State<AddSpecialist> createState() => _AddSpecialistState();
}

class _AddSpecialistState extends State<AddSpecialist> {
  bool isloading = false;

  var nameControllr = TextEditingController();
  var formkey = GlobalKey<FormState>();
  var specialistNode = FocusNode();
  @override
  void dispose() {
    nameControllr.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: EdgeInsets.all(10),
      child: SafeArea(
        child: Form(
          key: formkey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Hero(
                  tag: 'تخصص جديد',
                  child: SvgPicture.asset(
                    'assets/svgs/add_clinic.svg',
                    width: 200,
                    height: 200,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                FittedBox(
                  child: Text(
                    'تخصص جديد'.tr,
                    style: Theme.of(context)
                        .textTheme
                        .displaySmall!
                        .copyWith(fontFamily: 'Tajawal-Regular'),
                  ),
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'يجب ان يكون الاسم موجود'.tr;
                    }
                  },
                  controller: nameControllr,
                  onFieldSubmitted: (value) {
                    FocusScope.of(context).requestFocus(specialistNode);
                  },
                  decoration: InputDecoration(label: Text('اسم التخصص'.tr)),
                ),
              
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: 200,
                  child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateColor.resolveWith(
                              (states) => Color.fromARGB(255, 112, 231, 22))),
                      onPressed: isloading
                          ? null
                          : () async {
                              if (formkey.currentState!.validate()) {
                                setState(() {
                                  isloading = true;
                                });
                                var lastId = 0;
                                var collection = FirebaseFirestore.instance
                                    .collection('specialists');
                                var snpshots = await collection
                                    .orderBy('id', descending: true)
                                    .get();
                                if (snpshots.docs.length == 0) {
                                  lastId = 1;
                                } else {
                                  lastId = snpshots.docs[0].data()['id'];
                                }

                                lastId = lastId + 1;
                                print(lastId);
                                await collection.add({
                                  'name': nameControllr.text,
                                  'id': lastId
                                });

                                setState(() {
                                  isloading = false;
                                });
                                setState(() {
                                  nameControllr.text = '';
                                });
                                Get.showSnackbar(GetSnackBar(
                                  messageText: Text(
                                    'تم الحفظ بنجاح',
                                    textAlign: TextAlign.center,
                                  ),
                                  duration: Duration(seconds: 2),
                                  titleText: Text(
                                    'نجاح',
                                    textAlign: TextAlign.center,
                                  ),
                                ));
                              }
                            },
                      child: isloading  ? Center(child: CircularProgressIndicator(),) : Text('حفظ'.tr)),
                )
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
