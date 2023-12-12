import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:country_list_pick/country_list_pick.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:international_phone_input/international_phone_input.dart';
import 'package:sahariano_travel/layout/cubit/cubit.dart';
import 'package:sahariano_travel/layout/cubit/states.dart';
import 'package:sahariano_travel/localization/demo_localization.dart';
import 'package:sahariano_travel/modeles/registerModel.dart';
import 'package:sahariano_travel/modeles/userModel.dart';
import 'package:sahariano_travel/modules/pages.dart/notification/notification_web.dart';
import 'package:sahariano_travel/modules/pages.dart/onbording_screen.dart';
import 'package:sahariano_travel/modules/pages.dart/verfication_web.dart';
import 'package:sahariano_travel/shared/components/components.dart';
import 'package:sahariano_travel/shared/network/remote/local/cache_helper.dart';

enum MobileVerificationState { SHOW_MOBILE_FROM_STATE, SHOW_OTP_FROM_STATE }
class SmSVerification extends StatefulWidget {
  final String name;
  final String lasname;
  final String curency;
  final String lang;
  const SmSVerification({
    Key key,this.name,this.lasname,this.curency, this.lang
  }) : super(key: key);

  @override
  _SmSVerificationState createState() => _SmSVerificationState();
}

class _SmSVerificationState extends State<SmSVerification> {
  var fbm = FirebaseMessaging.instance;
  String otp, authStatus = "";
  String fcmtoken='';
static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  Map<String, dynamic> _deviceData = <String, dynamic>{};
  var fromkey = GlobalKey<FormState>();
  Future<void> verifyPhoneNumber(BuildContext context) async {
    print(phoneNumber);
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber:phoneNumber,
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
        verificationId = verId;
        setState(() {
          authStatus = "OTP has been successfully send";
          isloading = true;
          navigateTo(context,VerficationWeb(
            phoneCode:phoneCode,
            phoneNumber:phoneNumber,
            verificationId:verificationId,
          ));
          print('${authStatus}');
        });

      },
      codeAutoRetrievalTimeout: (String verId) {
        verificationId = verId;
      },
    );
  }

