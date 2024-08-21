import 'package:dummy_app/gen/colors.gen.dart';
import 'package:dummy_app/presentation/common/widgets/webview/webview_widget.dart';
import 'package:flutter/material.dart';

class InitView extends StatelessWidget {
  const InitView({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorName.remanPrimaryColor,
      child: const Webview(url: 'https://flutter.dev', title: 'title'),
    );
  }
}
