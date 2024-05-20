import 'dart:async';

import 'package:dummy_app/app/home/home.page.dart';
import 'package:get/get.dart';

class InitializeController extends GetxController {
  final name = 'aaa';
  RxBool isLoad = true.obs;
  @override
  void onInit() {
    isLoad.value = true;
    print('로딩중');
    super.onInit();
    print('로딩중');
    Timer(const Duration(seconds: 3), () {
      isLoad.value = false;
      Get.offAllNamed(HomePage.routeName());
    });
  }
}
