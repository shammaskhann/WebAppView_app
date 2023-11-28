import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:webview_app/views/home/home_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isAndroid) {
    await AndroidInAppWebViewController.setWebContentsDebuggingEnabled(true);

    var swAvailable = await AndroidWebViewFeature.isFeatureSupported(
        AndroidWebViewFeature.SERVICE_WORKER_BASIC_USAGE);
    var swInterceptAvailable = await AndroidWebViewFeature.isFeatureSupported(
        AndroidWebViewFeature.SERVICE_WORKER_SHOULD_INTERCEPT_REQUEST);

    if (swAvailable && swInterceptAvailable) {
      AndroidServiceWorkerController serviceWorkerController =
          AndroidServiceWorkerController.instance();

      await serviceWorkerController
          .setServiceWorkerClient(AndroidServiceWorkerClient(
        shouldInterceptRequest: (request) async {
          print(request);
          return null;
        },
      ));
    }
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeView(),
    );
  }
}
// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
// import 'package:webview_app/views/home/home_view.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   if (Platform.isAndroid) {
//     await AndroidInAppWebViewController.setWebContentsDebuggingEnabled(true);

//     var swAvailable = await AndroidWebViewFeature.isFeatureSupported(
//         AndroidWebViewFeature.SERVICE_WORKER_BASIC_USAGE);
//     var swInterceptAvailable = await AndroidWebViewFeature.isFeatureSupported(
//         AndroidWebViewFeature.SERVICE_WORKER_SHOULD_INTERCEPT_REQUEST);

//     if (swAvailable && swInterceptAvailable) {
//       AndroidServiceWorkerController serviceWorkerController =
//           AndroidServiceWorkerController.instance();

//       await serviceWorkerController
//           .setServiceWorkerClient(AndroidServiceWorkerClient(
//         shouldInterceptRequest: (request) async {
//           print(request);
//           return null;
//         },
//       ));
//     }
//   }
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       home: HomeView(),
//     );
//   }
// }
