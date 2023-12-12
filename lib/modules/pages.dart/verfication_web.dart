import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';
import 'package:sahariano_travel/modeles/registerModel.dart';
import 'package:sahariano_travel/modeles/userModel.dart';
import 'package:sahariano_travel/modules/pages.dart/onbording_screen.dart';
import 'package:sahariano_travel/modules/pages.dart/register.dart';
import 'package:sahariano_travel/modules/pages.dart/sms_verification.dart';
import 'package:sahariano_travel/shared/components/components.dart';
import 'package:sahariano_travel/shared/components/constants.dart';
import 'package:sahariano_travel/shared/network/remote/dio_helper.dart';
import 'package:sahariano_travel/shared/network/remote/local/cache_helper.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class VerficationWeb extends StatefulWidget {
  final String phoneCode;
  final String phoneNumber;
  String verificationId;
  VerficationWeb({ Key key,this.phoneCode, this.phoneNumber, this.verificationId }) : super(key: key);

  @override
  VerficationWebState createState() => VerficationWebState();
}

class VerficationWebState extends State<VerficationWeb>{
   var fbm = FirebaseMessaging.instance;
  String fcmtoken='';
   String code;
   bool onEditing = true;
   String otp, authStatus = "";
static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  Map<String, dynamic> _deviceData = <String, dynamic>{};
  var fromkey = GlobalKey<FormState>();

@override
  void initState() {
    fbm.getToken().then((token){
     print(token);
     fcmtoken = token;
    });
    initPlatformState();

      // WidgetsBinding.instance.addPostFrameCallback((_) =>
      //   ShowCaseWidget.of(context)
      //       .startShowCase([iconcart,iconserch,morecategory,moreproduct]));
    super.initState();
  }
  Future<void> initPlatformState() async {
    var deviceData = <String, dynamic>{};
    try {
     if (Platform.isAndroid) {
          deviceData = _readAndroidBuildData(await deviceInfoPlugin.androidInfo);
        } else if (Platform.isIOS) {
          deviceData = _readIosDeviceInfo(await deviceInfoPlugin.iosInfo);
        }
    } on PlatformException {
      deviceData = <String, dynamic>{
        'Error:':'Failed to get platform version.'
      };
    }

    if (!mounted) return;
    setState(() {
      _deviceData = deviceData;
    });
  }
  Map<String, dynamic> _readAndroidBuildData(AndroidDeviceInfo build) {
    return <String, dynamic>{
      'version.release': build.version.release,
      'fingerprint': build.fingerprint,
      'androidId': build.androidId,
    };
  }

  Map<String, dynamic> _readIosDeviceInfo(IosDeviceInfo data) {
    return <String, dynamic>{
      'name': data.name,
      'systemName': data.systemName,
      'systemVersion': data.systemVersion,
      'model': data.model,
      'localizedModel': data.localizedModel,
      'identifierForVendor': data.identifierForVendor,
      'isPhysicalDevice': data.isPhysicalDevice,
      'utsname.sysname:': data.utsname.sysname,
      'utsname.nodename:': data.utsname.nodename,
      'utsname.release:': data.utsname.release,
      'utsname.version:': data.utsname.version,
      'utsname.machine:': data.utsname.machine,
      'id':data.identifierForVendor
    };
  }


   RegisterModelApi registerModelApi;
   RegisterModel userModel;

