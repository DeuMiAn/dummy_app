// ignore_for_file: unrelated_type_equality_checks

import 'package:dummy_app/common/models/device.dart';
import 'package:get/get.dart';

class CommonService extends GetxService {
  static CommonService get to => Get.find();

  // 디바이스 정보
  final _device = Device().obs;

  Device get device => _device.value;

  set device(Device value) => _device.value = value;

  CommonService._();

  factory CommonService.create() => CommonService._();

  void init() async {
    // 디바이스 정보 가져오기
    getDevice();
  }

  @override
  void onInit() {
    init();
    super.onInit();
  }

  void getDevice() {
    // var sDevice = UtilFunc.storage.read('device');
    // if (sDevice != null) {
    //   device = sDevice;
    // }
  }
}
