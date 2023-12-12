import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CreateTicketPayment extends StatefulWidget {
  final String url;
  const CreateTicketPayment({ Key key,this.url }) : super(key: key);

  @override
  _CreateTicketPaymentState createState() => _CreateTicketPaymentState();
}

class _CreateTicketPaymentState extends State<CreateTicketPayment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:WebView(
              initialUrl: '${widget.url}',
              debuggingEnabled: false,
              allowsInlineMediaPlayback: true,
              initialMediaPlaybackPolicy: AutoMediaPlaybackPolicy.always_allow,
              javascriptMode: JavascriptMode.unrestricted,
            )
    );
  }
}