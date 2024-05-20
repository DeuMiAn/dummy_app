import 'package:dummy_app/app/common/webview.dart';
import 'package:dummy_app/app/home/home.controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return const Webview(
      url: 'http://dailytalk.net',
      title: 'home',
      isRefresh: false,
      showAppBar: false,
    );
  }
}