import 'package:flutter/material.dart';
import 'package:infoinstall/PresentationLayer/Components/color_plattes.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  final String url;

  const WebViewScreen({super.key, required this.url});

  @override
  State<StatefulWidget> createState() => _WebViewScreenState();

  // @override
  // _WebViewScreenState createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setUserAgent(
        "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Safari/537.36",
      )
      ..setMediaPlaybackRequiresUserGesture(
          false) // Important for auto-playing media
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "LIVE VIDEO CHAT",
          style: TextStyle(color: ColorsPlatte.lightgreenshede),
        ),
        backgroundColor: ColorsPlatte.accentColor,
      ),
      body: WebViewWidget(
        controller: _controller,
      ),
    );
  }
}

extension on WebViewController {
  setMediaPlaybackRequiresUserGesture(bool bool) {}
}
