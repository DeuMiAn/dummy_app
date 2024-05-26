import 'dart:async';
import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:reman_app/common/util.func.dart';
import 'package:reman_app/config/app.pages.dart';
import 'package:reman_app/config/app.routes.dart';
import 'package:reman_app/config/bindings/app.binding.dart';
import 'package:reman_app/config/bindings/binding.dart';
import 'package:reman_app/config/bindings/network.binding.dart';

void main() async {
  runZonedGuarded(() async {
    // 비동기 사용처리
    WidgetsFlutterBinding.ensureInitialized();

    // firbase 초기화
    runApp(const MainApp());
  }, (error, stackTrace) {
    log('error out side:', error: error, stackTrace: stackTrace);
  });
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: Routes.init,
      getPages: AppPages.pages,
      scaffoldMessengerKey: kScaffoldMessengerKey,
      debugShowCheckedModeBanner: true,
      initialBinding: MultipleBindingBuilder(
        bindings: [AppBinding(), NetworkBinding()],
      ),
      builder: (context, child) {
        EasyLoading.instance
          ..loadingStyle = EasyLoadingStyle.custom
          ..indicatorColor = Colors.blueAccent
          ..maskColor = Colors.white.withOpacity(0.54)
          ..maskType = EasyLoadingMaskType.custom
          ..textColor = Colors.black
          ..backgroundColor = Colors.transparent
          ..contentPadding = EdgeInsets.zero
          ..progressColor = Colors.black
          ..boxShadow = []
          ..indicatorType = EasyLoadingIndicatorType.fadingCube;
        ErrorWidget.builder = (errorDetails) {
          Widget error = Text('$errorDetails');
          if (child is Scaffold || child is Navigator) {
            error = Scaffold(
              body: SafeArea(child: error),
            );
          }
          return error;
        };
        return MediaQuery(
          data: MediaQuery.of(context)
              .copyWith(textScaler: const TextScaler.linear(1.0)),
          child: EasyLoading.init()(context, child),
        );
      },
    );
  }
}
