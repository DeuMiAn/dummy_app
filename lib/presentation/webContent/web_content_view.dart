import 'package:dummy_app/gen/colors.gen.dart';
import 'package:dummy_app/presentation/common/widgets/webview/webview_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'web_content_controller.dart';

class WebContentView extends GetView<WebContentController> {
  const WebContentView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: ColorName.remanPrimaryColor,
        child: Stack(children: [
          Obx(
            () => Webview(
              url: controller.webUrl.value,
              title: controller.webUrl.value,
            ),
          ),
        ]),
      ),
    );
  }
}
