import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late WebViewController controller;
  bool _isLoading = false;

  // loading bar
  showAlertDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: Row(
        children: [
          const CircularProgressIndicator(),
          Container(
              margin: const EdgeInsets.only(left: 5),
              child: const Text("Loading")),
        ],
      ),
    );

    
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  void initState() {
    super.initState();

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            setState(() {
              _isLoading = progress != 100;
            });
          },
          onPageStarted: (String url) {
            setState(() {
              _isLoading = true;
            });
          },
          onPageFinished: (String url) {
            setState(() {
              _isLoading = false;
            });
          },
          onWebResourceError: (WebResourceError error) {
            // showDialog(
            //   context: context,
            //   builder: (BuildContext context) {
            //     return AlertDialog(
            //       title: const Text("Error"),
            //       content: const Text(
            //           "An error occurred. Please check your internet connection."),
            //       actions: <Widget>[
            //         TextButton(
            //           child: const Text("OK"),
            //           onPressed: () {
            //             Navigator.of(context).pop();
            //           },
            //         ),
            //       ],
            //     );
            //   },
            // );
          },
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://zana5.com/')) {
              final url = request.url;

              if (url.startsWith('https://zana5.com/')) {
                return NavigationDecision.navigate;
              } else if (url.startsWith('https://zana5.com/')) {
                return NavigationDecision.navigate;
              } else {
                return NavigationDecision.prevent;
              }
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse('https://zana5.com/'));
  }

  loading() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Material(
          borderRadius: BorderRadius.circular(10),
          color: Colors.black,
          elevation: 5,
          child: SizedBox(
            height: MediaQuery.of(context).size.height / 3,
            width: MediaQuery.of(context).size.width / 1.5,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 80,
                    width: 80,
                    decoration: const BoxDecoration(shape: BoxShape.circle),
                    child: Image.asset(
                      "assets/logo zana 1.png",
                      color: const Color(0xffF48E27),
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Loading ...',
                    style: TextStyle(
                        fontSize: 20,
                        color: Color(0xffF48E27),
                        letterSpacing: 3,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const CircularProgressIndicator(
                    color: Color(0xffF48E27),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF48E27),
      body: SafeArea(
        child: Stack(
          children: [
            WebViewWidget(controller: controller),
            if (_isLoading) loading(),
          ],
        ),
      ),
    );
  }
}
