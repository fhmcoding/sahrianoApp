import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahariano_travel/layout/cubit/cubit.dart';
import 'package:sahariano_travel/layout/cubit/states.dart';
import 'package:sahariano_travel/localization/demo_localization.dart';
import 'package:sahariano_travel/modules/pages.dart/sms_verification.dart';
import 'package:sahariano_travel/shared/network/remote/local/cache_helper.dart';
import 'onbording_screen.dart';

class Register extends StatefulWidget {
    final String lang;
      final String phoneCode;
  final String phoneNumber;

  const Register({Key key, this.lang, this.phoneCode, this.phoneNumber}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> with InputValidationMixin{
   var fbm = FirebaseMessaging.instance;
  String fcmtoken='';

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

  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  String selectCurrency = "Currency";
  bool accept = false;
    bool isLoading=true;


  @override
  Widget build(BuildContext context) {
    print(widget.lang);
    
    return BlocProvider(
      create: (BuildContext context)=>AppCubit(),
      child: BlocConsumer<AppCubit,AppStates>(
       listener: (context,state){
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
            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>SmSVerification(curency: selectCurrency,lasname: firstNameController.text,name: lastNameController.text,)), (route) => route.isFirst);
            },
            )..show();
            }else{
              print('${state.userModel.user.id}');
              print('${state.userModel.user.type}');
              Cachehelper.saveData(key: "id",value:state.userModel.user.id);
              Cachehelper.saveData(key: "firstName",value: state.userModel.user.firstName);
              Cachehelper.saveData(key: "lastName",value: state.userModel.user.lastName);
              Cachehelper.saveData(key: "currency",value: state.userModel.user.currency);
              Cachehelper.saveData(key: "phone",value: state.userModel.user.phone);
              Cachehelper.saveData(key: "language",value: state.userModel.user.language);
              Cachehelper.saveData(key: "firebaseUid",value: state.userModel.user.firebaseUid);
              Cachehelper.saveData(key: "type",value: state.userModel.user.type);
               Navigator.push(context,MaterialPageRoute(builder: (context) => OnbordingScreen()));
            }
          }
       },
       builder: (context,state){
         return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back,
                color: Color(0xFF173242),
              ),
            ),
            elevation: 0,
          ),
          body: SingleChildScrollView(
            child: Form(
              key: fromkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Text(
                      DemoLocalization.of(context)
                          .getTranslatedValue('create_account'),
                      style: TextStyle(
                          color: Color(0xFF173242),
                          fontSize: 28,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, top: 10, right: 20),
                    child: Text(
                      DemoLocalization.of(context).getTranslatedValue('first_name'),
                      style: TextStyle(
                          color: Color(0xFF174C6B),
                          fontWeight: FontWeight.w700,
                          fontSize: 17),
                    ),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                    child: TextFormField(
                      autofocus:true,
                      controller:firstNameController,
                      style: TextStyle(color: Colors.black),
                      validator: (input) {
                if (isEmailValid(input)==true) return null;
                else
                  return 'please don\'t write firstName in arabic';
              },
              onFieldSubmitted: (val){
                if (fromkey.currentState.validate()) {
                    fromkey.currentState.save();
                    // use the email provided here
                  }
              },
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(
                                width: 2,
                                color: Color(0xFFf47b31),
                              )),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(
                                 width: 2,
                                color: Color(0xFFf47b31),
                              )),
                          hintText: DemoLocalization.of(context)
                              .getTranslatedValue('first_name'),
                              
                          hintStyle: TextStyle(
                            color: Color(0xFF7B919D),
                          )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                    child: Text(
                      DemoLocalization.of(context).getTranslatedValue('last_name'),
                      style: TextStyle(
                          color: Color(0xFF174C6B),
                          fontWeight: FontWeight.w700,
                          fontSize: 17),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                    child: TextFormField(
                      controller:lastNameController,
                     validator: (input) {
                if (isEmailValid(input)==true) return null;
                else
                  return 'please don\'t write lastName in arabic';
              },
              onFieldSubmitted: (val){
                if (fromkey.currentState.validate()) {
                    fromkey.currentState.save();
                    // use the email provided here
                  }
              },
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(
                                 width: 2,
                                color: Color(0xFFf37021),
                              )
                              ),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(
                                 width: 2,
                                color: Color(0xFFf37021),
                              )),
                          hintText: DemoLocalization.of(context)
                              .getTranslatedValue('last_name'),
                          hintStyle: TextStyle(
                            color: Color(0xFF7B919D),
                          )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                    child: Text(
                      DemoLocalization.of(context).getTranslatedValue('currency'),
                      style: TextStyle(
                          color: Color(0xFF174C6B),
                          fontWeight: FontWeight.w700,
                          fontSize: 17),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                        
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: Color(0xFFf37021), width: 2)),
                      width: double.infinity,
                      child: DropdownButton(
                          elevation: 3,
                          icon: Padding(
                            padding:
                                const EdgeInsets.only(top: 15, right: 10, left: 10),
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
                              selectCurrency,
                              style: TextStyle(
                                color: Color(0xFF7B919D),
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
                              selectCurrency = selecteCurrencyInfo;
                              
                             
                            });
                          }),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5, top: 10),
                    child: Row(
                      children: [
                        Checkbox(
                            checkColor: Colors.white,
                            activeColor: Color(0xFF174C6B),
                            value: accept,
                            onChanged: (value) {
                              setState(() {
                                accept = value;
                              });
                            }),
                        Text(
                          DemoLocalization.of(context)
                              .getTranslatedValue('accept_condition'),
                          style: TextStyle(
                              color: Color(0xFF173242),
                              fontSize: 13,
                              fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                    child: GestureDetector(
                      onTap: () {
                        if (fromkey.currentState.validate()){
                          isLoading = false;
                          setState(() {
                            
                          });
                          AppCubit.get(context).userRegister(
                          fcmToken:fcmtoken,
                          firstName:firstNameController.text,
                          lastName:lastNameController.text,
                          phone:widget.phoneNumber.replaceAll("+", "0"),
                          device_id:_deviceData['androidId'],
                          );

                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: selectCurrency != 'Currency' &&
                                  accept &&
                                  fromkey.currentState.validate()
                              ? Color(0xFFf37021)
                              : Color(0xFF7B919D),
                        ),
                        child: Center(
                          child:isLoading?
 Text(
                            DemoLocalization.of(context)
                                .getTranslatedValue('next_button'),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ):CircularProgressIndicator(color: Colors.white),
                        ),
                        height: 55,
                        width: double.infinity,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
       },
      ),
    );
  }
}
mixin InputValidationMixin {
  bool isPasswordValid(String password) => password.length == 6;

  bool isEmailValid(String input) {
    final alphanumeric = RegExp("(^[^-\\s][a-zA-Z0-9_\\s-]+\$)");
    
    return alphanumeric.hasMatch(input);
  }
}