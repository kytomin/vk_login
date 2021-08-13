import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:vk_login/model/vk_scope.dart';
import 'package:vk_login/utils/global_vars.dart';
import 'package:webview_flutter/webview_flutter.dart';

/// login page
class LoginPage extends StatefulWidget {
  /// VK app id
  final int appId;

  /// token permissions list
  final List<VKScope> permissions;

  const LoginPage({Key? key, required this.appId, required this.permissions}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState(appId, permissions);
}

class _LoginPageState extends State<LoginPage> {
  late final WebViewController _controller;
  final CookieManager cookieManager = CookieManager();

  late final int appId;
  late final List<VKScope> permissions;
  late final String url;

  bool isLoading = true;
  bool isClosing = false;

  _LoginPageState(this.appId, this.permissions) {
    String strPermissions = '';
    for (VKScope value in permissions) strPermissions += '${value.name},';
    this.url =
        'https://oauth.vk.com/authorize?client_id=$appId%20&scope=$strPermissions&redirect_uri=http://api.vk.com/blank.html&display=page&response_type=token';
  }

  @override
  void initState() {
    isLoading = true;
    isClosing = false;
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  Future<void> close() async {
    if (isClosing == false) {
      isClosing = true;
      cookieManager.clearCookies();
      await Future.delayed(Duration(milliseconds: 600), () => Navigator.pop(context));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: Stack(
          children: <Widget>[
            WebView(
              initialUrl: url,
              onWebViewCreated: (WebViewController webViewController) async {
                _controller = webViewController;
                await _controller.clearCache();
              },
              javascriptMode: JavascriptMode.unrestricted,
              navigationDelegate: (NavigationRequest request) async {
                if (request.url.startsWith('https://api.vk.com/blank.html#access_token=')) {
                  RegExp exp = RegExp('https://api.vk.com/blank.html#access_token=([0-9a-zA-Z]*)&expires_in=');
                  String? token = exp.firstMatch(request.url)?.group(1);
                  GlobalVars.token = token;
                  await _controller.loadUrl(Uri.dataFromString(GlobalVars.finishPage,
                          mimeType: 'text/html', encoding: Encoding.getByName('utf-8'))
                      .toString());
                  await close();
                  return NavigationDecision.prevent;
                }
                return NavigationDecision.navigate;
              },
              onPageFinished: (_) {
                setState(() {
                  isLoading = false;
                });
              },
            ),
            isLoading ? Center(child: CircularProgressIndicator()) : Stack()
          ],
        ),
      ),
    );
  }
}