  Future<void> LoginParfum({
  String firstName,
  String lastName,
  String phone,
  String password,
})
async{  
setState(() {
  
});
await DioHelper.postData(
  url:"${parfum}/api/v1/register",
  data: {
    "given_name":"${firstName}",
    "surname":"${lastName}",
    "phone_number":"${phone}",
    "uid": "${FirebaseAuth.instance.currentUser.uid}",
    "device":{
      "token_firebase":"${fcmtoken}",
      "device_id":"z0f33s43p4",
      "device_name":"iphone",
      "ip_address":"192.168.1.1",
      "mac_address":"192.168.1.1"
    }
  },
).then((value) {
  printFullText('login: ${value.data.toString()}');
  registerModelApi = RegisterModelApi.fromJson(value.data);
  Cachehelper.sharedPreferences.setString("access_token",registerModelApi.access_token);
  Cachehelper.saveData(key: "access_token", value:registerModelApi.access_token);
  Cachehelper.saveData(key: "token_type", value:registerModelApi.token_type);
  Cachehelper.saveData(key: "token", value:value.data['access_token']);
  
 setState(() {
   
 });
}).catchError((error){
  print(error.toString());
  setState(() {
    
  });
});
}


// Future<void> userRegister({
//   String firstName,
//   String lastName,
//   String phone,
//   String referralCode,
//   String currency,
//   String firebaseUid,
//   String language,
//   String device_id,
//   String phoneCode,
//   String FirstName,
// })
// async{
//   var data = {
//   "firstName":firstName,
// 	"lastName":lastName,
// 	"phone":phone.replaceAll("+", "0"),
// 	"referralCode":referralCode,
// 	"currency":currency,
// 	"firebaseUid":firebaseUid,
// 	"language":language,
//   "device_id":device_id,
//   "phoneCode":phoneCode
//   };
//   print(data);
// await DioHelper.postData(
//   url:"${elsaharianoUrl}/api/v1/auth/application/register",
//   data:data
// ).then((value) {
//   printFullText('register: ${value.data.toString()}');
//    userModel = RegisterModel.fromJson(value.data);
//     setState(() {
//
//     });
// }).catchError((error){
//   print(error.toString());
//    setState(() {
//
//    });
// });
// }

