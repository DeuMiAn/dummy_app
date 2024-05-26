import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reman_app/presentation/stateManagements/init/init.controller.dart';

class InitView extends GetView<InitController> {
  const InitView({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Center(
          child: Text(
        controller.initTexxt,
        style: const TextStyle(color: Colors.white),
      )),
    );
  }
}
