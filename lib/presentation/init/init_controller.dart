import 'dart:async';

import 'package:dummy_app/presentation/webContent/web_content_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InitController extends GetxController {
  String initTexxt = '앱초기화중';
  TextEditingController textEditingController = TextEditingController();

  @override
  Future<void> onInit() async {
    super.onInit();
    await Future.delayed(const Duration(seconds: 4));
  }

  void goToWebview() {
    Get.toNamed(WebContentPage.routeName(
        Uri.encodeComponent(textEditingController.text)));
  }

  @override
  void dispose() {
    Get.delete<InitController>();
    print('초기화 컨트롤러 죽는다 응애');
    super.dispose();
  }
}
