import 'package:get/get.dart';

class AppTranslator extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en': {
          'مركز ابن زياد': 'Ibn Zyad Clinc Center',
          'مرحبا بكم في مركز ابن زياد الطبي':
              'Welcome to Ibn Ziyad Medical Center',
          'التالي': 'Next',
          'شكرا لكم': 'Thank You',
           'عيادات اخصائيين':'Special Clinics',
          'المختبر': 'Laboratory',
          'موجات صوتيه': 'UltraSound Waves','قائمه التحاليل':'Test Prices','العيادات':'Clnics','المعرض':'Gallary','تواصل معنا':'Contact us','العروض':'Offers'
        },
      };
}
