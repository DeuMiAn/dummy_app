import 'package:get/get.dart';
import 'package:reman_app/config/app.routes.dart';

class InitController extends GetxController {
  String initTexxt = '앱초기화중';
  @override
  Future<void> onInit() async {
    super.onInit();
    print('시작');
    await Future.delayed(const Duration(seconds: 5));
    Get.offAllNamed(Routes.home);
  }

  @override
  void dispose() {
    Get.delete<InitController>();
    print('초기화 컨트롤러 죽는다 응애');
    super.dispose();
  }
}
