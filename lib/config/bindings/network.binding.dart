import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:reman_app/config/bindings/network.interceptors.dart';
import 'package:reman_app/config/network.constant.dart';

class NetworkBinding extends Bindings {
  @override
  void dependencies() {
    Get.log('[$runtimeType] Network Binding dependencies()');
    final dio = Dio(
      BaseOptions(
        baseUrl: '',
        connectTimeout: 10000.ms,
      ),
    )..interceptors.addAll([
        UserKeyInterceptor(), //요청 헤더에 유저토큰추가
        DeviceInfoInterceptor(), //요청 헤더에 디바이스 정보와 앱 버전을 추가
        if (kDebugMode) //Flutter에서 Debug 모드로 실행 중인지 아니면 Release 모드로 실행 중인지 파악하는 상수, foundation 모듈이 필요
          PrettyDioLogger(
            //디버그 모드에서 요청 및 응답을 로깅
            requestHeader: true,
            requestBody: true,
            responseBody: false,
            responseHeader: false,
            logPrint: (object) => Get.log(object.toString()),
          ),
      ]);

    // Dio
    Get.lazyPut(() => dio, fenix: true, tag: kAppHttpClientTag);

    // Repositories
    // Get.lazyPut(() => someRepo(httpClient: dio), fenix: true);
  }
}

extension NumDurationExtensions on num {
  Duration get microseconds => Duration(microseconds: round());
  Duration get ms => (this * 1000).microseconds;
  Duration get milliseconds => (this * 1000).microseconds;
  Duration get seconds => (this * 1000 * 1000).microseconds;
  Duration get minutes => (this * 1000 * 1000 * 60).microseconds;
  Duration get hours => (this * 1000 * 1000 * 60 * 60).microseconds;
  Duration get days => (this * 1000 * 1000 * 60 * 60 * 24).microseconds;
}
