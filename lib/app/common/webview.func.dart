import 'dart:io';

import 'package:dummy_app/app/common/webview.dart';
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
        // useOnDownloadStart: true,
      ),
      android: AndroidInAppWebViewOptions(useHybridComposition: true),
      ios: IOSInAppWebViewOptions(allowsInlineMediaPlayback: true),
    );
  }

  static URLRequest getUrlRequest(String url, {bool isRelease = false}) {
    if (isRelease) {
      return URLRequest(
        url: WebUri.uri(Uri.parse(url)),
        headers: {
          'User-Agent': Platform.isIOS ? 'iPhone' : 'Android',
          'X-platform': Platform.isIOS ? 'app-ios' : 'app-android',
        },
      );
    }
    return URLRequest(
      url: WebUri.uri(Uri.parse(url)),
      headers: {
        'User-Agent': Platform.isIOS ? 'iPhone' : 'Android',
        'X-platform': Platform.isIOS ? 'app-ios' : 'app-android',
        'X-apple-test': 'on',
      },
    );
  }

  static Future<NavigationActionPolicy?> shouldOverrideUrlLoading(
    InAppWebViewController controller,
    NavigationAction navigationAction, {
    bool openNewWebViewWhenDetailPage = false,
  }) async {
    var uri = navigationAction.request.url!;

    // RegExp
    final prodViewRegExp = RegExp(r'^\/prod\/prodView\/(\d*)(\/?)$');
    final seminarViewRegExp = RegExp(r'^\/prod\/seminarView\/(\d*)(\/?)$');

    if (![
      'http',
      'https',
      'file',
      'chrome',
      'data',
      'javascript',
      'about',
    ].contains(uri.scheme)) {
      var uriString = uri.toString();

      if (uri.scheme == 'intent') {
        var appUrl = await getAppUrl(uriString);
        if (await canLaunchUrlString(appUrl)) {
          uriString = appUrl;
        } else {
          uriString = await getMarketUrl(uriString);
        }
      }

      // 실행여부 확인
      if (await canLaunchUrlString(uriString)) {
        await launchUrlString(uriString, mode: LaunchMode.externalApplication);
        return NavigationActionPolicy.CANCEL;
      }
    } else if (openNewWebViewWhenDetailPage &&
        prodViewRegExp.hasMatch(uri.path)) {
      Get.to(() => Webview(
            url: uri.toString(),
            title: '패키지 상세',
            isRefresh: false,
          ));
      return NavigationActionPolicy.CANCEL;
    } else if (openNewWebViewWhenDetailPage &&
        seminarViewRegExp.hasMatch(uri.path)) {
      Get.to(() => Webview(
            url: uri.toString(),
            title: '세미나 상세',
            isRefresh: false,
          ));
      return NavigationActionPolicy.CANCEL;
    }

    return NavigationActionPolicy.ALLOW;
  }

  static LinearProgressIndicator progress(progress, color) {
    return LinearProgressIndicator(
      value: progress,
      color: color,
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
        //TODO: 결제완료후 처리로직 작성
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

const platform = MethodChannel('iipamaster');
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
