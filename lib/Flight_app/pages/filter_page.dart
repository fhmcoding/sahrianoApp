// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:sahariano_travel/shared/components/components.dart';

// class FilterPage extends StatefulWidget {
//   const FilterPage({ Key key }) : super(key: key);

//   @override
//   _FilterPageState createState() => _FilterPageState();
// }

// class _FilterPageState extends State<FilterPage> {
// selectedDatedepart;
// selectedDatearival;
// stop;
// airlin;
// isfilterd;
// departure;
// selectedDepart;
// arrival;
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//                         top: true,
//                         minimum:EdgeInsets.only(left: 0,right: 0,top: 25) ,
//                         child: Scaffold(
                          
//                           bottomNavigationBar:Padding(
//                               padding: const EdgeInsets.only(left: 25, right: 25, top: 15, bottom: 15),
//                               child: GestureDetector(
//                                onTap:(){
//                                     DateTime dateTime_from = null;
//                                     DateTime dateTime_to = null;
//                                     DateTime dateTimeAR_from = null;
//                                     DateTime dateTimeAR_to = null;
//                                     if(selectedDatedepart == 'Morning'){
//                                       dateTime_from = DateTime.parse('${flight[0]['departureDate']}T05:00:00');
//                                       dateTime_to = DateTime.parse('${flight[0]['departureDate']}T12:00:00');
//                                     }
//                                     else if (selectedDatedepart == 'Evening') {
//                                       dateTime_from = DateTime.parse('${flight[0]['departureDate']}T12:00:00');
//                                       dateTime_to = DateTime.parse('${flight[0]['departureDate']}T17:00:00');
//                                     }
//                                     else {
//                                       dateTime_from = DateTime.parse('${flight[0]['departureDate']}T17:00:00');
//                                       dateTime_to = DateTime.parse('${flight[0]['departureDate']}T05:00:00');
//                                     }
//                                      final dataArivalDate =flight[0]['options'][0]['segments'][['segments'].length - 1]['arrivalDateTime'];
//                                      final Datearrival =  DateTime.parse(dataArivalDate);
//                                      final Datearrival2 = DateFormat('yyyy-MM-dd').format(Datearrival);                                         
//                                      if(selectedDatearival == 'Morning'){
//                                       dateTimeAR_from = DateTime.parse('${Datearrival2}T05:00:00');
//                                       dateTimeAR_to = DateTime.parse('${Datearrival2}T12:00:00');
//                                     }
//                                     else if (selectedDatearival == 'Evening') {
//                                       dateTimeAR_from = DateTime.parse('${Datearrival2}T12:00:00');
//                                       dateTimeAR_to = DateTime.parse('${flight[0]['departureDate']}T17:00:00');
//                                     }
//                                     else {
//                                       dateTimeAR_from = DateTime.parse('${Datearrival2}T17:00:00');
//                                       dateTimeAR_to = DateTime.parse('${Datearrival2}T05:00:00');
//                                     }
//                                     setState((){
//                                      FILTERDATA = flight
//                                     .where((value) {
//                                       return selectedDatedepart != null ? DateTime.parse(value['options'][0]['segments'][0]['departureDateTime']).compareTo(dateTime_from) >=0 && 
//                                       DateTime.parse(value['options'][0]['segments'][0]['departureDateTime']).compareTo(dateTime_to) <=0 : true ;
//                                     }).where((value) {
//                                       return selectedDatearival != null ? DateTime.parse(value['options'][0]['segments'][0]['arrivalDateTime']).compareTo(dateTimeAR_from) >=0 && 
//                                       DateTime.parse(value['options'][0]['segments'][0]['arrivalDateTime']).compareTo(dateTimeAR_to) <=0 : true ;
//                                     }).where((value){
//                                       return stop!=null? value['options'][0]['segments'].length==stop:true;
//                                     }).where((value){
//                                       return airlin !=null? value['options'][0]['segments'][0]['marketingAirline'] == airlin:true;
//                                     })
//                                     .toList();
//                                     isfilterd = true;
//                                     Navigator.pop(context);
//                                     });
//                                },
//                                 child: Container(
//                                   height: 55,
//                                   decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(10),
//                                       color: Color(0xFFF28300)),
//                                   width: double.infinity,
//                                   child: Center(
//                                       child: Text(
//                                     "Filter",
//                                     style: TextStyle(
//                                       fontSize: 20,
//                                       color: Colors.white,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                     textAlign: TextAlign.center,
//                                   )),
//                                 ),
//                               ),),
//                            appBar: AppBar(
//                              elevation: 0,
//                              leading: GestureDetector(
//                                onTap: (){
//                                  Navigator.of(context).pop();
//                                },
//                                child: Icon(Icons.arrow_back,color: Colors.white)),
//                              title: Text('Filter',style: TextStyle(color: Colors.white),)),
//                           body: ListView(
//                                 physics: BouncingScrollPhysics(),
//                                 shrinkWrap: true,
//                                 children: [
//                                   // SizedBox(height: 50,),
//                                     buildTitel(
//                               title: 'Stops',
//                               iconData: Icons.route_outlined,
//                               fontSize: 13),
//                                   StatefulBuilder(builder: (context,state){
                                   
