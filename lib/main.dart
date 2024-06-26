import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quik_broker_admin/Helper/constant/controller/ConstantController.dart';
import 'package:quik_broker_admin/firebase_options.dart';
import 'package:quik_broker_admin/pages/Home/view/HomeScreen.dart';
import 'package:quik_broker_admin/pages/login/views/LoginPage.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'pages/SplashScreen/views/SplashScreen.dart';

Future<void> main() async {
  runZonedGuarded(() async {
    await SentryFlutter.init(
      (options) {
        options.dsn = 'https://example@sentry.io/add-your-dsn-here';
      },
    );

    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    WidgetsFlutterBinding.ensureInitialized();
    runApp(const MyApp());
  }, (exception, stackTrace) async {
    await Sentry.captureException(exception, stackTrace: stackTrace);
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quik broker admin',
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: const Color.fromRGBO(4, 28, 50, 1)),
        useMaterial3: true,
        // scrollbarTheme: ScrollbarThemeData(
        //   thumbColor: WidgetStateProperty.all(Colors.transparent),
        // ),
      ),
      home: FutureBuilder(
        future: Future.delayed(
          const Duration(seconds: 2),
        ),
        builder: (context, snapshot) {
          final Constantcontroller controller = Get.put(Constantcontroller());
          if (snapshot.connectionState == ConnectionState.done) {
            return Obx(
              () => controller.isLogin.value
                  ? const HomeScreen()
                  : const LoginPage(),
            );
          } else {
            return const Splashscreen();
          }
        },
      ),
    );
  }
}
