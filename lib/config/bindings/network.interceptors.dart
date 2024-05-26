import 'dart:io';

import 'package:dio/dio.dart';

class UserKeyInterceptor extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    String? userToken;
    try {
      userToken = '로컬스토리지나 기타에서 가져온 토큰';
    } catch (_) {}

    // UserID 정보가 있는경우 헤더에 추가
    final newOptions = options.copyWith(headers: {
      ...options.headers,
      if (userToken != null) 'userToken': userToken,
    });

    super.onRequest(newOptions, handler);
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
