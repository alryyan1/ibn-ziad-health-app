import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AddClinic extends StatefulWidget {
  static const route = '/addclinic';
  AddClinic({super.key});

  @override
  State<AddClinic> createState() => _AddClinicState();
}

class _AddClinicState extends State<AddClinic> {
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

  int gender = 1;

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
                SvgPicture.asset(
                  'assets/svgs/positive.svg',
                  width: 200,
                  height: 200,
                ),
                Text(
                  'اضافه عياده جديده'.tr,
                  style: Theme.of(context)
                      .textTheme
                      .displaySmall!
                      .copyWith(fontFamily: 'Cairo-Regular'),
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
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'يجب ان يكون التخصص موجود'.tr;
                    }
                  },
                  controller: specialistController,
                  focusNode: specialistNode,
                  decoration: InputDecoration(label: Text('الاختصاص'.tr)),
                ),
                DropdownButton(
                  value: gender,
                  isExpanded: true,
                  items: [
                    DropdownMenuItem(
                      child: Text(
                        'ذكر',
                        style: TextStyle(color: Colors.black),
                      ),
                      value: 1,
                    ),
                    DropdownMenuItem(
                      child: Text(
                        'انثي',
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
                ElevatedButton(
                    onPressed: () async {
                      if (formkey.currentState!.validate()) {
                        var lastId = 0;
                        var collection =
                            FirebaseFirestore.instance.collection('clinics');
                        var snpshots = await collection
                            .orderBy('id', descending: true)
                            .get();
                        if (snpshots.docs.length == 0) {
                          lastId = 1;
                        } else {
                          lastId = int.parse(snpshots.docs[0].data()['id']);
                        }

                        lastId = lastId + 1;
                        print(lastId);
                        var fd = await collection.add({
                          'doctor_name': nameControllr.text,
                          'specialist_name': specialistController.text,
                          'male': gender == 1,
                          'id': lastId
                        });

                        Get.showSnackbar(GetSnackBar(
                          duration: Duration(milliseconds: 2000),
                          messageText: Text(
                            'تمت العمليه بنجاح',
                            textAlign: TextAlign.center,
                          ),
                        ));
                      }
                    },
                    child: Text('حفظ'.tr))
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
