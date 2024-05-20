import 'package:dummy_app/app/initialize/initialize.controller.dart';
import 'package:dummy_app/app/initialize/initialize.view.dart';
import 'package:get/get.dart';

class InitializePage extends GetPage {
  static String routeName() => '/';
  InitializePage()
      : super(
          name: routeName(),
          page: () => const InitializeView(),
          binding: BindingsBuilder(() {
            Get.lazyPut(() => InitializeController());
          }),
        );
}
