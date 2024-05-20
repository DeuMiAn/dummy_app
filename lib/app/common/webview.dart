import 'dart:io';

import 'package:dummy_app/app/common/webview.func.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';

typedef OnStartCallback = void Function(
    {InAppWebViewController? controller, Uri? url});

class Webview extends StatefulWidget {
  final String url;
  final String title;
  final OnStartCallback? onStart;
  final bool isRefresh;
  final bool showAppBar;
  final bool openNewWebViewWhenDetailPage;

  const Webview({
    Key? key,
    required this.url,
    required this.title,
    this.onStart,
    this.isRefresh = true,
    this.showAppBar = true,
    this.openNewWebViewWhenDetailPage = false,
  }) : super(key: key);

  @override
  WebviewState createState() => WebviewState();
}

class WebviewState extends State<Webview> {
  final GlobalKey webViewKey = GlobalKey();
  InAppWebViewController? webViewController;
  PullToRefreshController? pullToRefreshController;
  InAppWebViewGroupOptions? options;
  URLRequest? initialUrlRequest;
  OnStartCallback? onStart;
  double progress = 0;
  var pageIndex = 0.obs;

  @override
  void initState() {
    startRefreshing();
    initialUrlRequest = WebviewFunc.getUrlRequest(
      widget.url,
    );
    options = WebviewFunc.getOptions();
    onStart = widget.onStart;

    super.initState();
  }

  void startRefreshing() {
    if (widget.isRefresh) {
      pullToRefreshController = PullToRefreshController(
        options: PullToRefreshOptions(color: Colors.blueAccent),
        onRefresh: () async {
          if (Platform.isAndroid) webViewController?.reload();
          if (Platform.isIOS) {
            webViewController?.loadUrl(
                urlRequest: URLRequest(
              url: await webViewController?.getUrl(),
            ));
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

  Future<void> onWebViewCreated(controller) async {
    WebviewFunc.addJavascriptHandler(controller);
    webViewController = controller;
  }

  Future<PermissionRequestResponse?> androidOnPermissionRequest(
      controller, origin, resources) async {
    return PermissionRequestResponse(
        resources: resources, action: PermissionRequestResponseAction.GRANT);
  }

  void onLoadStop(controller, url) async {
    endRefreshing();

    // 웹뷰 페이지 인덱스 확인
    WebHistory? webHistory = await webViewController!.getCopyBackForwardList();
    pageIndex.value = webHistory!.currentIndex!;
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
                title: Text(widget.title),
                elevation: 0,
                centerTitle: true,
                actions: [
                  Obx(() => Container(
                        child: pageIndex.value > 0
                            ? GestureDetector(
                                onTap: () {
                                  HapticFeedback.lightImpact();
                                  home();
                                },
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
                androidOnPermissionRequest: androidOnPermissionRequest,
                shouldOverrideUrlLoading: (controller, navigationOptions) =>
                    WebviewFunc.shouldOverrideUrlLoading(
                  controller,
                  navigationOptions,
                  openNewWebViewWhenDetailPage:
                      widget.openNewWebViewWhenDetailPage,
                ),
                onLoadStart: (controller, url) {
                  // URL 변경이 감지될 때마다 호출됩니다.
                  if (onStart != null) {
                    onStart!(controller: controller, url: url);
                  }
                },
                onLoadStop: onLoadStop,
                onLoadError: onLoadError,
                onProgressChanged: onProgressChanged,
              ),
              progress < 1.0
                  ? WebviewFunc.progress(progress, Colors.blueGrey)
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
