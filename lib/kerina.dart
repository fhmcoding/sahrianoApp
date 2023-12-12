import 'package:flutter/material.dart';
import 'package:sahariano_travel/drawer/menuwidget.dart';
import 'package:sahariano_travel/shared/components/constants.dart';
import 'package:sahariano_travel/shared/network/remote/local/cache_helper.dart';


import 'localization/demo_localization.dart';
import 'modules/pages.dart/notification/notification_web.dart';


class KerinaApp extends StatefulWidget {
    final int currentIndex;

  const KerinaApp({Key key, this.currentIndex}) : super(key: key);

  @override
  _KerinaAppState createState() => _KerinaAppState();
}

class _KerinaAppState extends State<KerinaApp>{
  
    String phone = Cachehelper.getData(key: "phone");
    // String lang = Cachehelper.getData(key: "language");
    String language = Cachehelper.getData(key: "langugeCode"); 




  @override
  Widget build(BuildContext context) {
    print(phone);

    List pages = [
    {
      "name":"${DemoLocalization.of(context).getTranslatedValue('Kerina')}",
      "url":"https://elsahariano.com/kreina/info.php?phone=${phone.replaceAll('+', "0")}&lang=${language}"
    },
    {
      "name":"${DemoLocalization.of(context).getTranslatedValue('Target')}",
      "url":"https://elsahariano.com/kreina/kriena.php?phone=${phone.replaceAll('+', "0")}&lang=${language}"
    },
    {
      "name":"${DemoLocalization.of(context).getTranslatedValue('Points')}",
      "url":"https://elsahariano.com/kreina/points.php?phone=${phone.replaceAll('+', "0")}&lang=${language}"
    },
    {
      "name":"${DemoLocalization.of(context).getTranslatedValue('Advantage')}",
      "url":"https://elsahariano.com/kreina/avantage.php?phone=${phone.replaceAll('+', "0")}&lang=${language}"
    },
    {
      "name":"${DemoLocalization.of(context).getTranslatedValue('Management')}",
      "url":"https://elsahariano.com/kreina/gestion.php?phone=${phone.replaceAll('+', "0")}&lang=${language}"
    }
    ];
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: appColor,
        elevation: 0,
        centerTitle: true,
        leading: MenuWidget(color: Colors.white),
        title: Text('${DemoLocalization.of(context).getTranslatedValue('Kerina')}',style: TextStyle(color: Colors.white,fontSize: 22,fontWeight: FontWeight.bold),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.center,
           mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ...pages.map((e) {
             return Column(
               children: [
                 Container(
                     decoration: BoxDecoration(
                     borderRadius: BorderRadius.circular(5),
                     color: appColor,
                   ),
                 width: double.infinity,
                 height: 55,
                 child: ElevatedButton(
                   style: ElevatedButton.styleFrom(
                     primary: appColor,
                   ),
                   onPressed: (){
                      Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                              builder: (context) => NotificationWeb(url:'${e['url']}',title:e['name'],)));
                 }, child: Text('${e['name']}',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),)),
           ),
           SizedBox(height: 15,)
               ],
             );
            }),
           
          

          ],
        ),
      ),
    );
  }
}