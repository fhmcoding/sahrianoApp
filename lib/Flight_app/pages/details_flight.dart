import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sahariano_travel/Flight_app/cubit_flight/cubit.dart';
import 'package:sahariano_travel/Flight_app/cubit_flight/states.dart';
import 'package:sahariano_travel/Flight_app/pages/reservations_page.dart';
import 'package:sahariano_travel/shared/components/components.dart';
import 'package:sahariano_travel/shared/components/constants.dart';
import 'dart:async';

class DetailsFlight extends StatefulWidget {
  final String departureAirport;
  final String arrivalAirport;
  final String departureDateTime;
  final String arrivalDateTime;
  final String departureDate;
  final String price;
  final String opertedby;
  final String image;
  final int currentIndex;
  final Map<String, dynamic> flights;
  final Timer timer;
  DetailsFlight(
      {Key key,
      this.departureAirport,
      this.arrivalAirport,
      this.departureDateTime,
      this.arrivalDateTime,
      this.departureDate,
      this.price,
      this.image,
      this.flights, this.currentIndex, this.opertedby, this.timer,})
      : super(key: key);

  @override
  _DetailsFlightState createState() => _DetailsFlightState();
}

class _DetailsFlightState extends State<DetailsFlight> {
  Map<String, dynamic> flightResult;
  Map<String, dynamic> baggage;
  List flightsht=[];
  var totalprice = 0.0;

  // double getTotalepricebytravel(String travelerType) {
  //    totalprice = 0.0;
  //    flightResult['travelers'].forEach((value) {
  //      if (value['travelerType'] == travelerType){
  //         if (value['price']['taxes']!=null) {
  //            for (var i = 0; i < value['price']['taxes'].length; i++) {
  //       totalprice = totalprice + double.parse(value['price']['taxes'][i]['amount']);
  //      }
  //         }else {
  //       totalprice = 0.0;
  //       }
      
