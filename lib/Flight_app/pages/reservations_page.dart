import 'dart:async';
import 'package:country_list_pick/country_list_pick.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sahariano_travel/Flight_app/cubit_flight/cubit.dart';
import 'package:sahariano_travel/Flight_app/cubit_flight/states.dart';
import 'package:sahariano_travel/Flight_app/pages/confirem_page.dart';
import 'package:sahariano_travel/shared/components/components.dart';
import 'package:sahariano_travel/shared/components/constants.dart';
import 'package:sahariano_travel/shared/network/remote/local/cache_helper.dart';
import 'package:sahariano_travel/voles.dart';

class ReservationPage extends StatefulWidget {
  final totalPrice;
  static List trying = [];
  final double totalTaxe;
  final sequence_number;
  final List<dynamic> FlightOneWay;
  final Map<String, dynamic> flights;
  final Map<String, dynamic> flightsrture;
  final Map<String, dynamic> parm;
  final int currentIndex;
  final String operitedby;
   final String providerType;
  final Timer timer;
  const ReservationPage(
      {Key key,
      this.providerType,
      this.totalPrice,
      this.totalTaxe,
      this.sequence_number,
      this.FlightOneWay,
      this.flights,
      this.flightsrture,
      this.parm,
      this.currentIndex,
      this.operitedby, this.timer})
      : super(key: key);

  @override
  _ReservationPageState createState() => _ReservationPageState();
}

class _ReservationPageState extends State<ReservationPage> {
  Map<String, dynamic> flightResult;
  Map<String, dynamic> selectedseat;
  Map<String, dynamic> baggage;
  var fromkey = GlobalKey<FormState>();
  List<dynamic> filterdate = [];
  List<dynamic> flights = [];
  var operaitedby;
  // airline(List airline, String logo) {
  //   airline.forEach((value) {
  //     if (value['iata_code'] == logo) {
  //       operaitedby = value['name'];
  //     }
  //   });
  //   return operaitedby;
  // }
  // contact data------------------------------------
  var MONNameController = TextEditingController();
  var MONlasController = TextEditingController();
  var monphoneController = TextEditingController();
  var emailController = TextEditingController();
  var statenameController = TextEditingController();
  var citynameController = TextEditingController();
  var postcodeController = TextEditingController();
  var MonaddressController = TextEditingController();
  String token = Cachehelper.getData(key: "token");
  String MonCountryCode;
  String MoncountryCallingCode;
  List<dynamic> flightRetun = null;
  List<dynamic> flightdepart = null;
  List<dynamic> flightAR = [];
  String tokenflight = Cachehelper.getData(key: "token_flight");
  String setcookie = Cachehelper.getData(key: "set-cookie");
  bool isloading;
  dynamic totalMarkup = 0.0;
  dynamic totalservice_fee_cedido = 0.0;
  dynamic totalservice_fee = 0.0;
  
  dynamic getServiceFeebytravel(String travelerType,){
    
    totalservice_fee = 0.0;
    
    if(flightResult!=null){
      flightResult['travelers'].forEach((value) {
        if (value['type'] == travelerType) {
          totalservice_fee = totalservice_fee + value['price']['service_fee'];
        }
      });
    }else {
      widget.flights['travelers'].forEach((value) {
        if (value['type'] == travelerType) {
          totalservice_fee = totalservice_fee + value['price']['service_fee'];
        }
      });
    }
    return totalservice_fee;
  }
  dynamic getMarkupbytravel(String travelerType,){
    totalMarkup = 0.0;
    if(flightResult!=null){
      flightResult['travelers'].forEach((value) {
        if (value['type'] == travelerType) {
          totalMarkup = totalMarkup + value['price']['markup'];
        }
      });

    }else{
      widget.flights['travelers'].forEach((value) {
        if (value['type'] == travelerType) {
          totalMarkup = totalMarkup + value['price']['markup'];
        }
      });}
    return totalMarkup;
  }

  dynamic getTotalService_fee_sedidobytravel(String travelerType){
    if(flightResult!=null){
      totalservice_fee_cedido = 0.0;
      flightResult['travelers'].forEach((value) {
        if (value['type'] == travelerType) {
          totalservice_fee_cedido = totalservice_fee_cedido + value['price']['service_fee_cedido'];
        }
      });
    }else{
      totalservice_fee_cedido = 0.0;
      widget.flights['travelers'].forEach((value) {
        if (value['type'] == travelerType) {
          totalservice_fee_cedido = totalservice_fee_cedido + value['price']['service_fee_cedido'];
        }
      });
    }

    return totalservice_fee_cedido;
  }

  // contact data------------------------------------
  List travelersBooking = [];

  List Travelers = [];

  void initState() {
    ReservationPage.trying = [];
    
    flightsht= [];
    flightsht.add(widget.flights);
    // countryService.bags =[];
    getTarvelByCount();
    create();
    super.initState();
  }
 var travelerTypes = [];

  getTarvelByCount() {
    print(countryService.params['qte_infants']);

    var travelerTypes = [];

    dynamic travelerIndex = 1;

    for (var index = 0; index < countryService.params['qte_adults'];index++) {
      travelerTypes.add({
        "TravelerRefNumber": "${travelerIndex}",
        "PassengerTypeCode": "ADT"
      });
      travelerIndex += 1;
    }

    for (var index = 0; index < countryService.params['qte_children']; index++) {
      travelerTypes.add({
        "TravelerRefNumber": "${travelerIndex}",
        "PassengerTypeCode": "CHD"
      });
      travelerIndex += 1;
    }

    for (var index = 0 ; index < countryService.params['qte_infants']; index++){
      travelerTypes.add({
        "TravelerRefNumber": "${travelerIndex}",
        "PassengerTypeCode": "INF"
      });
      travelerIndex += 1;
    }

    return travelerTypes;
  }


  List travelerReference = [];
  var arrivalAirport;
  var departureAirport;
  var flightNumber;
//   TravelerReference(){
//     travelerReference =[]; 
//   flightsht.forEach((value) { 
//      travelerReference.add(value['travelers'][0]['travelerReference']);
//    });
//    return travelerReference;
//  }
  String selectseat;
  create() {
    Travelers = [];
    getTarvelByCount().forEach((element) {
      print(element);
      Travelers.add({
            // "referenceId":TravelerReference(),
            "TravelerRefNumber":"${element['TravelerRefNumber']}",
            "BirthDate": "",
            "PassengerTypeCode":"${element['PassengerTypeCode']}",
            "Gender": "",
            "NamePrefix": "",
            "FirstName": "",
            "LastName": "",
            "Contact": {
                "Email": "",
                "Phones": [
                    {
                        "deviceType": "MOBILE",
                        "countryCallingCode": 212,
                        "number": ""
                    }
                ]
            },
            "Documents": [
                {
                    "documentType": "",
                    "number": "",
                    "expiryDate": "",
                    "birthPlace": "",
                    "birthCountry": "",
                    "issuanceLocation": "AR",
                    "issuanceDate": "2021-06-17",
                    "issuanceCountry": "AR",
                    "validityCountry": "MA",
                    "nationality": "MA",
                    "holder": true
                }
            ]
        });
       
    });
   
  }
 
