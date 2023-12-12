import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
class CountryService{
  Map serviceFee={};
  int adults = 1;
  int childerns = 0;
  int infants = 0;
  int total = 0;
  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var telephoneController ;
  var numberController;
  var Expirydate;
  var email;
  var birthPlace;
  var dateofbirth;
  var birthCountry;
  var nationality;
  var issuanceDate;
  var issuanceCountry;
  var selecedepart;
  var selecedretur;
  String depart;
  var departureDate;
  var retureDate;
  bool addOneWayOffers = true;
  var subnameair;
String datedepart;
String datereturn;
int bookingid;
int transaction_id;
int bookingidPnr;
List search=[];
Map<String, dynamic> params;
Map<String, dynamic> bookingresult;
List<dynamic> booking=[];
List<dynamic> sub=[];
List<dynamic> pro=[];
Map<String, dynamic> bookinBackend;
List<dynamic> itemsCartAtay = [];
List<dynamic> itemsCartParfum = [];
List<dynamic> itemsCart = [];
List<dynamic> brandProduct;
String Cabin = 'Economy';
List<dynamic> SlidersAtay=[];
List<dynamic> SlidersParfum=[];
List<dynamic> categoriesatay = [];
List<dynamic> categoriesparfum=[];
List<dynamic> productsParfum=[];
List<dynamic> productsAtay=[];
List<dynamic> brandsAtay =[];
List<dynamic> brandsParfum =[];
List<dynamic> imagesataycom =[];
String genderataycom;
String subnameataycom = '';
List<dynamic> itemsataycom =[];
int varition_idataycom;
String genderparfum;
String subnameparfum = '';
List<dynamic> itemsparfum =[];
int varition_idparfum;
List<dynamic> imagesparfum=[];
List<dynamic> travelers=[];
Map<String, dynamic> getPriceResult;
List<dynamic> bagsSelected ;
List<String>categorie=[];
List<dynamic> flightbooking=[];
List<dynamic> flightoneWay=[];
int indexId = 0;
int id;
String pnr;
DateTime Depart;
DateTime Return;
Map<String, dynamic> customer;
String tokenFlight;
List<dynamic> bags =[];
Map TotalPrice;

final _dio = new Dio();
Future getSearchAir(String query)async{
  search = [];
 try {
   final url = 'https://elsahariano.com/v2//airports/getAirports?term=${query}';
   final response = await _dio.get(url);
   search = response.data;
   return response;
 } catch (e) {
   print(e);
   return [];
 }
  } 
  
 List<dynamic> airlines = [];
var operaitedby;
  airline(List airline,String logo){
                                
                                airline.forEach((value) { 
                                  if (value['iata_code']==logo) {
                                   operaitedby = value['name']; 
                                  }
                                });
                                return operaitedby;
                                 }

}