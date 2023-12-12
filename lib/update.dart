import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io';

class Update extends StatefulWidget {
  const Update({ Key key }) : super(key: key);

  @override
  _UpdateState createState() => _UpdateState();
}

class _UpdateState extends State<Update> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
         Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/logo.png',height: 100),
              SizedBox(height: 15,),
              Text('El Sahariano Travel needs an update',style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600, fontSize: 14),),
              SizedBox(height: 15,),
              Padding(
                padding: const EdgeInsets.only(left: 30,right: 30),
                child: Text('To use this app you need to download the latest version , please update app now',style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w600, fontSize: 14),textAlign: TextAlign.center),
              ),
             SizedBox(height: 20,),
               Padding(
                  padding: const EdgeInsets.only(left: 30,right: 30),
                 child: Container(
                     decoration: BoxDecoration(
                     borderRadius: BorderRadius.circular(5),
                     color:Color(0xFF1e8e3e),
                   ),
                 width: double.infinity,
                 height: 55,
                 child: ElevatedButton(
                   style: ElevatedButton.styleFrom(
                    primary: Color(0xFF1e8e3e),
                   ),
                   onPressed: (){
                     if(Platform.isAndroid){
                       launch("https://play.google.com/store/apps/details?id=com.elsaharianobookingapp");
                     }
                     else if(Platform.isIOS){
                       launch("https://apps.apple.com/ma/app/el-sahariano-travel/id1598163292");
                     }
                   },
                      child: Text('UPDATE',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 15),)),
           ),
               ),
            ],
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.only(bottom: 25),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(FontAwesomeIcons.googlePlay,size: 20),
                SizedBox(width: 10,),
                Text('Google play',style: TextStyle(color: Color.fromARGB(255, 64, 64, 64),fontWeight: FontWeight.bold,fontSize: 15),)
              ],
            ),
          )
        ],
      ),
    );
  }
}