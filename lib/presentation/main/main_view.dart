import 'package:dummy_app/gen/colors.gen.dart';
import 'package:dummy_app/presentation/common/widgets/webview/webview_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'main_controller.dart';

class MainView extends GetView<MainController> {
  const MainView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: ColorName.remanPrimaryColor,
        child: Stack(children: [
          Obx(
            () => Webview(
              url: controller.webUrl.value,
              title: 'title',
            ),
          ),
        ]),
      ),
    );
  }
}
