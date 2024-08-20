import 'dart:async';

import 'package:get/get.dart';

class InitController extends GetxController {
  String initTexxt = '앱초기화중';

  @override
  Future<void> onInit() async {
    super.onInit();
    await Future.delayed(const Duration(seconds: 4));
  }

  @override
  void dispose() {
    Get.delete<InitController>();
    print('초기화 컨트롤러 죽는다 응애');
    super.dispose();
  }
}