@override
  void initState() {
    fbm.getToken().then((token){
     print(token);
     fcmtoken = token;
    });
    initPlatformState();
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

  int id = Cachehelper.getData(key: "id");
  String phone = Cachehelper.getData(key: "phone");
  RegisterModel loginModel;
  RegisterModelApi registerModelApi;
  String type = "client";
  bool isloading = true;
  MobileVerificationState currentState = MobileVerificationState.SHOW_MOBILE_FROM_STATE;
  final GlobalKey<FormState> otpkey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scafoldkey = GlobalKey<ScaffoldState>();
  final _pinPutController = TextEditingController();
  final _pinPutFocusNode = FocusNode();
  String phoneNumber;
  String smsCode;
  String verificationId;
  final BoxDecoration pinPutDecoration = BoxDecoration(
    color: const Color.fromRGBO(43, 46, 66, 1),
    borderRadius: BorderRadius.circular(10.0),
    border: Border.all(
      color: const Color.fromRGBO(126, 203, 224, 1),
    ),
  );
  final auth =FirebaseAuth.instance;
  String phoneCode = '+212';
  bool visible = false;
  String confirmedNumber = ''; 
  void SignInWithPhoneAuthCredential(
      PhoneAuthCredential phoneAuthcredential) async {
    try {
      final authcredential =
          await FirebaseAuth.instance.signInWithCredential(phoneAuthcredential);
      if (authcredential.user != null){
        
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        isloading = false;
      });
      print("error is ${e.message}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>AppCubit(),
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (context, state){
            if(state is AppRegisterSuccessState){
            if(state.userModel.statusCode!=200){
            AwesomeDialog(
            context: context,
            dialogType: DialogType.WARNING,
            animType: AnimType.BOTTOMSLIDE,
            title: 'Worning',
            desc: 'This not your number try login with your number',
            btnOkText: 'Try again',
            btnOkOnPress: () {
            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>SmSVerification(curency: widget.curency,lasname: widget.lasname,name: widget.name,)), (route) => route.isFirst);
            },
            )..show();
            }else{
              Cachehelper.saveData(key: "id",value:state.userModel.user.id);
              Cachehelper.saveData(key: "firstName",value: state.userModel.user.firstName);
              Cachehelper.saveData(key: "lastName",value: state.userModel.user.lastName);
              Cachehelper.saveData(key: "currency",value: state.userModel.user.currency);
              Cachehelper.saveData(key: "phone",value: state.userModel.user.phone);
              Cachehelper.saveData(key: "language",value: state.userModel.user.language);
              Cachehelper.saveData(key: "firebaseUid",value: state.userModel.user.firebaseUid);
              Cachehelper.saveData(key: "type",value: state.userModel.user.type);
               Navigator.push(context,
               MaterialPageRoute(builder: (context) => OnbordingScreen()));
            }
          }
        },
        builder: (context, state){
          return Scaffold(
          key: _scafoldkey,
            backgroundColor: Colors.white,
            appBar: AppBar(
              elevation: 0,
              leading: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back,
                  color: Color(0xFF173242),
                ),
              ),
              title: Text(
                DemoLocalization.of(context).getTranslatedValue('title_apbar'),
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF173242)),
              ),
              centerTitle: true,
              backgroundColor: Colors.white,
            ),
            body:SingleChildScrollView(
                    child: Form(
                      key:fromkey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 5,
                          ),
                          Center(
                            child: Image.asset(
                              'assets/sms1.webp',
                              fit: BoxFit.cover,
                              height: 265,
                              width: double.infinity,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Center(
                            child: Text(
                              DemoLocalization.of(context)
                                  .getTranslatedValue('title'),
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF173242)),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Center(
                            child: Text(
                              DemoLocalization.of(context)
                                  .getTranslatedValue('subtitle'),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.normal,
                                  color: Color(0xFF174C6B)),
                            ),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child:
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                               Expanded(
                                 child: Container(
                                          height: 60,
                                          decoration: BoxDecoration(
                                              borderRadius:BorderRadius.circular(4),
                                              border: Border.all(
                                                  color: Color(0xFFf37021),
                                                  width: 2)),
                                          child: CountryListPick(
                                              theme: CountryTheme(
                                                initialSelection:'Choisir un pays',
                                                labelColor: Color(0xFFf37021),
                                                alphabetTextColor:Color(0xFFf37021),
                                                alphabetSelectedTextColor:Colors.red,
                                                alphabetSelectedBackgroundColor:Colors.grey[300],
                                                isShowFlag: false,
                                                isShowTitle: false,
                                                isShowCode: true,
                                                isDownIcon: false,
                                                showEnglishName: true,
                                              ),
                                              appBar: AppBar(
                                                backgroundColor:Color(0xFFf37021),
                                                title:Text('Choisir un pays',style: TextStyle(color: Colors.white),),
                                              ),
                                              initialSelection: '+212',
                                              onChanged: (CountryCode code) {
                                                print(code.name);
                                                print(code.dialCode);
                                                phoneCode =code.dialCode;
                                              },
                                              useUiOverlay: false,
                                              useSafeArea: false),
                                        ),
                               ),
                               SizedBox(width: 5,),
                                Expanded(
                                  flex: 3,
                                 child: buildTextFiled(
                                   keyboardType:TextInputType.number,
                                   hintText: 'Number',
                                   valid: 'Number',
                                   onSaved: (number){
                                     if (number.length==9) {
                                       phoneNumber = "${phoneCode}${number}";
                                     } else {
                                       final replaced = number.replaceFirst(RegExp('0'),'');
                                       phoneNumber = "${phoneCode}${replaced}";
                                       print(phoneNumber);
                                     }
                                   
                                   }
                                   ),
                               ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: GestureDetector(
                              onTap: () async{
                                 if (fromkey.currentState.validate()) {
                                    fromkey.currentState.save();
                                     setState(() {
                                      isloading = false;
                                     });
                                    await verifyPhoneNumber(context);
                                 }
                              },                            
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Color(0xFFf37021)
                                      
                                ),
                                child: Center(
                                    child:isloading?Text(
                                  DemoLocalization.of(context)
                                      .getTranslatedValue('next_buttonsend'),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ):CircularProgressIndicator(color: Colors.white)),
                                height: 58,
                                width: double.infinity,
                              ),
                    
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                );
        },
      ),
    );
  }



}
