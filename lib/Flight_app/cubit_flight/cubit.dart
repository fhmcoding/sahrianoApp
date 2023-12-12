import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sahariano_travel/Flight_app/country_service.dart';
import 'package:sahariano_travel/Flight_app/cubit_flight/states.dart';
import 'package:sahariano_travel/Flight_app/models/seatMap.dart';
import 'package:sahariano_travel/Flight_app/pages/creatTicketPay.dart';
import 'package:sahariano_travel/Flight_app/requestSafer.dart';
import 'package:sahariano_travel/shared/components/components.dart';
import 'package:sahariano_travel/shared/components/constants.dart';
import 'package:sahariano_travel/shared/network/remote/dio_helper.dart';
import 'package:sahariano_travel/shared/network/remote/local/cache_helper.dart';
// final _firestore = FirebaseFirestore.instance;
final countryService = new CountryService();
final requestSafer = new RequestSafer();
class FlightCubit extends Cubit<FlightStates> {
  FlightCubit() : super(FlightInitialState());
  static FlightCubit get(context) => BlocProvider.of(context);
  double total = 0.0;
  List<dynamic> flights = [];
  Map<String, dynamic> flightReservation;
  List<dynamic> flightbooking = [];
  List<dynamic> bagSelected = [];
  List<dynamic> flightAR = [];
  List<dynamic> filterdate = [];
  
