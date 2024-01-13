import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AddTest extends StatefulWidget {
  static const route = '/addtest';
  AddTest({super.key});

  @override
  State<AddTest> createState() => _AddTestState();
}

class _AddTestState extends State<AddTest> {
  bool isloading = false;
  var nameControllr = TextEditingController();
  var priceController = TextEditingController();
  var formkey = GlobalKey<FormState>();
  var priceNode = FocusNode();
  @override
  void dispose() {
    nameControllr.dispose();
    priceController.dispose();
    // TODO: implement dispose
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
                  tag: 'اضافه فحص',
                  child: SvgPicture.asset(
                    'assets/svgs/add_test.svg',
                    width: 200,
                    height: 200,
                  ),
                ),
                Text(
                  'اضافه فحص جديد'.tr,
                  style: Theme.of(context)
                      .textTheme
                      .displaySmall!
                      .copyWith(fontFamily: 'Cairo-Regular'),
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'يجب ادخال اسم الفحص'.tr;
                    }
                  },
                  controller: nameControllr,
                  onFieldSubmitted: (value) {
                    FocusScope.of(context).requestFocus(priceNode);
                  },
                  decoration: InputDecoration(
                      errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.pink)),
                      border: UnderlineInputBorder(),
                      label: Text('اسم الفحص'.tr)),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'يجب ادخال سعر الفحص'.tr;
                    }
                  },
                  controller: priceController,
                  focusNode: priceNode,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      focusColor: Colors.purple,
                      errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.pink)),
                      border: UnderlineInputBorder(),
                      label: Text('السعر'.tr)),
                ),
                SizedBox(
                  height: 40,
                ),
                Container(
                  width: 200,
                  child: ElevatedButton(
                      style: ButtonStyle(
                          padding: MaterialStateProperty.resolveWith(
                              (states) => EdgeInsets.all(10)),
                          backgroundColor: MaterialStateColor.resolveWith(
                              (states) => Color.fromARGB(255, 27, 223, 33))),
                      onPressed: isloading
                          ? null
                          : () async {
                              if (formkey.currentState!.validate()) {
                                setState(() {
                                  isloading = true;
                                });
                                var lastId = 0;
                                var collection = FirebaseFirestore.instance
                                    .collection('tests');
                                var snpshots = await collection
                                    .orderBy('id', descending: true)
                                    .get();
                                if (snpshots.docs.length == 0) {
                                  lastId = 1;
                                } else {
                                  lastId = snpshots.docs[0].data()['id'] ?? 0;
                                }

                                lastId = lastId + 1;
                                print(lastId);

                                var document = await collection.add({
                                  'main_test_name': nameControllr.text,
                                  'price': priceController.text,
                                  'available': true,
                                  'id': lastId
                                });

                                setState(() {
                                  isloading = false;
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
