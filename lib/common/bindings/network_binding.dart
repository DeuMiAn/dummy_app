import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dummy_app/common/constant/network_constant.dart';
import 'package:dummy_app/common/extensions/common_extensions.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class NetworkBinding extends Bindings {
  @override
  void dependencies() {
    Get.log('[$runtimeType] Network Binding dependencies()');
    final dio = Dio(
      BaseOptions(
        baseUrl: kApiBaseUri.toString(),
        connectTimeout: 10000.ms,
      ),
    )..interceptors.addAll([
        DeviceInfoInterceptor(),
        if (kDebugMode)
          PrettyDioLogger(
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
    // Get.lazyPut(() => HomeRepository(httpClient: dio), fenix: true);
  }
}

class DeviceInfoInterceptor extends Interceptor {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    String? os;

    try {
      os = Platform.isIOS ? 'ios' : 'android';
    } catch (_) {}

    // UserID 정보가 있는경우 헤더에 추가
    final newOptions = options.copyWith(headers: {
      ...options.headers,
      if (os != null) 'x-os': os,
    });

    super.onRequest(newOptions, handler);
  }
}
