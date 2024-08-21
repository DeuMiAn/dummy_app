import 'dart:io';

import 'package:dummy_app/presentation/common/widgets/webview/webview_func.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';

class Webview extends StatefulWidget {
  final String url;
  final String title;
  final bool isRefresh;
  final bool showAppBar;
  final bool olnyBack;
  final bool openNewWebViewWhenDetailPage;

  const Webview({
    super.key,
    required this.url,
    required this.title,
    this.isRefresh = true,
    this.showAppBar = true,
    this.olnyBack = false,
    this.openNewWebViewWhenDetailPage = false,
  });

  @override
  WebviewState createState() => WebviewState();
}

class WebviewState extends State<Webview> {
  final GlobalKey webViewKey = GlobalKey();
  InAppWebViewController? webViewController;
  PullToRefreshController? pullToRefreshController;
  InAppWebViewGroupOptions? options;
  URLRequest? initialUrlRequest;
  double progress = 0;
  var pageIndex = 0.obs;

  @override
  void initState() {
    super.initState();

    startRefreshing();
    initialUrlRequest = WebviewFunc.getUrlRequest(widget.url);
    options = WebviewFunc.getOptions();
  }

  void startRefreshing() {
    if (widget.isRefresh) {
      pullToRefreshController = PullToRefreshController(
        onRefresh: () async {
          if (Platform.isAndroid) webViewController?.reload();
          if (Platform.isIOS) {
            webViewController?.loadUrl(
                urlRequest: URLRequest(
                    url: await webViewController?.getUrl(),
                    headers: {
                  'User-Agent': Platform.isIOS ? 'iPhone' : 'Android',
                  'x-platform': Platform.isIOS ? 'app-ios' : 'app-android',
                }));
          }
        },
      );
    }
  }

  void endRefreshing() {
    if (widget.isRefresh) {
      pullToRefreshController!.endRefreshing();
    }
  }

  void backPage() {
    webViewController!.goBack();
  }

  void onWebViewCreated(controller) {
    WebviewFunc.addJavascriptHandler(controller);
    webViewController = controller;
  }

  Future<PermissionRequestResponse?> androidOnPermissionRequest(
      controller, origin, resources) async {
    return PermissionRequestResponse(
        resources: resources, action: PermissionRequestResponseAction.GRANT);
  }

  void onLoadError(controller, url, code, message) {
    endRefreshing();
  }

  void onProgressChanged(controller, progress) {
    if (progress == 100) endRefreshing();
    setState(() => this.progress = progress / 100);
  }

  void home() {
    webViewController!.goBackOrForward(steps: -pageIndex.value);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if (pageIndex > 0) {
          backPage();
        } else {
          Get.back();
        }

        return Future.value(false);
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: widget.showAppBar
            ? AppBar(
                title: Text(
                  widget.title,
                ),
                elevation: 0,
                centerTitle: true,
                leading: IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: const Icon(Icons.close),
                ),
                actions: widget.olnyBack
                    ? null
                    : [
                        Obx(() => Container(
                              child: pageIndex.value > 0
                                  ? GestureDetector(
                                      onTap: () {
                                        HapticFeedback.lightImpact();
                                        home();
                                      },
                                      child: const Icon(Icons.home),
                                    )
                                  : null,
                            )),
                        Obx(
                          () => Container(
                            child: pageIndex.value > 0
                                ? GestureDetector(
                                    onTap: () {
                                      HapticFeedback.lightImpact();
                                      backPage();
                                    },
                                    child: const Icon(Icons.arrow_back),
                                  )
                                : null,
                          ),
                        ),
                      ],
              )
            : null,
        body: SafeArea(
          child: Stack(
            children: [
              InAppWebView(
                key: webViewKey,
                initialUrlRequest: initialUrlRequest,
                initialOptions: options,
                pullToRefreshController: pullToRefreshController,
                onWebViewCreated: onWebViewCreated,
                shouldOverrideUrlLoading: (controller, action) async {
                  return NavigationActionPolicy.ALLOW;
                },
                androidOnPermissionRequest: androidOnPermissionRequest,
                onLoadError: onLoadError,
                onProgressChanged: onProgressChanged,
              ),
              progress < 1.0
                  ? WebviewFunc.progress(progress, Colors.amber)
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
