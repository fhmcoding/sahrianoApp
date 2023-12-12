import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:sahariano_travel/Flight_app/pages/creatTicketPay.dart';
import 'package:sahariano_travel/ataycom_app/pages/orderTicket.dart';
import 'package:sahariano_travel/localization/demo_localization.dart';
import 'package:sahariano_travel/shared/components/components.dart';
import 'package:sahariano_travel/shared/components/constants.dart';
import 'package:sahariano_travel/shared/network/remote/dio_helper.dart';

class PaymentShop extends StatefulWidget {
 final List<dynamic> PaymentMethods;
 final Map<String, dynamic> reservation;
 final Map<String, dynamic> bookingResult;
 final List<dynamic> itemsCart;
 final int total;
 final String type;
 final int currentIndex;
 const PaymentShop({ Key key,this.PaymentMethods,this.reservation,this.itemsCart,this.total,this.type,this.bookingResult, this.currentIndex}) : super(key: key);
  @override
  _PaymentShopState createState() => _PaymentShopState();
}
class _PaymentShopState extends State<PaymentShop> {
  bool isloading = true;
  String payment_method;
  Map<String, dynamic> Checkout;
  double priceMethod;
  Future checkout(String payment_method){
   setState(() {
     print(isloading);
     isloading = false;
   });
   var data = {
     "booking_id":110001057,
     "payment_method":"${payment_method}"
   };
   print(data);
   return DioHelper.postData(
      url: 'https://backend.elsahariano.com/unipay_v2/public/api/checkout',
      data:data
    ).then((value) {
      print(data);
    if (value.data['customerRedirectURL']!=null) {
    navigateTo(context, CreateTicketPayment(url:value.data['customerRedirectURL']));
    setState(() {
     isloading = true;
     });
    }else{
     Checkout = value.data;
     navigateTo(context,OrderTicket(Checkout:Checkout,payment_method:payment_method,itemsCart:widget.itemsCart,total: widget.total,priceMethod:priceMethod,type:widget.type,));
     setState(() {
     isloading = true;
    });
    }
    }).catchError((error) {
    setState((){
    });
    });
  }

