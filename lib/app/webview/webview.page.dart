import 'package:dummy_app/app/common/webview.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PolicyMarketingPage extends GetView {
  final bool showAppBar;

  const PolicyMarketingPage({
    Key? key,
    this.showAppBar = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Webview(
      url: 'http://dailytalk.net/',
      title: '',
      isRefresh: false,
      showAppBar: showAppBar,
    );
  }
}