//                                     return Column(
//                                       children: [
//                                       Padding(
//                                         padding: const EdgeInsets.only(left: 20,right: 20,top: 10),
//                                         child: Container(
//                                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.white),
//                                           height: 25,
//                                           width: double.infinity,
                                          
//                                           child: Row(
//                                             crossAxisAlignment: CrossAxisAlignment.center,
//                                             mainAxisAlignment: MainAxisAlignment.center,
//                                             children: [
//                                               SizedBox(
//                                                width: 0,
//                                               ),
//                                 buildCabinClass(
//                                     text: 'Direct',
//                                     group: stop,
//                                     onChanged: (value) {
//                                      state((){
//                                         stop = value;
//                                      });
//                                       print(value);
//                                     },
//                                     value: 1),
//                                 SizedBox(
//                                   width: 10,
//                                 ),
//                                 buildCabinClass(
//                                     text: '1 Stop',
//                                     group: stop,
//                                     onChanged: (value) {
//                                       state((){
//                                         stop = value;
//                                      });
//                                       print(value);
//                                     },
//                                     value: 2),
//                                 SizedBox(
//                                   width: 10,
//                                 ),
//                                 buildCabinClass(
//                                     text: '2+ Stop',
//                                     group: stop,
//                                     onChanged: (value) {
//                                        state((){
//                                         stop = value;
//                                      });
//                                       print(value);
//                                     },
//                                     value: 3),
//                                 SizedBox(
//                                   width: 20,
//                                 )
//                                             ],
//                                           ),
                                         
//                                         ),
//                                       ),
                                      
//                                       ],
//                                     );
//                                   }),
//                                     buildTitel(
//                               title: 'Price Range',
//                               iconData: Icons.attach_money,
//                               fontSize: 13
//                               ),
//                               //  Padding(
//                               // padding:
//                               //   const EdgeInsets.only(left: 20, right: 20, top: 10),
//                               // child: StatefulBuilder(
//                               // builder: (context,state){
//                               //   return Container(
                               
//                               //   width: double.infinity,
//                               //   decoration: BoxDecoration(
//                               //     borderRadius: BorderRadius.circular(10),
//                               //     color: Colors.white,
//                               //   ),
//                               //   child: SliderTheme(
//                               //     data: SliderThemeData(
//                               //       valueIndicatorColor: Color(0xFFF28300),
//                               //       activeTickMarkColor: Colors.transparent,
//                               //       inactiveTickMarkColor: Colors.transparent,
//                               //       rangeThumbShape: RoundRangeSliderThumbShape(enabledThumbRadius: 10),
//                               //       overlayShape: RoundSliderOverlayShape(overlayRadius: 24)
//                               //     ),
//                               //     child: Column(
//                               //       mainAxisSize: MainAxisSize.min,
//                               //       crossAxisAlignment: CrossAxisAlignment.center,
//                               //       mainAxisAlignment: MainAxisAlignment.center,
//                               //       children: [
//                               //       SizedBox(height: 5),
//                               //        RangeSlider(
                                     
