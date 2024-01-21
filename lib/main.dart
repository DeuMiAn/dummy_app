import 'dart:async';
import 'dart:developer';

import 'package:dummy_app/app/common/util.func.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

void main() async {
  runZonedGuarded(() {
    runApp(const MainApp());
  }, (error, stackTrace) {
    log('error out side:', error: error, stackTrace: stackTrace);
  });
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    Timer? timer;
    late double progress;
    return GetMaterialApp(
      scaffoldMessengerKey: kScaffoldMessengerKey,
      debugShowCheckedModeBanner: true,
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
      home: SafeArea(
        child: Column(
          children: [
            Container(
              child: GestureDetector(
                  onTap: () =>
                      EasyLoading.showProgress(0.3, status: 'downloading...'),
                  child: const Text('안녕세상아')),
            ),
            Container(
              child: GestureDetector(
                  onTap: () {
                    progress = 0;
                    timer?.cancel();
                    timer = Timer.periodic(const Duration(milliseconds: 100),
                        (Timer timer) {
                      EasyLoading.showProgress(progress,
                          status: '${(progress * 100).toStringAsFixed(0)}%');
                      progress += 0.03;

                      if (progress >= 1) {
                        timer.cancel();
                        EasyLoading.dismiss();
                      }
                    });
                  },
                  child: const Text('안녕세상아')),
            ),
          ],
        ),
      ),
    );
  }
}
