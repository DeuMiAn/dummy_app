import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher_string.dart';

abstract class WebviewFunc {
  static InAppWebViewGroupOptions getOptions() {
    return InAppWebViewGroupOptions(
      crossPlatform: InAppWebViewOptions(
        javaScriptCanOpenWindowsAutomatically: true,
        javaScriptEnabled: true,
        mediaPlaybackRequiresUserGesture: false,
        useShouldOverrideUrlLoading: true,
        useOnDownloadStart: true,
        useOnLoadResource: true,
        transparentBackground: true,
      ),
      android: AndroidInAppWebViewOptions(useHybridComposition: true),
      ios: IOSInAppWebViewOptions(allowsInlineMediaPlayback: true),
    );
  }

  static URLRequest getUrlRequest(
    String url,
  ) {
    return URLRequest(
      url: WebUri(url),
      headers: {
        'User-Agent': Platform.isIOS ? 'iPhone' : 'Android',
        'x-platform': Platform.isIOS ? 'app-ios' : 'app-android',
      },
    );
  }

  static LinearProgressIndicator progress(progress, color) {
    return LinearProgressIndicator(
      value: progress,
      color: color,
      backgroundColor: Colors.amber,
    );
  }

  static void addJavascriptHandler(InAppWebViewController controller) {
    controller.addJavaScriptHandler(
      handlerName: 'onClose',
      callback: (List<dynamic> arguments) {
        if (kDebugMode) {
          print('JavascriptHandler onClose called');
        }
        Get.back();
      },
    );

    controller.addJavaScriptHandler(
      handlerName: 'onSuccess',
      callback: (List<dynamic> arguments) {
        if (kDebugMode) {
          print('JavascriptHandler onSuccess called');
        }
        Get.back();
      },
    );

    controller.addJavaScriptHandler(
      handlerName: 'onPaySuccess',
      callback: (List<dynamic> arguments) {
        if (kDebugMode) {
          print('JavascriptHandler onSuccess called');
        }
        Get.back(result: true);
      },
    );

    controller.addJavaScriptHandler(
      handlerName: 'onAlertMessage',
      callback: (List<dynamic> arguments) {
        if (kDebugMode) {
          print('JavascriptHandler onAlertMessage called');
        }
      },
    );

    controller.addJavaScriptHandler(
      handlerName: 'openWeb',
      callback: (List<dynamic> arguments) {
        if (kDebugMode) {
          print('JavascriptHandler openWeb called');
        }
        launchUrlString(arguments.first, mode: LaunchMode.externalApplication);
      },
    );
  }
}

const platform = MethodChannel('someMethod');
Future<String> getAppUrl(String url) async {
  if (Platform.isAndroid) {
    return await platform
        .invokeMethod('getAppUrl', <String, Object>{'url': url});
  } else {
    return url;
  }
}

Future<String> getMarketUrl(String url) async {
  if (Platform.isAndroid) {
    return await platform
        .invokeMethod('getMarketUrl', <String, Object>{'url': url});
  } else {
    return url;
  }
}
