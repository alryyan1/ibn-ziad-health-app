import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ibnziad/specialistController.dart';

class AddClinic extends StatefulWidget {
  static const route = '/addclinic';
  AddClinic({super.key});

  @override
  State<AddClinic> createState() => _AddClinicState();
}

class _AddClinicState extends State<AddClinic> {
  bool isloading = false;

  var nameControllr = TextEditingController();
  var specialistController = TextEditingController();
  var formkey = GlobalKey<FormState>();
  var specialistNode = FocusNode();
  @override
  void dispose() {
    nameControllr.dispose();
    specialistController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  int selectedSpecialist = 1;
  int gender = 1;
  List<Map> dropList = [];
  List<DropdownMenuItem> dropDownList = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Get.put(SpecialistController());

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
                  tag: 'عياده جديده',
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
                    'اضافه عياده جديده'.tr,
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
                  decoration: InputDecoration(label: Text('اسم الطبيب'.tr)),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                    width: double.infinity,
                    child: Text(
                      'التخصص'.tr,
                      textAlign: TextAlign.start,
                    )),
                GetBuilder<SpecialistController>(
                  init: SpecialistController(),
                  builder: (controller) {
                    return controller.isLoading
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : DropdownButton(
                            isExpanded: true,
                            value: controller.selected,
                            items: controller.list.map((e) {
                              return DropdownMenuItem<int>(
                                child: Text(e['name']),
                                value: e['id'],
                              );
                            }).toList(),
                            onChanged: (value) {
                              controller.updateSelected(value);
                            },
                          );
                  },
                ),
                Container(
                    width: double.infinity,
                    child: Text(
                      'النوع'.tr,
                      textAlign: TextAlign.start,
                    )),
                DropdownButton(
                  value: gender,
                  isExpanded: true,
                  items: [
                    DropdownMenuItem(
                      child: Text(
                        'ذكر'.tr,
                        style: TextStyle(color: Colors.black),
                      ),
                      value: 1,
                    ),
                    DropdownMenuItem(
                      child: Text(
                        'انثي'.tr,
                        style: TextStyle(color: Colors.black),
                      ),
                      value: 2,
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      gender = value!;
                    });
                  },
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
                                    .collection('clinics');
                                var snpshots = await collection
                                    .orderBy('id', descending: true)
                                    .get();
                                if (snpshots.docs.length == 0) {
                                  lastId = 1;
                                } else {
                                  lastId = snpshots.docs[0].data()['id'];
                                }

                                lastId = lastId + 1;
                                // print(lastId);,
                                var qsnapShot = await FirebaseFirestore.instance
                                    .collection('specialists')
                                    .where('id', isEqualTo: Get.find<SpecialistController>().selected)
                                    .get();
                                var specialistObj = qsnapShot.docs[0].data();

                                var fd = await collection.add({
                                  'doctor_name': nameControllr.text,
                                  'specialist': specialistObj,
                                  'male': gender == 1,
                                  'id': lastId
                                });

                                setState(() {
                                  isloading = false;
                                });
                                setState(() {
                                  nameControllr.text = '';
                                  specialistController.text = '';
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
                      child: isloading
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : Text('حفظ'.tr)),
                )
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
