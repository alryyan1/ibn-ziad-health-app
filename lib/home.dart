import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'main_icon.dart';
class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> boxes = [
      'قائمه التحاليل',
      'المعرض',
      'الأطباء الاختصاصين',
      'تواصل معنا',
      'الاخبار'
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text('مركز ابن زياد'),
        centerTitle: true,
      ),
      body: Container(
          child: GridView.builder(
        itemCount: boxes.length,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (context, index) {
          return MainIcon()
        },
      )),
    );
  }
}