  String tokenflight = Cachehelper.getData(key: "token_flight");
  String setcookie = Cachehelper.getData(key: "set-cookie");
  bool Loading = false;
  bool LoadingPrice = true;
  bool isLoading = false;
  String source;
  String order_id;
  String currency;
  String providerType;
  String direction;
  List<dynamic> options =[];
  List<dynamic> flightsbooke =[];
  Map<String, dynamic> selecedFlight;
  List<dynamic> flightsService;
  List<dynamic> filterdateService;
  List<dynamic> flightRetunService;
  List<dynamic> flightdepartService;
  List<dynamic> flightARService;
  dynamic TotalPrices = 0;
  double TotalTaxes = 0.0;
  int adult = 0;
  int childern = 0;
  int infans = 0;
  double adultprice = 0.0;
  double childernprice = 0.0;
  double infansprice = 0.0;
  double adultTaxes = 0.0;
  double childernTaxes = 0.0;
  double infansTaxes = 0.0;
  double adultFees = 0.0;
  double childernFees = 0.0;
  double infansFees = 0.0;
  String message ;
  Map<String, dynamic> flightResult;
  Map<String, dynamic> baggage;
  String departureDate;
  List<dynamic> details =[]; 
  List travelersBooking = [];
  dynamic customer ={};
  double price = 0.0;
  List<dynamic> sequence_number;
  Map<String, dynamic> reponseFlight;
  Map<String, dynamic> Flight;
  List flightPnr = [];
  List<String> airlinesvalues = [];
  List<dynamic> airline = [];
  List<dynamic> FILTERDATA;
   List<dynamic> filghtoneway;
   List<dynamic> FILTERRound;
   SeatMap seatMap;
   Format({date1}){
    final Date1 = DateTime.parse(date1);
    return DateFormat('yyyy-MM-dd').format(Date1);  
 }

Future SearchFlight(
      {
      List flight,
      int qte_adults,
      int qte_children,
      int qte_infants,
      String typeflight,
      bool addOneWayOffers,
     }) async {
     emit(SearchFlightLoadingState());
      Loading = false;
     Map jsonFlight = {
              "type":typeflight,
              "flights":flight,
              "qte_adults": qte_adults,
              "qte_children": qte_children,
              "qte_infants": qte_infants,
              "addOneWayOffers":false,
            };
    http.Response response = await http.post(Uri.parse('${baseurl}/api/v1/flights/search_flight'),
      headers: {
              'Content-type': 'application/json',
              "Accept": "application/json",
              'Connection':'keep-alive'
            },
            body: json.encode(jsonFlight))
        .then((response) {

          Cachehelper.saveData(key:'set-cookie', value:response.headers['set-cookie']);
      var responsebody = jsonDecode(response.body);
      print('------------------------------------------------------------------------------------------');
      printFullText(jsonFlight.toString());
      print('------------------------------------------------------------------------------------------');
          responsebody['flights'].forEach((flight) {
          if (!airlinesvalues.contains(flight['options'][0]['segments'][0]['operatingAirline'])) {
          airlinesvalues.add(flight['options'][0]['segments'][0]['operatingAirline']);
         }
       });
    
       getAirlineOperated(iata_code:airlinesvalues);
       countryService.params = responsebody['params'];

      flightResult = responsebody;
      FILTERDATA = flightsService = responsebody['flights'];
      // printFullText(jsonFlight.toString());
      // printFullText(responsebody.toString());
      if (countryService.params['type']=="one_way") {
      filghtoneway = responsebody['flights'].where((value) => value['departureDate'] == countryService.params['flights'][0]['departureDate']).toList();
      // filghtoneway.sort((a, b) => a["price"].compareTo(b["price"]));
      }
     if (countryService.params['type']=="round_trip"){
      FILTERDATA = responsebody['flights'].where((value) => value['direction'] == 'AR').toList();
      FILTERRound = responsebody['flights'].where((value) => value['direction'] == 'AR').toList().where((flight) => Format(date1:flight['options'][0]['segments'][0]['departureDateTime'])==countryService.params['flights'][0]['departureDate']
      && Format(date1:flight['options'][1]['segments'][0]['departureDateTime'])==countryService.params['flights'][1]['departureDate']).toList();
      }

      flightRetunService = flightsService.where((value) => value['direction'] == 'R').toList();
      flightdepartService =flightsService.where((value) => value['direction'] == 'A').toList();
      filterdate = flightsService.where((value) => value['direction'] == 'AR').toList();
       Loading = true;

       emit(SearchFlightSuccessState(
        FILTERound:FILTERRound,
        filghtoneway:filghtoneway,
        FILTERDATA:FILTERDATA,
        rangeData:filterdate,
        FlightOneWay:responsebody['flights'],
        flights:flightsService,
        filterdata:filterdate,
        flightsAR:flightARService,
        flightdepart:flightdepartService,
        flightsRetun:flightRetunService,
        parm: responsebody['params'],
      )
      );
    }).catchError((error) {
      print(error.toString());
      emit(SearchFlightErrorState(error.toString()));
    });
    return response;
  } 
   

bool getServicesLoadiung = true;
getServices({sequencenumbers,providerType,flight}) async {
     if(providerType != 'SHT'){
       getServicesLoadiung = false;
       emit(GetServicesLoadingState());

       http.Response response = await http
           .post(Uri.parse('${baseurl}/api/v1/flights/get_services'),
           headers: {
             'Content-type': 'application/json',
             "Accept": "application/json",
             'Cookie': "${setcookie}",
             'Connection':'keep-alive'
           },
           body: jsonEncode({
             "sequence_number":sequencenumbers,
             "include": ["bags","seatmaps"]
           }))
           .then((response){
         var responsebody = jsonDecode(response.body);
         // printFullText(sequencenumbers.toString());
         printFullText(responsebody.toString());

         responsebody['flights'].forEach((flight){
           reponseFlight = flight;

           // baggage = response['baggage'];
           // requestSafer.sourceRequrment = flight['source'];
           //  requestSafer.sourceRequrment = 'python';
         });

         // flightsprice = countryService.flightbooking = responsebody['flights'];
         adult = getCountbytravel('ADT',flight:responsebody['flights']);
         childern = getCountbytravel('CHD',flight:responsebody['flights'] );
         infans = getCountbytravel('INF',flight:responsebody['flights']);
         adultprice  =   getTotalepricebytravel('ADT',flight:responsebody['flights']);
         adultTaxes  =   getTotalTaxesbytravel('ADT',flight:responsebody['flights']);

         if (infans == 0) {
           infansprice = 0.0;
           infansTaxes = 0.0;
         } else {
           infansprice = getTotalepricebytravel('INF',flight:responsebody['flights']);
           infansTaxes = getTotalTaxesbytravel('INF',flight:responsebody['flights']);
         }
         if (childern == 0) {
           childernprice = 0.0;
           childernTaxes = 0.0;
         }else {
           childernprice = getTotalepricebytravel('CHD',flight:responsebody['flights']);
           childernTaxes = getTotalTaxesbytravel('CHD',flight:responsebody['flights']);
         }
         adultFees  = getTotalMarkupbytravel('ADT',flight: responsebody['flights']);

         if (infans == 0) {
           infansFees = 0.0;
         } else {
           infansFees = getTotalMarkupbytravel('INF',flight: responsebody['flights']);
         }
         if (childern == 0) {
           childernFees = 0.0;
         }else {
           childernFees = getTotalMarkupbytravel('CHD',flight: responsebody['flights']);
         }
         Loading =true;
         getServicesLoadiung = true;
         print(adult);
         print(adultTaxes);
         print(adultFees);
         emit(GetServicesSucessfulState(
           adult: adult,
           childern: childern,
           infans: infans,
           adultprice: adultprice,
           childernprice: childernprice,
           infansprice: infansprice,
           flight: responsebody,
           TotalPrice: TotalPrices,
           TotalTaxes: adultTaxes + childernTaxes + infansTaxes,
           adultTaxes:adultTaxes,
           childernTaxes:childernTaxes,
           infansTaxes:infansTaxes,
           TotalFees: adultFees + childernFees + infansFees,
           adultFee:adultFees,
           childernFee:childernFees,
           infansFee:infansFees,
           baggage:responsebody['baggage'],
           flightResult: reponseFlight,
         ));

       }).catchError((error) {
         print(error);
         getServicesLoadiung = true;
         emit(GetServicesErrorState(error.toString()));
       });

       return response;
     }else{
       emit(GetServicesSucessfulState());
     }

    }



  
// List bags = [];
 List<dynamic> bagsSelected;

Future getPrice(sequencenumbers,{List bags,List seatMap}) async {
    Map json = {
      "sequence_number": sequencenumbers
    };

    if(bags.length > 0 || seatMap.length > 0){
      json["services"] = {};
    }

    if(bags.length>0){
      json["services"]["bags"] = bags;
    }
    if(seatMap.length>0){
      json["services"]["seats"] = seatMap;
    }

    print('data:${json}');
    countryService.getPriceResult = {};
    emit(getPriceLoadingState());
    LoadingPrice =false;
    try {
        await http.post(Uri.parse('${baseurl}/api/v1/flights/get_price'),
            headers: {
              'Content-type': 'application/json',
              "Accept": "application/json",
              'authorization': 'Bearer ${tokenflight}',
              'Cookie': "${setcookie}",
              'Connection':'keep-alive'
            },
            body: jsonEncode(json)).then((response) {

     var responsebody = jsonDecode(response.body);

     print('=============================================');
     printFullText(json.toString());
     print('=============================================');


      countryService.getPriceResult = responsebody;
      countryService.flightbooking = responsebody['flights'];
      // countryService.flightbooking.forEach((element) {
      //       element['travelers'].forEach((e){
      //           countryService.bagsSelected = e['details'];
      //         e['details'].forEach((detail){
      //        detail['segmentsDetails'].forEach((segments_detail){
      //       segments_detail['includedCheckedBags'] = {};
      //      });
      //     print(countryService.bagsSelected);
      //
      //         });
      //       });
      //    });

     LoadingPrice =true;
     emit(getPriceSuccessState(
        adult: adult,
        childern: childern,
        infans: infans,
        adultprice: adultprice,
        childernprice: childernprice,
        infansprice: infansprice,
        flight: responsebody,
        TotalPrice: TotalPrices,
        TotalTaxes: adultTaxes + childernTaxes + infansTaxes,
        TotalFees: adultFees + childernFees + infansFees,
        adultFee:adultFees,
        childernFee:childernFees,
        infansFee:infansFees,
        bagsSelected:bagsSelected,
        getPriceResult:countryService.getPriceResult,
        bookingresult:responsebody,
        total:TotalPrices,
        sequence_number:sequence_number,
        price: price
      ));
    }).catchError((error) {
      print('=====================================================');
      printFullText('message is ${error.toString()}');
      print('=====================================================');
      emit(getPriceErrorState(error.toString(),message));
    });
    } catch (e) {
      print(e);
    }
    
  }


