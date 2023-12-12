import 'package:flutter/material.dart';
import 'package:sahariano_travel/shared/components/constants.dart';
import 'package:sahariano_travel/shared/network/remote/dio_helper.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NotificationWeb extends StatefulWidget {
  final String url;
  final String title;
  const NotificationWeb({ Key key,this.url, this.title }) : super(key: key);

  @override
  NotificationWebState createState() => NotificationWebState();
}

class NotificationWebState extends State<NotificationWeb>{
  bool isLoading=true;
  final _key = UniqueKey();
  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
      appBar: new AppBar(
        backgroundColor: appColor,
        centerTitle: true,
        elevation: 0,
        leading: GestureDetector(
          onTap: (){
            Navigator.of(context).pop();
          },
          child: Icon(Icons.arrow_back,color: Colors.white)),
        title:widget.title!=null? Text('${widget.title}',style: TextStyle(color: Colors.white),):null,
      ),
      body: Stack(
        children: <Widget>[
          WebView(
            key: _key,
            initialUrl:'${widget.url}',
            zoomEnabled: false,
            javascriptMode: JavascriptMode.unrestricted,
            onPageFinished: (finish){
              setState(() {
                isLoading = false;
              });
            },
           
          ),
          isLoading ? Center( child: CircularProgressIndicator(),)
                    : Stack(),
        ],
      ),
    );
  }


}