import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reman_app/presentation/stateManagements/home/home.controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('홈')),
      body: Container(
        color: Colors.white,
        child: const Center(child: Text("홈 바디")),
      ),
    );
  }
}