  Future BookingSafer(List travels,
   {
     sequencenumbers,
     FirstNameController,
     LastNameController,
     EmailController,
     StateNameController,
     CityNameController,
     PostNameController,
     AdressController,
     PhoneController,
     String CountryCode,
     String countryCallingCode
   }
  )
   async { 
    isLoading = false;
    emit(bookingLoadingState());
    var json ={
    "sequence_number":sequencenumbers,
    "travelers": travels,
     "contacts":{
      "email":"${EmailController}",
       "firstName":"${FirstNameController}",
       "lastName":"${LastNameController}",
        "phone":{
          "deviceType":"MOBILE",
          "countryCallingCode":"${countryCallingCode}",
          "number":"${PhoneController}"
        },
     },
};
    http.Response response = await http.post(Uri.parse('${baseurl}/api/v1/flights/book'),
            headers: {
              'Content-type':'application/json',
              "Accept":"application/json",
              'Cookie':"${setcookie}",
              'Connection':'keep-alive'
            },
            body:jsonEncode(json)
            ).then((response) async{
      var responsebody = jsonDecode(response.body);
      printFullText('${responsebody.toString()}');
      Cachehelper.saveData(key:'token', value:responsebody['customer']['token']);
      countryService.bookingid = responsebody['booking']['id'];
      getPaymentShop(
      booking_id:responsebody['booking']['id'],
      token:responsebody['customer']['token']
      );
      emit(bookingSuccessState(bookings:responsebody['items'],bookingResult:responsebody));

    }).catchError((error) {
      printFullText(error.toString());
      emit(bookingErrorState(error.toString()));
    });
    return response;
  }

String title;
String given_name;
String surname;
String email;
String phone_number;
String doc_issue_country;
String country;
String birth_date;
int id ;

Future getPaymentShop({int booking_id,token})async{
  emit(GetPaymentLoadingState());
  await http.post(
    Uri.parse('https://api.wadina.agency/api/v1/flights/payment_methods'),
    body:jsonEncode({"booking_id":booking_id}),
    headers:{'Content-Type':'application/json','Accept':'application/json','authorization': 'Bearer ${token}',},
  ).then((value) {
      isLoading = true;
      var responsebody = jsonDecode(value.body);
      print('-------------------------------------------->');
      countryService.transaction_id = responsebody['transaction_id'];
      printFullText(countryService.transaction_id.toString());
      print('-------------------------------------------->');
      emit(GetPaymentSucessfulState(
        PaymentMethods:responsebody['payment_methods'],
        bookingResult:countryService.bookingresult,
        ));
    }).catchError((error) {
      print(error.toString());
      emit(GetPaymentErrorState(error.toString()));
    });
  }


