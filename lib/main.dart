import 'export.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  var token = await FirebaseMessaging.instance.getToken();

  print('User granted permission: ${settings.authorizationStatus}');
  print('User granted permission: ${token}');
  FirebaseFirestore.instance.collection('tokens').add({'token': token});

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        translations: AppTranslator(),
        locale: Get.deviceLocale,
        getPages: pages,
        debugShowCheckedModeBanner: false,
        title: 'Ibn Ziad Medical Center',
        theme: theme,
        initialRoute: '/onBoarding');
  }
}

class OnBoarding extends StatelessWidget {
  OnBoarding({super.key});
  var controller = Get.put(OnBoardPageController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: PageView(
        onPageChanged: (value) {
          controller.currentPage = value;
        },
        controller: controller.pageController,
        children: [First(), Second()],
      ),
    );
  }
}
