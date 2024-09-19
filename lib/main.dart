import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:venturo_food/configs/pages/main_page.dart';
import 'package:venturo_food/configs/routes/main_route.dart';
import 'package:venturo_food/configs/themes/main_theme.dart';
import 'package:venturo_food/firebase_options.dart';
import 'package:venturo_food/modules/global_bindings/global_binding.dart';
import 'package:venturo_food/modules/global_controllers/analytics_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Get.put(AnalyticsController());

  await SentryFlutter.init(
    (options) {
      options.dsn =
          'https://86e887d5dc9744c090e86f9b303e8d44@o4505368078254080.ingest.sentry.io/4505368079499264';
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
        initialRoute: MainRoute.splashScreen,
        theme: mainTheme,
        defaultTransition: Transition.native,
        getPages: MainPage.main,
        initialBinding: GlobalBinding(),
      ),
    );
  }
}