  Map<String, dynamic> Checkout;

  Future checkout(String payment_method,{BuildContext context,bookingId,transaction_id,token})async{
    emit(CheckoutLoadingState());
    var checkoutjson = {
      "booking_id":countryService.bookingid,
      "payment_method_slug":payment_method,
      "transaction_id":countryService.transaction_id
};


   return await http.post(
      Uri.parse('https://api.wadina.agency/api/v1/flights/checkout'),
      body:jsonEncode(checkoutjson),
      headers:{'Content-Type':'application/json','Accept':'application/json','authorization': 'Bearer ${token}',},
    ).then((value) {
      print({
        "booking_id":countryService.bookingid,
        "payment_method_slug":payment_method,
        "transaction_id":countryService.transaction_id
      });
     var responsebody = jsonDecode(value.body);
     print('checkout:${responsebody}');
     emit(CheckoutSuccessState(Checkout:responsebody['customerRedirectURL']));
     if (responsebody['customerRedirectURL']!=null){
    navigateTo(context,CreateTicketPayment(url:responsebody['customerRedirectURL']));
    emit(CheckoutSuccessState(Checkout:responsebody['customerRedirectURL']));
    }
    else{
      Checkout = responsebody;
      printFullText(Checkout.toString());
      emit(CheckoutSuccessState(Checkout:responsebody));
    }
    }).catchError((error) {
      print(error.toString());
      emit(CheckoutErrorState(error.toString()));
    });
  }






 Future getAirlineOperated({iata_code}){
  emit(getAirlineOperatedState());
  return DioHelper.getData(
      url: 'https://airlabs.co/api/v9/airlines',
     query: {
       "api_key":"76c2b920-5a11-4406-942e-f97f4d325eee",
       "iata_code":iata_code
     }
    ).then((value) {
      airline=[];
      countryService.airlines =[];
      requestSafer.airlines = [];
      airline = countryService.airlines = requestSafer.airlines = value.data['response'];
      // print('airline ${value.data['response']}');
      emit(getAirlineOperatedSucessfulState());
    }).catchError((error) {
      print(error.toString());
      emit(getAirlineOperatedErrorState(error.toString()));
    });
  }


  dynamic totalprice=0.0;

  double getTotalepricebytravel(String travelerType,{List flight}){
    totalprice =0.0;
    flight.forEach((flight) {
      totalprice =0.0;
    flight['travelers'].forEach((value){
        if (value['type'] == travelerType){
          print(value['price']['total']);
          totalprice = totalprice + value['price']['total'];
        }
      });
    });
    return totalprice;
    
  }
  double base = 0.0;

  double getbasebytravel(String travelerType,{List flight}){
    totalprice = 0.0;
    flight.forEach((flight) {
    flight['travelers'].forEach((value){
        if (value['type'] == travelerType){
          base = base + value['price']['base'];
        }
      });
    });
    return base;
    
  }
  dynamic totalFee = 0.0;
  dynamic totalMarkup = 0.0;
  dynamic totalservice_fee = 0.0;
  dynamic totalservice_fee_cedido = 0.0;

