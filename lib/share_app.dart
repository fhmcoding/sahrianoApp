import 'package:flutter/material.dart';
import 'package:sahariano_travel/shared/components/constants.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:sahariano_travel/shared/network/remote/local/cache_helper.dart';
import 'drawer/menuwidget.dart';
import 'modules/pages.dart/notification/notification_web.dart';

class ShereApp extends StatelessWidget {
  final int selectedIndex ;
   ShereApp({ Key key, this.selectedIndex }) : super(key: key);
   String language = Cachehelper.getData(key: "langugeCode"); 
  String phone = Cachehelper.getData(key: "phone");
  @override
  Widget build(BuildContext context) {

     Future<void> shareAndroid() async {
    await FlutterShare.share(
      title: 'Example share',
      text: 'Sahariano Travel',
      linkUrl: 'https://play.google.com/store/apps/details?id=com.elsaharianobookingapp',
    );
  }

     Future<void> shareIos() async {
       await FlutterShare.share(
         title: 'Example share',
         text: 'Sahariano Travel',
         linkUrl: 'https://apps.apple.com/ma/app/el-sahariano-travel/id1598163292',
       );
     }

    return Scaffold(
     // bottomNavigationBar:  Container(
     //                               height: 80,
     //                               width: double.infinity,
     //                               color: Colors.white,
     //                               child: Padding(
     //                                 padding: const EdgeInsets.only(left: 20,right: 20,top: 13,bottom: 13),
     //                                 child: GestureDetector(
     //                                   onTap: (){
     //                                     if(Platform.isAndroid){
     //                                       shareAndroid();
     //                                     }
     //                                     else if(Platform.isIOS){
     //                                       shareIos();
     //                                     }
     //                                   },
     //                                   child: Container(
     //                                     height: 45,
     //                                     width: double.infinity,
     //                                     decoration: BoxDecoration(
     //                                        color:appColor,
     //                                       borderRadius: BorderRadius.circular(5)
     //                                     ),
     //                                    child: Center(child: Text('Share App',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 16),)),
     //                                   ),
     //                                 ),
     //                               ),
     //                             ),
      backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          leading:MenuWidget(),
          title: Text('Share App',style: TextStyle(color: appColor),),
          centerTitle: true,
          backgroundColor: Colors.white,
        ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          
          children: [
             SizedBox(height: 50,),
           Padding(
             padding: const EdgeInsets.only(left: 20,right: 20),
             child: Text('share the link the application with your friends and earning money',textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.w500,fontSize: 20),),
           ),
           SizedBox(height: 50,),
           Padding(
             padding: const EdgeInsets.only(left: 50,right: 50),
             child: Container(
             height: 150,width: double.infinity,
             
             decoration: BoxDecoration(border: Border.all(width: 1,color: appColor )),
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.center,
               mainAxisAlignment: MainAxisAlignment.center,
             children: [
               Text('1 amis invites'),
               SizedBox(height: 7,),
               Text('1 dirhams earning'),
               SizedBox(height: 7,),
               GestureDetector(
                 onTap: (){
                   Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                              builder: (context) => NotificationWeb(url:'https://elsahariano.com/kreina/points.php?phone=${phone.replaceAll('+', "0")}&lang=${language}',title:'Points',)));
                 },
                 child: Container(
                   decoration: BoxDecoration(
                     color: appColor,
                     borderRadius: BorderRadius.circular(5)),
                   child: Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: Text('Benefit from my points',style: TextStyle(color: Colors.white),),
                 ),),
               )
             ],
             ),),
           ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(left: 15,right: 15,bottom: 25),
              child: Row(
                children: [
               Expanded(
                    child: GestureDetector(
                      onTap: (){
                        shareIos();
                      },
                      child: Container(
                        height: 50,
                        child:Image.asset('assets/appstore.png',fit: BoxFit.cover,)
                      ),
                    ),
               ),
                  SizedBox(width: 10,),
                  Expanded(
                    child: GestureDetector(
                      onTap: (){
                       shareAndroid();
                      },
                      child: Container(
                        height: 50,
                        child: Image.asset('assets/android.png',fit: BoxFit.cover,)
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}