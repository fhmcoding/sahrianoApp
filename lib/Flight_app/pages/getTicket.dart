import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:sahariano_travel/layout/cubit/cubit.dart';
import 'package:sahariano_travel/layout/home.dart';
import 'package:sahariano_travel/shared/components/components.dart';
import 'package:sahariano_travel/shared/components/constants.dart';

class GetTicket extends StatefulWidget {
final  List <dynamic> bookingRest;
final  Map<String, dynamic> bookingResult;

final List<dynamic> airliens;
final  List travelers;
final  dynamic total;

  const GetTicket({Key key, this.bookingRest, this.airliens,this.travelers, this.total, this.bookingResult}) : super(key: key);

  @override
  _GetTicketState createState() => _GetTicketState();
}

class _GetTicketState extends State<GetTicket> {
  booking_tickets(){
    List tickets = [];
    widget.bookingResult['booking']['items'].forEach((flight)=>{
      flight['tickets'].forEach((ticket)=>{
        if(!tickets.any((myTicket) =>myTicket['traveller']['id']==ticket['traveller']['id'])){
          tickets.add(ticket)
        }
      })
    });
    return tickets;
  }
    var operaitedby;
   airline(List airline,String logo){
                                
                                airline.forEach((value) { 
                                  if (value['iata_code']==logo) {
                                   operaitedby = value['name']; 
                                  }
                                });
                                return operaitedby;
                                 }
                                 
Format({date1}){
    final Date1 = DateTime.parse(date1);
    return DateFormat('yyyy-MM-dd').format(Date1);  
 }
 @override
  void initState() {
   booking_tickets();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar:Container(
                                   height: 80,
                                   width: double.infinity,
                                   color: Colors.white,
                                   child: Padding(
                                     padding: const EdgeInsets.only(left: 20,right: 20,top: 13,bottom: 13),
                                     child: GestureDetector(
                                       onTap: (){
                                         Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>Home(Index: 0)), (route) => false);
                                       },
                                       child: Container(
                                         height: 45,
                                         width: double.infinity,
                                         decoration: BoxDecoration(
                                            color:appColor,
                                           borderRadius: BorderRadius.circular(5)
                                         ),
                                        child: Center(child: Text('Back to Home',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 16),)),
                                       ),
                                     ),
                                   ),
                                 ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 15,right: 15,top: 55),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                   Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     mainAxisAlignment: MainAxisAlignment.start,
                     children: [
                     Text('MOROCCO',style: TextStyle(fontSize: 10)),
                     Text('Phone: +212.528.9999999+',style: TextStyle(fontSize: 10)),
                     Text('Date Reservation : ${Format(date1:widget.bookingResult['booking']['created_at'])}',style: TextStyle(fontSize: 10)),
                     ],
                   ),
                   Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     mainAxisAlignment: MainAxisAlignment.start,
                     children: [
                      Text('EL SAHARIANO TRAVEL',style: TextStyle(fontSize: 10)),
                      Text('AV MEKKA EN FACE CTM',style: TextStyle(fontSize: 10)),
                      Text('LAAYOUNE',style: TextStyle(fontSize: 10)),
                     ],
                   ),
                  ],
                ),
              ),
               SizedBox(height: 10,),
               Container(
                      height: 100,
                      width:double.infinity,
                     decoration: BoxDecoration(
                       boxShadow:[
                         BoxShadow(
                                            blurRadius: 4,
                                            color: Colors.grey[350],
                                            offset: Offset(0, 0),
                                            spreadRadius: 1)
                         ],
                       color: Colors.white,
                       borderRadius: BorderRadius.circular(5),
                       border: Border.all(
                         color: Colors.grey,
                         width: 1
                       )
                     ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15,right: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Booking Id',style: TextStyle(color: Colors.grey,fontSize: 15,fontWeight: FontWeight.w600)),
                                Text('${widget.bookingResult['booking']['id']}',style: TextStyle(color:appColor,fontSize: 16,fontWeight: FontWeight.bold)),
                              ],
                            ),
                            SizedBox(height: 10,),
                             Row(
                               crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Total Price',style: TextStyle(color: Colors.grey,fontSize: 15,fontWeight: FontWeight.w600)),
                                Text('${widget.total} MAD',style: TextStyle(color:appColor,fontSize: 16,fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),

                     Padding(
                        padding: const EdgeInsets.only(left: 0,right: 0,top: 20),
                        child: Text('Flight Ticket :',
                            style: TextStyle(
                                color: Color(0xFF38444a),
                                fontSize: 15,
                                fontWeight: FontWeight.w600)),
                      ),

                   Padding(
                           padding: const EdgeInsets.only(left: 0,right: 0,top: 20),
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
                                 printFullText(item.toString());
                                 return Stack(
                               children: [
                                 ...item['options'].map((option){
                                    // int weight = item['travelers'][0]['details']!=null? item['travelers'][0]['details'][0]['segments_details'][0]['includedCheckedBags']['weight']:null;
                                   // String weightUnit =item['travelers'][0]['details']!=null? item['travelers'][0]['details'][0]['segments_details'][0]['includedCheckedBags']['weightUnit']:null;
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
                                           weight: null,
                                           weightUnit: null,
                                           pnr:item['pnr'],
                                           operaitedby:airline(widget.airliens, logo),
                                         );}),
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
                   SizedBox(height: 15,),

                   // Container(
                   //   child: Row(
                   //     children: [
                   //       Column(
                   //         mainAxisAlignment: MainAxisAlignment.start,
                   //         crossAxisAlignment: CrossAxisAlignment.start,
                   //         children: [
                   //           Row(
                   //             children: [
                   //               Text('Hamid Fahmi'),
                   //               SizedBox(width: 5),
                   //               Text('ADT')
                   //             ],
                   //           ),
                   //           Text('Flights'),
                   //           Text('Ory - Nce'),
                   //         ],
                   //       ),
                   //       SizedBox(width: 10),
                   //       Column(
                   //         mainAxisAlignment: MainAxisAlignment.start,
                   //         crossAxisAlignment: CrossAxisAlignment.start,
                   //         children: [
                   //           Row(
                   //             children: [
                   //               Text('Hamid Fahmi'),
                   //               SizedBox(width: 5),
                   //               Text('ADT')
                   //             ],
                   //           ),
                   //           Text('Flights'),
                   //           Text('Ory - Nce'),
                   //         ],
                   //       ),
                   //
                   //     ],
                   //   ),
                   // ),

              Padding(
                padding: const EdgeInsets.only(left: 0),
                child: Text('Travelers Info :',
                    style: TextStyle(
                        color: Color(0xFF38444a),
                        fontSize: 15,
                        fontWeight: FontWeight.w600)),
              ),

              ...booking_tickets().map((traveler){
                return Padding(
                  padding: const EdgeInsets.only(left: 0,right: 0,top: 10,bottom: 10),
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
                          Row(
                              mainAxisAlignment:MainAxisAlignment.spaceBetween,
                              children: [
                            Text('${traveler['traveller']['surname']} ${traveler['traveller']['given_name']}',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 14),),
                            SizedBox(width: 5),
                            Text(travels(traveler['traveller']['type']),style: TextStyle(fontWeight: FontWeight.w700,fontSize: 10),)
                          ]),
                          SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment:MainAxisAlignment.spaceBetween,
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
                                    ...widget.bookingResult['booking']['items'].map((e){
                                      return Column(
                                        children:[
                                          ...e['options'].map((option){
                                            final departureAirport = option['segments'][0]['departureAirport'];
                                            final arrivalAirport = option['segments'][option['segments'].length - 1]['arrivalAirport'];
                                            return Text('${departureAirport}-${arrivalAirport}',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 12),);
                                          })
                                        ],
                                      );
                                    }),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment:MainAxisAlignment.spaceBetween,
                            crossAxisAlignment:CrossAxisAlignment.start,
                            children: [
                              Text('Baggages : ',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 14),),
                              SizedBox(width: 5),
                              ...traveler['baggage'].map((e){
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(FontAwesomeIcons.suitcase,size: 12, color: appColor),
                                    SizedBox(width: 3,),
                                    Text('${double.parse(e['quantity']).toStringAsFixed(0)}',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 12,color:Color(0xFFed6905)),),
                                  ],
                                );
                              })
                            ],
                          ),
                          SizedBox(height: 10,),
                          traveler['seats'].length>0? Row(
                            mainAxisAlignment:MainAxisAlignment.spaceBetween,
                            crossAxisAlignment:CrossAxisAlignment.start,
                            children: [
                              Text('Seats : ',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 14),),
                              SizedBox(width: 5),
                              ...traveler['seats'].map((e){
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(Icons.chair_outlined,size: 12, color: appColor),
                                    SizedBox(width: 3,),
                                    Text('${e['code']}',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 12,color:Color(0xFFed6905)),),
                                  ],
                                );
                              }),
                            ],
                          ):SizedBox(height:0),

                        ],
                      ),
                    ),
                  ),
                );
              }),


        ],
          ),
        ),
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