  //     }
  //   });
  //   return totalprice;
  // }
  dynamic totalFee = 0.0;
  dynamic totalMarkup = 0.0;
  dynamic totalservice_fee_cedido = 0.0;
  dynamic totalTaxes = 0.0;
  dynamic totalservice_fee = 0.0;


dynamic getTotalMarkupbytravel(String travelerType,){
   if(flightResult!=null){
     totalservice_fee = 0.0;
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

dynamic getTotalService_fee_sedidobytravel(String travelerType,){
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

dynamic getTotalTaxesbytravel(String travelerType,){
   totalTaxes = 0.0;
   if(flightResult!=null){
     flightResult['travelers'].forEach((value) {
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
   }else{
     widget.flights['travelers'].forEach((value) {
       if (value['type'] == travelerType) {
         if (value['price']['taxes']!=null) {
           for (var i = 0; i < value['price']['taxes'].length; i++) {
             print(value['price']['taxes'][i]['amount']);
             totalTaxes = totalTaxes +  value['price']['taxes'][i]['amount'];
           }

         }else {
           totalTaxes = 0.0;
         }

       }
     });
   }
   return totalTaxes;
  }


  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (BuildContext context) => FlightCubit()..getServices(sequencenumbers:[widget.flights['sequenceNumber']],providerType:widget.flights['providerType'],flight: flightsht),
      child: BlocConsumer<FlightCubit, FlightStates>(
        listener: (context, state) {
         if (state is GetServicesSucessfulState){
             flightResult = state.flightResult;
             baggage = state.baggage;
          }
        },
        builder: (context, state) {
          var flightCubit = FlightCubit.get(context);
          return Scaffold(
            bottomNavigationBar: Container(
              height: 85,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(0),
                boxShadow: [
                  BoxShadow(
                      blurRadius: 3,
                      color: Colors.grey[350],
                      offset: Offset(3, 4),
                      spreadRadius: 6)
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 25, right: 25, top: 15, bottom: 15),
                child: GestureDetector(
                  onTap: () {
                   navigateTo(
                          context,
                          ReservationPage(
                            timer: widget.timer,
                            providerType:widget.flights['providerType'],
                          currentIndex: widget.currentIndex,
                            flights: widget.flights,
                             totalPrice:widget.flights['price'] ,
                            sequence_number:[widget.flights['sequenceNumber']],
                          ));
                    
                  },
                  child: Container(
                    height: 55,
                    decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(5),
                        color: Color(0xFFF28300)),
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Checkout',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '${widget.flights['price']} MAD',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ),
            ),
            backgroundColor: Colors.white,
            appBar: AppBar(
              centerTitle: true,
              elevation: 0.5,
              backgroundColor: Colors.white,
              leading: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.arrow_back, color: Colors.black)),
              title: Text('Ticket details',
                  style: TextStyle(color: appColor, fontSize: 20)),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 10, left: 15, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children:[
                    // Padding(
                    //   padding: const EdgeInsets.all(8.0),
                    //   child: Text('flight details',style: TextStyle(fontSize: 17,fontWeight: FontWeight.w600,color:Colors.black),),
                    // ),
                    flightCubit.getServicesLoadiung ? Column(
                      children: [
                        flightResult!=null?  Column(
                          children: [
                             ...flightResult['options'].map((option) {
                           return ListView.builder(
                             shrinkWrap: true,
                             physics: NeverScrollableScrollPhysics(),
                             itemCount:option['segments'].length,
                             itemBuilder: (context, index) {
                               final deprtureDate =option['segments'][index]['departureDateTime'];
                                final arrivalDate = option['segments'][index]['arrivalDateTime'];
                                  var datededepart = DateTime.parse(deprtureDate);
                                 final departuredate =  DateFormat.MMMMEEEEd().format(datededepart);
                                var datedearival = DateTime.parse(arrivalDate);
                                final ArrivalDate =  DateFormat('dd-MM-yyyy').format(datedearival);
                               final departureDate = option['segments'][index]['departureDateTime'];
                               var timedepar = DateTime.parse(departureDate);
                               final departureDateTime = DateFormat('HH:mm').format(timedepar);
                                final arivaltime = option['segments'][index]['arrivalDateTime'];
                                final departDate =  DateFormat('dd-MM-yyyy').format(timedepar);
                               var arivalTime = DateTime.parse(arivaltime);
                               final ArivalDateTime = DateFormat('HH:mm').format(arivalTime);
                                final logo =flightResult['options'][0]['segments'][0]['marketingAirline'];
                               int stops =option['segments'].length - 1;

                             return Padding(
                             padding: const EdgeInsets.all(8.0),
                             child: Column(
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: [
                                 Text('Flight to ${option['segments'][index]['departureAirport']} - ${option['segments'][index]['arrivalAirport']}',
                                     style: TextStyle(
                                         color: Colors.black,
                                         fontSize: 16,
                                         fontWeight: FontWeight.bold)),
                                 SizedBox(
                                   height: 15,
                                 ),
                                 Container(
                                     decoration: BoxDecoration(
                                     boxShadow: [
                                       BoxShadow(
                                           blurRadius: 2.8,
                                           color: Color(0xFFF28300),
                                           offset: Offset(0, 0),
                                           spreadRadius: 0)
                                     ],
                                     borderRadius: BorderRadius.circular(10),
                                     color: Colors.white,
                                   ),
                                   width: double.infinity,
                                   child: Column(
                                     crossAxisAlignment: CrossAxisAlignment.start,
                                     mainAxisAlignment: MainAxisAlignment.start,
                                     children: [
                                       Container(
                                         height: 45,
                                         decoration: BoxDecoration(
                                           gradient: LinearGradient(
                                             begin: Alignment.bottomCenter,
                                             end: Alignment.topCenter,
                                             colors: [
                                               Color.fromARGB(255, 255, 185, 106),
                                               Color.fromARGB(255, 255, 137, 1),
                                             ],
                                           ),
                                             // boxShadow: [
                                             // BoxShadow(
                                             //       blurRadius: 2.8,
                                             //       color: Color(0xFFF28300),
                                             //       offset: Offset(0, 0),
                                             //       spreadRadius: 0)
                                             // ],
                                             color: Color(0xFFF28300),
                                             borderRadius: BorderRadius.only(
                                               bottomLeft: Radius.circular(0),
                                               bottomRight: Radius.circular(0),
                                               topLeft: Radius.circular(11),
                                               topRight: Radius.circular(11),
                                             )),
                                         width: double.infinity,
                                         child: Padding(
                                           padding: const EdgeInsets.only(
                                               left: 15, right: 15),
                                           child:
                                           Row(
                                             children: [
                                               Text('${option['segments'][index]['departureAirport']} - ${option['segments'][index]['arrivalAirport']}',
                                                   style: TextStyle(
                                                       color: Colors.white,
                                                       fontWeight: FontWeight.bold,
                                                       fontSize: 15)),

                                                       Padding(
                                                         padding: const EdgeInsets.only(top: 8,left:20 ),
                                                         child: Column(
                                                           crossAxisAlignment: CrossAxisAlignment.start,
                                                           mainAxisAlignment: MainAxisAlignment.start,
                                                           children: [
                                                             Text('${departuredate}', style: TextStyle(
                                                       color: Colors.white,
                                                       fontWeight: FontWeight.bold,
                                                       fontSize: 13)),
                                                        SizedBox(height: 3,),
                                                             Row(
                                                               children: [
                                                                 Text(stops!=0?'${stops} stop':'non-stop', style: TextStyle(
                                                       color: Colors.white,
                                                       fontWeight: FontWeight.bold,
                                                       fontSize: 11)),
                                                       SizedBox(width: 12,),
                                                       Container(height: 10,color: Colors.white,width:1,),
                                                       SizedBox(width: 12,),
                                                      option['segments'][index]['duration']!=null?Text('${option['segments'][index]['duration']}', style: TextStyle(
                                                       color: Colors.white,
                                                       fontWeight: FontWeight.bold,
                                                       fontSize: 11)):Text('${option['duration'].replaceAll("PT", "")}', style: TextStyle(
                                                       color: Colors.white,
                                                       fontWeight: FontWeight.bold,
                                                       fontSize: 11)),
                                                               ],
                                                             ),
                                                           ],
                                                         ),
                                                       ),
                                             ],
                                           ),
                                         ),
                                       ),


                                       // SizedBox(height: 15),
                                       Padding(
                                         padding: const EdgeInsets.only(left: 18,right: 18,top: 10,bottom: 10),
                                         child: Row(
                                           children: [
                                             Column(
                                               mainAxisAlignment: MainAxisAlignment.start,
                                               crossAxisAlignment: CrossAxisAlignment.start,
                                               children: [
                                                 Column(
                                                   mainAxisAlignment: MainAxisAlignment.start,
                                                   crossAxisAlignment: CrossAxisAlignment.start,
                                                   children: [
                                                     Text('${departDate}',style: TextStyle(color: appColor,fontWeight: FontWeight.bold,fontSize: 11)),
                                                      Text('${departureDateTime}',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 14)),
                                                   ],
                                                 ),
                                                  SizedBox(height: 20,),
                                                 option['segments'][index]['duration']!=null? Text('${option['segments'][index]['duration'].replaceAll("PT", "")}',style: TextStyle(fontSize: 11)): Text('${option['duration'].replaceAll("PT", "")}',style: TextStyle(fontSize: 11)),
                                                   SizedBox(height: 20,),
                                                   Column(
                                                     mainAxisAlignment: MainAxisAlignment.start,
                                                     crossAxisAlignment: CrossAxisAlignment.start,
                                                     children: [
                                                      Text('${ArrivalDate}',style: TextStyle(color: appColor,fontWeight: FontWeight.bold,fontSize: 11)),
                                                      Text('${ArivalDateTime}',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 14)),
                                                     ],
                                                   ),
                                               ],
                                             ),
                                             SizedBox(width: 10,),
                                             Column(children: [
                                                SizedBox(height: 10,),
                                               Padding(
                                                 padding: const EdgeInsets.only(left: 5),
                                                 child: Transform.rotate(
                               angle: 0.6,
                               child: Icon(
                                 Icons.local_airport,
                                 color: Color(0xFFF28300),
                                 size: 17,
                               ),
                             ),
                                               ),
                                               Container(
                                                 height: 70,
                                                 width: 2,
                                                 color: Color.fromARGB(255, 255, 137, 1),
                                               ),
                                                Padding(
                                                 padding: const EdgeInsets.only(left: 5),
                                                 child: Transform.rotate(
                               angle: 2.6,
                               child: Icon(
                                 Icons.local_airport,
                                 color: Color(0xFFF28300),
                                 size: 17,
                               ),
                             ),
                                               ),
                                             ],),
                                             SizedBox(width: 15,),
                                              Column(
                                               mainAxisAlignment: MainAxisAlignment.start,
                                               crossAxisAlignment: CrossAxisAlignment.start,
                                               children: [
                                                 SizedBox(height: 10,),
                                                 Row(
                                                   children: [
                                                     Text('${option['segments'][index]['departureAirport']}',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 15)),
                                                     SizedBox(width: 8,),
                                                   ],
                                                 ),
                                                  SizedBox(height: 26,),
                                                  Column(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                        Row(
                                                               children: [
                                                                 Text('${option['segments'][index]['cabin']}', style: TextStyle(
                                                       color: Colors.black,
                                                       fontWeight: FontWeight.bold,
                                                       fontSize: 11)),
                                                       SizedBox(width: 12,),
                                                       Container(height: 10,color: Colors.black,width:1,),
                                                       SizedBox(width: 12,),
                                                        Text('${logo}${option['segments'][index]['flightNumber']}', style: TextStyle(
                                                       color: Colors.black,
                                                       fontWeight: FontWeight.bold,
                                                       fontSize: 11)),
                                                               ],
                                                             ),
                                                            SizedBox(height: 5,),
                                                           Text('Operated By ${widget.opertedby}',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 8)),

                                                    ],
                                                  ),
                                                   SizedBox(height: 20,),
                                                   Row(
                                                     children: [
                                                       Text('${option['segments'][index]['arrivalAirport']}',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 15)),
                                                       SizedBox(width: 8,),
                                                     ],
                                                   ),
                                               ],
                                             ),
                                           ],
                                         ),
                                       ),
                                     ],
                                   ),

                                 ),

                               ],
                             ),
                           );
                           });
                         }),
                          ],
                        ):Column(
                          children: [
                            ...widget.flights['options'].map((option) {
                              return ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount:option['segments'].length,
                                  itemBuilder: (context, index) {
                                    final deprtureDate =option['segments'][index]['departureDateTime'];
                                    final arrivalDate = option['segments'][index]['arrivalDateTime'];
                                    var datededepart = DateTime.parse(deprtureDate);
                                    final departuredate =  DateFormat.MMMMEEEEd().format(datededepart);
                                    var datedearival = DateTime.parse(arrivalDate);
                                    final ArrivalDate =  DateFormat('dd-MM-yyyy').format(datedearival);
                                    final departureDate = option['segments'][index]['departureDateTime'];
                                    var timedepar = DateTime.parse(departureDate);
                                    final departureDateTime = DateFormat('HH:mm').format(timedepar);
                                    final arivaltime = option['segments'][index]['arrivalDateTime'];
                                    final departDate =  DateFormat('dd-MM-yyyy').format(timedepar);
                                    var arivalTime = DateTime.parse(arivaltime);
                                    final ArivalDateTime = DateFormat('HH:mm').format(arivalTime);
                                    final logo =widget.flights['options'][0]['segments'][0]['marketingAirline'];
                                    int stops =option['segments'].length - 1;

                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('Flight to ${option['segments'][index]['departureAirport']} - ${option['segments'][index]['arrivalAirport']}',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold)),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                    blurRadius: 2.8,
                                                    color: Color(0xFFF28300),
                                                    offset: Offset(0, 0),
                                                    spreadRadius: 0)
                                              ],
                                              borderRadius: BorderRadius.circular(10),
                                              color: Colors.white,
                                            ),
                                            width: double.infinity,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Container(
                                                  height: 45,
                                                  decoration: BoxDecoration(
                                                      gradient: LinearGradient(
                                                        begin: Alignment.bottomCenter,
                                                        end: Alignment.topCenter,
                                                        colors: [
                                                          Color.fromARGB(255, 255, 185, 106),
                                                          Color.fromARGB(255, 255, 137, 1),
                                                        ],
                                                      ),
                                                      // boxShadow: [
                                                      // BoxShadow(
                                                      //       blurRadius: 2.8,
                                                      //       color: Color(0xFFF28300),
                                                      //       offset: Offset(0, 0),
                                                      //       spreadRadius: 0)
                                                      // ],
                                                      color: Color(0xFFF28300),
                                                      borderRadius: BorderRadius.only(
                                                        bottomLeft: Radius.circular(0),
                                                        bottomRight: Radius.circular(0),
                                                        topLeft: Radius.circular(11),
                                                        topRight: Radius.circular(11),
                                                      )),
                                                  width: double.infinity,
                                                  child: Padding(
                                                    padding: const EdgeInsets.only(
                                                        left: 15, right: 15),
                                                    child:
                                                    Row(
                                                      children: [
                                                        Text('${option['segments'][index]['departureAirport']} - ${option['segments'][index]['arrivalAirport']}',
                                                            style: TextStyle(
                                                                color: Colors.white,
                                                                fontWeight: FontWeight.bold,
                                                                fontSize: 15)),

                                                        Padding(
                                                          padding: const EdgeInsets.only(top: 8,left:20 ),
                                                          child: Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            children: [
                                                              Text('${departuredate}', style: TextStyle(
                                                                  color: Colors.white,
                                                                  fontWeight: FontWeight.bold,
                                                                  fontSize: 13)),
                                                              SizedBox(height: 3,),
                                                              Row(
                                                                children: [
                                                                  Text(stops!=0?'${stops} stop':'non-stop', style: TextStyle(
                                                                      color: Colors.white,
                                                                      fontWeight: FontWeight.bold,
                                                                      fontSize: 11)),
                                                                  SizedBox(width: 12,),
                                                                  Container(height: 10,color: Colors.white,width:1,),
                                                                  SizedBox(width: 12,),
                                                                  option['segments'][index]['duration']!=null?Text('${option['segments'][index]['duration']}', style: TextStyle(
                                                                      color: Colors.white,
                                                                      fontWeight: FontWeight.bold,
                                                                      fontSize: 11)):Text('${option['duration'].replaceAll("PT", "")}', style: TextStyle(
                                                                      color: Colors.white,
                                                                      fontWeight: FontWeight.bold,
                                                                      fontSize: 11)),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),


                                                // SizedBox(height: 15),
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 18,right: 18,top: 10,bottom: 10),
                                                  child: Row(
                                                    children: [
                                                      Column(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Column(
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              Text('${departDate}',style: TextStyle(color: appColor,fontWeight: FontWeight.bold,fontSize: 11)),
                                                              Text('${departureDateTime}',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 14)),
                                                            ],
                                                          ),
                                                          SizedBox(height: 20,),
                                                          option['segments'][index]['duration']!=null? Text('${option['segments'][index]['duration'].replaceAll("PT", "")}',style: TextStyle(fontSize: 11)): Text('${option['duration'].replaceAll("PT", "")}',style: TextStyle(fontSize: 11)),
                                                          SizedBox(height: 20,),
                                                          Column(
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              Text('${ArrivalDate}',style: TextStyle(color: appColor,fontWeight: FontWeight.bold,fontSize: 11)),
                                                              Text('${ArivalDateTime}',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 14)),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(width: 10,),
                                                      Column(children: [
                                                        SizedBox(height: 10,),
                                                        Padding(
                                                          padding: const EdgeInsets.only(left: 5),
                                                          child: Transform.rotate(
                                                            angle: 0.6,
                                                            child: Icon(
                                                              Icons.local_airport,
                                                              color: Color(0xFFF28300),
                                                              size: 17,
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          height: 70,
                                                          width: 2,
                                                          color: Color.fromARGB(255, 255, 137, 1),
                                                        ),
                                                        Padding(
                                                          padding: const EdgeInsets.only(left: 5),
                                                          child: Transform.rotate(
                                                            angle: 2.6,
                                                            child: Icon(
                                                              Icons.local_airport,
                                                              color: Color(0xFFF28300),
                                                              size: 17,
                                                            ),
                                                          ),
                                                        ),
                                                      ],),
                                                      SizedBox(width: 15,),
                                                      Column(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          SizedBox(height: 10,),
                                                          Row(
                                                            children: [
                                                              Text('${option['segments'][index]['departureAirport']}',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 15)),
                                                              SizedBox(width: 8,),
                                                            ],
                                                          ),
                                                          SizedBox(height: 26,),
                                                          Column(
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  Text('${option['segments'][index]['cabin']}', style: TextStyle(
                                                                      color: Colors.black,
                                                                      fontWeight: FontWeight.bold,
                                                                      fontSize: 11)),
                                                                  SizedBox(width: 12,),
                                                                  Container(height: 10,color: Colors.black,width:1,),
                                                                  SizedBox(width: 12,),
                                                                  Text('${logo}${option['segments'][index]['flightNumber']}', style: TextStyle(
                                                                      color: Colors.black,
                                                                      fontWeight: FontWeight.bold,
                                                                      fontSize: 11)),
                                                                ],
                                                              ),
                                                              SizedBox(height: 5,),
                                                              Text('Operated By ${widget.opertedby}',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 8)),

                                                            ],
                                                          ),
                                                          SizedBox(height: 20,),
                                                          Row(
                                                            children: [
                                                              Text('${option['segments'][index]['arrivalAirport']}',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 15)),
                                                              SizedBox(width: 8,),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),

                                          ),

                                        ],
                                      ),
                                    );
                                  });
                            }),
                          ],
                        )
                      ],
                    ):buildCondition(text: 'Flight'),
                   Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children:[

                       widget.flights['fareRules']!=null?Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         mainAxisAlignment: MainAxisAlignment.start,
                         children: [
                           widget.flights['fareRules']['rules'].length>0?Padding(
                             padding: const EdgeInsets.all(8.0),
                             child: Text('fare details',style: TextStyle(fontSize: 17,fontWeight: FontWeight.w600,color:Colors.black),),
                           ):SizedBox(height: 0),
                           flightCubit.getServicesLoadiung?Column(
                             children:[
                             widget.flights['fareRules']['rules'].length>0?Padding(
                                 padding: const EdgeInsets.only(left:7,right:10),
                                 child:Container(
                                   child:Column(
                                     crossAxisAlignment: CrossAxisAlignment.start,
                                     mainAxisAlignment: MainAxisAlignment.start,
                                     children: [
                                       Container(
                                         height: 45,
                                         decoration: BoxDecoration(
                                             gradient: LinearGradient(
                                               begin: Alignment.bottomCenter,
                                               end: Alignment.topCenter,
                                               colors: [
                                                 Color.fromARGB(255, 255, 185, 106),
                                                 Color.fromARGB(255, 255, 137, 1),
                                               ],
                                             ),
                                             boxShadow: [
                                               BoxShadow(
                                                   blurRadius: 2.8,
                                                   color: Color(0xFFF28300),
                                                   offset: Offset(0, 0),
                                                   spreadRadius: 0)
                                             ],
                                             color: Color(0xFFF28300),
                                             borderRadius: BorderRadius.only(
                                               bottomLeft: Radius.circular(0),
                                               bottomRight: Radius.circular(0),
                                               topLeft: Radius.circular(11),
                                               topRight: Radius.circular(11),
                                             )),
                                         width: double.infinity,
                                         child: Row(
                                           mainAxisAlignment:
                                           MainAxisAlignment.spaceBetween,
                                           children: [
                                             Padding(
                                               padding: const EdgeInsets.only(left: 7,right: 7),
                                               child: Text('Rules',style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.w600),),
                                             )

                                           ],
                                         ),
                                       ),

                                       Padding(
                                         padding: const EdgeInsets.all(8.0),
                                         child: Column(
                                           crossAxisAlignment: CrossAxisAlignment.start,
                                           mainAxisAlignment: MainAxisAlignment.start,
                                           children: [
                                             ...widget.flights['fareRules']['rules'].map((e){
                                               getdetails(e){
                                                 if (e['category']=='REVALIDATION'){
                                                   if (e['notApplicable']==true) {
                                                     return 'not allowed';
                                                   }
                                                   if (e['maxPenaltyAmount']=='0'){
                                                     return 'Maximum penalty amount';
                                                   }
                                                   return 'Maximum penalty amount ${e['maxPenaltyAmount']} MAD';

                                                 }else if (e['category']=='EXCHANGE'){
                                                   if (e['notApplicable']==true) {
                                                     return 'not allowed';
                                                   }
                                                   if (e['maxPenaltyAmount']=='0'){
                                                     return 'Maximum penalty amount';
                                                   }
                                                   return 'Maximum penalty amount ${e['maxPenaltyAmount']} MAD';

                                                 }if(e['category']=='REFUND'){
                                                   if (e['notApplicable']==true) {
                                                     return 'not allowed';
                                                   }else if(e['maxPenaltyAmount']=='0'){
                                                     return 'Maximum penalty amount';
                                                   }else{
                                                     return 'Maximum penalty amount ${e['maxPenaltyAmount']} MAD';
                                                   }
                                                 }
                                               }

                                               return Padding(
                                                 padding: const EdgeInsets.all(8.0),
                                                 child: Column(
                                                   crossAxisAlignment: CrossAxisAlignment.start,
                                                   mainAxisAlignment: MainAxisAlignment.start,
                                                   children: [
                                                     Row(
                                                       children: [
                                                         Text('${e['category']}',style: TextStyle(fontWeight: FontWeight.w600,color: Colors.black,fontSize: 13)),
                                                       ],
                                                     ),
                                                     SizedBox(height: 3,),
                                                     Row(
                                                       children: [
                                                         e['notApplicable']==true?
                                                         Container(
                                                             decoration: BoxDecoration(borderRadius: BorderRadius.circular(3),color: Color.fromARGB(220, 255, 211, 208),),
                                                             child: Padding(
                                                               padding: const EdgeInsets.all(6.0),
                                                               child: Text('${getdetails(e)}',style: TextStyle(color: Color(0XFFd1190c),fontWeight: FontWeight.bold,fontSize: 9,)),
                                                             )):Text('${getdetails(e)}',style: TextStyle(color: Colors.grey[400],fontWeight: FontWeight.w600,fontSize: 11)),
                                                         SizedBox(width: 5,),
                                                         e['maxPenaltyAmount']=='0'?e['maxPenaltyAmount']!=null?Container(
                                                             decoration: BoxDecoration(borderRadius: BorderRadius.circular(3),color: Color.fromARGB(255, 163, 243, 166),),

                                                             child: Padding(
                                                               padding: const EdgeInsets.all(3.0),
                                                               child: Text('Free',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12,color: Color.fromARGB(255, 30, 131, 33))),
                                                             )):Text('${e['maxPenaltyAmount']}'):SizedBox(height: 0,)
                                                       ],
                                                     )
                                                   ],
                                                 ),
                                               );
                                             })
                                           ],
                                         ),
                                       ),
                                     ],
                                   ),
                                   decoration: BoxDecoration(
                                     boxShadow: [
                                       BoxShadow(
                                           blurRadius: 2.8,
                                           color: Color(0xFFF28300),
                                           offset: Offset(0, 0),
                                           spreadRadius: 0)
                                     ],
                                     borderRadius: BorderRadius.circular(10),
                                     color: Colors.white,
                                   ),
                                   width: double.infinity,
                                 ),
                               ):SizedBox(height: 0),
                           ],):buildCondition(text: 'Fare details'),
                         ],
                       ):SizedBox(height: 0,)


                     ],
                   ),

                   Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('fare Price',style: TextStyle(fontSize: 17,fontWeight: FontWeight.w600,color:Colors.black),),
                   ),

                    Padding(
                      padding: const EdgeInsets.only(left: 7,right: 5),
                      child: Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 45,
                                      decoration: BoxDecoration(
                                         gradient: LinearGradient(
                                        begin: Alignment.bottomCenter,
                                        end: Alignment.topCenter,
                                        colors: [
                                          Color.fromARGB(255, 255, 185, 106),
                                          Color.fromARGB(255, 255, 137, 1),
                                        ],
                                      ),
                                          boxShadow: [
                                          BoxShadow(
                                                blurRadius: 2.8,
                                                color: Color(0xFFF28300),
                                                offset: Offset(0, 0),
                                                spreadRadius: 0)
                                          ],
                                          color: Color(0xFFF28300),
                                          borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(0),
                                            bottomRight: Radius.circular(0),
                                            topLeft: Radius.circular(11),
                                            topRight: Radius.circular(11),
                                          )),
                                      width: double.infinity,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                         Padding(
                                           padding: const EdgeInsets.only(left: 7),
                                           child: Text("Taxes and fees",style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.w600),),
                                         )

                                        ],
                                      ),
                                    ),

                                      Padding(
                                      padding: const EdgeInsets.only(left: 3,),
                                      child: Column(
                                        children: [

                                      flightCubit.getServicesLoadiung ?
                                      Column(
                                         children:[
                                           flightResult!=null? Column(
                                             children: [
                                               ...getTravllersTypes(flightResult['travelers']).map((type){
                                                 return Column(
                                                   crossAxisAlignment: CrossAxisAlignment.start,
                                                   mainAxisAlignment: MainAxisAlignment.start,
                                                   children: [
                                                     Padding(
                                                       padding: const EdgeInsets.only(left: 6,top: 5,right: 8),
                                                       child: Text('${travels(type)} :',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600,color: Color(0xFFF28300))),
                                                     ),
                                                     if(getTotalTaxesbytravel(type)!=0.0)
                                                       Padding(
                                                         padding: const EdgeInsets.only(left: 6,top: 5,right: 8,bottom: 5),
                                                         child: Row(
                                                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                           children: [
                                                             Text('Texes',style: TextStyle(fontWeight: FontWeight.w600,color: Colors.black)),
                                                             Row(
                                                               children: [
                                                                 Text('${getTotalTaxesbytravel(type)}',style: TextStyle(color: Colors.grey[400],fontWeight: FontWeight.w600,fontSize: 14)),
                                                                 SizedBox(width: 5,),
                                                                 Text('MAD',style: TextStyle(color: Colors.grey[400],fontWeight: FontWeight.w600,fontSize: 14)),
                                                               ],
                                                             ),
                                                           ],
                                                         ),
                                                       ),
                                                     Padding(
                                                       padding: const EdgeInsets.only(left: 6,top: 5,right: 8,bottom: 5),
                                                       child: Row(
                                                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                         children: [
                                                           Text('Base Fare',style: TextStyle(fontWeight: FontWeight.w600,color: Colors.black)),
                                                           Row(
                                                             children: [
                                                               Text('${flightResult['travelers'].where((traveler) => traveler['type'] == type).map((traveler) => double.parse(traveler['price']['base'])).reduce((a, b) => a + b)}',style: TextStyle(color: Colors.grey[400],fontWeight: FontWeight.w600,fontSize: 14)),
                                                               SizedBox(width: 5,),
                                                               Text('MAD',style: TextStyle(color: Colors.grey[400],fontWeight: FontWeight.w600,fontSize: 14)),
                                                             ],
                                                           ),
                                                         ],
                                                       ),
                                                     ),

                                                     Padding(
                                                       padding: const EdgeInsets.only(left: 6,top: 5,right: 8,bottom: 5),
                                                       child: Row(
                                                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                         children: [
                                                           Text('Fees',style: TextStyle(fontWeight: FontWeight.w600,color: Colors.black)),
                                                           Row(
                                                             children: [
                                                               Text("${getTotalMarkupbytravel(type)}",style: TextStyle(color: Colors.grey[400],fontWeight: FontWeight.w600,fontSize: 14)),
                                                               SizedBox(width: 5,),
                                                               Text('MAD',style: TextStyle(color: Colors.grey[400],fontWeight: FontWeight.w600,fontSize: 14)),
                                                             ],
                                                           ),
                                                         ],
                                                       ),
                                                     ),

                                                     Padding(
                                                       padding: const EdgeInsets.only(left: 6,top: 5,right: 8,bottom: 5),
                                                       child: Row(
                                                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                         children: [
                                                           Text('Service Fee Cedido',style: TextStyle(fontWeight: FontWeight.w600,color: Colors.black)),
                                                           Row(
                                                             children: [
                                                               Text("${getTotalService_fee_sedidobytravel(type)}",style: TextStyle(color: Colors.grey[400],fontWeight: FontWeight.w600,fontSize: 14)),
                                                               SizedBox(width: 5,),
                                                               Text('MAD',style: TextStyle(color: Colors.grey[400],fontWeight: FontWeight.w600,fontSize: 14)),
                                                             ],
                                                           ),
                                                         ],
                                                       ),
                                                     ),

                                                     Padding(
                                                       padding: const EdgeInsets.only(left: 6,top: 5,right: 8,bottom: 5),
                                                       child: Row(
                                                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                         children: [
                                                           Text('markup',style: TextStyle(fontWeight: FontWeight.w600,color: Colors.black)),
                                                           Row(
                                                             children: [
                                                               Text("${getMarkupbytravel(type)}",style: TextStyle(color: Colors.grey[400],fontWeight: FontWeight.w600,fontSize: 14)),
                                                               SizedBox(width: 5,),
                                                               Text('MAD',style: TextStyle(color: Colors.grey[400],fontWeight: FontWeight.w600,fontSize: 14)),
                                                             ],
                                                           ),
                                                         ],
                                                       ),
                                                     ),

                                                     Padding(
                                                       padding: const EdgeInsets.only(left: 6,top: 5,right: 8,bottom: 5),
                                                       child: Row(
                                                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                         children: [
                                                           Text('Total',style: TextStyle(fontWeight: FontWeight.w600,color: Colors.black)),
                                                           Row(
                                                             children: [

                                                               getTotalTaxesbytravel(type)!=0.0? Text('${getTotalMarkupbytravel(type)+flightResult['travelers'].where((traveler) => traveler['type'] == type).map((traveler) => double.parse(traveler['price']['base'])).reduce((a, b) => a + b)+getTotalTaxesbytravel(type)}',style: TextStyle(color: Colors.grey[400],fontWeight: FontWeight.w600,fontSize: 14)):Text('${flightResult['travelers'].where((traveler) => traveler['type'] == type).map((traveler) => traveler['price']['total']).reduce((a, b) => a + b)}',style: TextStyle(color: Colors.grey[400],fontWeight: FontWeight.w600,fontSize: 14)),
                                                               SizedBox(width: 5,),
                                                               Text('MAD',style: TextStyle(color: Colors.grey[400],fontWeight: FontWeight.w600,fontSize: 14)),
                                                             ],
                                                           ),
                                                         ],
                                                       ),
                                                     )
                                                   ],
                                                 );
                                               })
                                             ],
                                             
                                           ):Column(
                                             children: [
                                               ...getTravllersTypes(widget.flights['travelers']).map((type){

                                                 return Column(
                                                   crossAxisAlignment: CrossAxisAlignment.start,
                                                   mainAxisAlignment: MainAxisAlignment.start,
                                                   children: [
                                                     Padding(
                                                       padding: const EdgeInsets.only(left: 6,top: 5,right: 8),
                                                       child: Text('${type} :',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600,color: Color(0xFFF28300))),
                                                     ),
                                                     if(getTotalTaxesbytravel(type)!=0.0)
                                                       Padding(
                                                         padding: const EdgeInsets.only(left: 6,top: 5,right: 8,bottom: 5),
                                                         child: Row(
                                                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                           children: [
                                                             Text('Texes',style: TextStyle(fontWeight: FontWeight.w600,color: Colors.black)),
                                                             Row(
                                                               children: [
                                                                 Text('${getTotalTaxesbytravel(type)}',style: TextStyle(color: Colors.grey[400],fontWeight: FontWeight.w600,fontSize: 14)),
                                                                 SizedBox(width: 5,),
                                                                 Text('MAD',style: TextStyle(color: Colors.grey[400],fontWeight: FontWeight.w600,fontSize: 14)),
                                                               ],
                                                             ),
                                                           ],
                                                         ),
                                                       ),
                                                     widget.flights['travelers'].where((traveler) => traveler['type'] == type).map((traveler) => traveler['price']['base']).reduce((a, b) => a + b)!=null?Padding(
                                                       padding: const EdgeInsets.only(left: 6,top: 5,right: 8,bottom: 5),
                                                       child: Row(
                                                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                         children: [
                                                           Text('Base Fare',style: TextStyle(fontWeight: FontWeight.w600,color: Colors.black)),
                                                           Row(
                                                             children: [
                                                               Text('${widget.flights['travelers'].where((traveler) => traveler['type'] == type).map((traveler) => double.parse(traveler['price']['base'])).reduce((a, b) => a + b)}',style: TextStyle(color: Colors.grey[400],fontWeight: FontWeight.w600,fontSize: 14)),
                                                               SizedBox(width: 5,),
                                                               Text('MAD',style: TextStyle(color: Colors.grey[400],fontWeight: FontWeight.w600,fontSize: 14)),
                                                             ],
                                                           ),
                                                         ],
                                                       ),
                                                     ):SizedBox(height: 0,),

                                                     Padding(
                                                       padding: const EdgeInsets.only(left: 6,top: 5,right: 8,bottom: 5),
                                                       child: Row(
                                                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                         children: [
                                                           Text('Fees',style: TextStyle(fontWeight: FontWeight.w600,color: Colors.black)),
                                                           Row(
                                                             children: [
                                                               Text("${getTotalMarkupbytravel(type)}",style: TextStyle(color: Colors.grey[400],fontWeight: FontWeight.w600,fontSize: 14)),
                                                               SizedBox(width: 5,),
                                                               Text('MAD',style: TextStyle(color: Colors.grey[400],fontWeight: FontWeight.w600,fontSize: 14)),
                                                             ],
                                                           ),
                                                         ],
                                                       ),
                                                     ),

                                                     Padding(
                                                       padding: const EdgeInsets.only(left: 6,top: 5,right: 8,bottom: 5),
                                                       child: Row(
                                                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                         children: [
                                                           Text('Service Fee Cedido',style: TextStyle(fontWeight: FontWeight.w600,color: Colors.black)),
                                                           Row(
                                                             children: [
                                                               Text("${getTotalService_fee_sedidobytravel(type)}",style: TextStyle(color: Colors.grey[400],fontWeight: FontWeight.w600,fontSize: 14)),
                                                               SizedBox(width: 5,),
                                                               Text('MAD',style: TextStyle(color: Colors.grey[400],fontWeight: FontWeight.w600,fontSize: 14)),
                                                             ],
                                                           ),
                                                         ],
                                                       ),
                                                     ),

                                                     Padding(
                                                       padding: const EdgeInsets.only(left: 6,top: 5,right: 8,bottom: 5),
                                                       child: Row(
                                                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                         children: [
                                                           Text('markup',style: TextStyle(fontWeight: FontWeight.w600,color: Colors.black)),
                                                           Row(
                                                             children: [
                                                               Text("${getMarkupbytravel(type)}",style: TextStyle(color: Colors.grey[400],fontWeight: FontWeight.w600,fontSize: 14)),
                                                               SizedBox(width: 5,),
                                                               Text('MAD',style: TextStyle(color: Colors.grey[400],fontWeight: FontWeight.w600,fontSize: 14)),
                                                             ],
                                                           ),
                                                         ],
                                                       ),
                                                     ),

                                                     Padding(
                                                       padding: const EdgeInsets.only(left: 6,top: 5,right: 8,bottom: 5),
                                                       child: Row(
                                                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                         children: [
                                                           Text('Total',style: TextStyle(fontWeight: FontWeight.w600,color: Colors.black)),
                                                           Row(
                                                             children: [

                                                               getTotalTaxesbytravel(type)!=0.0? Text('${getTotalMarkupbytravel(type)+widget.flights['travelers'].where((traveler) => traveler['type'] == type).map((traveler) => double.parse(traveler['price']['base'])).reduce((a, b) => a + b)+getTotalTaxesbytravel(type)}',style: TextStyle(color: Colors.grey[400],fontWeight: FontWeight.w600,fontSize: 14)):Text('${widget.flights['travelers'].where((traveler) => traveler['type'] == type).map((traveler) => traveler['price']['total']).reduce((a, b) => a + b)}',style: TextStyle(color: Colors.grey[400],fontWeight: FontWeight.w600,fontSize: 14)),
                                                               SizedBox(width: 5,),
                                                               Text('MAD',style: TextStyle(color: Colors.grey[400],fontWeight: FontWeight.w600,fontSize: 14)),
                                                             ],
                                                           ),
                                                         ],
                                                       ),
                                                     )
                                                   ],
                                                 );
                                               })
                                             ],
                                           )
                                         ],
                                       ):
                                      Container(
                                          height: 100,
                                          child: Center(
                                          child:CircularProgressIndicator(),
                                          ),

                                         ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                decoration: BoxDecoration(

                                  boxShadow: [
                                    BoxShadow(
                                        blurRadius: 2.8,
                                        color: Color(0xFFF28300),
                                        offset: Offset(0, 0),
                                        spreadRadius: 0)
                                  ],
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                  ),
                                width: double.infinity,
                              ),
                    ),
                   
                   Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Baggage',style: TextStyle(fontSize: 17,fontWeight: FontWeight.w600,color:Colors.black),),
                    ),
                    ...widget.flights['options'].map((options){
                         final arrivalAirport = options['segments'][options['segments'].length -1]['arrivalAirport'];
                         final departureAirport =options['segments'][0]['departureAirport'];

                        return Column(
                        children: [
                        Column(
                           children: [
                            Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                 child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 45,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                              children: [
                                                Text('${departureAirport}',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600)),
                                                SizedBox(width: 5,),
                                                Transform.rotate(
                                                  angle: 1,
                                                  child: Icon(Icons.airplanemode_active,color: Colors.white,)),
                                                  SizedBox(width: 5,),
                                                 Text(' ${arrivalAirport}',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600))
                                              ],
                                              ),
                                        ),
                                        decoration: BoxDecoration(
                                           gradient: LinearGradient(
                                        begin: Alignment.bottomCenter,
                                        end: Alignment.topCenter,
                                        colors: [
                                          Color.fromARGB(255, 255, 185, 106),
                                          Color.fromARGB(255, 255, 137, 1),
                                        ],
                                      ),
                                            boxShadow: [
                                              BoxShadow(
                                                  blurRadius: 2.8,
                                                  color: Color(0xFFF28300),
                                                  offset: Offset(0, 0),
                                                  spreadRadius: 0)
                                            ],
                                            color: Color(0xFFF28300),
                                            borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(0),
                                              bottomRight: Radius.circular(0),
                                              topLeft: Radius.circular(11),
                                              topRight: Radius.circular(11),
                                            )),
                                        width: double.infinity,),

                                      flightCubit.getServicesLoadiung ?
                                     Column(
                                         children: [
                                           flightResult!=null? Column(
                                             children: [
                                               ...flightResult['travelers'].map((traveler){
                                                 // dynamic includedCheckedBags = traveler['details'][0]['segments_details'][0]['includedCheckedBags']['quantity'];

                                                 // int weight = traveler['details'][0]['segments_details'][0]['includedCheckedBags']['weight'];
                                                 // String weightUnit =  traveler['details'][0]['segments_details'][0]['includedCheckedBags']['weightUnit'];
                                                 // dynamic includedCheckedBags = traveler['details'][0]['segments_details'][0]['includedCheckedBags']!=null? traveler['details'][0]['segments_details'][0]['includedCheckedBags']['quantity']:0;
                                                 //

                                                 // final includingBaggage =traveler['details'][0]['segments_details'][0]['includedCheckedBags']!=null? traveler['details'][0]['segmentsDetails'][0]['includedCheckedBags']['quantity']:0;
                                                 // final weight = traveler['details'][0]['segments_details'][0]['includedCheckedBags']['weight'];
                                                 // final weightUnit = traveler['details'][0]['segments_details'][0]['includedCheckedBags']['weightUnit'];
                                                 return Column(
                                                   crossAxisAlignment: CrossAxisAlignment.start,
                                                   mainAxisAlignment: MainAxisAlignment.start,
                                                   children: [
                                                     SizedBox(height: 5,),
                                                     Padding(
                                                       padding: const EdgeInsets.only(left: 8,top: 5,right: 8),
                                                       child: Text('${travels(traveler['type'])} :',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600,color: Color(0xFFF28300))),
                                                     ),
                                                     SizedBox(height: 5,),
                                                     Padding(
                                                       padding: const EdgeInsets.only(left: 8,top: 5,right: 8,bottom: 5),
                                                       child: Row(
                                                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                         children: [
                                                           Text('Hand baggage :',style: TextStyle(fontWeight: FontWeight.w600,color: Colors.black)),
                                                           Text('Included up to 7 kg',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey[400],fontSize: 12))
                                                         ],),
                                                     ),
                                                     SizedBox(height: 5,),
                                                     // Padding(
                                                     //   padding: const EdgeInsets.only(left: 8,top: 5,right: 8,bottom: 5),
                                                     //   child:  Row(
                                                     //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                     //     children: [
                                                     //      Text('1st checked bag :',style: TextStyle(fontWeight: FontWeight.w600,color: Colors.black,)),
                                                     //    includedCheckedBags!=0? Row(
                                                     //       children: [
                                                     //         includedCheckedBags==null?
                                                     //         Text('Including ${includedCheckedBags!=null?includedCheckedBags:weight}${includedCheckedBags!=null?includedCheckedBags:weightUnit}',style: TextStyle(color: Colors.green,fontSize: 13),):
                                                     //         Text('Including ${includedCheckedBags}',style: TextStyle(color: Colors.green,fontSize: 13),),
                                                     //          SizedBox(width: 5,),
                                                     //         Image.asset('assets/luggage.png',height: 15,)
                                                     //       ],
                                                     //     ):Text('not Included',style: TextStyle(color: Color.fromARGB(255, 245, 83, 8),fontSize: 13)),
                                                     //      ],
                                                     //   )
                                                     // ),


                                                     baggage!=null?baggage['result']!='No Bags offers are available in this flight'?Column(
                                                       children: [
                                                         ...baggage['options'].map((option){
                                                           return Column(
                                                             children: [
                                                               option['bags']!=null?Column(
                                                                 children: [
                                                                   ...option['bags'].where((bag){
                                                                     if(bag['travelers'].contains(traveler['id'])){
                                                                       return true;
                                                                     }
                                                                     return false;
                                                                   }
                                                                   ).map((bag){
                                                                     return Column(
                                                                       children: [
                                                                         Padding(
                                                                             padding: const EdgeInsets.only(left: 4,top: 0,right: 8,bottom: 0),
                                                                             child:(option['id']==widget.flights['options'].indexOf(options)+1) != false? Row(
                                                                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                               children: [
                                                                                 Padding(
                                                                                   padding: const EdgeInsets.all(8.0),
                                                                                   child: Text('Additional baggage (${bag['quantity']} ${bag['unit']}) :',style: TextStyle(fontWeight: FontWeight.w600,color: Colors.black),),
                                                                                 ),
                                                                                 Center(child:Text('${bag['amount']} ${bag['currencyCode']}',style: TextStyle(color: Colors.grey[400],fontWeight: FontWeight.bold,fontSize: 14),textAlign:TextAlign.center,)),
                                                                               ],
                                                                             ):SizedBox(height: 0,))
                                                                       ],
                                                                     );
                                                                   })
                                                                 ],
                                                               ):SizedBox(height: 0,)
                                                             ],
                                                           );
                                                         })
                                                       ],
                                                     ):SizedBox(height: 0):SizedBox(height: 0),
                                                   ],
                                                 );
                                               }),
                                             ],
                                           ):Column(
                                             crossAxisAlignment: CrossAxisAlignment.start,
                                             mainAxisAlignment: MainAxisAlignment.start,
                                             children: [
                                               ...widget.flights['travelers'].map((traveler){
                                                 // final includingBaggage =traveler['details'][0]['segments_details'][0]['includedCheckedBags']!=null? traveler['details'][0]['segmentsDetails'][0]['includedCheckedBags']['quantity']:0;
                                                 print(traveler['details'].where((e)=>e['option_id']==options['id']).first['segments_details'][0]['includedCheckedBags']['quantity']);
                                                 return Column(
                                                   crossAxisAlignment: CrossAxisAlignment.start,
                                                   mainAxisAlignment: MainAxisAlignment.start,
                                                   children: [
                                                     SizedBox(height: 5,),
                                                     Padding(
                                                       padding: const EdgeInsets.only(left: 8,top: 5,right: 8),
                                                       child: Text('${travels(traveler['type'])} :',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600,color: Color(0xFFF28300))),
                                                     ),
                                                     SizedBox(height: 5,),
                                                     Padding(
                                                       padding: const EdgeInsets.only(left: 8,top: 5,right: 8,bottom: 5),
                                                       child: Row(
                                                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                         children: [
                                                           Text('Hand baggage :',style: TextStyle(fontWeight: FontWeight.w600,color: Colors.black)),
                                                           Text('Included up to 7 kg',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey[400],fontSize: 12))
                                                         ],),
                                                     ),
                                                     Padding(
                                                       padding: const EdgeInsets.only(left: 8,top: 5,right: 8,bottom: 5),
                                                       child: Row(
                                                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                         children: [
                                                           Text('1st checked bag :',style: TextStyle(fontWeight: FontWeight.w600,color: Colors.black)),
                                                           Text('included ${traveler['details'].where((e)=>e['option_id']==options['id']).first['segments_details'][0]['includedCheckedBags']['quantity']}',style: TextStyle(fontWeight: FontWeight.bold,color: Color(0xff4caf50),fontSize: 12))
                                                         ],),
                                                     ),
                                                     SizedBox(height: 5,),
                                                   ],
                                                 );
                                               })
                                             ],
                                           )

                                         ],
                                       ): Column(
                                         children: [
                                           Container(
                                              height: 100,
                                              child: Center(
                                              child:CircularProgressIndicator(),
                                              ),
                                              decoration: BoxDecoration(
                                               boxShadow: [
                                               BoxShadow(
                                              blurRadius: 2.8,
                                              color: Color(0xFFF28300),
                                              offset: Offset(0, 0),
                                              spreadRadius: 0)
                                                ],
                                                borderRadius:BorderRadius.only(
                                                  bottomLeft:Radius.circular(7),
                                                  bottomRight:Radius.circular(7),
                                                  topLeft:Radius.circular(0),
                                                  topRight:Radius.circular(0),),
                                                color: Colors.white,
                                               ),
                                             ),
                                         ],
                                       ), 
                                         ]
                                         ),
                                  decoration: BoxDecoration(
                                    
                                  boxShadow: [
                                    BoxShadow(
                                        blurRadius: 2.8,
                                        color: Color(0xFFF28300),
                                        offset: Offset(0, 0),
                                        spreadRadius: 0)
                                  ],
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                ),
                                width: double.infinity,
                            ),
                            )
                           ],
                         )
                        ],
                      );
                      }),
                      SizedBox(height: 10,),
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

getTravllersTypes(travllers){
  var types = ['ADT'];
  travllers.where((travller) => travller['type'] == 'CHD').length > 0 ? types.add('CHD') : true;
  travllers.where((travller) => travller['type'] == 'INF').length > 0 ? types.add('INF') : true;
  return types;
}