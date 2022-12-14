import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_dialogs/flutter_dialogs.dart';
import 'package:sdk/components/network_helper.dart';
import 'package:sdk/progress_bar.dart';
import 'package:sdk/screens/home_screen.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:xml/xml.dart';

class WebViewScreen extends StatefulWidget {
  final url;
  final code;
  WebViewScreen({@required this.url, @required this.code});

  @override
  _WebViewScreenState createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  String _url = '';
  String _code = '';
  bool _showLoader = false;
  bool _showedOnce = false;
  bool _isloading = false;
  void setProgressbar(bool isProgressbar) {
    setState(() {
      _isloading = isProgressbar;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    _url = widget.url;
    _code = widget.code;
    print('url in webview $_url, $_code');
  }

  void complete(XmlDocument xml) async {
    setState(() {
      _showLoader = true;
    });
    NetworkHelper _networkHelper = NetworkHelper();
    var response = await _networkHelper.completed(xml);
    print(response);
    if (response == 'failed' || response == null) {
      alertShow('Failed. Please try again', false);
      setState(() {
        _showLoader = false;
      });
    } else {
      final doc = XmlDocument.parse(response);
      final message = doc.findAllElements('message').map((node) => node.text);
      if (message.toString().length > 2) {
        String msg = message.toString();
        msg = msg.replaceAll('(', '');
        msg = msg.replaceAll(')', '');
        setState(() {
          _showLoader = false;
        });
        if (!_showedOnce) {
          _showedOnce = true;
          alertShow('Your transaction is $msg', true);
        }
        // https://secure.telr.com/gateway/webview_start.html?code=a8caa483fe7260ace06a255cc32e
      }
    }
  }

  void alertShow(String text, bool pop) {
    print('popup thrown');

    showPlatformDialog(
      context: context,
      builder: (_) => BasicDialogAlert(
        title: Text(
          '$text',
          style: TextStyle(fontSize: 15),
        ),
        // content: Text('$text Please try again.'),
        actions: <Widget>[
          BasicDialogAction(
              title: Text('Ok'),
              onPressed: () {
                print(pop.toString());
                if (pop) {
                  print('inside pop');
                  Navigator.pop(context);
                  Navigator.pop(context);
                } else {
                  print('inside false');
                  Navigator.pop(context);
                }
              }),
        ],
      ),
    );
  }

  void createXml() {
    final builder = XmlBuilder();
    builder.processing('xml', 'version="1.0"');
    builder.element('mobile', nest: () {
      builder.element('store', nest: () {
        builder.text('15996');
      });
      builder.element('key', nest: () {
        builder.text('pQ6nP-7rHt@5WRFv');
      });
      builder.element('complete', nest: () {
        builder.text(_code);
      });
    });

    final bookshelfXml = builder.buildDocument();
    print(bookshelfXml);
    complete(bookshelfXml);
  }

  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  @override
  Widget build(BuildContext context) {
    return MPProgressBar(
      color: Colors.transparent,
      inAsyncCall: _isloading,
      progressIndicator: const CircularProgressIndicator(
        color: Color(0xFFc37a1f),
      ),
      opacity: 0.5,
      dismissible: false,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            brightness: Brightness.light,
            title: Text(
              'Payment',
              style: TextStyle(color: Colors.black),
            ),
            leading: Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Cancel',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ),
          ),
          body: WebView(
            initialUrl: _url,
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController webViewController) {
              _controller.complete(webViewController);
            },
            navigationDelegate: (NavigationRequest request) {
              print('allowing navigation to $request');
              return NavigationDecision.navigate;
            },
            onPageStarted: (String url) {
              print('Page started loading: $url');
              _showedOnce = false;
              if (url.contains('close')) {
                // print('call the api');

              }
              if (url.contains('abort')) {
                print('show fail and pop');
              }
            },
            onPageFinished: (String url) {
              print('Page finished loading: $url');
              if (url.contains('close')) {
                print('call the api');
                createXml();
              }
              if (url.contains('abort')) {
                print('show fail and pop');
              }
            },
            gestureNavigationEnabled: true,
          )),
    );
  }
}
