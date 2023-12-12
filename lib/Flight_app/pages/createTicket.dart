import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sahariano_travel/Flight_app/country_service.dart';
import 'package:sahariano_travel/Flight_app/cubit_flight/cubit.dart';
import 'package:sahariano_travel/Flight_app/cubit_flight/states.dart';
import 'package:sahariano_travel/Flight_app/pages/getTicket.dart';
import 'package:sahariano_travel/Flight_app/requestSafer.dart';
import 'package:sahariano_travel/ataycom_app/layout/cubit/cubit.dart';
import 'package:sahariano_travel/layout/home.dart';
import 'package:sahariano_travel/shared/components/components.dart';
import 'package:sahariano_travel/shared/components/constants.dart';

final requestSafer = new RequestSafer();
final countryService = new CountryService();

class CreateTicket extends StatefulWidget {
final  List<dynamic> booking;
final  Map<String, dynamic> bookingResult;

final List<dynamic> FlightOneWay;
final List<dynamic> airliens;

final  Map<String, dynamic> Checkout;
final  List travelers;
final  String payment_method;
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
final dynamic Adt_markup;
final dynamic Chd_markup;
final dynamic Inf_markup;

final dynamic AdtService_Fee_Cedido;
final dynamic ChdService_Fee_Cedido;
final dynamic InfService_Fee_Cedido;

final dynamic AdtService_Fee;
final dynamic ChdService_Fee;
final dynamic InfService_Fee;
  bool isloading;
  CreateTicket({Key key,this.isloading,this.Checkout,this.booking,this.payment_method, this.FlightOneWay, this.airliens, this.MONNameController, this.MONlasController, this.monphoneController, this.emailController, this.statenameController, this.citynameController, this.postcodeController, this.MonaddressController, this.adt, this.chd, this.inf, this.totalTaxe, this.adtprice, this.chdprice, this.infprice, this.adtTaxes, this.chdTaxes, this.infTaxes, this.adultFee, this.childernFee, this.infansFee, this.total, this.travelers, this.bookingResult, this.Adt_markup, this.Chd_markup, this.Inf_markup, this.AdtService_Fee_Cedido, this.ChdService_Fee_Cedido, this.InfService_Fee_Cedido, this.AdtService_Fee, this.ChdService_Fee, this.InfService_Fee,}) : super(key: key);

  @override
  _CreateTicketState createState() => _CreateTicketState();
}

class _CreateTicketState extends State<CreateTicket>{
    var operaitedby;

   airline(List airline,String logo){
                                
                                airline.forEach((value) { 
                                  if (value['iata_code']==logo) {
                                   operaitedby = value['name']; 
                                  }
                                });
                                return operaitedby;
                                 }
    // double servicefee = 0.0;
  PaymentMethods(String payment_method) {
    if (payment_method == 'method_amanpay') {
      return 'amanpay';
    }
    if (payment_method == 'method_cashplus'){
      return 'cashplus';
    }
    if (payment_method == 'method_agencia') {
      return 'agencia';
    }
    if (payment_method == 'method_redsysbbva') {
      return 'redsysbbva';
    }
    else{
      return 'kiosk';
    }
  }
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return BlocProvider(
       create: (BuildContext context) =>FlightCubit(),
      child: WillPopScope(
        onWillPop: (){
          return Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>Home(Index: service.indexId=0)), (route) => false);
        },
        child: BlocConsumer<FlightCubit,FlightStates>(
          listener: (context,state){},
          builder: (context,state){
            return Scaffold(
            bottomNavigationBar:buildButton(text: 'Continue',ontap: (){
              navigateTo(context, GetTicket(
                airliens:widget.airliens,
                bookingResult: widget.bookingResult,
                travelers:widget.travelers,
                total:widget.bookingResult['booking']['total'],
              ));
            }),
            appBar: AppBar(
               leading: GestureDetector(
              onTap: (){
                return Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>Home(Index:service.indexId=0)), (route) => false);
              },
              child: Icon(Icons.arrow_back)),
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            'Create Ticket',
            style: TextStyle(color: Color(0xFFf37021), fontSize: 22),
          ),
          elevation: 0,
          ),
            body: SingleChildScrollView(
             physics: BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [

                  // Text('-------------------------------------------'),
                  //  Text('${widget.bookingResult['booking']['items']}'),
                  Padding(
                    padding: const EdgeInsets.only(left: 15,right: 15,top: 10),
                    child: Container(
                      height: 150,
                      decoration: BoxDecoration(
                        boxShadow: [
                              BoxShadow(
                                  blurRadius: 3,
                                  color: Colors.grey[350],
                                  offset: Offset(0, 0),
                                  spreadRadius: 2)
                            ],
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        border: Border.all(color:Color(0xFFf37021),width: 2)

                      ),
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Payment Code :',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w700,color:Color.fromARGB(255, 196, 196, 196))),
                          SizedBox(height: 10,),
                           widget.Checkout['payment_token']!=null?Text('${widget.Checkout['payment_token']}',style: TextStyle(fontSize: 25,fontWeight: FontWeight.w700,color:Color.fromARGB(255, 253, 108, 18))):Text('${widget.Checkout['booking_id']}',style: TextStyle(fontSize: 25,fontWeight: FontWeight.w700,color:Color.fromARGB(255, 253, 108, 18))),
                        ],
                      ),

                    ),
                  ),