  @override
  Widget build(BuildContext context) {
    dynamic price = widget.reservation['price'];
    return Scaffold(
      appBar:buildAppBar(context: context,text: DemoLocalization.of(context).getTranslatedValue('payment_methods')),
      body:  Column(
        children: [
          Row(children: [
            Padding(
              padding: const EdgeInsets.only(left: 20,top: 20,right: 20),
              child: Text('Choose your payment method :',style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 15
              ),),
            ),
          ],),
          SizedBox(height: 20,),
          Wrap(
            crossAxisAlignment:WrapCrossAlignment.start ,
            runAlignment: WrapAlignment.start,
            alignment:WrapAlignment.start,
            spacing: 10,
            runSpacing: 10,
            children: [
            ...widget.PaymentMethods.map((e){
              return GestureDetector(
                onTap: (){                  
                showDialog(context: context, builder: (context){
                          return StatefulBuilder(
                            builder: (BuildContext context,setState) {
                              return Dialog(
                              child: Container(
                                decoration:BoxDecoration(
                                  borderRadius:BorderRadius.circular(5),
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
                                      gradient: LinearGradient(
                                      begin: Alignment.topRight,
                                      end: Alignment.bottomLeft,
                                      colors: [
                                      Color(0XFFff733e),
                                      Color(0XFFffcf41),
                                        ],
                                        )
                                      ),
                                      child: Column(
                                        children: [
                                          SizedBox(height: 15,),
                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                             Text('${widget.reservation['price']}',style: TextStyle(
                                             color: Colors.white,
                                             fontSize: 15,
                                             fontWeight: FontWeight.bold
                                               ),),
                                               SizedBox(width: 5,),
                                              Text('PRECIO',style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 13,
                                              fontWeight: FontWeight.w600
                                                ),),
                                                 SizedBox(width: 5,),
                                              Text('+',style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 13,
                                              fontWeight: FontWeight.w600
                                                ),),
                                                SizedBox(width: 5,),
                                               Text('${(price * double.parse(e['fees_pourcentage'])/100).toStringAsFixed(2)} ',style: TextStyle(
                                             color: Colors.white,
                                             fontSize: 13,
                                             fontWeight: FontWeight.bold
                                               ),),
                                                SizedBox(width: 5,),
                                                Text('GASTOS',style: TextStyle(
                                             color: Color(0xFFFFFFFF),
                                             fontSize: 13,
                                             fontWeight: FontWeight.w600
                                               ),),
                                                SizedBox(width: 5,),
                                                Text(PaymentMethods(e['payment_method']),style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600
                                                 ),)
                                            ],
                                          ),
                                            Text('=',style: TextStyle(
                                               color: Colors.white,
                                               fontSize: 20,
                                               fontWeight: FontWeight.bold
                                           ),),
                                            Text('${(double.parse((price * double.parse(e['fees_pourcentage'])/100).toStringAsFixed(2))+price).toStringAsFixed(2)} ${DemoLocalization.of(context).getTranslatedValue('currenc')}',style: TextStyle(
                                               color: Colors.white,
                                               fontSize: 26,
                                               fontWeight: FontWeight.bold
                                           ),),
                                            Text(DemoLocalization.of(context).getTranslatedValue('Total_Price'),
                                             style:TextStyle(
                                             color: Colors.white,
                                             fontSize:15,
                                           ),),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 15,right: 15,top: 10),
                                      child: Text('${DemoLocalization.of(context).getTranslatedValue('payment_methods_subtitle')} ${PaymentMethods(e['payment_method'])} ${DemoLocalization.of(context).getTranslatedValue('payment_methods_sub')}',textAlign: TextAlign.center,style: TextStyle(
                                        fontSize:18,
                                        color: Color.fromARGB(255, 37, 23, 18)
                                      ))
                                    ),
                                    Spacer(),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 15,right: 15,top: 0,bottom: 15),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                         BuildCondition(
                                          condition:isloading,
                                          builder: (context){
                                          return GestureDetector(
                                           onTap: (){
                                            setState((){
                                              isloading = true;
                                              checkout(e['payment_method']);
                                              payment_method = e['payment_method'];
                                              priceMethod = widget.reservation['price'] + widget.reservation['price'] * double.parse(e['fees_pourcentage'])/100;
                                              });
                                            },
                                           child: Container(
                                              decoration: BoxDecoration(
                                                 borderRadius: BorderRadius.circular(5),
                                                 color: Color.fromARGB(255, 1, 241, 53),
                                               ),
                                             height: 50,
                                             width: 120,
                                             child: Center(child: Text(DemoLocalization.of(context).getTranslatedValue('Oui'),textAlign: TextAlign.center,
                                             style: TextStyle(
                                               color: Colors.white,
                                               fontSize: 17,
                                               fontWeight: FontWeight.w600
                                             ),)),
                                           ),
                                         );
                                        },
                                        fallback: (context){
                                          return Container(
                                             decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(5),
                                                color: Color.fromARGB(255, 1, 241, 53),
                                              ),
                                            height: 50,
                                            width: 120,
                                            child: Center(child:CircularProgressIndicator(color: Colors.white,)),
                                          );
                                        },
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
                                             child: Center(child: Text(DemoLocalization.of(context).getTranslatedValue('cancel'),textAlign: TextAlign.center,style: TextStyle(
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
                        child: Image.asset('assets/${e['payment_method']}.png',),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: 8,),
                          Text(PaymentMethods(e['payment_method']),style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Color(0xFF173242),
                          ),),
                          Divider(),
                         Padding(
                           padding: const EdgeInsets.only(top: 0,left: 6,right: 6),
                           child: Container(
                             height: 36,
                             child: Center(child:Text(DemoLocalization.of(context).getTranslatedValue('pay'),textAlign:TextAlign.center,style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold))),
                             decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),color:widget.type==ataycom ?ataycomColor:parfumColor),
                             width: double.infinity,
                             
                           ),
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
                    border: Border.all(width: 2,color: widget.type==ataycom ?ataycomColor:parfumColor),
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