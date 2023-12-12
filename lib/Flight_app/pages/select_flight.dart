import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sahariano_travel/Flight_app/country_service.dart';
import 'package:sahariano_travel/Flight_app/cubit_flight/cubit.dart';
import 'package:sahariano_travel/Flight_app/cubit_flight/states.dart';
import 'package:sahariano_travel/Flight_app/pages/details_flight.dart';
import 'package:sahariano_travel/Flight_app/pages/reservations_page.dart';
import 'package:sahariano_travel/ataycom_app/layout/cubit/cubit.dart';
import 'package:sahariano_travel/layout/home.dart';
import 'package:sahariano_travel/shared/components/components.dart';
import 'package:sahariano_travel/shared/components/constants.dart';
import 'package:sahariano_travel/shared/network/remote/local/cache_helper.dart';
import 'package:shimmer/shimmer.dart';
final countryService = new CountryService();
class SelectFlight extends StatefulWidget {
  final bool isMulticity;
  final int currentIndex;
  final DateTime depart;
   DateTime departOneWay;
  final  DateTime retun;
  final  String type;
  final  List flight;
  final  int qte_adults;
  final  int qte_children;
  final  int qte_infants;
  final  List<dynamic> flights;
  List<dynamic> FILTERDATA;
  final List<dynamic> flightRetun;
  List<dynamic> flightdepart;
  final String departAirport;
  final String dateDepart;
  final String arivalAirport;
  final Map<String, dynamic> parm;
  final Map<String, dynamic> result;
  final bool isaddOneWayOffers;
   bool isCalendre;
  SelectFlight(
      {Key key,
      this.isMulticity,
      this.type,
      this.depart,
      this.retun,
      this.currentIndex,
      this.qte_adults,
      this.qte_children,
      this.qte_infants,
      this.flight,
      this.flights,
      this.flightRetun,
      this.flightdepart,
      this.dateDepart,
      this.FILTERDATA,
      this.departAirport,
      this.arivalAirport,
      this.parm,
      this.isaddOneWayOffers,
      this.result,
      this.departOneWay,
      this.isCalendre,
      })
      : super(key: key);

  @override
  _SelectFlightState createState() => _SelectFlightState();
}

class _SelectFlightState extends State<SelectFlight>{
  String selcteddepart;
  String selctedretun;
  List<dynamic> filterdata=[];
    List<dynamic> flightData=[];
  List<dynamic> flightdepart = [];
  List<dynamic> flightRetun = [];
  List<dynamic> flightOneWay = [];
  Map<String, dynamic>flightRetunOneWay;
  Map<String, dynamic>flightDepartOneWay;
  Map<String, dynamic> parm ;
  int selecteruture;
  int selectedepart;
  String pricedepart;
  var departPrice;
  var returnPrice;
  String basdepart;
  String basarival;
  dynamic sequenceNumberdep;
  dynamic sequenceNumberRetu;
  Map<String, dynamic> flights;
  List<dynamic> flight;
  Map<String, dynamic> flightsrtur;
  bool isfilterd = false;
  var selectedDatedepart;
  var selectedDatearival;
  int stop = 1;
  int selectedDepart;
  int selectedRival;
 

  String tokenflight = Cachehelper.getData(key: "token_flight");
  bool isloading = false;
  Timer timer;
  bool isShow = true;
  int selected = 3;
  var now = DateTime.now();
  var operaitedby;
  // double minprice = 0.0;
  // airline(List airline,String logo){
  //
  //                               airline.forEach((value) {
  //                                 if (value['iata_code']==logo) {
  //                                  operaitedby = value['name'];
  //                                 }
  //                               });
  //                               return operaitedby;
  //                                }


   
 Minprice0neWay(date1){
    print("flight is ${flight}");
      var i = 0;
      dynamic  minpriceOneway = null ;
        flight.where((flight) => flight['departureDate']==date1
       ).forEach((element) {
          if (i == 0 || element['price'] < minpriceOneway ){
          minpriceOneway = element['price'];
          }
           // i=i+1;
          // minpriceOneway = element['price'];
          print(element['price']);
        });
        return minpriceOneway;
     }

Format({date1}){
    final Date1 = DateTime.parse(date1);
    return DateFormat('yyyy-MM-dd').format(Date1);  
 }



  void initState() {
  if (flightData != null){
    timer = Timer(Duration(minutes: 15),
  (){
     showDialog(
       barrierDismissible: false,
       context: context, builder: (_)=>StatefulBuilder(
              builder:(context,setState){
                return  AlertDialog(
                  title: Text('Please refresh your search for the latest prices'),
                content: Text('Flight prices change frequently due to availability and demand. We want to make sure you always see the best prices, guaranteed.'),
                actionsAlignment: MainAxisAlignment.center,
                actions: [
                Container(
                  color: appColor,
                  child: TextButton(onPressed: (){
                  setState(() {
                  flightData = [];
                });
                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>SelectFlight(
                                    currentIndex: widget.currentIndex,
                                    type:widget.type,
                                    flight:widget.flight,
                                    qte_adults:widget.qte_adults,
                                    qte_children:widget.qte_children,
                                    qte_infants: widget.qte_infants,
                                    isaddOneWayOffers:widget.isaddOneWayOffers,
                                    retun: widget.retun,
                                    depart: widget.depart,
                                    isCalendre:widget.isCalendre,
                                    isMulticity: widget.isMulticity,
                                    departOneWay: widget.departOneWay,
                                    )),(route) => route.isFirst);
              },child: Text('Refresh search',style: TextStyle(color: Colors.white),)),
                )
                ],
              );
              } ,
              
            ),);
  });
  }

    super.initState();
  }
    @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }



List departure = [
   {
     'name':'Morning',
     'time':'(05:00pm-11:59am)',
     'image':'assets/sun.png'
   },
   {
     'name':'Evening',
     'time':'(18:00pm-23:59pm)',
     'image':'assets/crescent-moon.png'
   },
   {
     'name':'Afternoon',
     'time':'(12:00pm-17:59pm)',
     'image':'assets/sunrise.png'
   }
 ];
List arrival =[
  {
     'name':'Morning',
     'time':'(05:00pm-11:59am)',
     'image':'assets/sun.png'
   },
   {
     'name':'Evening',
     'time':'(18:00pm-23:59pm)',
     'image':'assets/crescent-moon.png'
   },
   {
     'name':'Afternoon',
     'time':'(12:00pm-17:59pm)',
     'image':'assets/sunrise.png'
   }
 ];
String airlin;

