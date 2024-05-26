import 'package:dio/dio.dart';
import 'package:get/get.dart';

const kAppHttpClientTag = 'appHttpClient';
const kApiBaseUrlTag = 'apiBaseUrl';
const kImageBaseUrlTag = 'imageBaseUrl';
const kFileBaseUrlTag = 'fileBaseUrl';

Dio get kAppHttpClient => Get.find(tag: kAppHttpClientTag);

Uri get kApiBaseUri => Get.find(tag: kApiBaseUrlTag);

Uri get kImageBaseUri => Get.find(tag: kImageBaseUrlTag);

Uri get kFileBaseUri => Get.find(tag: kFileBaseUrlTag);
