import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:sahariano_travel/Flight_app/cubit_flight/cubit.dart';
import 'package:sahariano_travel/Flight_app/cubit_flight/states.dart';
import 'package:sahariano_travel/Flight_app/pages/paymentCash.dart';
import 'package:sahariano_travel/Flight_app/requestSafer.dart';
import 'package:sahariano_travel/shared/components/components.dart';
import 'package:sahariano_travel/shared/components/constants.dart';

import '../../shared/network/remote/local/cache_helper.dart';
final requestSafer = new RequestSafer();

class ConfirmedPage extends StatefulWidget {
 final List<dynamic> FlightOneWay;
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
final  Timer timer;

final  List travelers;
final  Map<String, dynamic> flights;
final  Map<String, dynamic> flightsrture;
final  Map<String, dynamic>  selectedBag;

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
final  total;
dynamic booking;
  Map<String, dynamic> bookingresult;
final List<dynamic> bagsSelected;
String sourceRequrment;
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



ConfirmedPage({ Key key,this.total,this.totalPrice, this.totalTaxe, this.flights, this.flightsrture, this.adt, this.chd, this.inf, this.adtprice, this.chdprice, this.infprice, this.travelers, this.bookingresult, this.MONNameController, this.MONlasController, this.monphoneController, this.emailController, this.statenameController, this.citynameController, this.postcodeController, this.MonaddressController, this.sequence_number, this.MonCountryCode, this.MoncountryCallingCode, this.FlightOneWay, this.adtTaxes, this.chdTaxes, this.infTaxes, this.adultFee, this.childernFee, this.infansFee, this. sourceRequrment,this.selectedBag, this.bagsSelected, this.timer, this.providerType, this.Adt_markup, this.Chd_markup, this.Inf_markup, this.AdtService_Fee_Cedido, this.ChdService_Fee_Cedido, this.InfService_Fee_Cedido, this.AdtService_Fee, this.ChdService_Fee, this.InfService_Fee}) : super(key: key);
  @override
  _ConfirmedPageState createState() => _ConfirmedPageState();
}

class _ConfirmedPageState extends State<ConfirmedPage> {
  var seatAvailabe = null;
  double price ;
  bool isloading = true;
   Map<String, dynamic> customer;
   Map<String, dynamic> flights;
    int adt;
  int chd;
  int inf;
  String token = Cachehelper.getData(key: "token");

  double totalTaxe;
  double adtprice;
  double chdprice;
  double infprice;

  double adtTaxes;
  double chdTaxes;
  double infTaxes;

  double adultFee;
  double childernFee;
  double infansFee;

