import 'package:dummy_app/app/initialize/initialize.controller.dart';
import 'package:dummy_app/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class InitializeView extends GetView<InitializeController> {
  const InitializeView({super.key});
  @override
  Widget build(BuildContext context) {
    if (controller.isLoad.isTrue) {
      return Container(
        child: Center(child: Assets.images.h1Logo.svg()),
      );
    } else {
      return const SizedBox();
    }
  }
}
