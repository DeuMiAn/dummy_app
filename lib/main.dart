import 'dart:async';
import 'dart:developer';

import 'package:dummy_app/common/bindings/app_binding.dart';
import 'package:dummy_app/common/bindings/binding.dart';
import 'package:dummy_app/common/bindings/network_binding.dart';
import 'package:dummy_app/common/config/app.pages.dart';
import 'package:dummy_app/common/config/app.routes.dart';
import 'package:dummy_app/common/constant/network_constant.dart';
import 'package:dummy_app/common/util.func.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'common/config/app.config.dart';

void main() async {
  runZonedGuarded(() async {
    // 비동기 사용처리
    WidgetsFlutterBinding.ensureInitialized();
    // 스토리지 초기화
    await GetStorage.init();

    await FlutterDownloader.initialize(
        debug:
            false, // optional: set to false to disable printing logs to console (default: true)
        ignoreSsl:
            true // option: set to false to disable working with http links (default: false)
        );

    // Env 환경에 따른 분리
    Get.put(Uri.parse(AppConfig.apiDomain), tag: kApiBaseUrlTag);
    Get.put(Uri.parse(AppConfig.imgDomain), tag: kImageBaseUrlTag);
    Get.put(Uri.parse(AppConfig.fileDomain), tag: kFileBaseUrlTag);

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
