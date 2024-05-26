import 'package:get/get.dart';
import 'package:reman_app/presentation/stateManagements/home/home.controller.dart';
import 'package:reman_app/presentation/stateManagements/init/init.controller.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    // 공통
    // Get.put(CommonService.create(), permanent: true);
    // Get.put(StorageService.create(), permanent: true);

    // 앱 초기화
    Get.lazyPut(() => InitController(), fenix: true);
    // 앱 홈
    Get.lazyPut(() => HomeController(), fenix: true);
  }
}
