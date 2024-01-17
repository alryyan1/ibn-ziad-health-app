import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'main_icon.dart';
import 'package:get/get.dart';
import 'add_clinic.dart';
import 'main_test.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'language.dart';
import 'add_specialist.dart';
class Settings extends StatelessWidget {
  const Settings({super.key});
  static const route = '/settings';

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
    List<Widget> boxes = [
      MainIcon(
          picture: SvgPicture.asset('assets/svgs/add_test.svg',
              width: 50, height: 50),
          name: 'اضافه فحص'.tr,
          page: '/addtest'),
      MainIcon(
          name: 'عياده جديده'.tr,
          picture: SvgPicture.asset('assets/svgs/add_clinic.svg',
              width: 50, height: 50),
          page: AddClinic.route),
          
      MainIcon(
          name: 'تخصص جديد'.tr,
          picture: SvgPicture.asset('assets/svgs/add_clinic.svg',
              width: 50, height: 50),
          page: AddSpecialist.route),
      MainIcon(
          name: 'اللغه'.tr,
          picture: SvgPicture.asset('assets/svgs/settings.svg',
              width: 50, height: 50),
          page: LanguageSettings.route),
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text('الاعدادات'.tr),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
            child: Column(
          children: [
            GridView.builder(
              shrinkWrap: true,
              itemCount: boxes.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 2 / 1.5,
                  crossAxisCount: 2,
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 15),
              itemBuilder: (context, index) {
                return boxes[index];
              },
            ),
            Spacer(),
            ElevatedButton(
                onPressed: add,
                child: Text('انشاء قاعده تحاليل علي سحابه قوقل'.tr)),
            ElevatedButton(onPressed: delete, child: Text('مسح بيانات'.tr))
          ],
        )),
      ),
    );
  }
}
