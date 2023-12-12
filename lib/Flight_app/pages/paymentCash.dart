import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahariano_travel/Flight_app/cubit_flight/cubit.dart';
import 'package:sahariano_travel/Flight_app/cubit_flight/states.dart';
import 'package:sahariano_travel/Flight_app/pages/createTicket.dart';
import 'package:sahariano_travel/Flight_app/requestSafer.dart';
import 'package:sahariano_travel/localization/demo_localization.dart';
import 'package:sahariano_travel/shared/components/components.dart';
import 'package:sahariano_travel/shared/network/remote/local/cache_helper.dart';

final requestSafer = new RequestSafer();

enum MobileVerificationState { SHOW_MOBILE_FROM_STATE, SHOW_OTP_FROM_STATE }
class PaymentCash extends StatefulWidget {
 final List<dynamic> PaymentMethods;
 final  Map<String, dynamic> customer;

  final List<dynamic> travlers;
 final Map<String, dynamic> reservation;
final List<dynamic>booking;
  final Map<String, dynamic> bookingResult;

 final List<dynamic> FlightOneWay;
 final  MONNameController;
final  MONlasController;
final  monphoneController;
final  emailController;
final  statenameController;
final  citynameController;
final  postcodeController;
final  MonaddressController;
final  int adt;
final  int chd;
final  int inf;
final  totalPrice;
final  double totalTaxe;
final  double adtprice;
final  double chdprice;
final  double infprice;
final  double adtTaxes;
final  double chdTaxes;
final  double infTaxes;
final  double adultFee;
final  double childernFee;
final  double infansFee;
final  dynamic total;
final  sequence_number;
final  Timer timer;
final  List<dynamic> airlines;

final  String MonCountryCode;
final  String MoncountryCallingCode;
final String sourceRequrment;
final String providerType;
 final dynamic Adt_markup;
 final dynamic Chd_markup;
 final dynamic Inf_markup;

 final dynamic AdtService_Fee_Cedido;
 final dynamic ChdService_Fee_Cedido;
 final dynamic InfService_Fee_Cedido;

 final dynamic AdtService_Fee;
 final dynamic ChdService_Fee;
 final dynamic InfService_Fee;
 PaymentCash({ Key key ,this.PaymentMethods,this.reservation,this.bookingResult, this.travlers, this.FlightOneWay, this.MONNameController, this.MONlasController, this.monphoneController, this.emailController, this.statenameController, this.citynameController, this.postcodeController, this.MonaddressController, this.sequence_number, this.MonCountryCode, this.MoncountryCallingCode, this.sourceRequrment, this.customer, this.airlines, this.adt, this.chd, this.inf, this.totalPrice, this.totalTaxe, this.adtprice, this.chdprice, this.infprice, this.adtTaxes, this.chdTaxes, this.infTaxes, this.adultFee, this.childernFee, this.infansFee, this.total, this.providerType, this.timer, this.booking, this.Adt_markup, this.Chd_markup, this.Inf_markup, this.AdtService_Fee_Cedido, this.ChdService_Fee_Cedido, this.InfService_Fee_Cedido, this.AdtService_Fee, this.ChdService_Fee, this.InfService_Fee}) : super(key: key);

  @override
  _PaymentCashState createState() => _PaymentCashState();
}

