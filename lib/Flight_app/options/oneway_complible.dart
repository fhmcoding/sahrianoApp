import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sahariano_travel/Flight_app/pages/reservations_page.dart';
import 'package:sahariano_travel/shared/components/components.dart';
import 'package:sahariano_travel/shared/components/constants.dart';

class OnewayComplible extends StatefulWidget {
  final List<dynamic> flightdepart;
  final List<dynamic> flightRetun;
  final List airline;
  final int currentIndex;
  final Widget showprice;
  var departPrice;
  var returnPrice;
  int selecteruture;
  int selectedepart;
  var operaitedby;
  int sequenceNumberdep;
  int sequenceNumberRetu;
  Map<String, dynamic>flightRetunOneWay;
  Map<String, dynamic>flightDepartOneWay;
   OnewayComplible({ Key key, this.flightdepart, this.flightRetun, this.airline, this.showprice, this.currentIndex, this.departPrice, this.returnPrice,this.selectedepart,this.selecteruture}) : super(key: key);

  @override
  _OnewayComplibleState createState() => _OnewayComplibleState();
}

class _OnewayComplibleState extends State<OnewayComplible> {

  List<dynamic> flightOneWay = [];
  

  
    airline(List airline,String logo){
                                
                                airline.forEach((value) { 
                                  if (value['iata_code']==logo) {
                                   widget.operaitedby = value['name']; 
                                  }
                                });
                                return widget.operaitedby;
                                 }
  @override
  Widget build(BuildContext context) {
    return Container(
                     height: 400,
                      color: bgColor,
                      child: Column(
                        children: [
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 0,right: 0,bottom: 0,top: 0),
                              child: Row(
                                children: [
                                  Container(
                                    height: 400,
                                    width: 325,
                                    color: bgColor,
                                    child: SingleChildScrollView(
                                      child: Padding(
                                         padding: const EdgeInsets.only(left: 5,right: 5,bottom: 0,top: 0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text('Select Depart :',style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold
                      )),
                                          ),
                                  ...widget.flightdepart.map((flight){
                                    return Column(
                                        children: [
                                    ...flight['options'].map((options) {
                                       int weight = flight['travelers'][0]['details'][0]['segments_details'][0]['includedCheckedBags']['weight'];
                                        String weightUnit = flight['travelers'][0]['details'][0]['segments_details'][0]['includedCheckedBags']['weightUnit'];
                                        int includedCheckedBags = flight['travelers'][0]['details'][0]['segments_details'][0]['includedCheckedBags']['quantity'];
                                     final arrivalDate = options['segments'][options['segments'].length - 1]['arrivalDateTime'];
                                     final departureAirport = options['segments'][0]['departureAirport'];
                                     final datedeparture = options['segments'][0]['departureDateTime'];
                                     final arrivalAirport = options['segments'][options['segments'].length - 1]['arrivalAirport'];
                                     final flightNumber = options['segments'][0]['flightNumber'];
                                     final arrivalAirportTerminal = options['segments'][options['segments'].length - 1]['arrivalAirportTerminal'];
                                     final departureAirportTerminal = options['segments'][0]['departureAirportTerminal'];
                                     final logo = flight['options'][0]['segments'][0]['marketingAirline'];
                                     final cabin = options['segments'][0]['cabin'];
                                     int stops =options['segments'].length - 1;
                                     var timedearival = DateTime.parse(arrivalDate);
                                     var Dateearival = DateTime.parse(arrivalDate);
                                     final arrivalDateTime = DateFormat('HH:mm').format(timedearival);
                                     final DatedaArival = DateFormat('yyyy-MM-dd').format(Dateearival);
                                     var dateedatedeparture = DateTime.parse(datedeparture);
                                     final datedepart = DateFormat('HH:mm').format(dateedatedeparture);
                                     final Datedateedatedeparture = DateFormat('yyyy-MM-dd').format(dateedatedeparture);
                                    
          
                                             return Container(
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
                                                   buildticketCard(
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
                                                     bagageCount: includedCheckedBags,
                                                     weight:weight,
                                                     weightUnit:weightUnit,
                                                     operaitedby:airline(widget.airline,logo)
                                                   ),
                                                    Padding(
                                           padding: const EdgeInsets.only(left: 10),
                                           child: Row(
                                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                             children: [
                                                Text('View details', 
                                                  style: TextStyle(
                                                  fontSize: 13,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w600),),
                                               Text('${flight['price']} MAD',
                                               style:TextStyle(
                                                    fontSize: 13,
                                                    color: appColor,
                                                    fontWeight: FontWeight.bold,
                                               ),),
                                               Radio(
                                                 value:flight['sequenceNumber'],
                                                groupValue:widget.selectedepart,
                                                onChanged: (value){
                                               setState(() {
                                                  widget.selectedepart = value;
                                                  widget.departPrice =  flight['price'];
                                                  widget.sequenceNumberdep =flight['sequenceNumber'];
                                                  widget.flightDepartOneWay =flight;
                                               });
                                               if (widget.selecteruture != null) {
                                                return widget.showprice;
                                              }
          
                                               })
                                             ],
                                           ),
                                         ),
                                                 ],
                                               ),
                                             );}),
                                            SizedBox(height: 10,)
                                        
                                        ],
                                    );
                                  }),
                                   ],
                                        ),
                                      ),
                                    ),
                                  ),
                                    SizedBox(width: 0.4,),
                                   Container(
                                    height: 400,
                                    width: 330,
                                     color: bgColor,
                                     child: SingleChildScrollView(
                                      child: Padding(
                                         padding: const EdgeInsets.only(left: 5,right: 5,bottom: 0,top: 0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text('Select Return :',style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold
                      )),
                                          ),
                                          ...widget.flightRetun.map((flight) {
                                    return Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                    ...flight['options'].map((options) {
                                        String includedCheckedBags = flight['travelers'][0]['details'][0]['segments_details'][0]['includedCheckedBags']['quantity'];
                                        int weight = flight['travelers'][0]['details'][0]['segments_details'][0]['includedCheckedBags']['weight'];
                                        String weightUnit = flight['travelers'][0]['details'][0]['segments_details'][0]['includedCheckedBags']['weightUnit'];
                                     final arrivalDate = options['segments'][options['segments'].length - 1]['arrivalDateTime'];
                                     final departureAirport = options['segments'][0]['departureAirport'];
                                     final datedeparture = options['segments'][0]['departureDateTime'];
                                     final arrivalAirport = options['segments'][options['segments'].length - 1]['arrivalAirport'];
                                     final flightNumber = options['segments'][0]['flightNumber'];
                                     final arrivalAirportTerminal = options['segments'][options['segments'].length - 1]['arrivalAirportTerminal'];
                                     final departureAirportTerminal = options['segments'][0]['departureAirportTerminal'];
                                     final logo =flight['options'][0]['segments'][0]['marketingAirline'];
                                     final cabin = options['segments'][0]['cabin'];
                                     int stops =options['segments'].length - 1;
                                     var timedearival = DateTime.parse(arrivalDate);
                                     var Dateearival = DateTime.parse(arrivalDate);
                                     final arrivalDateTime = DateFormat('HH:mm').format(timedearival);
                                     final DatedaArival = DateFormat('yyyy-MM-dd').format(Dateearival);
                                     var dateedatedeparture = DateTime.parse(datedeparture);
                                        final datedepart = DateFormat('HH:mm').format(dateedatedeparture);
                                        final Datedateedatedeparture = DateFormat('yyyy-MM-dd').format(dateedatedeparture);
                                        return Container(
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
                                                   buildticketCard(
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
                                                     weightUnit:weightUnit,
                                                     operaitedby:airline(widget.airline, logo)
                                                   ),
                                                    Padding(
                                           padding: const EdgeInsets.only(left: 10),
                                           child: Row(
                                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                             children: [
                                               
                                                Text('View details', 
                                                  style: TextStyle(
                                                  fontSize: 13,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w600),),
                                               Text('${flight['price']} MAD',
                                               style:TextStyle(
                                                    fontSize: 13,
                                                    color: appColor,
                                                    fontWeight: FontWeight.bold,
                                               ),),
                                               Radio(value: flight['sequenceNumber'],
                                                groupValue: widget.selecteruture,
                                                 onChanged: (value){
                                                setState(() {
                                                  
                                                  widget.selecteruture = value;
                                                  widget.returnPrice = flight['price'];
                                                  widget.sequenceNumberRetu =flight['sequenceNumber'];
                                                  widget.flightRetunOneWay = flight;
                                                  
                                                 
                                                  printFullText(widget.flightRetunOneWay.toString());
                                                });
                                                 if (widget.selectedepart != null) {
                                                return widget.showprice;
                                              }
                                               })
                                             ],
                                           ),
                                         ),
                                        
                                                 ],
                                               ),
                                             );}),
                                          SizedBox(height: 10,),
                                        
                                         
                                        ],
                                    );
                                  }),
                                  
          
                                             
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    );
  }
}