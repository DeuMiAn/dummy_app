import 'package:get/get.dart';
import 'package:reman_app/config/app.routes.dart';
import 'package:reman_app/presentation/stateManagements/home/home.controller.dart';
import 'package:reman_app/presentation/stateManagements/init/init.controller.dart';

import 'init.view.dart';

class InitPage extends GetPage {
  static String routeName() => Routes.init;
  InitPage()
      : super(
          name: routeName(),
          page: () => const InitView(),
          binding: BindingsBuilder(() {
            Get.put(() => InitController());
          }),
        );
}