                   Padding(
                      padding: const EdgeInsets.only(left: 15,right: 15,top: 15),
                      child: Text('Booking Ticket :',
                          style: TextStyle(
                              color: Color(0xFF38444a),
                              fontSize: 15,
                              fontWeight: FontWeight.w600)),
                    ),


                    Padding(
                         padding: const EdgeInsets.only(left: 15,right: 15,top: 10),
                          child: Container(
                               decoration: BoxDecoration(
                                       borderRadius: BorderRadius.circular(5),
                                       color: Colors.white,
                                       boxShadow: [
                                         BoxShadow(
                                             blurRadius: 4,
                                             color: Colors.grey[350],
                                             offset: Offset(0, 0),
                                             spreadRadius: 1)
                                       ],
                                     ),
                             child: Column(
                               children: [
                             ...widget.bookingResult['booking']['items'].map((item) {
                               return Stack(
                             children: [
                               ...item['options'].map((option){


                                    // int weight = item['travelers'][0]['details']!=null? item['travelers'][0]['details'][0]['segments_details'][0]['includedCheckedBags']['weight']:null;
                                   // String weightUnit =item['travelers'][0]['details']!=null? item['travelers'][0]['details'][0]['segments_details'][0]['includedCheckedBags']['weightUnit']:null;
                                   // print(item['travelers']);
                                   // int includedCheckedBags = item['travelers'][0]['details']!=null?item['travelers'][0]['details'][0]['segments_details'][0]['includedCheckedBags']['quantity']:0;

                                   final arrivalDate = option['segments'][option['segments'].length - 1]['arrivalDateTime'];
                                 final departureAirport = option['segments'][0]['departureAirport'];
                                 final datedeparture = option['segments'][0]['departureDateTime'];
                                 final arrivalAirport = option['segments'][option['segments'].length - 1]['arrivalAirport'];
                                 final flightNumber = option['segments'][0]['flightNumber'];
                                 final arrivalAirportTerminal = option['segments'][option['segments'].length - 1]['arrivalAirportTerminal'];
                                 final departureAirportTerminal = option['segments'][0]['departureAirportTerminal'];
                                  final logo = option['segments'][0]['marketingAirline'];
                                 final cabin = option['segments'][0]['cabin'];
                                 int stops = option['segments'].length - 1;
                                 var timedearival = DateTime.parse(arrivalDate);
                                 var Dateearival = DateTime.parse(arrivalDate);
                                 final arrivalDateTime = DateFormat('HH:mm').format(timedearival);
                                 final DatedaArival = DateFormat('yyyy-MM-dd').format(Dateearival);
                                 var dateedatedeparture = DateTime.parse(datedeparture);
                                  final datedepart = DateFormat('HH:mm').format(dateedatedeparture);
                                 final Datedateedatedeparture = DateFormat('yyyy-MM-dd').format(dateedatedeparture);


                                       return buildticketCard(
                                         arrivalDateTime: arrivalDateTime,
                                         datedeparture: Datedateedatedeparture,
                                         arrivalAirport: arrivalAirport,
                                         departureAirport: departureAirport,
                                         departureDateTime:datedepart,
                                         duration: option['duration'],
                                         flightNumber: flightNumber,
                                         DateArival: DatedaArival,
                                         arrivalAirportTerminal:arrivalAirportTerminal,
                                         departureAirportTerminal:departureAirportTerminal,
                                         stops:stops,
                                         logo:logo,
                                         cabin:cabin,
                                         bagageCount:0,
                                         weight:null,
                                         weightUnit: null,
                                         pnr:item['pnr'],
                                         operaitedby:airline(widget.airliens, logo),
                                       );
                                       }),
                               Container(
                                 decoration: BoxDecoration(
                                     color:changeColor(item['providerType']),
                                     borderRadius: BorderRadius.only(
                                       bottomRight: Radius.circular(0),
                                       bottomLeft: Radius.circular(0),
                                       topLeft: Radius.circular(5),
                                       topRight: Radius.circular(0),
                                     )
                                 ),
                                 height:80,
                                 width:2,
                               ),
                             ],
                               );
                             }),
                                 SizedBox(height: 10,),

                               ],
                             ),
                             ),
                        ),

