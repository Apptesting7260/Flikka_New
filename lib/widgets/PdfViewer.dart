// import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';
//
// class PDFViewer extends StatefulWidget {
//   final String url ;
//   const PDFViewer({super.key, required this.url});
//
//   @override
//   State<PDFViewer> createState() => _PDFViewerState();
// }
//
// class _PDFViewerState extends State<PDFViewer> {
//
//   WebViewController controller = WebViewController() ;
//   // @override
//   // void initState() {
//   //   controller..setJavaScriptMode(JavaScriptMode.unrestricted)
//   //     ..setBackgroundColor(const Color(0x00000000))
//   //     ..setNavigationDelegate(
//   //       NavigationDelegate(
//   //         onProgress: (int progress) {
//   //            CommonFunctions.showLoadingDialog(context, "Loading") ;
//   //         },
//   //         onPageStarted: (String url) {},
//   //         onPageFinished: (String url) {},
//   //         onWebResourceError: (WebResourceError error) {},
//   //         onNavigationRequest: (NavigationRequest request) {
//   //           // if (request.url.startsWith('https://www.youtube.com/')) {
//   //           //   return NavigationDecision.prevent;
//   //           // }
//   //           return NavigationDecision.navigate;
//   //         },
//   //       ),
//   //     )
//   //     ..loadRequest(Uri.parse(widget.url));
//   //   super.initState();
//   // }
//   @override
//   Widget build(BuildContext context) {
//     return  Scaffold(
//       body: Center(
//         child:  WebViewWidget(
//           controller: controller..setJavaScriptMode(JavaScriptMode.unrestricted)
//             ..setJavaScriptMode(JavaScriptMode.unrestricted)
//               ..loadRequest(Uri.parse('https://docs.google.com/gview?embedded=true&url=${widget.url}',))
//         )
//       ),
//     );
//   }
// }