//                               //          divisions: 20,
//                               //          labels:RangeLabels(values.toString(),values.toString()),
//                               //          values: RangeValues(values.start,values.end),
//                               //          min: _lowprice,
//                               //          max: _highprice,
                                       
//                               //         onChanged: (RangeValues _values){
//                               //        state((){
//                               //          _highprice = _values.start;
//                               //          _highprice = _values.end;
//                               //        });
//                               //         },
//                               //         ),
//                               //         Padding(
//                               //           padding: const EdgeInsets.only(
//                               //               left: 15, right: 15, bottom: 0),
//                               //           child: Row(
//                               //             mainAxisAlignment:
//                               //                 MainAxisAlignment.spaceBetween,
//                               //             children: [
//                               //               buildSlideLabel(min),
//                               //               buildSlideLabel(max),
//                               //             ],
//                               //           ),
//                               //         ),
//                               //       ],
//                               //     ),
//                               //   ),
//                               // );
//                               // },
//                               // ),
//                               //  ),
                              
//                                   buildTitel(title:'Departure time',iconData: Icons.airplanemode_on_outlined,fontSize: 13),
//                                   StatefulBuilder(builder: (context,state){
//                                     return Column(
//                                       children: [
//                                       Padding(
//                                         padding: const EdgeInsets.only(left: 20,right: 20,top: 10),
//                                         child: Container(
//                                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.white),
//                                           width: double.infinity,
//                                            child:  GridView.count(
//                                             crossAxisCount: 2,
//                                 physics: NeverScrollableScrollPhysics(),
//                                 mainAxisSpacing: 0,
//                                 crossAxisSpacing: 0,
//                                 childAspectRatio: 5 / 2,
//                                 shrinkWrap: true,
//                                 children: [
//                                ...departure.map((e) {
//                                  return  Padding(
//                                    padding: const EdgeInsets.all(8.0),
//                                    child: GestureDetector(
//                                      onTap: (){
//                                        state((){
//                                         selectedDatedepart = e['name'];
//                                         selectedDepart = departure.indexOf(e);
//                                        });
                                      
//                                      },
//                                      child: Container(
//                                         decoration: BoxDecoration(
//                                             borderRadius: BorderRadius.circular(10),
//                                             color: selectedDepart == departure.indexOf(e)? Color.fromARGB(255, 255, 137, 1):Color.fromARGB(255, 243, 243, 243)),
//                                         child: Column(
//                                           crossAxisAlignment: CrossAxisAlignment.center,
//                                           mainAxisAlignment: MainAxisAlignment.center,
//                                           children: [
//                                             Image.asset('${e['image']}',
//                                                 height: 15, color:selectedDepart == departure.indexOf(e)?Color.fromARGB(255, 255, 255, 255):Colors.black),
//                                             Text(
//                                               '${e['name']}',
//                                               style: TextStyle(
//                                                   color: selectedDepart == departure.indexOf(e)? Colors.white:Colors.black,
//                                                   fontSize: 11,
//                                                   fontWeight: FontWeight.bold),
//                                             ),
//                                             Text(
//                                               '${e['time']}',
//                                               style: TextStyle(
//                                                   color:
//                                                       selectedDepart == departure.indexOf(e)?Color.fromARGB(255, 255, 255, 255):Colors.black,
//                                                       fontWeight: FontWeight.w600,
//                                                   fontSize: 11),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                    ),
//                                  );
//                                })
//                                 ],
//                                 ),
//                                 ),
//                                 ),
                                      