                     Padding(
                      padding: const EdgeInsets.only(left: 15,right: 15,top: 10),
                      child: Text('CUSTOMER INFO :',
                          style: TextStyle(
                              color: Color(0xFF38444a),
                              fontSize: 15,
                              fontWeight: FontWeight.w600)),
                    ),


                    Padding(
                      padding: const EdgeInsets.only(left: 15,right: 15,top: 10),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 4,
                                color: Colors.grey[350],
                                offset: Offset(0, 0),
                                spreadRadius: 1)
                          ],
                        ),
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: buildPriceCart(text: 'FirstName',subtext:"${widget.bookingResult['customer']['user']['given_name']}"),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: buildPriceCart(text: 'LastName',subtext:"${widget.bookingResult['customer']['user']['surname']}"),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: buildPriceCart(text: 'Email',subtext:"${widget.bookingResult['customer']['user']['email']}"),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: buildPriceCart(text: 'Telephone',subtext:"${widget.bookingResult['customer']['user']['phone_number']}"),
                            ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    Padding(
                       padding: const EdgeInsets.only(left: 15,right: 15,top: 10),
                        child: Text('Price Details:',
                         style: TextStyle(
                            fontSize: 17,
                             color: Color.fromARGB(255, 114, 114, 114),
                             fontWeight: FontWeight.w600)),
                            ),
                             SizedBox(
                              height: 10,
                            ),
                            Padding(
                               padding: const EdgeInsets.only(left: 15,right: 15,top: 0),
                              child: buildCartTotalPrice(
                                  Totalprice:widget.bookingResult['booking']['total'].toStringAsFixed(2),
                                  adt: widget.adt,
                                  adtTaxes:widget.adtTaxes,
                                  adtprice: widget.adtprice,
                                  adultFee:widget.adultFee,
                                  chd: widget.chd,
                                  chdTaxes:widget.chd!=0?widget.chdTaxes:0 ,
                                  chdprice:widget.chd!=0?widget.chdprice:0,
                                  childernFee:widget.childernFee,
                                  inf: widget.inf,
                                  infTaxes:widget.infTaxes,
                                  infansFee: widget.infansFee,
                                  infprice:widget.infprice,
                                  Adt_markup: widget.Adt_markup,
                                  Chd_markup: widget.Chd_markup,
                                  Inf_markup: widget.Inf_markup,
                                  AdtService_Fee_Cedido: widget.AdtService_Fee_Cedido,
                                  ChdService_Fee_Cedido: widget.ChdService_Fee_Cedido,
                                  InfService_Fee_Cedido: widget.InfService_Fee_Cedido,
                                  AdtService_Fee: widget.AdtService_Fee,
                                  ChdService_Fee: widget.ChdService_Fee,
                                  InfService_Fee: widget.InfService_Fee,
                                ),
                            ),
                  //

                            Padding(
                    padding: EdgeInsets.only(left: 15,right: 15,top: 15),
                    child: Container(
                      height: 300,
                      width: double.infinity,
                      decoration: BoxDecoration(
                         boxShadow: [
                            BoxShadow(
                                blurRadius: 4,
                                color: Colors.grey[350],
                                offset: Offset(0, 0),
                                spreadRadius: 1)
                          ],
                        borderRadius: BorderRadius.circular(5),
                         color: Colors.white,
                         ),
                        child: Column(
                          children: [
                            SizedBox(height: 10,),
                            Text('How to pay ?',style: TextStyle(fontSize: 27,color: appColor,),),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Column(
                              children: [
                                Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                Container(
                                  height: 50,
                                  width: 50,
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(25),color: appColor),
                                     child: Image.asset('assets/travel-agency.png',),
                                  ),
                                  SizedBox(width: 20,),
                                  Expanded(child: Container(
                                    child: RichText(
                                      text:TextSpan(
                                        style: TextStyle(color: Colors.black),
                                      children: [
                                        TextSpan(
                                          text: '1- Go to one of the '
                                        ),
                                         TextSpan(
                                          text: '${PaymentMethods(widget.payment_method)} ',
                                          style: TextStyle(
                                            color: appColor
                                          )
                                        ),
                                          TextSpan(
                                          text: 'bills ',
                                           style: TextStyle(
                                            color: appColor
                                          )
                                        ),
                                          TextSpan(
                                          text: 'or ',
                                        ),
                                         TextSpan(
                                          text: 'cash guarantee ',
                                           style: TextStyle(
                                            color: appColor
                                          )
                                        ),

                                         TextSpan(
                                          text: 'with the payment code above.'
                                        ),
                                      // Text('1- Go to one of the cash plus agencies, bills or cash guarantee with the payment code above.'),

                                  ]
                                  )
                                  )
                                  )
                                  )
                                ],
                              ),
                            ),
                             SizedBox(height: 20,),
                             Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                Container(
                                  height: 50,
                                  width: 50,
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(25),color: appColor),
                                    child: Image.asset('assets/payment-method.png'),
                                  ),
                                 SizedBox(width: 20,),
                                  Expanded(child: Container(child:RichText(
                                      text:TextSpan(
                                        style: TextStyle(color: Colors.black),
                                      children: [
                                        TextSpan(
                                          text: '2- Show the  '
                                        ),
                                         TextSpan(
                                          text: 'payment code ',
                                          style: TextStyle(
                                            color: appColor
                                          )
                                        ),
                                          TextSpan(
                                          text: 'for ',

                                        ),
                                          TextSpan(
                                          text: 'the cash plus agent, ',

                                        ),
                                          TextSpan(
                                          text: ' bills ',
                                           style: TextStyle(
                                            color: appColor
                                          )
                                        ),
                                         TextSpan(
                                          text: 'or ',
                                        ),
                                         TextSpan(
                                          text: 'cash guarantee.',
                                           style: TextStyle(
                                            color: appColor
                                          )
                                        ),
                                      // Text('1- Go to one of the cash plus agencies, bills or cash guarantee with the payment code above.'),

                                  ]
                                  )
                                  )
                                  ))
                                  //  Text('2- Show the payment code for the cash plus agent, bills or cash guarantee.'),
                                ],
                              ),
                            ),
                             SizedBox(height: 20,),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(25),color: appColor),
                                   child: Image.asset('assets/banking.png',),
                                  ),
                                  SizedBox(width: 20,),
                                  Expanded(child: Container(child:RichText(
                                      text:TextSpan(
                                        style: TextStyle(color: Colors.black),
                                      children: [
                                        TextSpan(
                                          text: '3- After payment, you will receive the final ticket  '
                                        ),
                                         TextSpan(
                                          text: 'via ',

                                        ),
                                          TextSpan(
                                          text: 'SMS ',
                                           style: TextStyle(
                                            color: appColor
                                          )
                                        ),
                                          TextSpan(
                                          text: 'or ',

                                        ),
                                          TextSpan(
                                          text: ' e-mail ',
                                           style: TextStyle(
                                            color: appColor
                                          )
                                        ),
                                         TextSpan(
                                          text: 'after payment. ',
                                        ),



                                  ]
                                  )
                                  ))),

                                ],
                              ),
                            ),
                              ],
                            ),
                          )


                          ],
                        ),
                    ),
                  ),

                  
                  SizedBox(height: 20,),
                ],
              ),
            )
          );

          },
        ),
      ),
    );
  }

}
  // Row(
  //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                       children: [
  //                         Text('Total:',
  //                             style: TextStyle(
  //                                 fontSize: 20,
  //                                 color: Color.fromARGB(255, 37, 33, 32),
  //                                 fontWeight: FontWeight.w600)),
  //                         Text('1594 MAD MAD',
  //                             style: TextStyle(
  //                                 fontSize: 20,
  //                                 color: Color.fromARGB(255, 37, 33, 32),
  //                                 fontWeight: FontWeight.w600))
  //                       ],
  //                     ),
  //                     SizedBox(
  //                       height: 5,
  //                     ),
  //                     Text('Including taxes and fees',
  //                         style: TextStyle(
  //                             fontSize: 12,
  //                             color: Color.fromARGB(255, 199, 198, 198),
  //                             fontWeight: FontWeight.w600)),
  //                     SizedBox(
  //                       height: 10,
  //                     ),
  //                     Container(
  //                       height: 1,
  //                       color: Colors.grey[200],
  //                       width: double.infinity,
  //                     ),
  //                     SizedBox(
  //                       height: 10,
  //                     ),
  //                     Row(
  //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                       children: [
  //                         Text('Base Price',
  //                             style: TextStyle(
  //                                 fontSize: 15,
  //                                 color: Color.fromARGB(234, 48, 43, 41),
  //                                 fontWeight: FontWeight.w600)),
  //                         Text('100 MAD',
  //                             style: TextStyle(
  //                                 fontSize: 15,
  //                                 color: Color.fromARGB(234, 48, 43, 41),
  //                                 fontWeight: FontWeight.w600))
  //                       ],
  //                     ),
  //                     SizedBox(
  //                       height: 10,
  //                     ),
  //                     Row(
  //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                       children: [
  //                         Text('Taxes and fees',
  //                             style: TextStyle(
  //                                 fontSize: 15,
  //                                 color: Color.fromARGB(234, 48, 43, 41),
  //                                 fontWeight: FontWeight.w600)),
  //                         Text('524 MAD',
  //                             style: TextStyle(
  //                                 fontSize: 15,
  //                                 color: Color.fromARGB(234, 48, 43, 41),
  //                                 fontWeight: FontWeight.w600))
  //                       ],
  //                     ),