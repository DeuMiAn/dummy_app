import 'package:dummy_app/app/Home/Home.view.dart';
import 'package:dummy_app/app/home/home.controller.dart';
import 'package:get/get.dart';

class HomePage extends GetPage {
  static String routeName() => '/home';
  HomePage()
      : super(
          name: routeName(),
          page: () => const HomeView(),
          binding: BindingsBuilder(() {
            Get.lazyPut(() => HomeController());
          }),
        );
}
