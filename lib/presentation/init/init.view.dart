import 'package:dummy_app/gen/colors.gen.dart';
import 'package:flutter/material.dart';

class InitView extends StatelessWidget {
  const InitView({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
        color: ColorName.remanPrimaryColor, child: const Text('ds'));
  }
}