  double TotalFees;
  var arrivalAirport;
  List param=[
    "type",
    "full name",
    "flight",
    "Aditional baggage"
    "Checked baggage",
  ];
  @override
  Widget build(BuildContext context) {
   
    return BlocProvider(
      create: (BuildContext context) =>FlightCubit(),
      child: BlocConsumer<FlightCubit,FlightStates>(
        listener: (context,state){
        if(state is bookingSuccessState){
          widget.booking = state.bookings;
          widget.bookingresult = state.bookingResult;
        }
         if (state is GetPaymentSucessfulState){
            return navigateTo(
                context,
                PaymentCash(
                  providerType: widget.providerType,
                  PaymentMethods:state.PaymentMethods,
                  reservation: state.reservation,
                  bookingResult:widget.bookingresult,
                  booking: widget.booking,
                  FlightOneWay:widget.FlightOneWay,
                  travlers:widget.travelers,
                  MONNameController: widget.MONNameController,
                  MONlasController:widget.MONlasController ,
                  MonCountryCode:widget.MonCountryCode ,
                  MonaddressController:widget.MonaddressController ,
                  MoncountryCallingCode:widget.MoncountryCallingCode ,
                  citynameController: widget.citynameController,
                  emailController: widget.emailController,
                  monphoneController:widget.monphoneController ,
                  postcodeController: widget.postcodeController,
                  sequence_number: widget.sequence_number,
                  statenameController:widget.statenameController,
                  sourceRequrment: widget.sourceRequrment,
                  customer:customer,
                  airlines:countryService.airlines,


                  adt:widget.adt,
                  chd:widget.chd,
                  inf:widget.inf,

                  adtTaxes: widget.adtTaxes,
                  chdTaxes:widget.adtTaxes,
                  infTaxes:widget.infTaxes,

                  adtprice:widget.adtprice ,
                  chdprice: widget.chdprice,
                  infprice: widget.infprice,

                  adultFee: widget.adultFee,
                  childernFee: widget.childernFee,
                  infansFee: widget.infansFee,

                  total:widget.total,
                  totalPrice: widget.totalPrice,
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
          
          var cubit = FlightCubit.get(context);
        return Scaffold(
        bottomNavigationBar:Padding(
              padding:const EdgeInsets.only(
                    left: 20, right: 20, top: 5, bottom: 5),
              child: GestureDetector(
                            onTap: () {
                              setState(() {
                                widget.timer.cancel();
                                isloading = false;
                              });
                             cubit.BookingSafer(
                                  widget.travelers,
                                  FirstNameController:widget.MONNameController,
                                  LastNameController:widget.MONlasController,
                                  EmailController:widget.emailController,
                                  CountryCode:widget.MonCountryCode,
                                  StateNameController:widget.statenameController,
                                  CityNameController:widget.citynameController,
                                  PostNameController:widget.postcodeController,
                                  AdressController:widget.MonaddressController,
                                  countryCallingCode:widget.MoncountryCallingCode,
                                  PhoneController:widget.monphoneController,
                                  sequencenumbers:widget.sequence_number,
                                );

                              },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 55,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Color(0xFFF28300)),
                                width: double.infinity,
                                child:Center(
                                    child:isloading?Text(
                                  'Confirm',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ):CircularProgressIndicator(color: Colors.white,)),
                              ),
                            ),
                          ),
            ),
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              centerTitle: true,
              title: Text('Confirm Information',style: TextStyle(color: Color(0xFFf37021), fontSize: 22),),
              leading: GestureDetector(
                onTap: (){
                  Navigator.of(context).pop();
                },
                child: Icon(Icons.arrow_back,color: Colors.black)),
            ),
        body: SingleChildScrollView(
          child: Padding(
           padding: const EdgeInsets.only(left: 10,right: 10,top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 4),
                              child: Text('Price Details:',
                                  style: TextStyle(
                                      fontSize: 17,
                                      color: Color.fromARGB(255, 114, 114, 114),
                                      fontWeight: FontWeight.w600)),
                            ),
                             SizedBox(
                              height: 10,
                            ),
                              buildCartTotalPrice(
                                Totalprice:widget.totalPrice,
                                adt: widget.adt,
                                adtTaxes:widget.adtTaxes,
                                adtprice:widget.adtprice,
                                adultFee:widget.adultFee,
                                chd:widget.chd,
                                chdTaxes:widget.chdTaxes,
                                chdprice:widget.chdprice,
                                childernFee:widget.chdTaxes,
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
                           SizedBox(
                              height: 10,
                            ),
                            Padding(
                            padding: const EdgeInsets.only(left: 5),
                              child: Text('Flight details :',
                                  style: TextStyle(
                                      fontSize: 17,
                                      color: Color.fromARGB(255, 114, 114, 114),
                                      fontWeight: FontWeight.w600)),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Column(
                              children: [Stack(
                              children: [
                                Container(
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
                                   children:[
                                     widget.flights['providerType']!='SHT'?
                                         Column(
                                           children: [
                                             ...countryService.getPriceResult['flights'].map((e){
                                               return Column(
                                                 children: [
                                                   ...e['options'].map((options) {
                                                     int weight = e['travelers'][0]['details']!=null?e['travelers'][0]['details'][0]['segments_details'][0]['includedCheckedBags']['weight']:null;
                                                     // String weightUnit =e['travelers'][0]['details']!=null? e['travelers'][0]['details'][0]['segmentsDetails'][0]['includedCheckedBags']['weightUnit']:null;
                                                     dynamic includedCheckedBags =e['travelers'][0]['details']!=null? e['travelers'][0]['details'][0]['segments_details'][0]['includedCheckedBags']!=null? e['travelers'][0]['details'][0]['segments_details'][0]['includedCheckedBags']['quantity']:0:0;
                                                     final arrivalDate = options['segments'][options['segments'].length - 1]['arrivalDateTime'];
                                                     final departureAirport = options['segments'][0]['departureAirport'];
                                                     final datedeparture = options['segments'][0]['departureDateTime'];
                                                     arrivalAirport = options['segments'][options['segments'].length - 1]['arrivalAirport'];
                                                     final flightNumber = options['segments'][0]['flightNumber'];
                                                     final arrivalAirportTerminal = options['segments'][options['segments'].length - 1]['arrivalAirportTerminal'];
                                                     final departureAirportTerminal = options['segments'][0]['departureAirportTerminal'];
                                                     final logo =options['segments'][0]['marketingAirline'];
                                                     final cabin = options['segments'][0]['cabin'];
                                                     int stops =options['segments'].length - 1;
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
                                                         duration: options['duration'],
                                                         flightNumber: flightNumber,
                                                         DateArival: DatedaArival,
                                                         arrivalAirportTerminal:arrivalAirportTerminal,
                                                         departureAirportTerminal:departureAirportTerminal,
                                                         stops:stops,
                                                         logo:logo,
                                                         cabin:cabin,
                                                         bagageCount:includedCheckedBags,
                                                         weight:weight,
                                                         weightUnit:null,
                                                         operaitedby:countryService.airline(countryService.airlines, logo)
                                                     );}),
                                                   SizedBox(height: 10,),
                                                 ],
                                               );
                                             }),
                                           ],
                                         ):Column(
                                           children: [
                                           ...widget.flights['options'].map((options) {
                                           int weight = widget.flights['travelers'][0]['details']!=null?widget.flights['travelers'][0]['details'][0]['segments_details'][0]['includedCheckedBags']['weight']:null;
                                           // String weightUnit =e['travelers'][0]['details']!=null? e['travelers'][0]['details'][0]['segmentsDetails'][0]['includedCheckedBags']['weightUnit']:null;
                                           dynamic includedCheckedBags =widget.flights['travelers'][0]['details']!=null? widget.flights['travelers'][0]['details'][0]['segments_details'][0]['includedCheckedBags']!=null? widget.flights['travelers'][0]['details'][0]['segments_details'][0]['includedCheckedBags']['quantity']:0:0;
                                           final arrivalDate = options['segments'][options['segments'].length - 1]['arrivalDateTime'];
                                           final departureAirport = options['segments'][0]['departureAirport'];
                                           final datedeparture = options['segments'][0]['departureDateTime'];
                                           arrivalAirport = options['segments'][options['segments'].length - 1]['arrivalAirport'];
                                           final flightNumber = options['segments'][0]['flightNumber'];
                                           final arrivalAirportTerminal = options['segments'][options['segments'].length - 1]['arrivalAirportTerminal'];
                                           final departureAirportTerminal = options['segments'][0]['departureAirportTerminal'];
                                           final logo =options['segments'][0]['marketingAirline'];
                                           final cabin = options['segments'][0]['cabin'];
                                           int stops =options['segments'].length - 1;
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
                                           duration: options['duration'],
                                           flightNumber: flightNumber,
                                           DateArival: DatedaArival,
                                           arrivalAirportTerminal:arrivalAirportTerminal,
                                           departureAirportTerminal:departureAirportTerminal,
                                           stops:stops,
                                           logo:logo,
                                           cabin:cabin,
                                           bagageCount:includedCheckedBags,
                                           weight:weight,
                                           weightUnit:null,
                                           operaitedby:countryService.airline(countryService.airlines, logo)
                                           );}),
                                           SizedBox(height: 10,),
                                           ],
                                           )
                                   ],
                                 ),
                                 ),
                           ],
                         )

                          // widget.FlightOneWay != null
                          //       ? Column(
                          //           children: [
                          //              Container(
                          //        decoration: BoxDecoration(
                          //                borderRadius: BorderRadius.circular(5),
                          //                color: Colors.white,
                          //                boxShadow: [
                          //                  BoxShadow(
                          //                      blurRadius: 4,
                          //                      color: Colors.grey[350],
                          //                      offset: Offset(0, 0),
                          //                      spreadRadius: 1)
                          //                ],
                          //              ),
                          //      child: Column(
                          //        children: [
                          //         ...widget.FlightOneWay.map((Flight) {
                          //           return Column(
                          //          children: [
                          //          ...Flight['options'].map((options) {
                          //          int weight = Flight['travelers'][0]['details'][0]['segments_details'][0]['includedCheckedBags']['weight'];
                          //           // String weightUnit = Flight['travelers'][0]['details'][0]['segments_details'][0]['includedCheckedBags']['weightUnit'];
                          //          dynamic includedCheckedBags =Flight['travelers'][0]['details'][0]['segments_details'][0]['includedCheckedBags']!=null? Flight['travelers'][0]['details'][0]['segments_details'][0]['includedCheckedBags']['quantity']:0;
                          //          final arrivalDate = options['segments'][options['segments'].length - 1]['arrivalDateTime'];
                          //          final departureAirport = options['segments'][0]['departureAirport'];
                          //          final datedeparture = options['segments'][0]['departureDateTime'];
                          //          final arrivalAirport = options['segments'][options['segments'].length - 1]['arrivalAirport'];
                          //          final flightNumber = options['segments'][0]['flightNumber'];
                          //          final arrivalAirportTerminal = options['segments'][options['segments'].length - 1]['arrivalAirportTerminal'];
                          //          final departureAirportTerminal = options['segments'][0]['departureAirportTerminal'];
                          //          final logo =Flight['options'][0]['segments'][0]['marketingAirline'];
                          //          final cabin = options['segments'][0]['cabin'];
                          //          int stops =options['segments'].length - 1;
                          //          var timedearival = DateTime.parse(arrivalDate);
                          //          var Dateearival = DateTime.parse(arrivalDate);
                          //          final arrivalDateTime = DateFormat('HH:mm').format(timedearival);
                          //          final DatedaArival = DateFormat('yyyy-MM-dd').format(Dateearival);
                          //          var dateedatedeparture = DateTime.parse(datedeparture);
                          //           final datedepart = DateFormat('HH:mm').format(dateedatedeparture);
                          //          final Datedateedatedeparture = DateFormat('yyyy-MM-dd').format(dateedatedeparture);
                          //                return buildticketCard(
                          //                  arrivalDateTime: arrivalDateTime,
                          //                  datedeparture: Datedateedatedeparture,
                          //                  arrivalAirport: arrivalAirport,
                          //                  departureAirport: departureAirport,
                          //                  departureDateTime:datedepart,
                          //                  duration: options['duration'],
                          //                  flightNumber: flightNumber,
                          //                  DateArival: DatedaArival,
                          //                  arrivalAirportTerminal:arrivalAirportTerminal,
                          //                  departureAirportTerminal:departureAirportTerminal,
                          //                  stops:stops,
                          //                  logo:logo,
                          //                  cabin:cabin,
                          //                  bagageCount:includedCheckedBags,
                          //                  weight:weight,
                          //                  weightUnit:'',
                          //                  operaitedby:countryService.airline(countryService.airlines, logo)
                          //                );}),
                          //
                          //          ],
                          //           );
                          //         })
                          //        ],
                          //      ),
                          //      ),
                          //           ],
                          //         )
                          //       : SizedBox(
                          //           height: 0,
                          //         ),
                        ],
                      ),
                            SizedBox(
                              height: 10,
                            ),
                            // Padding(
                            //    padding: const EdgeInsets.only(left: 5),
                            //   child: Text('Travelers Info :',
                            //       style: TextStyle(
                            //           fontSize: 17,
                            //           color: Color.fromARGB(255, 114, 114, 114),
                            //           fontWeight: FontWeight.w600)),
                            // ),
                            // SizedBox(
                            //   height: 10,
                            // ),
                            // Padding(
                            //   padding: const EdgeInsets.all(8.0),
                            //   child: Container(
                            //     decoration: BoxDecoration(
                            //       borderRadius: BorderRadius.circular(5),
                            //       color: Colors.white,
                            //       boxShadow: [
                            //         BoxShadow(
                            //             blurRadius: 4,
                            //             color: Colors.grey[350],
                            //             offset: Offset(0, 0),
                            //             spreadRadius: 1)
                            //       ],
                            //     ),
                            //     width: double.infinity,
                            //     child: Column(
                            //       children: [
                            //        Column(
                            //             children: [
                            //              ListView.separated(
                            //                 separatorBuilder: (context,index){
                            //                   return buildDivider();
                            //                 },
                            //                 physics: NeverScrollableScrollPhysics(),
                            //                   shrinkWrap: true,
                            //                   itemCount:widget.travelers.length,
                            //                   itemBuilder: (context, index) {
                            //                     return Padding(
                            //                       padding: const EdgeInsets.all(8.0),
                            //                       child: buildPassangerInfo(Passanger:widget.travelers[index]),
                            //                     );
                            //                   }),
                            //               SizedBox(
                            //                height: 10,
                            //               ),
                            //
                            //
                            //
                            //
                            //
                            //
                            //             ],
                            //           ),
                            //
                            //       ],
                            //     ),
                            //   ),
                            // ),
                            // SizedBox(height: 10,),
                            Padding(
                               padding: const EdgeInsets.only(left: 0),
                              child: Text('Travelers Info :',
                                  style: TextStyle(
                                      fontSize: 17,
                                      color: Color.fromARGB(255, 114, 114, 114),
                                      fontWeight: FontWeight.w600)),
                            ),
                //             DataTable(
                //       columnSpacing:5,
                //       columns: [
                //       DataColumn(label: Text('Type',style: TextStyle(fontSize: 10),)),
                //       DataColumn(label: Text('FullName',style: TextStyle(fontSize: 10))),
                //       DataColumn(label: Text('Flights',style: TextStyle(fontSize: 10))),
                //       DataColumn(label: Text('Aditional bag',style: TextStyle(fontSize: 10),)),
                //       DataColumn(label: Text('Checked bag',style: TextStyle(fontSize: 10),)),
                //       DataColumn(label: Text('Seat',style: TextStyle(fontSize: 10),)),
                //     ],
                //     rows: [
                //       ...widget.travelers.asMap().entries.map((traveler){
                //         return DataRow(
                //             cells:[
                //               DataCell(
                //                   Text('${traveler.value['PassengerTypeCode']}',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 10),)),
                //               DataCell(
                //                   Column(
                //                 crossAxisAlignment: CrossAxisAlignment.start,
                //                 mainAxisAlignment: MainAxisAlignment.center,
                //                 children: [
                //                   Text('${traveler.value['FirstName']} ${traveler.value['LastName']}',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 10),),
                //                 ],
                //               )),
                //               DataCell(
                //                   Column(
                //                     crossAxisAlignment: CrossAxisAlignment.start,
                //                     mainAxisAlignment: MainAxisAlignment.center,
                //                     children: [
                //                       ...countryService.getPriceResult['flights'].map((e){
                //                         return Column(
                //                           children:[
                //                             ...e['options'].map((option){
                //                               final departureAirport = option['segments'][0]['departureAirport'];
                //                               final arrivalAirport = option['segments'][option['segments'].length - 1]['arrivalAirport'];
                //                               return Text('${departureAirport}-${arrivalAirport}',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 10),);
                //                             })
                //                           ],
                //                         );
                //                       }),
                //
                //
                //
                //                     ],
                //                   )
                //               ),
                //               DataCell(
                //                   Column(
                //                     crossAxisAlignment: CrossAxisAlignment.start,
                //                     mainAxisAlignment: MainAxisAlignment.center,
                //                     children: [
                //                      ...countryService.getPriceResult['flights'].map((e){
                //                        return Column(
                //                          children: [
                //                           ...e['travelers'][traveler.key]['details'].map((detail){
                //                             return Row(
                //                               crossAxisAlignment: CrossAxisAlignment.center,
                //                               mainAxisAlignment: MainAxisAlignment.center,
                //                               children: [
                //                                Icon(FontAwesomeIcons.suitcase,size: 12, color: appColor),
                //                                SizedBox(width: 5,),
                //                                Text('${detail['segments_details'][0]['additionalServices']['chargeableCheckedBags']['quantity']!=null?detail['segments_details'][0]['additionalServices']['chargeableCheckedBags']['quantity']:0}',style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold,color: appColor))
                //                               ],
                //                             );
                //                           })
                //                          ],
                //                        );
                //                      })
                //                     ],
                //                   )
                //               ),
                //               DataCell(
                //                   Column(
                //                     crossAxisAlignment: CrossAxisAlignment.start,
                //                     mainAxisAlignment: MainAxisAlignment.center,
                //                     children: [
                //                       ...countryService.getPriceResult['flights'].map((e){
                //                         return Column(
                //                           children: [
                //                             ...e['travelers'][traveler.key]['details'].map((detail){
                //                               return Row(
                //                                 crossAxisAlignment: CrossAxisAlignment.center,
                //                                 mainAxisAlignment: MainAxisAlignment.center,
                //                                 children: [
                //                                   Icon(FontAwesomeIcons.suitcase,size: 12, color: appColor),
                //                                   SizedBox(width: 5,),
                //                                   Text('${detail['segments_details'][0]['includedCheckedBags']['quantity']!=null?detail['segments_details'][0]['includedCheckedBags']['quantity']:0}',style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold,color: appColor))
                //                                 ],
                //                               );
                //                             })
                //                           ],
                //                         );
                //                       })
                //                     ],
                //                   )),
                //                DataCell(
                //                   Column(
                //                     crossAxisAlignment: CrossAxisAlignment.start,
                //                     mainAxisAlignment: MainAxisAlignment.center,
                //                     children: [
                //                       ...countryService.getPriceResult['flights'].map((e){
                //                         return Column(
                //                           children: [
                //                             ...e['travelers'][traveler.key]['details'].map((detail){
                //                               print(detail['segments_details'][0]['additionalServices']['chargeableSeatNumber']);
                //                               return Row(
                //                                 crossAxisAlignment: CrossAxisAlignment.center,
                //                                 mainAxisAlignment: MainAxisAlignment.center,
                //                                 children: [
                //                                   Icon(Icons.chair_sharp,size: 12, color: appColor),
                //                                   SizedBox(width: 5,),
                //                                   Text('${detail['segments_details'][0]['additionalServices']['chargeableSeatNumber']}',style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold,color: appColor))
                //                                 ],
                //                               );
                //                             })
                //                           ],
                //                         );
                //                       })
                //                     ],
                //                   )
                //               ),
                //
                //             ]);
                //          })
                //     ]
                // ),

                ...widget.travelers.asMap().entries.map((traveler){
                  return Padding(
                    padding: const EdgeInsets.only(left: 5,right: 5,top: 10,bottom: 10),
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
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          mainAxisAlignment:MainAxisAlignment.start,
                          crossAxisAlignment:CrossAxisAlignment.start,
                          children: [
                            Row(children: [
                              Text('${traveler.value['FirstName']} ${traveler.value['LastName']}',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 14),),
                              SizedBox(width: 5),
                              Text('${traveler.value['PassengerTypeCode']}',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 10),)
                            ]),
                            SizedBox(height: 10,),
                            Row(
                              mainAxisAlignment:MainAxisAlignment.start,
                              crossAxisAlignment:CrossAxisAlignment.start,
                              children: [
                                Text('Flights : ',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 14)),
                                SizedBox(width: 5),
                                Padding(
                                  padding: const EdgeInsets.only(top: 0),
                                  child: Column(
                                    mainAxisAlignment:MainAxisAlignment.start,
                                    crossAxisAlignment:CrossAxisAlignment.start,
                                    children: [
                                  widget.flights['providerType']!='SHT'?Column(
                                    children: [
                                      ...countryService.getPriceResult['flights'].map((e){
                                        return Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children:[
                                            ...e['options'].map((option){
                                              final departureAirport = option['segments'][0]['departureAirport'];
                                              final arrivalAirport = option['segments'][option['segments'].length - 1]['arrivalAirport'];
                                              return Text('${departureAirport}-${arrivalAirport}',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 10),);
                                            })
                                          ],
                                        );
                                      }),
                                    ],
                                  ):Column(
                                    children: [
                                      Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children:[
                                          ...widget.flights['options'].map((option){
                                            final departureAirport = option['segments'][0]['departureAirport'];
                                            final arrivalAirport = option['segments'][option['segments'].length - 1]['arrivalAirport'];
                                            return Text('${departureAirport}-${arrivalAirport}',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 10),);
                                          })
                                        ],
                                      )
                                    ],
                                  )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10,),
                            Row(
                              mainAxisAlignment:MainAxisAlignment.start,
                              crossAxisAlignment:CrossAxisAlignment.start,
                              children: [
                                Text('Baggages : ',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 14),),
                                SizedBox(width: 5),
                                widget.flights['providerType']!='SHT'? Column(
                            children: [
                                ...countryService.getPriceResult['flights'].map((e){
                                 return Column(
                                  children: [
                                    ...e['travelers'][traveler.key]['details'].map((detail){
                                      return Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(FontAwesomeIcons.suitcase,size: 12, color: appColor),
                                          SizedBox(width: 5,),
                                          Text('${detail['segments_details'][0]['includedCheckedBags']['quantity']!=null?detail['segments_details'][0]['includedCheckedBags']['quantity']:0}',style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold,color: appColor))
                                        ],
                                      );
                                    })
                                  ],
                                );
                              })
                            ],
                          ):Column(
                                  children: [
                                    ...widget.flights['travelers'][traveler.key]['details'].map((detail){
                                      return Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(FontAwesomeIcons.suitcase,size: 12, color: appColor),
                                          SizedBox(width: 5,),
                                          Text('${detail['segments_details'][0]['includedCheckedBags']['quantity']!=null?detail['segments_details'][0]['includedCheckedBags']['quantity']:0}',style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold,color: appColor))
                                        ],
                                      );
                                    })
                                  ],
                                )

                              ],
                            ),
                            SizedBox(height: 10,),
                            Row(
                              mainAxisAlignment:MainAxisAlignment.start,
                              crossAxisAlignment:CrossAxisAlignment.start,
                              children: [
                                Text('Seats : ',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 14),),
                                SizedBox(width: 5),
                                widget.flights['providerType']!='SHT'? Column(
                            children: [
                                    ...countryService.getPriceResult['flights'].map((e){
                                return Column(
                                  children: [
                                    ...e['travelers'][traveler.key]['details'].map((detail){
                                      print(detail['segments_details'][0]['additionalServices']['chargeableSeatNumber']);
                                      return detail['segments_details'][0]['additionalServices']['chargeableSeatNumber']!=null?Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.chair_sharp,size: 12, color: appColor),
                                          SizedBox(width: 5,),
                                          Text('${detail['segments_details'][0]['additionalServices']['chargeableSeatNumber']}',style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold,color: appColor))
                                        ],
                                      ):SizedBox(height:0);
                                    })
                                  ],
                                );
                              })
                            ],
                          ):Column(
                                  children: [
                                    ...widget.flights['travelers'][traveler.key]['details'].map((detail){
                                     setState(() {
                                       seatAvailabe =detail['segments_details'][0]['additionalServices']['chargeableSeatNumber'];
                                     });

                                      return detail['segments_details'][0]['additionalServices']['chargeableSeatNumber']!=null?Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.chair_sharp,size: 12, color: appColor),
                                          SizedBox(width: 5,),
                                          Text('${detail['segments_details'][0]['additionalServices']['chargeableSeatNumber']}',style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold,color: appColor))
                                        ],
                                      ):SizedBox(height:0);
                                    })
                                  ],
                                )

                              ],
                            ),

                          ],
                        ),
                      ),
                    ),
                  );
                }),





                SizedBox(height: 20,)
                         

              ],
            ),
          ),
        ),
      );
        }, )
    );
  }
}