class _PaymentCashState extends State<PaymentCash> {
  bool isloading = true;
  String payment_method;
  MobileVerificationState currentState = MobileVerificationState.SHOW_MOBILE_FROM_STATE;
  String phoneNumber = Cachehelper.getData(key: "phone");
  String token = Cachehelper.getData(key: "token");
  String smsCode;
  String verificationId;
   Map<String, dynamic> Checkout;
   Map<String, dynamic> bookingResult;


 
  @override
  Widget build(BuildContext context) {
    
     // dynamic price = widget.reservation['price'];
     dynamic TotalPrice ;
    return BlocProvider(
     create: (BuildContext context) =>FlightCubit(),
      child: BlocConsumer<FlightCubit,FlightStates>(
        listener:(context,state){
        if (state is CheckoutSuccessState) {
                  Checkout = state.Checkout;
                  navigateTo(context,CreateTicket(
            isloading:true,
            Checkout: Checkout,
            // bookingRest:state.fligtresult,
            airliens: widget.airlines,
            travelers: widget.travlers,
            booking:widget.booking,
            bookingResult: widget.bookingResult,
            payment_method:payment_method,
            FlightOneWay:widget.FlightOneWay,
            MONNameController: widget.MONNameController,
            MONlasController:widget.MONlasController ,
            emailController:widget.emailController ,
            monphoneController:widget.monphoneController,
            adt: widget.adt,
                  chd: widget.chd,
                  inf: widget.inf,
                  adtTaxes: widget.adtTaxes,
                  chdTaxes:widget.adtTaxes,
                  infTaxes:widget.infTaxes,
                  adtprice:widget.adtprice ,
                  chdprice: widget.chdprice,
                  infprice: widget.infprice,
                  adultFee: widget.adultFee,
                  childernFee: widget.childernFee,
                  infansFee: widget.infansFee,
                  total:TotalPrice,
                  totalTaxe: widget.totalTaxe,

                    Adt_markup:widget.Adt_markup,
                    Chd_markup:widget.Chd_markup,
                    Inf_markup:widget.Inf_markup,

                    AdtService_Fee_Cedido:widget.AdtService_Fee_Cedido,
                    ChdService_Fee_Cedido:widget.ChdService_Fee_Cedido,
                    InfService_Fee_Cedido:widget.InfService_Fee_Cedido,

                    AdtService_Fee:widget.AdtService_Fee,
                    ChdService_Fee:widget.ChdService_Fee,
                    InfService_Fee:widget.InfService_Fee,
           ));
                 }
        },
        builder:(context,state){
          var Cubit = FlightCubit.get(context);
          print(widget.PaymentMethods);
          return Scaffold(
          appBar:buildAppBar(context: context,text: 'Secure Payment'),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Row(children:[
                  Padding(
                    padding: const EdgeInsets.only(left: 15,top: 20),
                    child: Text('Choose your payment method :',style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 15
                    ),),
                  ),
                ],),
                
                SizedBox(height: 20,),
                Wrap(
                  crossAxisAlignment:WrapCrossAlignment.start,
                  runAlignment: WrapAlignment.start,
                  alignment:WrapAlignment.start,
                  spacing:10,
                  runSpacing:10,
                  children:[
                  ...widget.PaymentMethods.map((e){
                    return GestureDetector(
                      onTap: (){
                      showDialog(context: context, builder:(context){
                                return StatefulBuilder(
                                  builder: (BuildContext context,setState) {
                                    return Dialog(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                         color: Colors.white,
                                      ),
                                      height: 300,
                                      child: Column(
                                        children: [
                                          Container(
                                            height: 130,
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                             borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(5),
                                                  bottomLeft: Radius.circular(0),
                                                  bottomRight:Radius.circular(0),
                                                  topRight:Radius.circular(4),
                                                ),
                                             ),
                                            child: Padding(
                                              padding: const EdgeInsets.only(left: 20,top: 10),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [

                                                  SizedBox(height: 10,),
                                                  Text('Payment Method Details',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color:Color(0xff212529))),

                                                  SizedBox(height: 5,),
                                                  Row(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: [
                                                       Text('Price : ',style: TextStyle(color:Color(0xff696c70),fontWeight:FontWeight.w500,fontSize:14)),
                                                      SizedBox(width: 5,),
                                                      Text('${e['total']}',style: TextStyle(color:Color(0xFFed6905),fontWeight:FontWeight.bold,fontSize:17)),
                                                    ],
                                                  ),
                                                  Row(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: [
                                                      Text('Expenses ${e['name']} :',style: TextStyle(color:Color(0xff696c70),fontWeight:FontWeight.w500,fontSize:14)),
                                                      SizedBox(width: 5,),
                                                      Text('${e['fee']}',style: TextStyle(color:Color(0xFFed6905),fontWeight:FontWeight.bold,fontSize:17)),
                                                    ],
                                                  ),
                                                  Row(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: [
                                                      Text('Total  :',style: TextStyle(color:Color(0xff696c70),fontWeight:FontWeight.w500,fontSize:14)),
                                                      SizedBox(width: 5,),
                                                      Text('${e['total']}',style: TextStyle(color:Color(0xFFed6905),fontWeight:FontWeight.bold,fontSize:17)),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Divider(height: 5),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 15,right: 15,top: 10),
                                            child: Text('Etes-vous sûr de vouloir method_cashplus comme mode de paiement ?',textAlign: TextAlign.center,style: TextStyle(
                                              fontSize: 18,
                                              color: Color.fromARGB(255, 37, 23, 18)
                                            )),
                                          ),
                                          Spacer(),
                                        
                                          Padding(
                                            padding: const EdgeInsets.only(left: 15,right: 15,top: 0,bottom: 13),
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                             GestureDetector(
                                                 onTap: (){
                                                  setState((){
                                                     isloading = false;

                                                     Cubit.checkout(e['name'],context: context,transaction_id:e['transaction_id'],token:token);
                                                    // if(widget.sourceRequrment == 'python' && e['payment_method']=='method_agencia'){
                                                    //  FirebaseAuth.instance.verifyPhoneNumber(
                                                    //     phoneNumber: phoneNumber,
                                                    //     verificationCompleted: (PhoneAuthCredential) async {
                                                    //       setState(() {
                                                    //         isloading = false;
                                                    //       });
                                                    //     },
                                                    //     verificationFailed: (verificationFailed) async {
                                                    //       setState(() {
                                                    //         isloading = true;
                                                    //       });
                                                    //     },
                                                    //     codeSent: (verificationId, resendingToken) async {
                                                    //       setState(() {
                                                    //         navigateTo(
                                                    //         context,
                                                    //          Otp(phoneNumber: phoneNumber,
                                                    //           verificationId: verificationId,
                                                    //           smsCode:smsCode,
                                                    //           MONNameController:widget.MONNameController ,
                                                    //           MONlasController:widget.MONlasController ,
                                                    //           MonCountryCode: widget.MonCountryCode,
                                                    //           MonaddressController: widget.MonaddressController,
                                                    //           MoncountryCallingCode:widget.MoncountryCallingCode ,
                                                    //           citynameController:widget.citynameController ,
                                                    //           emailController:widget.emailController ,
                                                    //           monphoneController: widget.monphoneController,
                                                    //           postcodeController: widget.postcodeController,
                                                    //           sequence_number: widget.sequence_number,
                                                    //           statenameController:widget.statenameController ,
                                                    //           travlers: widget.travlers,
                                                    //           paymentMethod:e['payment_method'],
                                                    //           bookingRest: widget.bookingResult,
                                                    //           FlightOneWay:widget.FlightOneWay,
                                                              
                                                    //           ));
                                                    //             setState((){
            
                                                    //             });
                                                    //         this.verificationId = verificationId;
                                                    //       });
                                                    //     },
                                                    //     codeAutoRetrievalTimeout: (verificationId) async {
                                                    //       return Duration(
                                                    //         seconds: 4
                                                    //       );
                                                    //     },
                                                    //   );
                                                    // }else{
                                                    //   if(widget.providerType=='SHT'){
                                                    //     Cubit.checkoutSht(e['payment_method'],context: context);
                                                    //  TotalPrice =price * double.parse(e['fees_pourcentage'])/100 + price;
                                                    //   }else{
                                                    //    Cubit.checkout(e['payment_method'],context: context);
                                                    //  TotalPrice =price * double.parse(e['fees_pourcentage'])/100 + price;
                                                    //   }
                                                    

                                                    // }
                                                    });
                                                  },
                                                 child: Container(
                                                    decoration: BoxDecoration(
                                                       borderRadius: BorderRadius.circular(5),
                                                       color: Color.fromARGB(255, 1, 241, 53),
                                                     ),
                                                   height: 50,
                                                   width: 120,
                                                   child: Center(child:isloading? Text('Oui',textAlign: TextAlign.center,
                                                   style: TextStyle(
                                                     color: Colors.white,
                                                     fontSize: 17,
                                                     fontWeight: FontWeight.w600
                                                   ),):CircularProgressIndicator(color: Colors.white,)),
                                                 ),
                                               ),
                                               SizedBox(width: 15,),
                                                 GestureDetector(
                                                   onTap: (){
                                                     Navigator.pop(context);
                                                   },
                                                   child: Container(
                                                     decoration: BoxDecoration(
                                                       border: Border.all(width: 1.5,color:Color(0xFFF28300) ),
                                                       borderRadius: BorderRadius.circular(5),
                                                       color: Colors.white
                                                     ),
                                                   height: 50,
                                                   width: 120,
                                                   child: Center(child: Text('Cancel',textAlign: TextAlign.center,style: TextStyle(
                                                     color: Color(0xFFF28300),
                                                     fontSize: 17,
                                                     fontWeight: FontWeight.w600
                                                   ),)),
                                                  ),
                                                 ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                    },
                                  
                                );
                              });
                      },
                      child: Container(
                        height: 175,
                        width: 175,
                        child: Column(
                          children: [
                            Container(
                              height: 90,
                              decoration: BoxDecoration(
                                color: Color(0Xfff7f5f6),
                                borderRadius: BorderRadius.only(
                                  bottomLeft:Radius.circular(0) ,
                                  bottomRight:Radius.circular(0) ,
                                  topLeft:Radius.circular(8) ,
                                  topRight:Radius.circular(8) ,
                                )
                              ),
                              width: double.infinity,
                              child: Image.network('${e['image']}',),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(height: 8),
                                Text("${e['name']}",style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14
                                ),),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                      decoration: BoxDecoration(
                                        color:Color(0xFFed6905),
                                        borderRadius: BorderRadius.circular(5)
                                      ),
                                      width:double.infinity,child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child:Center(child: Text('Pay',style:TextStyle(color: Colors.white,fontWeight:FontWeight.bold,fontSize: 16),)),
                                  )),
                                )
                              ],
                            ),
                           
                          ],
                        ),
                        decoration: BoxDecoration(
                          boxShadow: [
                                  BoxShadow(
                                      blurRadius: 4,
                                      color: Colors.grey[350],
                                      offset: Offset(0, 0),
                                      spreadRadius: 1)
                                ],
                          border: Border.all(width: 2,color: Color(0xFFF28300),),
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                      ),
                    );
            
                  })
                  ],
                ),
               
               
              ],
            ),
          ));
        } ,
      ),
    );
  }
  PaymentMethods(String payment_method) {
    if (payment_method == 'method_amanpay') {
      return 'method amanpay';
    }
    if (payment_method == 'method_cashplus'){
      return 'method cashplus';
    }
    if (payment_method == 'method_agencia') {
      return 'method agencia';
    }
    if (payment_method == 'method_redsysbbva') {
      return 'method redsysbbva';
    }
    else{
      return 'method kiosk';
    }
  }


  
}
class Otp extends StatefulWidget {
  String phoneNumber;
  final  String smsCode;
  final String verificationId;
  Map<String, dynamic> Checkout;
  final Map<String, dynamic> bookingRest;
  final List<dynamic> travlers;
  final List<dynamic> FlightOneWay;
  final String payment_method;
   final  MONNameController;
final  MONlasController;
final  monphoneController;
final  emailController;
final  statenameController;
final  citynameController;
final  postcodeController;
final  MonaddressController;
final  sequence_number;
final  String MonCountryCode;
final  String MoncountryCallingCode;
final String paymentMethod;
 Otp({ Key key, this.phoneNumber, this.smsCode, this.verificationId,this.Checkout ,this.bookingRest,this.FlightOneWay,this.travlers,this.payment_method, this.MONNameController, this.MONlasController, this.monphoneController, this.emailController, this.statenameController, this.citynameController, this.postcodeController, this.MonaddressController, this.sequence_number, this.MonCountryCode, this.MoncountryCallingCode, this.paymentMethod}) : super(key: key);

