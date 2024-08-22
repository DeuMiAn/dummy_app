import 'package:get/get.dart';

class WebContentController extends GetxController {
  final String? urlLink;
  final RxString webUrl = ''.obs;

  WebContentController(this.urlLink);
  @override
  Future<void> onInit() async {
    super.onInit();
    webUrl.value = urlLink ?? '빈값';
  }
}