RangeValues values = RangeValues(0, 0);
  @override
  Widget build(BuildContext context){
   Minprice(date1,date2){
        var i = 0;
        var  minprice = null;
        flight.where((flight) => Format(date1:flight['options'][0]['segments'][0]['departureDateTime'])==date1 
        && Format(date1:flight['options'][1]['segments'][0]['departureDateTime'])==date2).forEach((element) {
          if (i== 0 || element['price'] < minprice ) {
          minprice = element['price'];
          }
          i=i+1;
        });
        return minprice;
      
     }
    
     List rangeDate = [];
     flightData.forEach((flight) { 
          if (!rangeDate.contains(flight['departureDate'])) {
         rangeDate.add(flight['departureDate']);
      }
     });
        
   List<DateTime> DepartureDate =[];
   List<DateTime> DepartureDateOneWay =[];
   List<DateTime> RetureDate =[];

  if (widget.depart!=null) {
  if (DepartureDate.isEmpty) {
  for (var i = 0; i < 4; i++) {
  int days = i;
  final departbyday = widget.depart.add(Duration(days:days));
  DepartureDate.add(departbyday);
 }


 for (var i = 1; i < 4; i++) {
   int days = i;
  final departremovday = widget.depart.subtract(Duration(days:days));
  DepartureDate.add(departremovday);
 }
  } 
  }
  
  if (widget.departOneWay!=null) {
  if (DepartureDateOneWay.isEmpty) {
  for (var i = 0; i < 4; i++) {
  int days = i;
  final departbyday = widget.departOneWay.add(Duration(days:days));
  DepartureDateOneWay.add(departbyday);
 }


 for (var i = 1; i < 4; i++) {
   int days = i;
  final departremovday = widget.departOneWay.subtract(Duration(days:days));
  DepartureDateOneWay.add(departremovday);
 }
  } 

  }


 if (widget.retun!=null) {
     if (RetureDate.isEmpty) {
  for (var i = 0; i < 4; i++){
  int days = i;
  final retunbyday = widget.retun.add(Duration(days:days));
  
  RetureDate.add(retunbyday);
 }
 for (var i = 1; i < 4; i++) {
  
   int days = i;
  final retunremovday = widget.retun.subtract(Duration(days:days));
  RetureDate.add(retunremovday);
 }
   } 

 } 


  List<DateTime> newDepartureDate = [];
   DateFormat format = DateFormat("yyyy-MM-dd");
    if (widget.depart!=null){
      if (newDepartureDate.isEmpty) {
     for (int i = 0; i < DepartureDate.length; i++) {
    newDepartureDate.add(format.parse(DepartureDate[i].toString()));
  }
  newDepartureDate.sort((a,b) => a.toString().compareTo(b.toString()));
  for (var i = 0; i < DepartureDate.length; i++) {
  }
  }
  }
  List<DateTime> newDepartureDateOneWay = [];
   DateFormat formatoneway = DateFormat("yyyy-MM-dd");
    if (widget.departOneWay!=null){
      if (newDepartureDateOneWay.isEmpty) {
     for (int i = 0; i < DepartureDateOneWay.length; i++) {
    newDepartureDateOneWay.add(formatoneway.parse(DepartureDateOneWay[i].toString()));
  }
  newDepartureDateOneWay.sort((a,b) => a.toString().compareTo(b.toString()));
  for (var i = 0; i < DepartureDateOneWay.length; i++) {
   
  }
  }
  }
List<DateTime> newReturnDate = [];
   DateFormat formatRerun = DateFormat("yyyy-MM-dd");
    if (widget.depart!=null){
      if (newReturnDate.isEmpty) {
     for (int i = 0; i < DepartureDate.length; i++){
    newReturnDate.add(formatRerun.parse(RetureDate[i].toString()));
  }
  newReturnDate.sort((a,b) => a.toString().compareTo(b.toString()));
  for (var i = 0; i < RetureDate.length; i++) {
  }
  }
  }
    return BlocProvider(
      create: (BuildContext context) => FlightCubit()..SearchFlight(
                            typeflight: widget.type,
                            flight: widget.flight,
                            qte_adults:widget.qte_adults,
                            qte_children:widget.qte_children,
                            qte_infants:widget.qte_infants,
                            addOneWayOffers: widget.isaddOneWayOffers,
      ),
      child:BlocConsumer<FlightCubit, FlightStates>(
        listener: (context, state){
         if (state is SearchFlightSuccessState){
         if (widget.type=='one_way') {
           flightData = filterdata = state.filghtoneway;
            // flightData.sort((a, b) => a["price"].compareTo(b["price"]));
           flight = state.FILTERDATA;
           print(flight);
         }
         if (widget.type=='round_trip') {
          flightData = filterdata = state.FILTERound;
          flightData.sort((a, b) => a["price"].compareTo(b["price"]));
          flightdepart = state.flightdepart;
          flightRetun = state.flightsRetun;
          flight = state.FILTERDATA;
         }
          if (widget.type=='multi_destination'){
           flightData = filterdata = state.FILTERDATA;
           flight = state.FILTERDATA;
           flightData.sort((a, b) => a["price"].compareTo(b["price"]));
          }
       }
       
      },
      builder: (context, state) {
        var flightCubit = FlightCubit.get(context);
        showprice() {
            return buildShowPrice(
              departPrice:departPrice ,
              returnPrice:returnPrice,
              onTap: (){
                
                               flightOneWay=[];
                                flightOneWay.addAll({
                                  flightDepartOneWay,
                                  flightRetunOneWay
                                });
                                   navigateTo(
                                      context,
                                      ReservationPage(
                                        currentIndex: widget.currentIndex,
                                         FlightOneWay:flightOneWay,
                                         totalPrice: departPrice + returnPrice,
                                         timer:timer,
                                         flights: null,
                                         providerType:flightDepartOneWay['providerType'],
                                         sequence_number:[
                                          '${sequenceNumberRetu}',
                                          '${sequenceNumberdep}'
                                        ],
                                      ));
              }
            );
          }
          return Scaffold(
              bottomNavigationBar: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(0),
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 3,
                        color: Colors.grey[350],
                        offset: Offset(3, 4),
                        spreadRadius: 7)
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 25, right: 25, top: 15, bottom: 15),
                  child: GestureDetector(
                    onTap: ()  {
                       flightData = filterdata;
                                selectedRival = null;
                                selectedDepart = null;
                                selectedDatedepart = null;
                                selectedDatearival = null;
                                airlin = null;
                                stop =null;
                                isfilterd = false;
                  showModalBottomSheet(
                    isScrollControlled:true,
                    enableDrag: false,
                    context: context, builder: (BuildContext context){
                               
                                selectedRival = null;
                                selectedDepart = null;
                                selectedDatedepart = null;
                                selectedDatearival = null;
                                airlin = null;
                                stop =null;
                                isfilterd = false;
                           List<String> airlinesvalues = [];
                           flightData.forEach((flight) { 
                         if (!airlinesvalues.contains(flight['options'][0]['segments'][0]['marketingAirline'])) {
                          airlinesvalues.add(flight['options'][0]['segments'][0]['marketingAirline']);
                          }
                        });
                    return SafeArea(
                      child: Scaffold(
                        
                        bottomNavigationBar:Container(
                            
                         width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(0),
                                      boxShadow: [
                      BoxShadow(
                        blurRadius: 3,
                        color: Colors.grey[350],
                        offset: Offset(3, 4),
                        spreadRadius: 7)
                                      ],
                                    ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 25, right: 25, top: 15, bottom: 15),
                            child: GestureDetector(
                             onTap:(){
                                  DateTime dateTime_from = null;
                                  DateTime dateTime_to = null;
                                  DateTime dateTimeAR_from = null;
                                  DateTime dateTimeAR_to = null;
                                  if(selectedDatedepart == 'Morning'){
                                    dateTime_from = DateTime.parse('${filterdata[0]['departureDate']}T05:00:00');
                                    dateTime_to = DateTime.parse('${filterdata[0]['departureDate']}T11:59:00');
                                  }
                                  else if (selectedDatedepart == 'Evening') {
                                    dateTime_from = DateTime.parse('${filterdata[0]['departureDate']}T18:00:00');
                                    dateTime_to = DateTime.parse('${filterdata[0]['departureDate']}T23:59:00');
                                  }
                                  else {
                                    dateTime_from = DateTime.parse('${filterdata[0]['departureDate']}T12:00:00');
                                    dateTime_to = DateTime.parse('${filterdata[0]['departureDate']}T17:59:00');
                                  }
                                  // options['segments'][options['segments'].length - 1]['arrivalDateTime']
                                   final dataArivalDate = filterdata[0]['options'][0]['segments'][['segments'].length - 1]['arrivalDateTime'];
                                   final Datearrival =  DateTime.parse(dataArivalDate);
                                   final Datearrival2 = DateFormat('yyyy-MM-dd').format(Datearrival);                                         
                                   if(selectedDatearival == 'Morning'){
                                    dateTimeAR_from = DateTime.parse('${Datearrival2}T05:00:00');
                                    dateTimeAR_to = DateTime.parse('${Datearrival2}T11:59:00');
                                  }
                                  else if (selectedDatearival == 'Evening') {
                                    dateTimeAR_from = DateTime.parse('${Datearrival2}T18:00:00');
                                    dateTimeAR_to = DateTime.parse('${filterdata[0]['departureDate']}T23:59:00');
                                  }
                                  else {
                                    dateTimeAR_from = DateTime.parse('${Datearrival2}T12:00:00');
                                    dateTimeAR_to = DateTime.parse('${Datearrival2}T17:59:00');
                                  }
                                  setState((){
                                   flightData = filterdata.where((value) {
                                    return selectedDatedepart != null ? DateTime.parse(value['options'][0]['segments'][0]['departureDateTime']).compareTo(dateTime_from) >=0 && 
                                    DateTime.parse(value['options'][0]['segments'][0]['departureDateTime']).compareTo(dateTime_to) <=0 : true ;
                                  }).where((value) {
                                    return selectedDatearival != null ? DateTime.parse(value['options'][0]['segments'][0]['arrivalDateTime']).compareTo(dateTimeAR_from) >=0 && 
                                    DateTime.parse(value['options'][0]['segments'][0]['arrivalDateTime']).compareTo(dateTimeAR_to) <=0 : true ;
                                  }).where((value){
                                    return stop!=null? value['options'][0]['segments'].length==stop:true;
                                  }).where((value){
                                    return airlin !=null? value['options'][0]['segments'][0]['marketingAirline'] == airlin:true;
                                  })
                                  .toList();
                                  isfilterd = true;
                                  Navigator.pop(context);
                                  });
                             },
                              child: Container(
                                height: 55,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: appColor),
                                width: double.infinity,
                                child: Center(
                                    child: Text(
                                  "Filter",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                )),
                              ),
                            ),),
                        ),
                         
                        body: ListView(
                              physics: BouncingScrollPhysics(),
                              shrinkWrap: true,
                              children: [
                                SizedBox(height: 25,),
                                Padding(
                                  padding: const EdgeInsets.only(left: 20,right: 20,top: 20),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      GestureDetector(
                                        onTap: (){
                                        Navigator.of(context).pop();
                                        },
                                        child: Icon(Icons.arrow_back)),
                                      Text('Filter',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: appColor,),textAlign: TextAlign.center,),
                                      Icon(Icons.arrow_back,color: Colors.white),
                                    ],
                                  ),
                                ),
                                
                                SizedBox(height: 10,),
                                Container(height: 0.2,width: double.infinity,color: Color.fromARGB(255, 159, 158, 158),),
                                  buildTitel(
                            title: 'Stops',
                            iconData: Icons.route_outlined,
                            fontSize: 13),
                                StatefulBuilder(builder: (context,state){
                                 
                                  return Column(
                                    children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 20,right: 20,top: 10),
                                      child: Container(
                                         decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: Colors.white),
                                        height: 25,
                                        width: double.infinity,
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                             width: 0,
                                            ),
                              buildStops(
                                  text: 'Direct',
                                  group: stop,
                                  onChanged: (value) {
                                   state((){
                                      stop = value;
                                   });
                                    print(value);
                                  },
                                  value: 1),
                              SizedBox(
                                width: 10,
                              ),
                              buildStops(
                                  text: '1 Stop',
                                  group: stop,
                                  onChanged: (value) {
                                    state((){
                                      stop = value;
                                   });
                                    print(value);
                                  },
                                  value: 2),
                              SizedBox(
                                width: 10,
                              ),
                              buildStops(
                                  text: '2+ Stop',
                                  group: stop,
                                  onChanged: (value) {
                                     state((){
                                      stop = value;
                                   });
                                    print(value);
                                  },
                                  value: 3),
                              SizedBox(
                                width: 20,
                              )
                                          ],
                                        ),
                                       
                                      ),
                                    ),
                                    
                                    ],
                                  );
                                }),
                                buildTitel(title:'Departure time',iconData: Icons.airplanemode_on_outlined,fontSize: 13),
                                StatefulBuilder(builder: (context,state){
                                  return Column(
                                    children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 20,right: 20,top: 10),
                                      child: Container(
                                         decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.white),
                                        width: double.infinity,
                                         child:  GridView.count(
                                          crossAxisCount: 2,
                              physics: NeverScrollableScrollPhysics(),
                              mainAxisSpacing: 0,
                              crossAxisSpacing: 0,
                              childAspectRatio: 5 / 2,
                              shrinkWrap: true,
                              children: [
                             ...departure.map((e) {
                               return  Padding(
                                 padding: const EdgeInsets.all(8.0),
                                 child: GestureDetector(
                                   onTap: (){
                                     state((){
                                      selectedDatedepart = e['name'];
                                      selectedDepart = departure.indexOf(e);
                                     });
                                    
                                   },
                                   child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          color: selectedDepart == departure.indexOf(e)? Color.fromARGB(255, 255, 137, 1):Color.fromARGB(255, 243, 243, 243)),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Image.asset('${e['image']}',
                                              height: 15, color:selectedDepart == departure.indexOf(e)?Color.fromARGB(255, 255, 255, 255):Colors.black),
                                          Text(
                                            '${e['name']}',
                                            style: TextStyle(
                                                color: selectedDepart == departure.indexOf(e)? Colors.white:Colors.black,
                                                fontSize: 11,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            '${e['time']}',
                                            style: TextStyle(
                                                color:
                                                    selectedDepart == departure.indexOf(e)?Color.fromARGB(255, 255, 255, 255):Colors.black,
                                                    fontWeight: FontWeight.w600,
                                                fontSize: 11),
                                          ),
                                        ],
                                      ),
                                    ),
                                 ),
                               );
                             })
                              ],
                              ),
                              ),
                              ),
                                    
                                    ],
                                  );
                                }),
                                  buildTitel(title:'Arrival time',iconData: Icons.airplanemode_on_outlined,fontSize: 13),
                                StatefulBuilder(builder: (context,state){
                                  return Column(
                                    children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 20,right: 20,top: 10),
                                      child: Container(
                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.white),
                                      width: double.infinity,
                                      child: GridView.count(
                                      crossAxisCount: 2,
                              physics: NeverScrollableScrollPhysics(),
                              mainAxisSpacing: 0,
                              crossAxisSpacing: 0,
                              childAspectRatio: 5 / 2,
                              shrinkWrap: true,
                              children: [
                              ...arrival.map((e){
                              return  Padding(
                                 padding: const EdgeInsets.all(8.0),
                                 child: GestureDetector(
                                   onTap: (){
                                    state((){
                                      selectedDatearival = e['name'];
                                      selectedRival = arrival.indexOf(e);
                                    });
                                   },
                                   child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          color:  selectedRival == arrival.indexOf(e)? Color.fromARGB(255, 255, 137, 1):Color.fromARGB(255, 243, 243, 243)),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [ 
                                          Image.asset('${e['image']}',
                                              height: 15, color: selectedRival == arrival.indexOf(e)?Color.fromARGB(255, 255, 255, 255):Colors.black,),
                                          Text(
                                            '${e['name']}',
                                            style: TextStyle(
                                                color:  selectedRival == arrival.indexOf(e)?Color.fromARGB(255, 255, 255, 255):Colors.black,
                                                fontSize: 11,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            '${e['time']}',
                                            style: TextStyle(
                                                color:
                                                    selectedRival == arrival.indexOf(e)?Color.fromARGB(255, 255, 255, 255):Colors.black,
                                                fontSize: 11),
                                          ),
                                        ],
                                      ),
                                    ),
                                 ),
                               );
                             })
                              ],
                              ),
                              ),
                              ),
                             buildTitel(title:'Airliens',iconData: Icons.airlines,fontSize: 13),
                                    StatefulBuilder(builder: ((context, setState) {
                                      return Padding(
                                          padding: const EdgeInsets.only(left: 20,right: 20,top: 10),
                                        child: Container(
                                           decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.white),
                                          width: double.infinity,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                            
                                               ...airlinesvalues.map((e){
                                     return RadioListTile(
                                         title: Row(
                                           crossAxisAlignment: CrossAxisAlignment.start,
                                           mainAxisAlignment: MainAxisAlignment.start,
                                           children: [
                                              Image.network('https://s1.travix.com/global/assets/airlineLogos/${e}_mini.png'),
                                              SizedBox(width: 5,),
                                             Text('',style: TextStyle(fontSize: 13,fontWeight: FontWeight.w600),)
                                           ],
                                         ),
                                         value: e, groupValue: airlin, onChanged: (val){
                                          setState((){
                                              airlin = val;
                                            });
                                     });
                                   }),
                                    ],
                                    ),
                                  ),
                                      );
                                    }))  
                                    ],
                                  );
                                }),
                              ],
                            ),
                      ),
                    );
                      
                  });
                    },
                    
                    child: Container(
                      height: 55,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: appColor),
                      width: double.infinity,
                      child: Center(
                          child: Text(
                        'Short & Filter',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      )),
                    )
                  ),
                ),
              ),
              appBar: AppBar(
                leading: GestureDetector(
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                    ),
                    onTap: () {
                      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>Home(Index:service.indexId=widget.currentIndex,)), (route) => route.isFirst);
                      timer.cancel();
          
                    }),
                backgroundColor: Colors.white,
                centerTitle: true,
                actions: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: isfilterd == true
                        ? GestureDetector(
                          onTap: (){
                            setState(() {
                                flightData = filterdata;
                                selectedRival = null;
                                selectedDepart = null;
                                selectedDatedepart = null;
                                selectedDatearival = null;
                                airlin = null;
                                stop =null;
                                isfilterd = false;
                              });
                          },
                          child: Image.asset('assets/filter-remove.png',height: 5,color:appColor,))
                        : SizedBox(height: 0),
                  )
                ],
                title: Text(
                  "Select Flight",
                  style: TextStyle(color: appColor, fontSize: 20),
                ),
                elevation: 0,
              ),
              backgroundColor: Colors.white,
              body: SingleChildScrollView(
                child: flightCubit.Loading?Column(
                  crossAxisAlignment:CrossAxisAlignment.start ,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[

                    //      widget.departOneWay==null? widget.isMulticity == false? widget.isCalendre!=null?Padding(
                    //   padding: const EdgeInsets.all(8.0),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     children: [
                    //       GestureDetector(
                    //         onTap: (){
                    //           widget.flight.forEach((e){
                    //            e['range']=1;
                    //             print(e);
                    //           });
                    //         Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>SelectFlight(
                    //                 currentIndex: widget.currentIndex,
                    //                 type:widget.type,
                    //                 flight:widget.flight,
                    //                 qte_adults:widget.qte_adults,
                    //                 qte_children:widget.qte_children,
                    //                 qte_infants: widget.qte_infants,
                    //                 isaddOneWayOffers:false,
                    //                 retun: widget.retun,
                    //                 depart: widget.depart,
                    //                 isCalendre: true,
                    //                  isMulticity: false,
                    //                 )), (route) => route.isFirst);
                    //           setState(() {
                    //             // widget.isCalendre = true;
                    //             //  widget.isCalendre = !widget.isCalendre;
                    //             isShow = true;
                    //           });
                    //         },
                    //         child: Container(
                    //           height: 35,
                    //           decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: widget.isCalendre?appColor:Color.fromARGB(255, 255, 208, 175)),
                    //           child: Padding(
                    //             padding: const EdgeInsets.all(8.0),
                    //             child: Row(
                    //               children: [
                    //                 Icon(Icons.calendar_today,color:  widget.isCalendre? Colors.white:Color.fromARGB(255, 252, 82, 9),size: 18),
                    //                 SizedBox(width: 5),
                    //                 Text('CALENDAR VIEW',style: TextStyle(
                    //                   fontSize: 12,
                    //                   color:  widget.isCalendre? Colors.white:Color.fromARGB(255, 252, 82, 9),
                    //                   fontWeight: FontWeight.bold
                    //                 ),),
                    //               ],
                    //             ),
                    //           )),
                    //       ),
                    //
                    //       GestureDetector(
                    //         onTap: (){
                    //            widget.flight.forEach((e) {
                    //            e['range']=0;
                    //           });
                    //            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>SelectFlight(
                    //                 currentIndex: widget.currentIndex,
                    //                 type:widget.type,
                    //                 flight:widget.flight,
                    //                 qte_adults:widget.qte_adults,
                    //                 qte_children:widget.qte_children,
                    //                 qte_infants: widget.qte_infants,
                    //                 isaddOneWayOffers:true,
                    //                 retun: widget.retun,
                    //                 depart: widget.depart,
                    //                 isCalendre: false,
                    //                  isMulticity: false,
                    //                 )), (route) => route.isFirst);
                    //               setState(() {
                    //               //  widget.isCalendre = !widget.isCalendre;
                    //               isShow = false;
                    //               });
                    //
                    //
                    //         },
                    //         child: Container(
                    //           height: 35,
                    //           decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: widget.isCalendre?Color.fromARGB(255, 255, 208, 175):appColor,),
                    //           child: Padding(
                    //             padding: const EdgeInsets.all(8.0),
                    //             child: Row(
                    //               children: [
                    //                 Icon(Icons.list, color: widget.isCalendre? Color.fromARGB(255, 252, 82, 9):Colors.white,size: 18),
                    //                 SizedBox(width: 5),
                    //                 Text('LIST VIEW',style: TextStyle(
                    //                   fontSize: 12,
                    //                   color:  widget.isCalendre? Color.fromARGB(255, 252, 82, 9):Colors.white,
                    //                   fontWeight: FontWeight.bold
                    //                 ),),
                    //               ],
                    //             ),
                    //           )),
                    //       ),
                    //     ],
                    //   ),
                    // ):SizedBox(height: 0):SizedBox(height: 0):SizedBox(height: 0),
                    //   widget.isMulticity == false? SizedBox(height: 0):SizedBox(height: 0),

                 newReturnDate.length>0?widget.isCalendre?Padding(
                   padding: const EdgeInsets.only(left: 5,right: 5),
                   child: GestureDetector(
                     onTap: (){
                     setState(() {
                       isShow =! isShow;
                     });
                     },
                     child: Container(
                       decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(5),
                          color: Colors.white,
                       ),
                       child: Padding(
                         padding: const EdgeInsets.only(bottom: 5,top: 5,right: 10,left: 10),
                         child: Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           mainAxisAlignment: MainAxisAlignment.start,
                           children: [
                            Text('Flexible dates',style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold)),
                             Align(
                                alignment: Alignment.centerRight,
                                child:isShow?Icon(Icons.arrow_drop_up):Icon(Icons.arrow_drop_down,)),
                                Text('Compare prices for nearby days',style: TextStyle(fontSize: 12)),
                           ],
                         ),
                       ),
                       width: double.infinity,

                     ),
                   ),
                 ):SizedBox(height: 0):SizedBox(height: 0),
                newReturnDate.length>0?isShow?widget.isCalendre? widget.isMulticity == false?
                       Padding(
                    padding: const EdgeInsets.only(left: 5,right: 5),
                    child: Table(
                      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                      border: TableBorder(
                        verticalInside: BorderSide(color: Colors.grey,),
                        horizontalInside: BorderSide(color: Colors.grey,),
                      ),
                      children: [
                       TableRow(
                       decoration: BoxDecoration(color:Color.fromARGB(255, 255, 208, 175)),
                         children: [
                         Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text('departure',style: TextStyle(fontSize: 8,fontWeight: FontWeight.bold),),
                                              Icon(Icons.arrow_forward_outlined,size: 9,)
                                            ],
                                          ),
                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text('return',style: TextStyle(fontSize: 8,fontWeight: FontWeight.bold),),
                                               Icon(Icons.arrow_downward_sharp,size: 9,)
                                            ],
                                          ),
                            ],
                          ),

                         ...newDepartureDate.map((departureDate) => Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Text('${DateFormat('MM-dd').format(departureDate)}',style: TextStyle(fontSize: 11,fontWeight: FontWeight.w600),textAlign:TextAlign.center),
                         ))
                         ]
                       ),
                       ...newReturnDate.map((newReturnDate){
                        return TableRow(
                        decoration: BoxDecoration(color:Color(0XFFfdeee2)),
                         children: [
                           Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Text('${DateFormat('MM-dd').format(newReturnDate)}',style: TextStyle(fontSize: 11,fontWeight: FontWeight.w600,),textAlign:TextAlign.center),
                          ),
                           ...newDepartureDate.map((departureDate) {
                             return  Container(
                                alignment: AlignmentDirectional.center,
                                child:departureDate.isBefore(newReturnDate)?Minprice(DateFormat('yyyy-MM-dd').format(departureDate), DateFormat('yyyy-MM-dd').format(newReturnDate))!=null?GestureDetector(
                                  onTap: (){
                                    setState((){
                                     flightData = flight.where((flight) => Format(date1:flight['options'][0]['segments'][0]['departureDateTime'])==DateFormat('yyyy-MM-dd').format(departureDate)
                                     && Format(date1:flight['options'][1]['segments'][0]['departureDateTime'])==DateFormat('yyyy-MM-dd').format(newReturnDate)).toList().toList();
                                     flightData.sort((a, b) => a["price"].compareTo(b["price"]));

                                    });
                                  },
                                  child:Container(
                                    height: 30,
                                    child: Center(
                                      child:Text(
                                       '${Minprice(DateFormat('yyyy-MM-dd').format(departureDate),DateFormat('yyyy-MM-dd').format(newReturnDate))}',
                                        style: TextStyle(fontWeight: FontWeight.bold,fontSize: 11),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  )
                                ):GestureDetector(
                                  onTap: (){
                                 widget.flight[0]['departureDate']=DateFormat('yyyy-MM-dd').format(departureDate);
                                 widget.flight[1]['departureDate']=DateFormat('yyyy-MM-dd').format(newReturnDate);
                                 Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>SelectFlight(
                                    currentIndex: widget.currentIndex,
                                    type:widget.type,
                                    flight:widget.flight,
                                    qte_adults:widget.qte_adults,
                                    qte_children:widget.qte_children,
                                    qte_infants: widget.qte_infants,
                                    isaddOneWayOffers:false,
                                    retun:departureDate,
                                    depart:newReturnDate,
                                    isCalendre: true,
                                     isMulticity: false,
                                    )), (route) => route.isFirst);
                                  },
                                  child:now.isBefore(departureDate)?Text('search',style: TextStyle(color: Color.fromARGB(255, 83, 83, 83),fontWeight: FontWeight.w600,fontSize: 12),):Text('-',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,))):Text('-',style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600,)));
                           })
                         ]
                       );
                       }),
                      ],
                   ),
                  ) :SizedBox(height: 0):SizedBox(height: 0):SizedBox(height: 0):SizedBox(height: 0),
                 widget.departOneWay!=null?widget.isMulticity == false ?
                 Container(
                     width: double.infinity,
                     color: Colors.white,
                     child: SingleChildScrollView(
                       controller:ScrollController(initialScrollOffset: 180.0,keepScrollOffset: true,) ,
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            ...newDepartureDateOneWay.map((DepartureDateOneWay){
                              return Padding(
                              padding: const EdgeInsets.only(left: 10,top: 10,bottom: 0,right: 10),
                               child: Minprice0neWay(DateFormat('yyyy-MM-dd').format(DepartureDateOneWay))==null?
                             buildItem(
                                DepartureDateOneWay:DepartureDateOneWay,
                                index:newDepartureDateOneWay.indexOf(DepartureDateOneWay),
                                selected:selected,
                                type: 'search',
                                onTap: (){
                                   setState((){
                                   widget.flight[0]['departureDate'] = DateFormat('yyyy-MM-dd').format(DepartureDateOneWay);
                                   Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>SelectFlight(
                                     currentIndex: widget.currentIndex,
                                     type:widget.type,
                                     flight:widget.flight,
                                     qte_adults:widget.qte_adults,
                                     qte_children:widget.qte_children,
                                     qte_infants: widget.qte_infants,
                                     isaddOneWayOffers: widget.isaddOneWayOffers,
                                     retun: widget.retun,
                                     depart: widget.depart,
                                     departOneWay:DepartureDateOneWay,
                                      isMulticity: false,
                                     )), (route) => route.isFirst);

                                });
                                }
                              ):buildItem(
                                DepartureDateOneWay:DepartureDateOneWay,
                                index:newDepartureDateOneWay.indexOf(DepartureDateOneWay),
                                selected:selected,
                                      type: "${Minprice0neWay(DateFormat('yyyy-MM-dd').format(DepartureDateOneWay))} MAD",
                                // type: '100',
                                  onTap:(){
                                setState((){
                                selected = newDepartureDateOneWay.indexOf(DepartureDateOneWay);
                                flightData = filterdata = flight.where((value)=>value['departureDate']==DateFormat('yyyy-MM-dd').format(DepartureDateOneWay)).toList();

                                });
                                }
                              ),
                            );
                           })
                          ],
                        )
                      ),
                   )
                   :
                   SizedBox(height: 0):SizedBox(height: 0),
                widget.isCalendre!=null?!widget.isCalendre? widget.isMulticity == false ?flightdepart.length>0?Padding(
                    padding: const EdgeInsets.only(left: 10,right: 10,top: 10),
                    child: Text('Best flexibility :',style: TextStyle(
                      fontSize: 17,
                      color: appColor,
                      fontWeight: FontWeight.bold
                    )),
                  ):SizedBox(height: 0):SizedBox(height: 0):SizedBox(height: 0):SizedBox(height: 0),
                 widget.isCalendre!=null?widget.isMulticity == false ? flightdepart.length>0?SizedBox(height: 10):SizedBox(height: 0):SizedBox(height: 0):SizedBox(height: 0),
                 widget.isCalendre!=null?widget.isMulticity == false ?flightdepart.length>0?Container(color: appColor,height:3,width: double.infinity,):SizedBox(height: 0):SizedBox(height: 0):SizedBox(height: 0),
                 SizedBox(height: 5),
                //widget.isMulticity == false ?Container(height: 1,width: double.infinity,color: appColor,):SizedBox(height: 0),
                 widget.isCalendre!=null?!widget.isCalendre?  widget.isMulticity == false ?
                flightdepart.length>0? Container(
                 color: Colors.white,
                    child: Column(
                      children: [
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 0,right: 0,bottom: 0,top: 0),
                            child: Row(
                              children: [
                                Container(
                                  height:400,
                                  width: 325,
                                 color: Colors.white,
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
                                          ...flightdepart.map((flight){
                                            return Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                            ...flight['options'].map((options){
                                            //  int weight = flight['travelers'][0]['details'][0]['segments_details'][0]['includedCheckedBags']['weight'];
                                            //  String weightUnit = flight['travelers'][0]['details'][0]['segments_details'][0]['includedCheckedBags']['weightUnit'];
                                              dynamic includedCheckedBags = flight['travelers'][0]['details'][0]['segments_details'][0]['includedCheckedBags']['quantity'];
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
                                                         crossAxisAlignment: CrossAxisAlignment.start,
                                                         mainAxisAlignment: MainAxisAlignment.start,
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
                                                             weight:0,
                                                             weightUnit:'',
                                                             operaitedby:''
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
                                                       Text('${flight['price'].toStringAsFixed(2)} MAD',
                                                       style:TextStyle(
                                                            fontSize: 13,
                                                            color: appColor,
                                                            fontWeight: FontWeight.bold,
                                                       ),),
                                                       Radio(
                                                         value:"${flight['sequenceNumber']}",
                                                        groupValue:selcteddepart,
                                                        onChanged: (value){
                                                       setState(() {
                                                          selcteddepart = value;
                                                          departPrice =  flight['price'];
                                                          sequenceNumberdep = flight['sequenceNumber'];
                                                          flightDepartOneWay =flight;
                                                          print(flightDepartOneWay);
                                                       });
                                                       if (selctedretun != null) {
                                                        return showprice();
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
                               flightRetun.length>0?Container(
                                  height:flightRetun.length==1?220:400,
                                  width: 330,
                                   color: Colors.white,
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
                                        ...flightRetun.map((flight) {
                                  return Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                  ...flight['options'].map((options) {
                                    dynamic includedCheckedBags = flight['travelers'][0]['details'][0]['segments_details'][0]['includedCheckedBags']['quantity'];
                                   // int weight = flight['travelers'][0]['details'][0]['segments_details'][0]['includedCheckedBags']['weight'];
                                   // String weightUnit = flight['travelers'][0]['details'][0]['segments_details'][0]['includedCheckedBags']['weightUnit'];
                                   final arrivalDate = options['segments'][options['segments'].length - 1]['arrivalDateTime'];
                                   final departureAirport = options['segments'][0]['departureAirport'];
                                   final datedeparture = options['segments'][0]['departureDateTime'];
                                   final arrivalAirport = options['segments'][options['segments'].length - 1]['arrivalAirport'];
                                   final flightNumber = options['segments'][0]['flightNumber'];
                                   final arrivalAirportTerminal = options['segments'][options['segments'].length - 1]['arrivalAirportTerminal'];
                                   final departureAirportTerminal = options['segments'][0]['departureAirportTerminal'];
                                   final logo =flight['options'][0]['segments'][0]['marketingAirline'];
                                   final cabin = options['segments'][0]['cabin'];
                                   int stops = options['segments'].length - 1;
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
                                                   weight:0,
                                                   weightUnit:'',
                                                    operaitedby:''
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
                                             Text('${flight['price'].toStringAsFixed(2)} MAD',
                                             style:TextStyle(
                                                  fontSize: 13,
                                                  color: appColor,
                                                  fontWeight: FontWeight.bold,
                                             ),),
                                             Radio(value: "${flight['sequenceNumber']}",
                                              groupValue: selctedretun,
                                               onChanged: (value){
                                              setState(() {
                                                selctedretun = value;
                                                returnPrice = flight['price'];
                                                sequenceNumberRetu =flight['sequenceNumber'];
                                                flightRetunOneWay = flight;
                                                printFullText(flightRetunOneWay.toString());
                                              });
                                               if (selcteddepart != null) {
                                              return showprice();
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
                                ):SizedBox(height: 0,)
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                  :SizedBox(height: 0)
                  :SizedBox(height: 0)
                  :SizedBox(height: 0):SizedBox(height: 0),

                selctedretun != null && selcteddepart != null
                                  ? showprice()

                                  : SizedBox(
                                      height: 0,
                                    ),
                  SizedBox(
                                      height: 5,
                                    ),
                                     SizedBox(
                                      height: 10,
                                    ),
                 widget.isCalendre == false ? widget.isMulticity == false ?flightdepart.length>0?Container(color: appColor,height:3,width: double.infinity,):SizedBox(height: 0):SizedBox(height: 0):SizedBox(height: 0),


                 Padding(
                    padding: const EdgeInsets.only(left: 10,right: 10,top: 5),
                    child: Text('Best Price',style: TextStyle(
                      fontSize: 17,
                      color: appColor,
                      fontWeight: FontWeight.bold
                    )),
                  ), 
                   SizedBox(height: 5,),
                  Column(
                    children: [
                   flightData.length > 0 ?Column(
                          children: [
                       ...flightData.map((e){
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Stack(
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
                                 // Text('${e}'),
                              ...e['options'].map((options){
                                print('--------------------------------------------');

                                print('--------------------------------------------');
                                int weight =e['travelers'][0]['details']!=null? e['travelers'][0]['details'][0]['segments_details'][0]['includedCheckedBags']['weight']:null;
                                String weightUnit = e['travelers'][0]['details']!=null?e['travelers'][0]['details'][0]['segments_details'][0]['includedCheckedBags']['weightUnit']:null;
                                dynamic includedCheckedBags =e['travelers'][0]['details']!=null? e['travelers'][0]['details'][0]['segments_details'][0]['includedCheckedBags']!=null? e['travelers'][0]['details'][0]['segments_details'][0]['includedCheckedBags']['quantity']:0:0;
                                 final arrivalDate = options['segments'][options['segments'].length - 1]['arrivalDateTime'];
                                 final departureAirport = options['segments'][0]['departureAirport'];
                                 final datedeparture = options['segments'][0]['departureDateTime'];
                                 final arrivalAirport = options['segments'][options['segments'].length - 1]['arrivalAirport'];
                                 final flightNumber = options['segments'][0]['flightNumber'];
                                 final arrivalAirportTerminal = options['segments'][options['segments'].length - 1]['arrivalAirportTerminal'];
                                 final departureAirportTerminal = options['segments'][0]['departureAirportTerminal'];
                                 final logo = e['options'][0]['segments'][0]['marketingAirline'];
                                 final cabin = options['segments'][0]['cabin'];
                                 int stops = options['segments'].length - 1;
                                 var timedearival = DateTime.parse(arrivalDate);
                                 var Dateearival = DateTime.parse(arrivalDate);
                                 final arrivalDateTime = DateFormat('HH:mm').format(timedearival);
                                 final DatedaArival = DateFormat('yyyy-MM-dd').format(Dateearival);
                                 var dateedatedeparture = DateTime.parse(datedeparture);
                                 final datedepart = DateFormat('HH:mm').format(dateedatedeparture);
                                 final Datedateedatedeparture = DateFormat('yyyy-MM-dd',).format(dateedatedeparture);


                                       return buildticketCard(
                                         arrivalDateTime: arrivalDateTime,
                                         datedeparture: Datedateedatedeparture,
                                         arrivalAirport: arrivalAirport,
                                         departureAirport: departureAirport,
                                         departureDateTime:datedepart,
                                         duration: options['duration'].replaceAll("PT", ""),
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
                                         operaitedby:'${e['options'][0]['segments'][0]['marketingAirlineName']}'
                                       );}),


                                          Container(
                                           color: Colors.white,
                                           child: Row(
                                             children: <Widget>[
                                               SizedBox(
                                                 height: 20,
                                                 width: 10,
                                                 child: DecoratedBox(
                                                   decoration: BoxDecoration(
                                                       borderRadius:
                                                           BorderRadius.only(
                                                               topRight: Radius
                                                                   .circular(10),
                                                               bottomRight:
                                                                   Radius.circular(
                                                                       10)),
                                                       color: Colors.grey[300]),
                                                 ),
                                               ),
                                               Expanded(
                                                 child: Padding(
                                                   padding:
                                                       const EdgeInsets.all(8.0),
                                                   child: LayoutBuilder(
                                                     builder:
                                                         (context, constraints) {
                                                       return Flex(
                                                         children: List.generate(
                                                             (constraints.constrainWidth() /
                                                                     10)
                                                                 .floor(),
                                                             (index) => SizedBox(
                                                                   height: 1,
                                                                   width: 5,
                                                                   child:
                                                                       DecoratedBox(
                                                                     decoration: BoxDecoration(
                                                                         color: Colors
                                                                             .grey
                                                                             .shade400),
                                                                   ),
                                                                 )),
                                                         direction:
                                                             Axis.horizontal,
                                                         mainAxisSize:
                                                             MainAxisSize.max,
                                                         mainAxisAlignment:
                                                             MainAxisAlignment
                                                                 .spaceBetween,
                                                       );
                                                     },
                                                   ),
                                                 ),
                                               ),
                                               SizedBox(
                                                 height: 20,
                                                 width: 10,
                                                 child: DecoratedBox(
                                                   decoration: BoxDecoration(
                                                       borderRadius:
                                                           BorderRadius.only(
                                                         topLeft:
                                                             Radius.circular(10),
                                                         bottomLeft:
                                                             Radius.circular(10),
                                                       ),
                                                       color: Colors.grey[300]),
                                                 ),
                                               ),
                                             ],
                                           ),
                                         ),
                                          SizedBox(height: 0,),
                                          Container(
                                           padding: EdgeInsets.only(
                                               left: 0, right: 10, bottom: 12),
                                           decoration: BoxDecoration(
                                               color: Colors.white,
                                               boxShadow: [
                                                 BoxShadow(
                                                     blurRadius: 6,
                                                     color: Colors.grey[350],
                                                     offset: Offset(0, 0),
                                                     spreadRadius: 0)
                                               ],
                                               borderRadius: BorderRadius.only(
                                                   bottomLeft: Radius.circular(10),
                                                   bottomRight:
                                                       Radius.circular(10)
                                                       )
                                                       ),
                                           child: Row(
                                             mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                             children: <Widget>[
                                               Padding(
                                                 padding: const EdgeInsets.only(top: 20,left: 15),
                                                 child: GestureDetector(
                                                   onTap: (){
                                                    navigateTo(
                                       context,
                                       DetailsFlight(
                                         flights: e,
                                         timer:timer,
                                         currentIndex:widget.currentIndex,
                                          opertedby:'${e['options'][0]['segments'][0]['marketingAirlineName']}',
                                       ));
                                                   },
                                                   child: Row(
                                                     children: [
                                                       SizedBox(width: 3,),
                                                       Text('View details',
                                                        style: TextStyle(
                                                          fontSize: 14,
                                                          color: Colors.black,
                                                          fontWeight: FontWeight.w600),),
                                                     ],
                                                   ),
                                                 ),
                                               ),
                                               Padding(
                                                 padding: const EdgeInsets.only(
                                                     top: 20),
                                                 child: Text(
                                                     "${e['price']} ${e['currency']}",
                                                     textAlign: TextAlign.end,
                                                     style: TextStyle(
                                                         fontSize: 16,
                                                         fontWeight:
                                                             FontWeight.bold,
                                                         color:
                                                             appColor)),
                                               ),
                                               Padding(
                                                   padding: const EdgeInsets.only(
                                                       top: 10),
                                                   child: GestureDetector(
                                                         onTap: () {
                                                        navigateTo(
                                                        context,
                                                        ReservationPage(
                                                        providerType:e['providerType'],
                                                        flights: e,
                                                        timer:timer,
                                                        totalPrice:e['price'],
                                                        sequence_number:[e['sequenceNumber']],
                                                        currentIndex:widget.currentIndex,
                                                        parm: widget.parm,
                                                        FlightOneWay:null,
                                                         operitedby:'',
                                                       ));
                                                       },
                                                         child: Container(
                                                           height: 30,
                                                           width: 90,
                                                           decoration: BoxDecoration(
                                                               borderRadius:
                                                                   BorderRadius
                                                                       .circular(
                                                                           4),
                                                               color: appColor),
                                                           child: Center(
                                                               child: Text(
                                                             'booking',
                                                             style: TextStyle(
                                                                 color:
                                                                     Colors.white,
                                                                 fontWeight:
                                                                     FontWeight
                                                                         .bold),
                                                           )),
                                                         ),
                                                       )
                                                       )
                                             ],
                                           ),
                                         ),

                               ],
                             ),
                             ),
                             SizedBox(height: 5,),
                             Container(
                                  decoration: BoxDecoration(
                                    color:changeColor(e['providerType']),
                                    borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(0),
                                      bottomLeft: Radius.circular(0),
                                      topLeft: Radius.circular(5),
                                      topRight: Radius.circular(0),
                                    )
                                  ),
                              height: 100,
                              width:2,
                                ),

                          ],
                        ),
                      );
                       }).toList(),
                      ],
                    ):Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                  Container(color: appColor,height: 2.5,width: double.infinity,),
                   Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: Container(
                       height: 55,
                       color: Color(0xFFfff3cd),
                       child: Center(child: Padding(
                         padding: const EdgeInsets.all(5.0),
                         child: Text('there is no search result please try again with different dates',style: TextStyle(color: Color.fromARGB(255, 96, 82, 40)),textAlign: TextAlign.center,),
                       ))),
                   )
                  ],
                ),
                    ],
                  ),
                               
                  ],
                ):Column(
                      children: [
                        
                       ListView.builder(
                         shrinkWrap: true,
                         itemCount: 8,
                         itemBuilder: (context,index){
                         return Padding(
                         padding: const EdgeInsets.all(8.0),
                         child: Container(
                          
                           width: double.infinity,
                           decoration: BoxDecoration(
                              boxShadow: [
                BoxShadow(
                  blurRadius: 1,
                  color: Colors.grey[350],
                  offset: Offset(0, 0),
                  spreadRadius: 1),
                      ],
                             borderRadius: BorderRadius.circular(5),color: Colors.white,),
                           child: Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             mainAxisAlignment: MainAxisAlignment.start,
                             children: [
                             Padding(
                               padding: const EdgeInsets.all(8.0),
                               child: Column(
                                 children: [
                                    Row(
                children: <Widget>[
                Shimmer.fromColors(
                    baseColor: Colors.grey[300],
                                              highlightColor: Colors.grey[100],
                                              period:Duration(seconds: 2),
                  child: Container(
                    height: 14,
                    width: 100,
                    color: Colors.grey[100],
                    child: Text(
                      "ORY",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                ),
                SizedBox(
                  width: 16,
                ),
                SizedBox(
                  height: 6,
                  width: 6,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Stack(
                      children: <Widget>[
                        SizedBox(
                          height: 24,
                          child: LayoutBuilder(
                            builder: (context, constraints) {
                                return Flex(
                                  children: List.generate(
                                      (constraints.constrainWidth() / 6).floor(),
                                      (index) => SizedBox(
                                            height: 1,
                                            width: 3,
                                            child: DecoratedBox(
                                              decoration: BoxDecoration(
                                                  color: Colors.grey.shade300),
                                            ),
                                          )),
                                  direction: Axis.horizontal,
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                );
                            },
                          ),
                        ),
                        Center(
                            child: Transform.rotate(
                          angle: 1.5,
                          child: Icon(
                            Icons.local_airport,
                            color: appColor,
                            size: 24,
                          ),
                        ))
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 6,
                  width: 6,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                SizedBox(
                  width: 16,
                ),
                Shimmer.fromColors(
                    baseColor: Colors.grey[300],
                                              highlightColor: Colors.grey[100],
                                              period:Duration(seconds: 2),
                  child: Container(
                      height: 14,
                    width: 100,
                    color: Colors.grey[100],
                    child: Text(
                      "NCE",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                )
                ],
                      ),
                      Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                SizedBox(
                    width: 50,
                    child: Shimmer.fromColors(
                   baseColor: Colors.grey[300],
                   highlightColor: Colors.grey[100],
                   period:Duration(seconds: 2),
                      child: Container(
                          height: 13,
                    width: 50,
                    color: Colors.grey[100],
                        child: Text(
                          "09:30",
                          style: TextStyle(
                              fontSize: 13,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    )),
                Shimmer.fromColors(
                  baseColor: Colors.grey[300],
                                              highlightColor: Colors.grey[100],
                                              period:Duration(seconds: 2),
                  child: Container(
                    height: 12,
                    width: 75,
                    color: Colors.grey[100],
                    child: Text(
                      "",
                      style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 32, 26, 24)),
                    ),
                  ),
                ),
                 SizedBox(
                    width: 50,
                    child: Shimmer.fromColors(
                   baseColor: Colors.grey[300],
                                              highlightColor: Colors.grey[100],
                                              period:Duration(seconds: 2),
                      child: Container(
                          height: 13,
                    width: 50,
                    color: Colors.grey[100],
                        child: Text(
                          "09:30",
                          style: TextStyle(
                              fontSize: 13,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    )),
                ],
                      ),
                      SizedBox(
                height: 13,
                      ),
                      Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                   Shimmer.fromColors(
                     baseColor: Colors.grey[300],
                                              highlightColor: Colors.grey[100],
                                              period:Duration(seconds: 2),
                    child: Container(
                       height: 14,
                        width: 45,
                        color: Colors.red,
                      child: Text(
                        "2022-03-12",
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                
                  Shimmer.fromColors(
                     baseColor: Colors.grey[300],
                                              highlightColor: Colors.grey[100],
                                              period:Duration(seconds: 2),
                    child: Container(
                      height: 14,
                      width: 75,
                      color: Colors.white,
                      child: Row(
                        children: <Widget>[
                          Text(
                            "Flight",
                            style: TextStyle(fontSize: 11, color: Colors.grey),
                          ),
                          Text(
                            "222",
                            style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ),
                ]
                ),
                                 ],
                               ),
                             ),
                     Row(
                                        children: <Widget>[
                                          SizedBox(
                                            height: 20,
                                            width: 10,
                                            child: DecoratedBox(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topRight: Radius
                                                              .circular(10),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  10)),
                                                  color: Colors.grey[300]),
                                            ),
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: LayoutBuilder(
                                                builder:
                                                    (context, constraints) {
                                                  return Flex(
                                                    children: List.generate(
                                                        (constraints.constrainWidth() /
                                                                10)
                                                            .floor(),
                                                        (index) => SizedBox(
                                                              height: 1,
                                                              width: 5,
                                                              child:
                                                                  DecoratedBox(
                                                                decoration: BoxDecoration(
                                                                    color: Colors
                                                                        .grey
                                                                        .shade400),
                                                              ),
                                                            )),
                                                    direction:
                                                        Axis.horizontal,
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20,
                                            width: 10,
                                            child: DecoratedBox(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(10),
                                                    bottomLeft:
                                                        Radius.circular(10),
                                                  ),
                                                  color: Colors.grey[300]),
                                            ),
                                          ),
                                        ],
                                      ),
                                    Container(
                                        padding: EdgeInsets.only(
                                            left: 0, right: 10, bottom: 12),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                  blurRadius: 6,
                                                  color: Colors.grey[350],
                                                  offset: Offset(0, 0),
                                                  spreadRadius: 0)
                                            ],
                                            borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(10),
                                                bottomRight:
                                                    Radius.circular(10)
                                                    )
                                                    ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.only(top: 10,left: 10),
                                              child: Shimmer.fromColors(
                                                baseColor: Colors.grey[300],
                                              highlightColor: Colors.grey[100],
                                              period:Duration(seconds: 2),
                                                child: Container(height: 40,width: 80,color: Colors.red,)),
                                            ),
                                          
                                            Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 10),
                                                child: Shimmer.fromColors(
                                                   baseColor: Colors.grey[300],
                                              highlightColor: Colors.grey[100],
                                              period:Duration(seconds: 2),
                                                  child: Container(
                                                    height: 30,
                                                    width: 90,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    4),
                                                        color: Color(
                                                            0xFFF28300)),
                                                    child: Center(
                                                        child: Text(
                                                      'booking',
                                                      style: TextStyle(
                                                          color:
                                                              Colors.white,
                                                          fontWeight:
                                                              FontWeight
                                                                  .bold),
                                                    )),
                                                  ),
                                                )
                                                    )
                                          ],
                                        ),
                                      ), 
                
                             ],
                           ),
                         ),
                       );
                       })
                      ],
                    ),
              )
              );
        },
      ),
    );
  }

  buildSlideLabel(dynamic value) {
    return Text(
      "${value.round().toString()} MAD",
      style: TextStyle(
          fontSize: 15, fontWeight: FontWeight.w600, color: Colors.grey),
    );
  }
}



