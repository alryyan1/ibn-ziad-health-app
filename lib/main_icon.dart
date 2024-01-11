import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MainIcon extends StatelessWidget {
  MainIcon({
    super.key,
    required name,
    required picture,
    required String page,
    this.args,
  })  : _name = name,
        _picture = picture,
        _page = page;
  Object? args;

  String _name;
  SvgPicture _picture;
  String _page;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Get.toNamed(_page, arguments: args);
        },
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Color.fromARGB(255, 160, 225, 162),
                Color.fromARGB(255, 85, 127, 65)
              ]),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                    color: Colors.green,
                    blurRadius: 3,
                    spreadRadius: 2,
                    offset: Offset(-2, 4))
              ]),
          width: 45,
          height: 45,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _picture,
                SizedBox(
                  height: 10,
                ),
                FittedBox(
                  child: Text(
                    _name,
                    style:
                        TextStyle(fontSize: 18, fontFamily: 'Tajawal-Regular'),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