   // Future<void> userLogin({
   //   String phone,
   //   String firebaseUid,
   //   String device_id,
   //   String phoneCode,
   // })
   // async{
   //   var data = {
   //     "phone_number":phone.replaceAll("+", "0"),
   //     "uid":FirebaseAuth.instance.currentUser.uid,
   //     "device":{
   //       "token_firebase":"${fcmtoken}",
   //       "device_id":"${device_id}",
   //       "device_name":"iphone",
   //       "ip_address":"192.168.1.1",
   //       "mac_address":"192.168.1.1"
   //     }
   //   };
   //   print(data);
   //   await DioHelper.postData(
   //       url:"${elsaharianoUrl}/api/v1/auth/application/login",
   //       data:data
   //   ).then((value) {
   //
   //   }).catchError((error){
   //     print(error.toString());
   //     setState(() {
   //
   //     });
   //   });
   // }




Future<void>Login({phone,device_id,firebaseUid})async{
    print(widget.phoneNumber);
  var data = {
    "phone_number":phone.replaceAll("+", "0"),
    "uid":firebaseUid,
    "device":{
      "token_firebase":"${fcmtoken}",
      "device_id":"${device_id}",
      "device_name":"iphone",
      "ip_address":"192.168.1.1",
      "mac_address":"192.168.1.1"
    }
  };
  print(data);
  http.Response response = await http.post(
    Uri.parse('${baseurl}/api/v1/auth/application/login'),
    headers:{'Content-Type':'application/json','Accept':'application/json','Authorization': 'Bearer ${access_token}'},
    body:jsonEncode(data)
  ).then((value){
    var responsebody = jsonDecode(value.body);
    print(responsebody);
    if(responsebody['message']=='Sign In Successful'){
      Cachehelper.saveData(key: "phone",value:widget.phoneNumber);
      Cachehelper.saveData(key: "firstName",value:responsebody['user']['given_name']);
      Cachehelper.saveData(key: "lastName",value:responsebody['user']['surname']);
      // Cachehelper.saveData(key: "currency",value:responsebody['user']['currency']);
      // Cachehelper.saveData(key: "language",value:responsebody['user']['language']);
      Cachehelper.saveData(key: "id",value:responsebody['user']['id']);
      if(responsebody['user']['type']!=null){
        Cachehelper.saveData(key: "type",value:responsebody['user']['type']);
      }else{
        Cachehelper.saveData(key: "type",value:"client");
      }
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>OnbordingScreen()), (route) => false);
      userModel = RegisterModel.fromJson(responsebody);
      setState(() {

      });
    }

    if(responsebody['message']=='this device is not the correct device'){
      AwesomeDialog(
        context:context,
        dialogType:DialogType.WARNING,
        animType:AnimType.BOTTOMSLIDE,
        title:'Worning',
        desc:'This not your number try login with your number ${responsebody['device_number']}',
        btnOkText:'Try again',
        btnOkOnPress: () {
          navigateTo(context, SmSVerification());
        },
      )..show();
    }

    if(responsebody['message']=='user logging failed'){
      navigateTo(context, Register(lang:'en',phoneNumber:widget.phoneNumber,phoneCode:widget.phoneCode));
    }



  }).catchError((error){
    printFullText(error.toString());
  });
  return response;
}


   Future<void> verifyPhoneNumber(BuildContext context) async {

     await FirebaseAuth.instance.verifyPhoneNumber(
       phoneNumber:widget.phoneNumber,
       timeout: const Duration(seconds: 15),
       verificationCompleted: (AuthCredential authCredential) {
         setState(() {
           authStatus = "Your account is successfully verified";
           print('${authStatus}');

         });
       },
       verificationFailed: (authException) {
         setState(() {
           authStatus = authException.message;
           print(authStatus);
           // Fluttertoast.showToast(
           //     msg: "فشلت محاولة حصول على كود يرجى تواصل معنا",
           //     toastLength: Toast.LENGTH_SHORT,
           //     gravity: ToastGravity.BOTTOM,
           //     webShowClose:false,
           //     backgroundColor:AppColor,
           //     textColor: Colors.white,
           //     fontSize: 16.0
           // );

           print('${authStatus}');
         });
       },
       codeSent: (String verId, [int forceCodeResent]) {
         widget.verificationId = verId;


       },
       codeAutoRetrievalTimeout: (String verId) {
         widget.verificationId = verId;
       },
     );
   }


  bool isLoading=true;
  final _key = UniqueKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          elevation: 0,
          leading: GestureDetector(
            onTap: (){
              Navigator.of(context).pop();
              },
              child: Icon(Icons.arrow_back,color: Colors.black)),
              title:Text('verification',style: TextStyle(color: Colors.black),),
          ),
        body:Stack(
          children:<Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      'verification',
                      style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),
                    ),
                  ),
                ),

                SizedBox(height: 5,),

                Padding(
                  padding: const EdgeInsets.only(right: 20,left: 20),
                  child: Text('Wait a little while and then enter the code we just sent to your number', style: TextStyle(fontSize: 17.0,color: Colors.grey[500]),textAlign: TextAlign.center),
                ),

                TextButton(onPressed:(){
                  Navigator.pop(context);
                },child:Text('Change number',
                  style:TextStyle(
                      color:appColor,
                      fontWeight:FontWeight.bold,
                      fontSize:15.8
                ),)),

                VerificationCode(
                  fillColor:Colors.grey[100],
                  fullBorder:true,
                  underlineUnfocusedColor: Colors.grey[100],
                  textStyle:Theme.of(context).textTheme.bodyText2.copyWith(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),
                  keyboardType:TextInputType.number,
                  underlineColor:appColor,
                  length:6,
                  cursorColor:appColor,
                  margin:const EdgeInsets.all(1),
                  onCompleted:(String value)async{
                    code = value;
                    isLoading = false;
                    await FirebaseAuth.instance.signInWithCredential(PhoneAuthProvider.credential(verificationId:widget.verificationId,smsCode:code)).then((value){
                      Login(phone:widget.phoneNumber,device_id:_deviceData['fingerprint'],firebaseUid:FirebaseAuth.instance.currentUser.uid,);
                      // userLogin(
                      //   device_id:_deviceData['fingerprint'],
                      //   phone:widget.phoneNumber,
                      //   phoneCode:widget.phoneCode,
                      //   firebaseUid:FirebaseAuth.instance.currentUser.uid,
                      // );
                     }).catchError((e){
                      print(e.toString());

                     });

                    setState((){

                    });
                  },
                  onEditing: (bool value) {
                    setState(() {
                      onEditing = value;
                    });
                    if (!onEditing) FocusScope.of(context).unfocus();
                  },
                ),

                SizedBox(height: 10,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Did not receive a code? '),
                    TextButton(onPressed: (){
                      verifyPhoneNumber(context);
                     },child: Text('Resend',style: TextStyle(
                        color: appColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 15.8
                    ),)),
                  ],
                ),

                SizedBox(height: 6,),
                GestureDetector(
                  onTap: ()async{
                    isLoading = false;
                    await FirebaseAuth.instance.signInWithCredential(PhoneAuthProvider.credential(verificationId:widget.verificationId, smsCode: code)).then((value){
                      print('sign in successfully');
                      // if(islogin){
                      //   if(FirebaseAuth.instance.currentUser!=null){
                      //     fbm.getToken().then((token)async{
                      //       fcmtoken = token;
                      //       await DioHelper.postData(
                      //         data:{
                      //           "phone": "${phoneNumber}",
                      //           "uid": "${FirebaseAuth.instance.currentUser.uid}",
                      //           "device":{
                      //             "token_firebase":"${fcmtoken}",
                      //             "device_id":"z0f33s43p4",
                      //             "device_name":"iphone",
                      //             "ip_address":"192.168.1.1",
                      //             "mac_address":"192.168.1.1"
                      //           }
                      //         },
                      //         url: 'https://www.api.canariapp.com/v1/client/login',
                      //       ).then((value) {
                      //         printFullText(value.data.toString());
                      //         Cachehelper.sharedPreferences.setString("deviceId",value.data['device_id'].toString());
                      //         Cachehelper.sharedPreferences.setString("token",value.data['token']);
                      //         Cachehelper.sharedPreferences.setString("first_name",value.data['client']['first_name']);
                      //         Cachehelper.sharedPreferences.setString("last_name",value.data['client']['last_name']);
                      //         Cachehelper.sharedPreferences.setString("phone",value.data['client']['phone']);
                      //         setState(() {
                      //           Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>MyHomePage(
                      //             latitude: latitude,
                      //             longitude: longitude,
                      //             myLocation: myLocation,
                      //             timestart: TimeStart,
                      //             timeend: TimeEnd,
                      //           )), (route) => false);
                      //         });
                      //       }).catchError((error){
                      //         setState(() {
                      //           Fluttertoast.showToast(
                      //               msg: "ليس لديك حساب قم بانشاء واحد",
                      //               toastLength: Toast.LENGTH_SHORT,
                      //               gravity: ToastGravity.BOTTOM,
                      //               webShowClose:false,
                      //               backgroundColor: AppColor,
                      //               textColor: Colors.white,
                      //               fontSize: 16.0
                      //           );
                      //           isLoading =true;
                      //           islogin = false;
                      //           iswebview = false;
                      //         });
                      //       });
                      //     });
                      //   }
                      // }else{
                      //   fbm.getToken().then((token)async{
                      //     fcmtoken = token;
                      //     await DioHelper.postData(
                      //       data:{
                      //         "first_name":FirstnameController.text,
                      //         "last_name":LastnameController.text,
                      //         "phone":"${phoneNumber}",
                      //         "invitation_code":InvitationCodeController.text,
                      //         "device":{
                      //           "token_firebase":"${fcmtoken}",
                      //           "device_id":"z0f33s43p4",
                      //           "device_name":"iphone",
                      //           "ip_address":"192.168.1.1",
                      //           "mac_address":"192.168.1.1"
                      //         }
                      //       },
                      //       url: 'https://www.api.canariapp.com/v1/client/register',
                      //     ).then((value) {
                      //       Cachehelper.sharedPreferences.setString("deviceId",value.data['device_id'].toString());
                      //       Cachehelper.sharedPreferences.setString("token",value.data['token']);
                      //       Cachehelper.sharedPreferences.setString("first_name",value.data['client']['first_name']);
                      //       Cachehelper.sharedPreferences.setString("last_name",value.data['client']['last_name']);
                      //       Cachehelper.sharedPreferences.setString("phone",value.data['client']['phone']);
                      //       setState(() {
                      //         Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>MyHomePage(
                      //           latitude: latitude,
                      //           longitude: longitude,
                      //           myLocation: myLocation,
                      //           timestart: TimeStart,
                      //           timeend: TimeEnd,
                      //         )), (route) => false);
                      //       });
                      //     }).catchError((error){
                      //       setState(() {
                      //         Fluttertoast.showToast(
                      //             msg: "ليس لديك حساب قم بانشاء واحد",
                      //             toastLength: Toast.LENGTH_SHORT,
                      //             gravity: ToastGravity.BOTTOM,
                      //             webShowClose:false,
                      //             backgroundColor: AppColor,
                      //             textColor: Colors.white,
                      //             fontSize: 16.0
                      //         );
                      //         isLoading =true;
                      //         islogin = false;
                      //         iswebview = false;
                      //       });
                      //     });
                      //   });
                      // }

                    });

                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20,right: 20),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color:code!=null?appColor:Colors.grey[300]
                      ),
                      child: Center(
                          child: isLoading ? Text('Confirm',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ) : CircularProgressIndicator(color: Colors.white)),
                      height: 58,
                      width: double.infinity,
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    Text('If you face any problem in registering'),
                    TextButton(
                        onPressed: () async => await launch(
                            "https://wa.me/+212619157091?text= مشكلتي : لم يصلني كود"),
                        child: Text('Connect with us',style: TextStyle(
                            color: appColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 12.8
                        ),)),
                  ],
                ),
              ],
            ),
          ],
        )

        // Stack(
        //   children: <Widget>[
        //
        //
        //
        //     // WebView(
        //     //   key: _key,
        //     //   zoomEnabled: false,
        //     //   initialUrl: widget.url,
        //     //   javascriptMode: JavascriptMode.unrestricted,
        //     //   javascriptChannels:<JavascriptChannel>{
        //     // JavascriptChannel(
        //     //     name: 'messageHandler',
        //     //     onMessageReceived: (JavascriptMessage message) {
        //     //         print(jsonDecode(message.message));
        //     //         Map<String, dynamic> user = jsonDecode(message.message);
        //     //         if (user['status']==false){
        //     //           navigateTo(context, Register(lang: 'en',phoneNumber: widget.phoneNumber,phoneCode: widget.phoneCode,));
        //     //         }else{
        //     //            userRegister(
        //     //            FirstName:'',
        //     //            currency:'',
        //     //            device_id:_deviceData['androidId'],
        //     //            firebaseUid:'',
        //     //            firstName:'',
        //     //            language:'',
        //     //            lastName:'',
        //     //            phone:widget.phoneNumber,
        //     //            phoneCode:widget.phoneCode,
        //     //            referralCode:''
        //     //            ).then((value) {
        //     //              if (userModel.statusCode!=200){
        //     //               AwesomeDialog(
        //     //               context:context,
        //     //               dialogType:DialogType.WARNING,
        //     //               animType:AnimType.BOTTOMSLIDE,
        //     //               title:'Worning',
        //     //               desc:'This not your number try login with your number',
        //     //               btnOkText:'Try again',
        //     //               btnOkOnPress: () {
        //     //                 navigateTo(context, SmSVerification());
        //     //                },
        //     //              )..show();
        //     //           }else{


        //     //             Cachehelper.saveData(key: "phone",value:widget.phoneNumber);
        //     //             Cachehelper.saveData(key: "firstName",value:user['firstName']);
        //     //             Cachehelper.saveData(key: "lastName",value:user['lastName']);
        //     //             Cachehelper.saveData(key: "currency",value:user['currency']);
        //     //             Cachehelper.saveData(key: "language",value:user['lang']);
        //     //             Cachehelper.saveData(key: "id",value:user['id']);
        //     //             Cachehelper.saveData(key: "type",value:user['type']);
        //     //             Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>OnbordingScreen()), (route) => false);
        //     //

      //     }
        //     //           });
        //     //         }
        //     //     },)},
        //     //   onPageFinished: (finished){
        //     //      setState(() {
        //     //        isLoading = false;
        //     //      });
        //     //   },
        //     //
        //     //
        //     // ),
        //     // isLoading ? Center(child: CircularProgressIndicator(),)
        //     //           : Stack(),
        //   ],
        // ),
      );
  }


}