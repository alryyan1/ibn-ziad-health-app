import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainIcon extends StatelessWidget {
  MainIcon({
    super.key,
    required name,
    required icon,
    required String page,
    this.args,
  })  : _name = name,
        _icon = icon,
        _page = page;
  Object? args;

  String _name;
  Widget _icon;
  String _page;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Get.toNamed(_page, arguments: args);
        },
        child: Container(
          decoration: BoxDecoration(
              color: Colors.black38,
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    offset: Offset(-3, 5),
                    blurRadius: 2,
                    spreadRadius: 1)
              ],
              border: Border.all(),
              borderRadius: BorderRadius.circular(20)),
          width: 35,
          height: 35,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _icon,
                SizedBox(
                  height: 10,
                ),
                FittedBox(
                  child: Text(
                    _name,
                    style: TextStyle(fontSize: 18),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
