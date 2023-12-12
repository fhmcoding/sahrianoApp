import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sahariano_travel/localization/demo_localization.dart';
import 'package:sahariano_travel/localization/localization_constants.dart';
import 'package:sahariano_travel/main.dart';
import 'package:sahariano_travel/modeles/language.dart';
import 'package:sahariano_travel/modules/pages.dart/notification/notification.dart';
import 'package:sahariano_travel/modules/pages.dart/register.dart';
import 'package:sahariano_travel/modules/pages.dart/sms_verification.dart';
import 'package:sahariano_travel/shared/components/components.dart';
import 'package:sahariano_travel/shared/network/remote/local/cache_helper.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
 String phone = Cachehelper.getData(key: "phone");
   String currency = Cachehelper.getData(key: "currency");
   String firstName = Cachehelper.getData(key: "firstName");
   String lastName = Cachehelper.getData(key: "lastName");
   String access_token = Cachehelper.getData(key: "access_token");
   String selectelang = 'language';
   String langApp;

  void _changeLanguge(Language lang) async{
    Locale _temp = await setLocale(lang.languageCode);
    
    // MyApp.setLocale(context, _temp);
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFf6f5f1),
        body:  Stack(
          alignment: Alignment.center,
          children: [
          
          Image(image: AssetImage('assets/screen.png'),height: MediaQuery.of(context).size.height,width: MediaQuery.of(context).size.width,fit: BoxFit.cover),
            Padding(
              padding: const EdgeInsets.only(top: 90),
              child: Text(
                DemoLocalization.of(context).getTranslatedValue('home_page'),
                style: TextStyle(
                    color: Color(0xFFf37021).withOpacity(0.8),
                    fontSize: 19,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 373),
              child: Container(
                  height: 58,
                  width: 350,
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xFFf37021), width: 1.5),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Stack(
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 16),
                            child: Icon(
                              Icons.language,
                              color: Color(0xFFf37021),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child: Container(
                              height: 30,
                              width: 2,
                              color: Color(0xFFf37021),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 55, top: 5, right: 30),
                        child: DropdownButton(
                          onChanged: (Language language) async {
                            await _changeLanguge(language);
                            setState(() {
                              selectelang = language.name;
                              langApp = language.languageCode;
                              print(langApp);
                            });
                          },
                            
                          icon: Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.black,
                          ),
                          underline: SizedBox(),
                          isExpanded: true,
                          hint: Padding(
                            padding: const EdgeInsets.only(right: 30, top: 0),
                            child: Text(
                              '${selectelang}'
                            ),
                          ),
                          items: Language.languageList()
                              .map<DropdownMenuItem<Language>>((lang) {
                                  return DropdownMenuItem(
                                    value:lang, child:Text(lang.name),
                                    );
                                } 
                              ).toList(),
                              
                        ),
                      )
                    ],
                  )
                  ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 515),
              child: GestureDetector(
                onTap: () {
                  if(phone!=null){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Register(lang:langApp,)));
                  }else{
                   return  Navigator.push(context, MaterialPageRoute(builder: (context)=>SmSVerification(lang:langApp,)));
                  }
                   
                   
                },
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Color(0xFFf37021),
                    ),
                    child: Center(
                      child: Text(
                        DemoLocalization.of(context)
                            .getTranslatedValue('login_button'),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    height: 55,
                    width: 350,
                  ),
                ),
              ),
            ),
                        
          ],
                ));
  }
}
