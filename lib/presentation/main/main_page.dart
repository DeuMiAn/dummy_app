import 'package:dummy_app/presentation/main/main_controller.dart';
import 'package:dummy_app/presentation/main/main_view.dart';
import 'package:get/get.dart';

class MainPage extends GetPage {
  static String routeName() => '/main';
  MainPage()
      : super(
          name: routeName(),
          page: () => const MainView(),
          binding: BindingsBuilder(() {
            Get.lazyPut(() => MainController());
          }),
        );
}
