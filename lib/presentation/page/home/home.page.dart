import 'package:get/get.dart';
import 'package:reman_app/config/app.routes.dart';
import 'package:reman_app/presentation/stateManagements/home/home.controller.dart';

import 'home.view.dart';

class HomePage extends GetPage {
  static String routeName() => Routes.home;
  HomePage()
      : super(
          name: routeName(),
          page: () => const HomeView(),
          binding: BindingsBuilder(() {
            Get.lazyPut(() => HomeController());
          }),
        );
}
