import 'package:dummy_app/gen/colors.gen.dart';
import 'package:dummy_app/presentation/init/init_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InitView extends GetView<InitController> {
  const InitView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: ColorName.remanPrimaryColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(children: [
              const SizedBox(height: 200, child: Center(child: Text('웹뷰 테스트'))),
              TextField(
                controller: controller.textEditingController,
                onEditingComplete: () {
                  controller.goToWebview();
                },
                decoration: const InputDecoration(
                  filled: true,
                  hintText: 'url을 입력해주세요',
                  fillColor: Colors.white,
                  focusColor: Colors.white,
                  border: OutlineInputBorder(),
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
