import 'package:dummy_app/common/config/app.routes.dart';
import 'package:dummy_app/presentation/init/init_controller.dart';
import 'package:get/get.dart';

import 'init_view.dart';

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
