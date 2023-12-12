import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'package:sahariano_travel/layout/cubit/cubit.dart';
import 'package:sahariano_travel/layout/home.dart';
import 'package:sahariano_travel/local_notification.dart';
import 'package:sahariano_travel/localization/demo_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:sahariano_travel/localization/localization_constants.dart';
import 'package:sahariano_travel/modules/pages.dart/login_page.dart';
import 'package:sahariano_travel/shared/bloc_observer.dart';
import 'package:sahariano_travel/shared/components/components.dart';
import 'package:sahariano_travel/shared/components/constants.dart';
import 'package:sahariano_travel/shared/network/remote/dio_helper.dart';
import 'package:sahariano_travel/shared/network/remote/local/cache_helper.dart';
import 'package:sahariano_travel/update.dart';
import 'ataycom_app/layout/cubit/cubit.dart';
import 'package:package_info_plus/package_info_plus.dart';

Future<void>firebaseMessagingBackgroundHandler(RemoteMessage message,)async{
  if (message.notification!=null) {
  }
}

 
 Future<bool>checkupdate() async {
     final info = await PackageInfo.fromPlatform();
    String appVersion = info.buildNumber;
    printFullText(appVersion);
    RemoteConfig remoteConfig = RemoteConfig.instance;
    remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: Duration(seconds: 60),
      minimumFetchInterval: Duration(seconds: 1)
    ));
    await remoteConfig.fetchAndActivate();
    String remoteConfigVersion = remoteConfig.getString('appVersion');
    printFullText(remoteConfigVersion);
     if (remoteConfigVersion.compareTo(appVersion)==1)
       return true;
     else
     return false;
  }

  // isLogin(){
  //   final auth = FirebaseAuth.instance;
  //   final user = auth.currentUser;
  //   print(user);
  //   if (user==null) {
  //     return SmSVerification();
  //   }else{
  //     return InializeWidget();
  //   }
  // }

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
   BlocOverrides.runZoned(() {
      runApp(MyApp());
   },
   blocObserver: MyBlocObserver(),
   );
  DioHelper.init();
  Cachehelper.init();
}

class MyApp extends StatefulWidget {  
  static void setLocale(BuildContext context, Locale local) {
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>();
    state.setLocale(local);
    }

  @override
  State<MyApp> createState() => _MyAppState();
  
}

class _MyAppState extends State<MyApp> {
    // var fbm = FirebaseMessaging.instance;
    // String fcmtoken='';

  void initState(){
   setState((){

   LocalNotificationService.initialize(context);
   });
   super.initState();
  }
  
  
 
  Locale _locale;
  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
      print(_locale);
    });
  }
  @override
  void didChangeDependencies() {
    getLocale().then((locale){
      setState(() {
        this._locale = locale;
      });
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
  

   if (_locale == null) {
      return SizedBox(height: 0,);
    } else {
      return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'El Sahariano Travel',
              theme: ThemeData(
                primarySwatch: Colors.orange,
              ),
              supportedLocales: [Locale('en','US'), Locale('ar', 'EG')],
              locale: _locale,
              localizationsDelegates: [
                DemoLocalization.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              localeResolutionCallback:(deviceLocal, supportedLocales){
                for (var local in supportedLocales) {
                  if (local.languageCode == deviceLocal.languageCode &&
                      local.countryCode == deviceLocal.countryCode){
                    return deviceLocal;
                  }
                }
                return supportedLocales.first;
              },
              home:InializeWidget(),
              );
    }
  }
}


  

class InializeWidget extends StatefulWidget {
  const InializeWidget({ Key key }) : super(key: key);

  @override
  _InializeWidgetState createState() => _InializeWidgetState();
}

class _InializeWidgetState extends State<InializeWidget> {
  
   String phone = Cachehelper.getData(key: "phone");
   final auth = FirebaseAuth.instance;
     var fbm = FirebaseMessaging.instance;
  String fcmtoken='';
   
  // FirebaseAuth _auth;
  // User _user;
  // _auth = FirebaseAuth.instance;
  //   _user = _auth.currentUser;
bool isloading = false;
  @override
  void initState() {
       fbm.getToken().then((token){
     print(token);
     fcmtoken = token;
    });
    super.initState();
    
  }
  Future GetNotificationnuevo({String estado})async{
   isloading = false;
 setState(() {
   
 });
   
await DioHelper.getData(
   url:"${elsaharianoUrl}/notifications/notifications.php?estado=${estado}&tel=${phone.replaceAll("+", "0")}&is_read=0",
   ).then((value){
     Service.newNotification = value.data['data'];
     print(Service.newNotification);
     
      isloading = true;
   setState(() {
     
   });
    
   }).catchError((error){
    setState(() {
      
    });
    print(error.toString());
   
   });
}
  
  @override
  Widget build(BuildContext context) {
    // print(auth.currentUser.uid);
    // print(auth.currentUser.phoneNumber);
  FirebaseMessaging.instance.getInitialMessage();
//      FirebaseMessaging.onMessageOpenedApp.listen((message){ 
//     if (message.notification!=null) {
//         LocalNotificationService.display(message);
//         print('click');
//      }
//      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>NotificationScreen(selectedIndex:service.indexId)), (route) => route.isFirst);
   
//  },);

 FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
    FirebaseMessaging.onMessage.listen((message){
     if (message.notification!=null) {
        LocalNotificationService.display(message);
        GetNotificationnuevo(estado: 'nuevo');
     }
  
 },);


    return Scaffold(
      body:FutureBuilder(
        future:checkupdate(),
        builder: (BuildContext context,snapshot){
          return phone == null?snapshot.data==true?Update():LoginPage():snapshot.data==true?Update():Home(Index: service.indexId,);
        },
      )
    );
  }
}



// phone == null ? LoginPage() : Home(Index: service.indexId,)