  int adt;
  int chd;
  int inf;

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

  dynamic TotalPrice ;
  List<dynamic> sequence_number;
  Map<String, dynamic> flightsrture;
  Map<String, dynamic> Flights;
  List<dynamic> flightOneWay;
  String sourceRequrment;
  Map<String, dynamic> selectedBag;
  List<dynamic> bagsSelected ;
  List flightsht=[];
 int Length = 26;
 int Width = 7;
 List chairs = [];
  String result2 = "+212";
  @override
  Widget build(BuildContext context) {
    // MONNameController.text = Cachehelper.getData(key: "firstName");
    // MONlasController.text = Cachehelper.getData(key: "lastName");
    // monphoneController.text = Cachehelper.getData(key: "phone");

    print(token);

    return BlocProvider(
      create: (BuildContext context) =>
          FlightCubit()..getServices(sequencenumbers:widget.sequence_number,providerType:widget.providerType,flight:flightsht),
      child: BlocConsumer<FlightCubit, FlightStates>(
        listener: (context, state) {
           if (state is getPriceSuccessState) {
            selectedBag = state.getPriceResult;
            bagsSelected = state.bagsSelected;
            adt = state.adult;
            chd = state.childern;
            inf = state.infans;
            adtprice = state.adultprice;
            chdprice = state.childernprice;
            infprice = state.infansprice;
            adultFee = state.adultFee;
            childernFee = state.childernFee;
            infansFee = state.infansFee;
            TotalFees = state.TotalFees;
            navigateTo(context,ConfirmedPage(
                            timer:widget.timer,
                            bagsSelected:bagsSelected,
                            total:TotalPrice,
                            selectedBag: selectedBag,
                            adt: adt,
                            chd: chd,
                            inf: inf,
                            adtprice: adtprice,
                            chdprice: chdprice,
                            infprice: infprice,
                            flights:  widget.flights,
                            totalTaxe: adtTaxes + chdTaxes + infTaxes,
                            travelers: Travelers,
                            FlightOneWay: widget.FlightOneWay,
                            adtTaxes: adtTaxes,
                            chdTaxes: chdTaxes,
                            infTaxes: infTaxes,
                            adultFee: adultFee,
                            childernFee: childernFee,
                            infansFee: infansFee,
                            sourceRequrment: sourceRequrment,
                            MONNameController: MONNameController.text,
                            MONlasController: MONlasController.text,
                            MonCountryCode: MonCountryCode,
                            MonaddressController: MonaddressController.text,
                            MoncountryCallingCode: MoncountryCallingCode,
                            citynameController: citynameController.text,
                            emailController: emailController.text,
                            monphoneController: monphoneController.text,
                            postcodeController: postcodeController.text,
                            sequence_number: widget.sequence_number,
                            statenameController: statenameController.text,
                            totalPrice:widget.totalPrice,

                            Adt_markup:getMarkupbytravel('ADT'),
                            Chd_markup:getMarkupbytravel('CHD'),
                            Inf_markup:getMarkupbytravel('INF'),

                            AdtService_Fee_Cedido:getTotalService_fee_sedidobytravel('ADT'),
                            ChdService_Fee_Cedido:getTotalService_fee_sedidobytravel('CHD'),
                            InfService_Fee_Cedido:getTotalService_fee_sedidobytravel('INF'),

                            AdtService_Fee:getServiceFeebytravel('ADT'),
                            ChdService_Fee:getServiceFeebytravel('CHD'),
                            InfService_Fee:getServiceFeebytravel('INF'),

            ));
          }
          if (state is GetServicesSucessfulState){
            flights = state.flights;
            Flights = state.flight;
            adt = state.adult;
            chd = state.childern;
            inf = state.infans;
            adtprice = state.adultprice;
            chdprice = state.childernprice;
            infprice = state.infansprice;
            adultFee = state.adultFee;
            childernFee = state.childernFee;
            infansFee = state.infansFee;
            Flights = state.flight;
            // flightOneWay = state.FlightOneWay;
            TotalFees = state.TotalFees;
            TotalPrice = state.TotalPrice;
            adtTaxes = state.adultTaxes;
            chdTaxes = state.childernTaxes;
            infTaxes = state.infansTaxes;
            baggage = state.baggage;
            flightResult = state.flightResult;
            selectedBag = state.getPriceResult;
            bagsSelected = state.bagsSelected;
            // sourceRequrment = state.sourceRequrment;
          }
           
        },
        builder: (context, state) {
          var cubit = FlightCubit.get(context);
          return Scaffold(
            bottomNavigationBar: Padding(
              padding:const EdgeInsets.only(
                    left: 25, right: 25, top: 15, bottom: 15),
              child: GestureDetector(
                onTap: () {
                   if (fromkey.currentState.validate()) {
                    fromkey.currentState.save();
                    if(widget.flights['providerType']=='SHT'){
                      navigateTo(context,ConfirmedPage(
                        timer:widget.timer,
                        bagsSelected:bagsSelected,
                        total:TotalPrice,
                        selectedBag: selectedBag,
                        adt: FlightCubit.get(context).getCountbytravel('ADT',flight: flightsht),
                        chd: FlightCubit.get(context).getCountbytravel('CHD',flight: flightsht),
                        inf: FlightCubit.get(context).getCountbytravel('INF',flight: flightsht),

                        adtprice: FlightCubit.get(context).getTotalepricebytravel('ADT',flight: flightsht),
                        chdprice: FlightCubit.get(context).getTotalepricebytravel('CHD',flight: flightsht),
                        infprice: FlightCubit.get(context).getTotalepricebytravel('INF',flight: flightsht),

                        flights:  widget.flights,
                        totalTaxe: FlightCubit.get(context).getTotalTaxesbytravel('ADT',flight: flightsht) + FlightCubit.get(context).getTotalTaxesbytravel('CHD',flight: flightsht) + FlightCubit.get(context).getTotalTaxesbytravel('INF',flight: flightsht),
                        travelers: Travelers,
                        FlightOneWay: widget.FlightOneWay,

                        adtTaxes: FlightCubit.get(context).getTotalTaxesbytravel('ADT',flight: flightsht),
                        chdTaxes: FlightCubit.get(context).getTotalTaxesbytravel('CHD',flight: flightsht),
                        infTaxes: FlightCubit.get(context).getTotalTaxesbytravel('INF',flight: flightsht),

                        adultFee: FlightCubit.get(context).getService_fee_bytravel('ADT',flight: flightsht),
                        childernFee: FlightCubit.get(context).getService_fee_bytravel('CHD',flight: flightsht),
                        infansFee: FlightCubit.get(context).getService_fee_bytravel('INF',flight: flightsht),
                        sourceRequrment: sourceRequrment,
                        MONNameController: MONNameController.text,
                        MONlasController: MONlasController.text,
                        MonCountryCode: MonCountryCode,
                        MonaddressController: MonaddressController.text,
                        MoncountryCallingCode: MoncountryCallingCode,
                        citynameController: citynameController.text,
                        emailController: emailController.text,
                        monphoneController: monphoneController.text,
                        postcodeController: postcodeController.text,
                        sequence_number: widget.sequence_number,
                        statenameController: statenameController.text,

                        totalPrice:widget.totalPrice,

                        Adt_markup:FlightCubit.get(context).getTotalMarkupbytravel('ADT',flight: flightsht),
                        Chd_markup:FlightCubit.get(context).getTotalMarkupbytravel('CHD',flight: flightsht),
                        Inf_markup:FlightCubit.get(context).getTotalMarkupbytravel('INF',flight: flightsht),

                        AdtService_Fee_Cedido:FlightCubit.get(context).getTotalService_fee_cedidobytravel('ADT',flight: flightsht),
                        ChdService_Fee_Cedido:FlightCubit.get(context).getTotalService_fee_cedidobytravel('CHD',flight: flightsht),
                        InfService_Fee_Cedido:FlightCubit.get(context).getTotalService_fee_cedidobytravel('INF',flight: flightsht),

                        AdtService_Fee:FlightCubit.get(context).getService_fee_bytravel('ADT',flight: flightsht),
                        ChdService_Fee:FlightCubit.get(context).getService_fee_bytravel('CHD',flight: flightsht),
                        InfService_Fee:FlightCubit.get(context).getService_fee_bytravel('INF',flight: flightsht),

                      ));
                    }else{
                      FlightCubit.get(context).getPrice(widget.sequence_number,bags: ReservationPage.trying,seatMap:chairs);
                    }
                    }
                },
                child: Container(
                height: 55,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Color(0xFFF28300)),
                  width: double.infinity,
                  child: Center(
                      child:FlightCubit.get(context).LoadingPrice
                          ? Text(
                              'Booking',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            )
                          : CircularProgressIndicator(
                              color: Colors.white,
                            )),
                ),
              ),
            ),
            appBar:buildAppBar(text: 'Flight reservation',context:context),
            body: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Form(
                  key: fromkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Text('${token}'),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 0),
                        child: Text('Flight details',
                            style: TextStyle(
                                fontSize: 17,
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontWeight: FontWeight.bold)),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Column(
                        children: [

                          // Text('${widget.FlightOneWay}'),
                          //  Text('${widget.flights}'),
                          widget.FlightOneWay == null
                              ? Stack(
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
                                        children: [
                                          ...widget.flights['options']
                                              .map((option) {
                                            int weight = widget.flights['travelers'][0]['details']!=null?widget.flights['travelers'][0]['details'][0]['segments_details'][0]['includedCheckedBags']['weight']:null;
                                            String weightUnit =widget.flights['travelers'][0]['details']!=null? widget.flights['travelers'][0]['details'][0]['segments_details'][0]['includedCheckedBags']['weightUnit']:null;
                                            dynamic includedCheckedBags =widget.flights['travelers'][0]['details']!=null? widget.flights['travelers'][0]['details'][0]['segments_details'][0]['includedCheckedBags']!=null? widget.flights['travelers'][0]['details'][0]['segments_details'][0]['includedCheckedBags']['quantity']:0:0;
                                            final arrivalDate = option['segments'][option['segments'].length - 1]['arrivalDateTime'];
                                            final departureAirport =option['segments'][0]['departureAirport'];
                                            final datedeparture = option['segments'][0]['departureDateTime'];
                                            final arrivalAirport = option['segments'][option['segments'].length - 1]['arrivalAirport'];
                                            final flightNumber = option['segments'][0]['flightNumber'];
                                            final arrivalAirportTerminal = option['segments'][option['segments'].length - 1]['arrivalAirportTerminal'];
                                            final departureAirportTerminal =option['segments'][0]['departureAirportTerminal'];
                                            final logo = widget.flights['options'][0]['segments'][0]['marketingAirline'];
                                            final cabin = option['segments'][0]['cabin'];
                                            int stops = option['segments'].length - 1;
                                            var timedearival = DateTime.parse(arrivalDate);
                                            var Dateearival = DateTime.parse(arrivalDate);
                                            final arrivalDateTime =DateFormat('HH:mm').format(timedearival);
                                            final DatedaArival = DateFormat('yyyy-MM-dd').format(Dateearival);
                                            var dateedatedeparture = DateTime.parse(datedeparture);
                                            final datedepart = DateFormat('HH:mm').format(dateedatedeparture);
                                            final Datedateedatedeparture = DateFormat('yyyy-MM-dd').format(dateedatedeparture);

                                            return buildticketCard(
                                                arrivalDateTime:arrivalDateTime,
                                                datedeparture:Datedateedatedeparture,
                                                arrivalAirport:arrivalAirport,
                                                departureAirport:departureAirport,
                                                departureDateTime:datedepart,
                                                duration:option['duration'],
                                                flightNumber:flightNumber,
                                                DateArival:DatedaArival,
                                                arrivalAirportTerminal:
                                                arrivalAirportTerminal,
                                                departureAirportTerminal:
                                                departureAirportTerminal,
                                                stops:stops,
                                                logo:logo,
                                                cabin:cabin,
                                                bagageCount:includedCheckedBags,
                                                weight:weight,
                                                weightUnit:weightUnit,
                                                operaitedby:'${widget.flights['options'][0]['segments'][0]['marketingAirlineName']}');
                                          }),
                                          SizedBox(height: 10),
                                        ],
                                      ),
                                    ),
                                  Container(
                                    decoration: BoxDecoration(
                                        color:changeColor(widget.flights['providerType']),
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
                              )
                              : SizedBox(height: 0),
                             
                          widget.FlightOneWay != null
                              ? Column(
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
                                        children: [
                                          ...widget.FlightOneWay.map((Flight) {
                                            return Column(
                                              children: [
                                                ...Flight['options'].map((options) {
                                                   int weight =Flight['travelers'][0]['details']!=null? Flight['travelers'][0]['details'][0]['segments_details'][0]['includedCheckedBags']['weight']:null;
                                                   String weightUnit = Flight['travelers'][0]['details']!=null?Flight['travelers'][0]['details'][0]['segments_details'][0]['includedCheckedBags']['weightUnit']:null;
                                                  dynamic includedCheckedBags =Flight['travelers'][0]['details']!=null? Flight['travelers'][0]['details'][0]['segments_details'][0]['includedCheckedBags']['quantity']:0;
                                                  final arrivalDate = options['segments'][options['segments'].length -1]['arrivalDateTime'];
                                                  final departureAirport = options['segments'][0]['departureAirport'];
                                                  final datedeparture = options['segments'][0]['departureDateTime'];
                                                  final arrivalAirport = options['segments'][options['segments'].length -1]['arrivalAirport'];
                                                  final flightNumber = options['segments'][0]['flightNumber'];
                                                  final arrivalAirportTerminal =options['segments'][options['segments'].length - 1]['arrivalAirportTerminal'];
                                                  final departureAirportTerminal =options['segments'][0]['departureAirportTerminal'];
                                                  final logo = Flight['options'][0]['segments'][0]['marketingAirline'];
                                                  final cabin =options['segments'][0]['cabin'];
                                                  int stops = options['segments'].length -1;
                                                  var timedearival =DateTime.parse(arrivalDate);
                                                  var Dateearival =DateTime.parse(arrivalDate);
                                                  final arrivalDateTime =DateFormat('HH:mm').format(timedearival);
                                                  final DatedaArival =DateFormat('yyyy-MM-dd').format(Dateearival);
                                                  var dateedatedeparture =DateTime.parse(datedeparture);
                                                  final datedepart = DateFormat('HH:mm').format(dateedatedeparture);
                                                  final Datedateedatedeparture =DateFormat('yyyy-MM-dd').format(dateedatedeparture);
                                                  return buildticketCard(
                                                      arrivalDateTime:arrivalDateTime,
                                                      datedeparture:Datedateedatedeparture,
                                                      arrivalAirport:arrivalAirport,
                                                      departureAirport:departureAirport,
                                                      departureDateTime:datedepart,
                                                      duration:options['duration'],
                                                      flightNumber:flightNumber,
                                                      DateArival: DatedaArival,
                                                      arrivalAirportTerminal:arrivalAirportTerminal,
                                                      departureAirportTerminal:departureAirportTerminal,
                                                      stops: stops,
                                                      logo: logo,
                                                      cabin: cabin,
                                                      bagageCount: includedCheckedBags,
                                                      weight: weight,
                                                      weightUnit:weightUnit,
                                                      operaitedby:countryService.airline(countryService.airlines,logo));
                                                }),
                                              ],
                                            );
                                          })
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              : SizedBox(height: 0),
                        ],
                      ),
                      // SizedBox(
                      //   height: 20,
                      // ),
                       SizedBox(height: 10),
                      Text('Contact :',
                          style: TextStyle(
                              fontSize: 18,
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontWeight: FontWeight.bold)),
                      SizedBox(
                        height: 10,
                      ),
                       Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white),
                        width: double.infinity,
                        child: Padding(
                          padding: EdgeInsets.only(left: 15, right: 15,bottom: 10,top: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              // Text('Contact :',
                              //     style: TextStyle(
                              //         fontSize: 16,
                              //         color: Color.fromARGB(234, 48, 43, 41),
                              //         fontWeight: FontWeight.bold)),
                              // SizedBox(
                              //   height: 10,
                              // ),
                              Row(
                                children: [
                                  Text('First name : ',
                                      style: TextStyle(
                                          fontSize: 13,
                                          color:
                                              Color.fromARGB(234, 49, 45, 43),
                                          fontWeight: FontWeight.bold)),
                                  Text('*',
                                      style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                              SizedBox(
                                height: 9,
                              ),
                              buildTextFiled(
                                  controller: MONNameController,
                                  hintText: 'name',
                                  valid: 'name'),
                              SizedBox(
                                height: 10,
                              ),
                              buildhint(hintText: 'Last name'),
                              SizedBox(
                                height: 9,
                              ),
                              buildTextFiled(
                                  hintText: 'The Last Name',
                                  valid: 'The Last Name',
                                  controller: MONlasController),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Text('Email : ',
                                      style: TextStyle(
                                          fontSize: 13,
                                          color:
                                              Color.fromARGB(234, 49, 45, 43),
                                          fontWeight: FontWeight.bold)),
                                  Text('*',
                                      style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                              SizedBox(
                                height: 9,
                              ),
                              buildTextFiled(
                                  keyboardType: TextInputType.emailAddress,
                                  controller: emailController,
                                  hintText: 'Email',
                                  valid: 'Email'),
                             
                              
                             
                              SizedBox(
                                height: 9,
                              ),
                             
                              
                              
                              buildhint(hintText: 'Phones',),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                            color: Color(0xFFf37021),
                                            width: 2)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: CountryListPick(
                                          theme: CountryTheme(
                                            initialSelection: 'Choisir un pays',
                                            labelColor: Color(0xFFf37021),
                                            alphabetTextColor:
                                                Color(0xFFf37021),
                                            alphabetSelectedTextColor:
                                                Colors.red,
                                            alphabetSelectedBackgroundColor:
                                                Colors.grey[300],
                                            isShowFlag: false,
                                            isShowTitle: false,
                                            isShowCode: true,
                                            isDownIcon: false,
                                            showEnglishName: false,
                                          ),
                                          appBar: AppBar(
                                            backgroundColor: Color(0xFFf37021),
                                            title: Text('Choisir un pays'),
                                          ),
                                          initialSelection: '+212',
                                          onChanged: (CountryCode code) {
                                            result2 = code.dialCode.replaceAll('+', '');
                                            MoncountryCallingCode = result2;
                                          },
                                          useUiOverlay: false,
                                          useSafeArea: false),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Container(
                                      child: buildTextFiled(
                                        keyboardType: TextInputType.phone,
                                          hintText: 'Number',
                                          valid: 'Number',
                                          controller: monphoneController),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text('Passengers :',
                          style: TextStyle(
                              fontSize: 18,
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontWeight: FontWeight.bold)),
                      SizedBox(
                        height: 10,
                      ),
                      ...Travelers.map((traveler) {
                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: double.infinity,
                                color: Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, top: 10, right: 10, bottom: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                              travels(traveler[
                                                  'PassengerTypeCode']),
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Color.fromARGB(
                                                      234, 48, 43, 41),
                                                  fontWeight: FontWeight.bold)),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      buildhint(hintText: 'First name'),
                                      SizedBox(
                                        height: 9,
                                      ),
                                      buildTextFiled(
                                          hintText: 'name ',
                                          onSaved: (text) {
                                            traveler['FirstName'] = text;
                                          }),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      buildhint(hintText: 'Last name'),
                                      SizedBox(
                                        height: 9,
                                      ),
                                      buildTextFiled(
                                          hintText: 'Last Name',
                                          onSaved: (text) {
                                            traveler['LastName'] = text;
                                          }),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      buildhint(hintText: 'Gender'),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                border: Border.all(
                                                  color: Color(0xFFf37021),
                                                  width: 2,
                                                ),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: DropdownButton(
                                                  elevation: 3,
                                                  icon: Icon(
                                                    Icons.keyboard_arrow_down,
                                                    color: Color(0xFF7B919D),
                                                  ),
                                                  underline: SizedBox(),
                                                  isExpanded: true,
                                                  hint: Text(
                                                    traveler['Gender'] != ''
                                                        ? traveler['Gender']
                                                        : 'Gender',
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xFF7B919D),
                                                        fontSize: 12),
                                                  ),
                                                  items: ["MALE", "FEMALE"]
                                                      .map((e) =>
                                                          DropdownMenuItem(
                                                            child: Center(
                                                              child: Text(
                                                                "$e",
                                                                style: TextStyle(
                                                                    color: Color(
                                                                        0xFF173242),
                                                                    fontSize:
                                                                        14),
                                                              ),
                                                            ),
                                                            value: e,
                                                          ))
                                                      .toList(),
                                                  onChanged:
                                                      (selecteCurrencyInfo) {
                                                    setState(() {
                                                      traveler['Gender'] =
                                                          selecteCurrencyInfo;
                                                    });
                                                  },
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Expanded(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  border: Border.all(
                                                      color: Color(0xFFf37021),
                                                      width: 2)),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: DropdownButton(
                                                    elevation: 3,
                                                    icon: Icon(
                                                      Icons.keyboard_arrow_down,
                                                      color: Color(0xFF7B919D),
                                                    ),
                                                    underline: SizedBox(),
                                                    isExpanded: true,
                                                    hint: Text(
                                                      traveler['NamePrefix'] !=
                                                              ''
                                                          ? traveler[
                                                              'NamePrefix']
                                                          : 'NamePrefix',
                                                      style: TextStyle(
                                                          color:
                                                              Color(0xFF7B919D),
                                                          fontSize: 12),
                                                    ),
                                                    items: ["Mr", "Mis"]
                                                        .map((e) =>
                                                            DropdownMenuItem(
                                                              child: Center(
                                                                child: Text(
                                                                  "$e",
                                                                  style: TextStyle(
                                                                      color: Color(
                                                                          0xFF173242),
                                                                      fontSize:
                                                                          14),
                                                                ),
                                                              ),
                                                              value: e,
                                                            ))
                                                        .toList(),
                                                    onChanged:
                                                        (selecteCurrencyInfo) {
                                                      setState(() {
                                                        traveler['NamePrefix'] =
                                                            selecteCurrencyInfo;
                                                      });
                                                    }),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      buildhint(hintText: 'Date of birth'),
                                      SizedBox(
                                        height: 9,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          var date = DateTime.now();
                                          print(date.year);
                                          if(traveler['PassengerTypeCode']=='ADT'){
                                            showDatePicker(
                                                  context: context,
                                                  initialDate:
                                                    DateTime(date.year - 18),
                                                  firstDate:
                                                      DateTime(1900),
                                                  lastDate:
                                                      DateTime(2100))
                                              .then((value) {
                                            setState(() {
                                              traveler['BirthDate'] =
                                                  DateFormat('yyyy-MM-dd')
                                                      .format(value);
                                            });
                                          });
                                          }if(traveler['PassengerTypeCode']=='CHD'){
                                            showDatePicker(
                                                  context: context,
                                                  initialDate:
                                                    DateTime(date.year - 12),
                                                  firstDate:
                                                      DateTime(1900),
                                                  lastDate:
                                                      DateTime(2100))
                                              .then((value) {
                                            setState(() {
                                              traveler['BirthDate'] =
                                                  DateFormat('yyyy-MM-dd')
                                                      .format(value);
                                            });
                                          });
                                          }if(traveler['PassengerTypeCode']=='INF'){
                                            showDatePicker(
                                                  context: context,
                                                  initialDate:
                                                    DateTime(date.year - 1),
                                                  firstDate:
                                                      DateTime(1900),
                                                  lastDate:
                                                      DateTime(2100))
                                              .then((value) {
                                            setState(() {
                                              traveler['BirthDate'] =
                                                  DateFormat('yyyy-MM-dd')
                                                      .format(value);
                                            });
                                          });
                                          }
                                         
                                        },
                                        child: Container(
                                          height: 60,
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            border: Border.all(
                                                color: Color(0xFFf37021),
                                                width: 2),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10, bottom: 0),
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.calendar_today,
                                                  color: Colors.grey,
                                                  size: 20,
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                traveler['BirthDate'] != ''
                                                    ? Text(
                                                        '${traveler['BirthDate']}',
                                                        style: TextStyle(
                                                            fontSize: 17),
                                                      )
                                                    : Text('Select Date')
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      buildhint(hintText: 'Email'),
                                      SizedBox(
                                        height: 9,
                                      ),
                                      buildTextFiled(
                                          keyboardType: TextInputType.emailAddress,
                                          hintText: 'Email',
                                          onSaved: (email) {
                                            traveler['Contact']['Email'] =
                                                email;
                                          }),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      buildhint(hintText: 'Telephone'),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      buildTextFiled(
                                          keyboardType: TextInputType.phone,
                                          hintText: 'Telephone',
                                          onSaved: (Telephone) {
                                            traveler['Contact']['Phones'][0]
                                                ['number'] = Telephone;
                                          }),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      buildhint(hintText: 'Type'),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  border: Border.all(
                                                      color: Color(0xFFf37021),
                                                      width: 2)),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: DropdownButton(
                                                    elevation: 3,
                                                    icon: Icon(
                                                      Icons.keyboard_arrow_down,
                                                      color: Color(0xFF7B919D),
                                                    ),
                                                    underline: SizedBox(),
                                                    isExpanded: true,
                                                    hint: Text(
                                                      traveler['Documents'][0][
                                                                  'documentType'] !=
                                                              ''
                                                          ? traveler[
                                                                  'Documents'][
                                                              0]['documentType']
                                                          : 'documentType',
                                                      style: TextStyle(
                                                          color:
                                                              Color(0xFF7B919D),
                                                          fontSize: 12),
                                                    ),
                                                    items: [
                                                      "IDENTITY_CARD",
                                                      "PASSPOWER"
                                                    ]
                                                        .map((e) =>
                                                            DropdownMenuItem(
                                                              child: Center(
                                                                child: Text(
                                                                  "$e",
                                                                  style: TextStyle(
                                                                      color: Color(
                                                                          0xFF173242),
                                                                      fontSize:
                                                                          14),
                                                                ),
                                                              ),
                                                              value: e,
                                                            ))
                                                        .toList(),
                                                    onChanged:
                                                        (selecteCurrencyInfo) {
                                                      setState(() {
                                                        traveler['Documents'][0]
                                                                [
                                                                'documentType'] =
                                                            selecteCurrencyInfo;
                                                      });
                                                    }),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Expanded(
                                            child: Container(
                                              height: 60,
                                              child: buildTextFiled(
                                                  hintText: 'Number',
                                                  onSaved: (number) {
                                                    traveler['Documents'][0]
                                                        ['number'] = number;
                                                  }),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      buildhint(
                                        hintText: 'Passport Expiration Date',
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          showDatePicker(
                                                  context: context,
                                                  initialDate: DateTime.now(),
                                                  firstDate: DateTime.now(),
                                                  lastDate:
                                                      DateTime(2040 - 05 - 01))
                                              .then((value) {
                                            setState(() {
                                              traveler['Documents'][0]
                                                      ['expiryDate'] =
                                                  DateFormat('yyyy-MM-dd')
                                                      .format(value);
                                              ;
                                            });
                                          });
                                        },
                                        child: Container(
                                          height: 60,
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            border: Border.all(
                                                color: Color(0xFFf37021),
                                                width: 2),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10, bottom: 0),
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.calendar_today,
                                                  color: Colors.grey,
                                                  size: 20,
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                traveler['Documents'][0]
                                                            ['expiryDate'] !=
                                                        ''
                                                    ? Text(
                                                        '${traveler['Documents'][0]['expiryDate']}',
                                                        style: TextStyle(
                                                            fontSize: 17),
                                                      )
                                                    : Text('Select ExpiryDate')
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 9,
                                      ),
                                      buildhint(hintText: 'Issuance Country'),
                                      SizedBox(
                                        height: 9,
                                      ),
                                      Container(
                                        height: 60,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(4),
                                            border: Border.all(
                                                color: Color(0xFFf37021),
                                                width: 2)),
                                        child: Row(
                                          children: [
                                            CountryListPick(
                                                theme: CountryTheme(
                                                  initialSelection:
                                                      'Choisir un pays',
                                                  labelColor: Color(0xFFf37021),
                                                  alphabetTextColor:
                                                      Color(0xFFf37021),
                                                  alphabetSelectedTextColor:
                                                      Colors.red,
                                                  alphabetSelectedBackgroundColor:
                                                      Colors.grey[300],
                                                  isShowFlag: true,
                                                  isShowTitle: true,
                                                  isShowCode: false,
                                                  isDownIcon: false,
                                                  showEnglishName: true,
                                                ),
                                                appBar: AppBar(
                                                  backgroundColor:
                                                      Color(0xFFf37021),
                                                  title:
                                                      Text('Choisir un pays'),
                                                ),
                                                initialSelection: '+1',
                                                onChanged: (CountryCode code) {
                                                  print(code.name);
                                                  print(code.code);

                                                  traveler['Documents'][0]
                                                          ['issuanceCountry'] =
                                                      code.code;
                                                },
                                                useUiOverlay: false,
                                                useSafeArea: false),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 9,
                                      ),
                                      buildhint(hintText: 'Issuance Location'),
                                      SizedBox(
                                        height: 9,
                                      ),
                                      Container(
                                        height: 60,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(4),
                                            border: Border.all(
                                                color: Color(0xFFf37021),
                                                width: 2)),
                                        child: Row(
                                          children: [
                                            CountryListPick(
                                                theme: CountryTheme(
                                                  initialSelection:
                                                      'Choisir un pays',
                                                  labelColor: Color(0xFFf37021),
                                                  alphabetTextColor:
                                                      Color(0xFFf37021),
                                                  alphabetSelectedTextColor:
                                                      Colors.red,
                                                  alphabetSelectedBackgroundColor:
                                                      Colors.grey[300],
                                                  isShowFlag: true,
                                                  isShowTitle: true,
                                                  isShowCode: false,
                                                  isDownIcon: false,
                                                  showEnglishName: true,
                                                ),
                                                appBar: AppBar(
                                                  backgroundColor:
                                                      Color(0xFFf37021),
                                                  title:
                                                      Text('Choisir un pays'),
                                                ),
                                                initialSelection: '+1',
                                                onChanged: (CountryCode code) {
                                                  print(code.name);
                                                  print(code.code);
                                                  traveler['Documents'][0]
                                                          ['issuanceLocation'] =
                                                      code.code;
                                                },
                                                useUiOverlay: false,
                                                useSafeArea: false),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                    widget.flights!=null? Column(
                                        children: [
                                          ...widget.flights['options'].map((option){
                                            printFullText(widget.flights['travelers'].toString());
                                          flightNumber = option['segments'][option['segments'].length - 1]['flightNumber'];
                                          arrivalAirport = option['segments'][option['segments'].length - 1]['arrivalAirport'];
                                          departureAirport = option['segments'][0]['departureAirport'];
                                         // int includedCheckedBags =widget.flights['travelers'][0]['details'][0]['segments_details'][0]['includedCheckedBags']!=null? widget.flights['travelers'][0]['details'][0]['segments_details'][0]['includedCheckedBags']['quantity']:0;
                                        //  int weight = widget.flights['travelers'][0]['details'][0]['segments_details'][0]['includedCheckedBags']!=null? flightResult['travelers'][0]['details'][0]['segments_details'][0]['includedCheckedBags']['weight']:null;
                                        // String weightUnit = flightResult['travelers'][0]['details'][0]['segments_details'][0]['includedCheckedBags']['weightUnit'];
                                        return buildBaggage(
                                          arrivalAirport:arrivalAirport,
                                          departureAirport:departureAirport,
                                          flightResult: widget.flights ,
                                          baggage:baggage,
                                          includedCheckedBags:'',
                                          traveler: traveler,
                                          weight:null,
                                          weightUnit:'',
                                          optionId: widget.flights['options'].indexOf(option)+1,
                                        );
                                      })
                                      ],
                                      ) : SizedBox(height: 0,),
                                      
                                     widget.FlightOneWay!=null? Column(
                                        children: [
                                          ...widget.FlightOneWay.map((flight){
                                            return Column(
                                             children: [
                                               ...flight['options'].map((option){
                                                 printFullText(option);
                                                 arrivalAirport = option['segments'][option['segments'].length - 1]['arrivalAirport'];
                                                 departureAirport =option['segments'][0]['departureAirport'];
                                                 flightNumber = option['segments'][option['segments'].length - 1]['flightNumber'];
                                              // int includedCheckedBags = flight['travelers'][0]['details'][0]['segments_details'][0]['includedCheckedBags']['quantity'];
                                              // int weight = flight['travelers'][0]['details'][0]['segments_details'][0]['includedCheckedBags']['weight'];
                                              // String weightUnit = flight['travelers'][0]['details'][0]['segments_details'][0]['includedCheckedBags']['weightUnit'];
                                               return buildBaggage(
                                                    arrivalAirport:option['segments'][option['segments'].length - 1]['arrivalAirport'],
                                                    departureAirport:option['segments'][0]['departureAirport'],
                                                    flightResult: widget.FlightOneWay,
                                                    baggage:baggage,
                                                    includedCheckedBags: 0,
                                                    traveler: traveler,
                                                    weight:null,
                                                    weightUnit:null,
                                                    optionId:flight['options'].indexOf(option) + 1,
                                                  );
                                               })
                                             ],
                                            );
                                          })
                                        ],
                                      ):SizedBox(height: 0),
                                       FlightCubit.get(context).Loading
                                        ? Column(
                               crossAxisAlignment: CrossAxisAlignment.start,
                                         mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  widget.flights!=null? Flights['seatmaps']['options'].length>0?Text(
                                    'Seat Selection',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14),
                                  ):SizedBox(height: 0):SizedBox(height: 0),
                                  widget.flights!=null?Column(
                                    children: [
                                      Flights['seatmaps']['options'].length>0?Column(
                                        children: [
                                          ...Flights['seatmaps']['options'].map((seatOption){
                                            return Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                ...seatOption['segments'].map((segment){
                                                  final departAirport = widget.flights['options'].where((e)=>e['id']==seatOption['optionId']).toList()[0]['segments'].where((seg)=>seg['id']==segment["segmentId"]).toList()[0]['departureAirport'];
                                                  final arivalAirport = widget.flights['options'].where((e)=>e['id']==seatOption['optionId']).toList()[0]['segments'].where((seg)=>seg['id']==segment["segmentId"]).toList()[0]['arrivalAirport'];
                                                  final flightNumber  = widget.flights['options'].where((e)=>e['id']==seatOption['optionId']).toList()[0]['segments'].where((seg)=>seg['id']==segment["segmentId"]).toList()[0]['flightNumber'].toString();
                                                  return Column(
                                                    mainAxisSize: MainAxisSize.max,
                                                    children: [
                                                      chairs.where((element) => element['option']==seatOption['optionId'] && element['segment']==segment['segmentId']&&element['traveler']==traveler['TravelerRefNumber']).toList().length>0?
                                                      Container(
                                                          child:Column(
                                                            children:[
                                                              ...chairs.where((element) => element['option']==seatOption['optionId'] && element['segment']==segment['segmentId']&&element['traveler']==traveler['TravelerRefNumber']).toList().map((e){
                                                                return Column(
                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                                  children: [
                                                                    Padding(
                                                                      padding: const EdgeInsets.only(bottom: 10,top: 10),
                                                                      child: Container(
                                                                        height: 80,
                                                                        width: double.infinity,
                                                                        decoration: BoxDecoration(
                                                                            borderRadius: BorderRadius.circular(5),
                                                                            border: Border.all(color: appColor,width: 1)
                                                                        ),
                                                                        child: Row(
                                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                          children: [
                                                                            Column(
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                                              children: [
                                                                                Padding(
                                                                                  padding: const EdgeInsets.all(8.0),
                                                                                  child: Row(
                                                                                    children: [
                                                                                      Text('${departAirport}',
                                                                                          style: TextStyle(
                                                                                              color: Colors.black, fontWeight: FontWeight.w600)),
                                                                                      SizedBox(
                                                                                        width: 5,
                                                                                      ),
                                                                                      Transform.rotate(
                                                                                          angle: 1,
                                                                                          child: Icon(Icons.airplanemode_active, color: appColor)),
                                                                                      SizedBox(
                                                                                        width: 5,
                                                                                      ),
                                                                                      Text('${arivalAirport}',
                                                                                          style: TextStyle(
                                                                                              color: Colors.black, fontWeight: FontWeight.w600))
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                                Padding(
                                                                                  padding: const EdgeInsets.all(8.0),
                                                                                  child: Row(
                                                                                    children: [
                                                                                      Text('Flight Number : ',style: TextStyle(fontSize: 12,color: Colors.grey),),
                                                                                      Text('${flightNumber}',style: TextStyle(fontSize: 12,color: Colors.grey),)
                                                                                    ],
                                                                                  ),
                                                                                )
                                                                              ],
                                                                            ),
                                                                            Row(
                                                                              children: [
                                                                                Column(
                                                                                  crossAxisAlignment:CrossAxisAlignment.start ,
                                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                                  children: [
                                                                                    Text('Number : ${e['number']}',style: TextStyle(fontSize: 11,color: Colors.grey),),
                                                                                    Text('Price : ${e['price']} DH',style: TextStyle(fontSize: 11,color: Colors.grey),),
                                                                                  ],
                                                                                ),
                                                                                SizedBox(width: 10,),
                                                                                TextButton(onPressed: ()async{
                                                                                  var seat = await showModalBottomSheet(
                                                                                      isScrollControlled: true,
                                                                                      context: context, builder: (context){
                                                                                    return Voles(segment:segment,option:seatOption,travelerId:traveler['TravelerRefNumber'],chairs: chairs,);
                                                                                  });
                                                                                  setState((){

                                                                                  });
                                                                                }, child:Text('Change',style: TextStyle(fontSize: 11,color: Colors.white),),style: ButtonStyle(backgroundColor: MaterialStateProperty.all(appColor))),
                                                                                SizedBox(width: 10,),
                                                                              ],
                                                                            )
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    )
                                                                  ],
                                                                );
                                                              })
                                                            ],
                                                          )
                                                      ):
                                                      Padding(
                                                        padding: const EdgeInsets.only(bottom: 10,top: 10),
                                                        child: Container(
                                                          height: 80,
                                                          width: double.infinity,
                                                          decoration: BoxDecoration(
                                                              borderRadius: BorderRadius.circular(5),
                                                              border: Border.all(color: appColor,width: 1)
                                                          ),
                                                          child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: [
                                                              Column(
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                children: [
                                                                  Padding(
                                                                    padding: const EdgeInsets.all(8.0),
                                                                    child: Row(
                                                                      children: [
                                                                        Text('${departAirport}',
                                                                            style: TextStyle(
                                                                                color: Colors.black, fontWeight: FontWeight.w600)),
                                                                        SizedBox(
                                                                          width: 5,
                                                                        ),
                                                                        Transform.rotate(
                                                                            angle: 1,
                                                                            child: Icon(Icons.airplanemode_active, color: appColor)),
                                                                        SizedBox(
                                                                          width: 5,
                                                                        ),
                                                                        Text('${arivalAirport}', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600))
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding: const EdgeInsets.all(8.0),
                                                                    child: Row(
                                                                      children: [
                                                                        Text('Flight Number : ',style: TextStyle(fontSize: 12,color: Colors.grey),),
                                                                        Text('${flightNumber}',style: TextStyle(fontSize: 12,color: Colors.grey),)
                                                                      ],
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                              Row(
                                                                children: [
                                                                  SizedBox(width: 10,),
                                                                  TextButton(onPressed: ()async{
                                                                    var seat = await showModalBottomSheet(
                                                                        isScrollControlled: true,
                                                                        context: context, builder: (context){

                                                                      return Voles(segment:segment,option:seatOption,travelerId:traveler['TravelerRefNumber'],chairs: chairs,);
                                                                    });
                                                                    setState((){

                                                                    });
                                                                  }, child:Text('Select',style: TextStyle(fontSize: 11,color: Colors.white),),style: ButtonStyle(backgroundColor: MaterialStateProperty.all(appColor))),
                                                                  SizedBox(width: 10,),
                                                                ],
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  );
                                                })
                                              ],
                                            );
                                          }),
                                        ],
                                      ): SizedBox(height: 0,),
                                    ],
                                  )
                                      :
                                  SizedBox(height: 0,),
 

                                ],
                              ):SizedBox(height: 0,),
                                      
                                      // Text('${Flights['flights']}')
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      }),

                      SizedBox(
                                    height: 10,
                                  ),
                      Text('Price details :',
                          style: TextStyle(
                              fontSize: 17,
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontWeight: FontWeight.bold)),
                      SizedBox(
                        height: 10,
                      ),

                            widget.providerType=='SHT'?
                            buildCartTotalPrice(
                            Totalprice:widget.totalPrice,
                            adt:FlightCubit.get(context).getCountbytravel('ADT',flight: flightsht),
                            adtTaxes:FlightCubit.get(context).getTotalTaxesbytravel('ADT',flight: flightsht),
                            adtprice:FlightCubit.get(context).getTotalepricebytravel('ADT',flight: flightsht),
                            adultFee:FlightCubit.get(context).getService_fee_bytravel('ADT',flight: flightsht),

                            AdtService_Fee:FlightCubit.get(context).getService_fee_bytravel('ADT',flight: flightsht),
                            ChdService_Fee:FlightCubit.get(context).getService_fee_bytravel('CHD',flight: flightsht),
                            InfService_Fee:FlightCubit.get(context).getService_fee_bytravel('INF',flight: flightsht),

                            AdtService_Fee_Cedido:FlightCubit.get(context).getTotalService_fee_cedidobytravel('ADT',flight: flightsht),
                            ChdService_Fee_Cedido:FlightCubit.get(context).getTotalService_fee_cedidobytravel('CHD',flight: flightsht),
                            InfService_Fee_Cedido:FlightCubit.get(context).getTotalService_fee_cedidobytravel('INF',flight: flightsht),

                            Adt_markup:FlightCubit.get(context).getTotalMarkupbytravel('ADT',flight: flightsht),
                            Chd_markup:FlightCubit.get(context).getTotalMarkupbytravel('CHD',flight: flightsht),
                            Inf_markup:FlightCubit.get(context).getTotalMarkupbytravel('INF',flight: flightsht),

                            chd:FlightCubit.get(context).getCountbytravel('CHD',flight: flightsht),
                            chdTaxes:FlightCubit.get(context).getTotalTaxesbytravel('CHD',flight: flightsht),
                            chdprice:FlightCubit.get(context).getTotalepricebytravel('CHD',flight: flightsht),
                            childernFee:FlightCubit.get(context).getService_fee_bytravel('CHD',flight: flightsht),

                            inf:FlightCubit.get(context).getCountbytravel('INF',flight: flightsht),
                            infTaxes:FlightCubit.get(context).getTotalTaxesbytravel('INF',flight: flightsht),
                            infansFee:FlightCubit.get(context).getService_fee_bytravel('INF',flight: flightsht),
                            infprice:FlightCubit.get(context).getTotalepricebytravel('INF',flight: flightsht),
                          ):
                         FlightCubit.get(context).Loading
                          ? buildCartTotalPrice(
                            Totalprice:widget.totalPrice,
                            adt:adt,
                            adtTaxes:adtTaxes,
                            adtprice:adtprice,
                            adultFee:getServiceFeebytravel('ADT'),

                            Adt_markup:getMarkupbytravel('ADT'),
                            Chd_markup:getMarkupbytravel('CHD'),
                            Inf_markup:getMarkupbytravel('INF'),

                            AdtService_Fee_Cedido:getTotalService_fee_sedidobytravel('ADT'),
                            ChdService_Fee_Cedido:getTotalService_fee_sedidobytravel('CHD'),
                            InfService_Fee_Cedido:getTotalService_fee_sedidobytravel('INF'),

                            AdtService_Fee:getServiceFeebytravel('ADT'),
                            ChdService_Fee:getServiceFeebytravel('CHD'),
                            InfService_Fee:getServiceFeebytravel('INF'),

                            chd:chd,
                            chdTaxes:chd!=0?chdTaxes:0,
                            chdprice:chdprice,
                            childernFee:getServiceFeebytravel('CHD'),
                            inf:inf,
                            infTaxes:infTaxes,
                            infansFee:getServiceFeebytravel('INF'),
                            infprice:infprice,
                          )
                          : Container(
                              height: 170,
                              width: double.infinity,
                              color: Colors.white,
                              child:
                              Center(child: CircularProgressIndicator())),
                              SizedBox(height: 20),

                           








                             
                             
                    ],
                  ),
                ),
              ),

            ),
          );
        },
      ),
    );
  }

  travels(String typeTravel) {
    if (typeTravel == 'ADT') {
      return 'Adult';
    }
    if (typeTravel == 'CHD') {
      return 'Children';
    } else {
      return 'Infans';
    }
  }
}
