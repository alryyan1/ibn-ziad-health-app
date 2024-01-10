import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ibnziad/controllers/OnBoardPageController.dart';

class First extends StatelessWidget {
  const First({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<OnBoardPageController>();
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [Color.fromARGB(255, 31, 143, 57), Colors.lightGreen])),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'مركز ابن زياد ',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.displaySmall,
            ),
            SizedBox(
              height: 70,
            ),
            Container(
              height: 200,
              decoration: BoxDecoration(
                image: const DecorationImage(
                  image: AssetImage("assets/images/2.png"),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            SizedBox(
              height: 70,
            ),
            Text('  مرحبا بكم في مركز اب زياد الطبي  ',
                textAlign: TextAlign.center,
                style: TextStyle(fontFamily: 'Tajawal-Regular', fontSize: 30)),
            const Spacer(),
            Container(
              height: 55,
              padding: EdgeInsets.all(5),
              width: double.infinity,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateColor.resolveWith((states) => Colors.green),
                ),
                onPressed: () {
                  print('init');
                  print(controller.currentPage);
                  controller.next();
                },
                child: const Text('التالي'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