  @override
  _OtpState createState() => _OtpState();
}

class _OtpState extends State<Otp> {
   final GlobalKey<FormState> otpkey = GlobalKey<FormState>();
  final _pinPutController = TextEditingController();
  final _pinPutFocusNode = FocusNode();
  final BoxDecoration pinPutDecoration = BoxDecoration(
    color: const Color.fromRGBO(43, 46, 66, 1),
    borderRadius: BorderRadius.circular(10.0),
    border: Border.all(
      color: const Color.fromRGBO(126, 203, 224, 1),
    ),
  );
  final auth =FirebaseAuth.instance;
  String phoneIsoCode;
  bool visible = false;
  String confirmedNumber = ''; 
  
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>FlightCubit(),
      child: BlocConsumer<FlightCubit,FlightStates>(
      listener: (context,state){
        if (state is CheckoutSuccessState) {
          widget.Checkout = state.Checkout;
        }
        // if (state is UpdatePNRSucessfulState){
        //     navigateTo(context,CreateTicket(
        //     isloading:true,
        //     Checkout: widget.Checkout,
        //     bookingRest:state.fligtresult,
        //     payment_method:widget.payment_method,
        //     FlightOneWay:widget.FlightOneWay,
        //    ));
        // }
      },
      builder: (context,state){
        var cubit = FlightCubit.get(context);
        return  Scaffold(
          body: Form(
          key: otpkey,
          child: Column(children: [
            Center(
              child: Image.asset(
                'assets/verification.png',
                height: 245,
              ),
            ),
            Text(
              DemoLocalization.of(context).getTranslatedValue('titlelsub'),
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 17,
                  color: Color(0xFF173242)),
            ),
            SizedBox(
              height: 15,
            ),
            // Padding(
            //   padding: const EdgeInsets.all(10.0),
            //   child: Directionality(
            //     textDirection: TextDirection.ltr,
            //     child: PinPut(
            //       validator: (pin) {
            //         if (pin == null || pin.isEmpty) {
            //           return 'Please enter some text';
            //         }
            //         return null;
            //       },
            //       fieldsCount: 6,
            //       withCursor: true,
            //       textStyle: const TextStyle(fontSize: 25.0, color: Colors.white),
            //       eachFieldWidth: 55.0,
            //       eachFieldHeight: 55.0,
            //       onSubmit: (pin) {
            //         if (otpkey.currentState.validate()) {
            //          cubit.checkout(widget.paymentMethod,context:context);      
            //           }
            //         setState(() {
                    
            //         });
            //       },
            //       focusNode: _pinPutFocusNode,
            //       controller: _pinPutController,
            //       submittedFieldDecoration: pinPutDecoration,
            //       selectedFieldDecoration: pinPutDecoration,
            //       followingFieldDecoration: pinPutDecoration,
            //       pinAnimationType: PinAnimationType.fade,
            //     ),
            //   ),
            // ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: _pinPutController.text.length < 6
                      ? Color(0xFF7B919D)
                      : Color(0xFFf37021),
                ),
                child: Center(
                    child: _pinPutController.text.length < 6
                        ? Text(
                            DemoLocalization.of(context)
                                .getTranslatedValue('next_buttonresend'),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          )
                        : CircularProgressIndicator(
                            color: Colors.white,
                          )),
                height: 58,
                width: double.infinity,
              ),
            ),
            SizedBox(
              height: 25,
            )
          ]),
        ),
        );
      },
      ),
    );
  }
   void onPhoneNumberChange(
      String number, String internationalizedPhoneNumber, String isoCode) {
    widget.phoneNumber = internationalizedPhoneNumber;
    phoneIsoCode = isoCode;
    setState(() {
      // isloading = true;
    });
  }

  void onValidPhoneNumber(
      String number, String internationalizedPhoneNumber, String isoCode) {
    setState(() {
      visible = true;
      confirmedNumber = internationalizedPhoneNumber;
    });
  }
}