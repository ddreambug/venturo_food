import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:venturo_food/configs/pages/main_page.dart';
import 'package:venturo_food/configs/routes/main_route.dart';
import 'package:venturo_food/configs/themes/main_theme.dart';
import 'package:venturo_food/firebase_options.dart';
import 'package:venturo_food/modules/global_bindings/global_binding.dart';
import 'package:venturo_food/modules/global_controllers/analytics_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //hive init
  await Hive.initFlutter();
  await Hive.openBox("venturo");

  //firebase init
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Get.put(AnalyticsController());

  await SentryFlutter.init(
    (options) {
      options.dsn =
          'https://3568268c0ddc5887b9b0c185423fb1e2@o4507999775752192.ingest.us.sentry.io/4507999795478528';
      options.tracesSampleRate = 1.0;
    },
    appRunner: () => runApp(const MyApp()),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(414, 896),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => GetMaterialApp(
        title: 'Trainee Skeleton',
        debugShowCheckedModeBanner: false,

        ///debugging purpose
        // initialRoute: MainRoute.list,
        initialRoute: MainRoute.splashScreen,
        theme: mainTheme,
        defaultTransition: Transition.native,
        getPages: MainPage.main,
        initialBinding: GlobalBinding(),
        builder: EasyLoading.init(),
      ),
    );
  }
}
