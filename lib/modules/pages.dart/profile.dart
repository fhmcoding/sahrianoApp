import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahariano_travel/drawer/menuwidget.dart';
import 'package:sahariano_travel/layout/cubit/cubit.dart';
import 'package:sahariano_travel/layout/cubit/states.dart';
import 'package:sahariano_travel/localization/demo_localization.dart';
import 'package:sahariano_travel/localization/localization_constants.dart';
import 'package:sahariano_travel/main.dart';
import 'package:sahariano_travel/modeles/language.dart';
import 'package:sahariano_travel/shared/components/constants.dart';
import 'package:sahariano_travel/shared/network/remote/local/cache_helper.dart';
import 'package:restart_app/restart_app.dart';

class Profile extends StatefulWidget {
  int id;
   final int selectedIndex ;

   Profile({ Key key,this.id, this.selectedIndex }) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  int id = Cachehelper.getData(key: "id");
  String firstName = Cachehelper.getData(key: "firstName");
  String lastName = Cachehelper.getData(key: "lastName");
  String currency = Cachehelper.getData(key: "currency");
  String type = Cachehelper.getData(key: "type");
  String language = Cachehelper.getData(key: "langugeCode"); 
  String phone = Cachehelper.getData(key: "phone");
  String selectelang = 'language';
  void _changeLanguge(Language lang) async{
    Locale _temp = await setLocale(lang.languageCode);
    MyApp.setLocale(context, _temp);
  }
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>AppCubit(),
      child: BlocConsumer<AppCubit,AppStates>(
        listener:(context,state){},
        builder:(context,state){
        //  Cachehelper.sharedPreferences.setString("type",AppCubit.get(context).type);
          return WillPopScope(
            onWillPop: (){
            return Navigator.push(context, MaterialPageRoute(builder: (context)=>InializeWidget()));
            },
            child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              leading: MenuWidget(),
              elevation: 0,
              backgroundColor: Colors.white,
              centerTitle: true,
              title: Text(DemoLocalization.of(context).getTranslatedValue('profile_account'),style: TextStyle(color: appColor),),
            ),
            body:Padding(
              padding: const EdgeInsets.only(left: 20,top: 40,right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(DemoLocalization.of(context).getTranslatedValue('first_name'),style: TextStyle(fontSize: 23),),
                  SizedBox(height: 15,),
                   Container(
                     child: Padding(
                       padding: const EdgeInsets.only(left: 10,top: 17,right: 10),
                       child: Text("${firstName}",style: TextStyle(fontSize: 20,color: Color(0xFF173242)),),
                     ),
                     decoration: BoxDecoration(
                       border: Border.all(color:Color(0xFFf37021),width: 2),
                       borderRadius: BorderRadius.circular(5),
                       color: Colors.white
                     ),
                     height: 60,width: double.infinity,),
                     SizedBox(height: 20,),
                      Text(DemoLocalization.of(context).getTranslatedValue('last_name'),style: TextStyle(fontSize: 23),),
                   SizedBox(height: 15,),
                 Container(
                     child: Padding(
                       padding: const EdgeInsets.only(left: 10,top: 17,right: 10),
                       child: Text("${lastName}",style: TextStyle(fontSize: 20,color: Color(0xFF173242)),),
                     ),
                     decoration: BoxDecoration(
                       border: Border.all(color:Color(0xFFf37021),width: 2),
                       borderRadius: BorderRadius.circular(5),
                       color: Colors.white
                     ),
                     height: 60,width: double.infinity,),
                     SizedBox(height: 20,),
                      Text(DemoLocalization.of(context).getTranslatedValue('currency'),style: TextStyle(fontSize: 23),),
                       SizedBox(height: 15,),
                  Container(
                        height: 60,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(color:Color(0xFFf37021), width: 2)),
                        width: double.infinity,
                        child: DropdownButton(
                            elevation: 3,
                            icon: Padding(
                              padding:
                                  const EdgeInsets.only(top: 10, right: 25, left: 50,),
                              child: Icon(
                                Icons.keyboard_arrow_down,
                                color: Color(0xFF7B919D),
                              ),
                            ),
                            underline: SizedBox(),
                            hint: Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, top: 10, right: 10),
                              child: Text(
                                currency!=null?"${currency}":'select Currency',
                                style: TextStyle(
                                  color:Color(0xFF173242),
                                ),
                              ),
                            ),
                            isExpanded: true,
                            items: ["MAD", "Euro"]
                                .map((e) => DropdownMenuItem(
                                      child: Center(
                                        child: Text(
                                          "$e",
                                          style: TextStyle(
                                            color: Color(0xFF173242),
                                          ),
                                        ),
                                      ),
                                      value: e,
                                    ))
                                .toList(),
                            onChanged: (selecteCurrencyInfo) {
                              setState(() {
                                currency = selecteCurrencyInfo;
                                Cachehelper.sharedPreferences.setString("currency", selecteCurrencyInfo);
                              });
                            }),
                      ),
                       SizedBox(height: 20,),
                       Text(DemoLocalization.of(context).getTranslatedValue('select_lang'),style: TextStyle(fontSize: 23),),
                       SizedBox(height: 15,),
                        Container(
                          height: 60,
                          width: double.infinity,
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
                                    padding: const EdgeInsets.only(top: 16,right: 5,left: 0),
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
                                 
                                  onChanged: (language) async {
                                    await _changeLanguge(language);
                                   Restart.restartApp(webOrigin: '/');
                                   
                                  },
                                    
                                  icon:  Padding(
                              padding:
                                  const EdgeInsets.only(top: 0, right: 0, left: 0),
                              child: Icon(
                                Icons.keyboard_arrow_down,
                                color: Color(0xFF7B919D),
                              ),
                            ),
                                  underline: SizedBox(),
                                  isExpanded: true,
                                  hint: Padding(
                                    padding: const EdgeInsets.only(right: 30, top: 0),
                                    child: Text(
                                     "${selectelang}",
                                      style: TextStyle(color: Color(0xFF173242)),
                                    ),
                                  ),
                                  items: Language.languageList()
                                      .map<DropdownMenuItem<Language>>(
                                        (lang) {
                                          return DropdownMenuItem(
                                            value: lang, child: Text(lang.name),
                                            );
                                            
                                        } 
                                      )
                                      .toList(),
                                ),
                              )
                            ],
                          )),
                            SizedBox(height: 20,),
                          GestureDetector(
                        onTap: () {
                         Restart.restartApp(webOrigin: '/');
                         },
                        child: Center(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color:Color(0xFFf37021),
                            ),
                            child: Center(
                              child: Text(
                                DemoLocalization.of(context)
                                    .getTranslatedValue('update_button'),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            height: 60,
                            width: double.infinity,
                          ),
                        ),
                      ),
                     
                ],
              ),
            )
            
                  
                  ),
          );
        } ,
      ),
    );
  }
}