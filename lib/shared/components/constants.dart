
import 'package:flutter/cupertino.dart';
import 'package:sahariano_travel/shared/network/remote/local/cache_helper.dart';
//url
String ataycom = 'http://ataycom.backend.elsahariano.com';

String parfum = 'http://parfum.backend.elsahariano.com';

String Appurl = 'https://api.backend.elsahariano.com/api/v1/flights/';


var elsaharianoUrl = "https://elsahariano.com/appUsers/";

String baseurl = "https://api.wadina.agency";


Map<String, dynamic> ProductionKey = {
   "app_id": "65058a74-07ef-406c-8fb4-135d63f59398-test",
   "app_secret": "AmSz4k2Xfv13qxNA2ztt"
};
Map<String, dynamic> TestKey = {
   "app_id":"60c98cd9-ac80-4ddb-9fd6-c1642ae4615a",
   "app_secret":"rOGBa6JX1P05MxNvutDR"
    };
const languageg = 'ar';
//Color
 Color ataycomColor = Color(0xFF99cd09);
 Color parfumColor =  Color(0xFFec008c);
 Color tabatayColor = Color(0xFF769F03);
 Color tabparfum = Color(0xFFb30a6e);
 Color appColor = Color(0xFFed6905);
 Color bgColor = Color(0xFFf8f9fa);
//Style
 const TextStyle titleStyle = TextStyle(
   fontSize: 15,fontWeight: FontWeight.w600,
   color: Color(0xFFec008c),
);
//shared
   String access_token = Cachehelper.getData(key: "access_token");
  var selecedepart;
  var selecedretur;
  var controllerdepart =  TextEditingController();
  var controllerarival =  TextEditingController(); 