  dynamic getTotalMarkupbytravel(String travelerType,{List flight}){
    totalFee = 0.0;
    totalMarkup = 0.0;
    totalservice_fee = 0.0;
    totalservice_fee_cedido = 0.0;
    flight.forEach((flight) {
      totalFee = 0.0;
      totalMarkup = 0.0;
      totalservice_fee = 0.0;
      totalservice_fee_cedido = 0.0;
      flight['travelers'].forEach((value) {
        if (value['type'] == travelerType) {
           totalMarkup = totalMarkup + value['price']['markup'];
          // print('markup : ${value['price']['service_fee_cedido']}');
          // totalservice_fee = totalservice_fee + value['price']['service_fee'];
          // totalservice_fee_cedido = totalservice_fee_cedido + value['price']['service_fee_cedido'];
          // totalFee = totalservice_fee + totalservice_fee_cedido + totalMarkup;
          print(totalMarkup);
        }
      });
    });
    return totalMarkup;
  }
  dynamic getTotalService_fee_cedidobytravel(String travelerType,{List flight}){
    totalFee = 0.0;
    totalMarkup = 0.0;
    totalservice_fee = 0.0;
    totalservice_fee_cedido = 0.0;
    flight.forEach((flight) {
      totalFee = 0.0;
      totalMarkup = 0.0;
      totalservice_fee = 0.0;
      totalservice_fee_cedido = 0.0;
      flight['travelers'].forEach((value) {
        if (value['type'] == travelerType) {
           // totalMarkup = totalMarkup + value['price']['markup'];
          // print('markup : ${value['price']['service_fee_cedido']}');
          // totalservice_fee = totalservice_fee + value['price']['service_fee'];
          totalservice_fee_cedido = totalservice_fee_cedido + value['price']['service_fee_cedido'];
          // totalservice_fee = totalservice_fee_cedido + totalservice_fee_cedido + totalMarkup;
          print(totalservice_fee_cedido);
        }
      });
    });
    return totalservice_fee_cedido;
  }

  dynamic getService_fee_bytravel(String travelerType,{List flight}){
   totalFee = 0.0;
   totalMarkup = 0.0;
   totalservice_fee = 0.0;
   totalservice_fee_cedido = 0.0;
    flight.forEach((flight) {
   totalFee = 0.0;
   totalMarkup = 0.0;
   totalservice_fee = 0.0;
   totalservice_fee_cedido = 0.0;
      flight['travelers'].forEach((value) {
      if (value['type'] == travelerType) {
       // totalMarkup = totalMarkup + value['price']['markup'];
       // print('markup : ${value['price']['service_fee_cedido']}');
      totalservice_fee = totalservice_fee + value['price']['service_fee'];
      // totalservice_fee_cedido = totalservice_fee_cedido + value['price']['service_fee_cedido'];
      // totalFee = totalservice_fee + totalservice_fee_cedido + totalMarkup;
      print(totalFee);
      }
      });
    });
    return totalservice_fee;
  }

  double totalTaxes = 0.0;
  double getTotalTaxesbytravel(String travelerType,{List flight}) {
   totalTaxes = 0.0;
    flight.forEach((flight) {
       totalTaxes = 0.0;
      flight['travelers'].forEach((value) {
      if (value['type'] == travelerType) {
        if (value['price']['taxes']!=null) {
          for (var i = 0; i < value['price']['taxes'].length; i++) {
          totalTaxes = totalTaxes +  value['price']['taxes'][i]['amount'];
         }
          
        }else {
        totalTaxes = 0.0;
        }
      
    }
      });
    });
    return totalTaxes;
  }


  var count = 0;
  //  error here
  int getCountbytravel(String travelerType,{List flight}) {
    count = 0;
    flight[0]['travelers'].forEach((value){
      if (value['type'] == travelerType){
        count = count + 1;
      }
    });
    return count;
  }


Future checkoutSht(String payment_method,{BuildContext context}){
    
    emit(CheckoutLoadingState());
    var checkoutjson = {
      "booking_id":countryService.bookingid,
      "payment_method":"${payment_method}"
};
    print(checkoutjson);
   return DioHelper.postData(
      url: '${baseurl}/unipay_v2/public/api/checkout',
      data: {
      "booking_id":countryService.bookingid,
      "payment_method":"${payment_method}"
}
    ).then((value) {
    if (value.data['customerRedirectURL']!=null){
    navigateTo(context,CreateTicketPayment(url:value.data['customerRedirectURL']));
    emit(CheckoutSuccessState(Checkout:value.data['customerRedirectURL']));
    }
    else{
      Checkout = value.data;
      printFullText(value.data.toString());
      emit(CheckoutSuccessState(Checkout:value.data));
    }
   
    }).catchError((error) {
      print(error.toString());
      emit(CheckoutErrorState(error.toString()));
    });
  }
}