//                                       ],
//                                     );
//                                   }),
//                                     buildTitel(title:'Arrival time',iconData: Icons.airplanemode_on_outlined,fontSize: 13),
//                                   StatefulBuilder(builder: (context,state){
//                                     return Column(
//                                       children: [
                                     
//                                       Padding(
//                                         padding: const EdgeInsets.only(left: 20,right: 20,top: 10),
//                                         child: Container(
//                                         decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.white),
//                                         width: double.infinity,
//                                         child: GridView.count(
//                                         crossAxisCount: 2,
//                                 physics: NeverScrollableScrollPhysics(),
//                                 mainAxisSpacing: 0,
//                                 crossAxisSpacing: 0,
//                                 childAspectRatio: 5 / 2,
//                                 shrinkWrap: true,
//                                 children: [
//                                 ...arrival.map((e){
//                                 return  Padding(
//                                    padding: const EdgeInsets.all(8.0),
//                                    child: GestureDetector(
//                                      onTap: (){
//                                       state((){
//                                         selectedDatearival = e['name'];
//                                         selectedRival = arrival.indexOf(e);
//                                       });
//                                      },
//                                      child: Container(
//                                         decoration: BoxDecoration(
//                                             borderRadius: BorderRadius.circular(10),
//                                             color:  selectedRival == arrival.indexOf(e)? Color.fromARGB(255, 255, 137, 1):Color.fromARGB(255, 243, 243, 243)),
//                                         child: Column(
//                                           crossAxisAlignment: CrossAxisAlignment.center,
//                                           mainAxisAlignment: MainAxisAlignment.center,
//                                           children: [ 
//                                             Image.asset('${e['image']}',
//                                                 height: 15, color: selectedRival == arrival.indexOf(e)?Color.fromARGB(255, 255, 255, 255):Colors.black,),
//                                             Text(
//                                               '${e['name']}',
//                                               style: TextStyle(
//                                                   color:  selectedRival == arrival.indexOf(e)?Color.fromARGB(255, 255, 255, 255):Colors.black,
//                                                   fontSize: 11,
//                                                   fontWeight: FontWeight.bold),
//                                             ),
//                                             Text(
//                                               '${e['time']}',
//                                               style: TextStyle(
//                                                   color:
//                                                       selectedRival == arrival.indexOf(e)?Color.fromARGB(255, 255, 255, 255):Colors.black,
//                                                   fontSize: 11),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                    ),
//                                  );
//                                })
//                                 ],
//                                 ),
//                                 ),
//                                 ),
//                                buildTitel(title:'Airliens',iconData: Icons.airlines,fontSize: 13),
//                                       StatefulBuilder(builder: ((context, setState) {
//                                         return Padding(
//                                             padding: const EdgeInsets.only(left: 20,right: 20,top: 10),
//                                           child: Container(
//                                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.white),
//                                             width: double.infinity,
//                                             child: Column(
//                                               crossAxisAlignment: CrossAxisAlignment.start,
//                                               mainAxisAlignment: MainAxisAlignment.start,
//                                               children: [
                                              
//                                                  ...airlinesvalues.map((e){
//                                        return RadioListTile(
//                                            title: Row(
//                                              crossAxisAlignment: CrossAxisAlignment.start,
//                                              mainAxisAlignment: MainAxisAlignment.start,
//                                              children: [
//                                                 Image.network('https://s1.travix.com/global/assets/airlineLogos/${e}_mini.png'),
//                                                 Text('  ${airline(flightCubit.airline, e)}')
//                                              ],
//                                            ),
//                                            value: e, groupValue: airlin, onChanged: (val){
//                                             setState((){
//                                                 airlin = val;
//                                               });
//                                        });
//                                      }),
//                                       ],
//                                       ),
//                                     ),
//                                         );
//                                       }))  
//                                       ],
//                                     );
//                                   }),
//                                 ],
//                               ),
//                         ),
//                       );
//   }
// }