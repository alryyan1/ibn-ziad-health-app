import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:ibnziad/export.dart';

class LanguageSettings extends StatelessWidget {
  const LanguageSettings({super.key});
  static const route = '/lang';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('اللغه'.tr),
      ),
      body: Column(
        children: [
          Text('اختار اللغه المفضله'.tr),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    child: Text('العربيه'),
                    onPressed: () {
                      Get.updateLocale(Locale('ar', 'US'));
                    },
                  ),
                  ElevatedButton(
                    child: Text('English'),
                    onPressed: () {
                      Get.updateLocale(Locale('en', 'Us'));
                    },
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
