import 'export.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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
