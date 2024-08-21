import 'package:dummy_app/common/services/common_service.dart';
import 'package:get/get.dart';

class AppBinding implements Bindings {
  @override
  void dependencies() {
    Get.log('[$runtimeType] App Binding dependencies()');

    // 공통
    Get.put(CommonService.create(), permanent: true); //내리뷰관련 공통코드

    // 홈
    // Get.lazyPut(() => HomeDashboardController(), fenix: true);
  }
}
