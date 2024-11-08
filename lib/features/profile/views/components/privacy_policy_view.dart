import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';

class PrivacyPolicyView extends StatelessWidget {
  const PrivacyPolicyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Privacy & Policy".tr),
      ),
      body: InAppWebView(
        initialUrlRequest: URLRequest(
          url: WebUri('https://venturo.id'),
        ),
      ),
    );
  }
}
