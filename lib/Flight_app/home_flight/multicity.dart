import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sahariano_travel/Flight_app/country_service.dart';
import 'package:sahariano_travel/Flight_app/countryserch_delegate.dart';
import 'package:sahariano_travel/Flight_app/cubit_flight/cubit.dart';
import 'package:sahariano_travel/Flight_app/cubit_flight/states.dart';
import 'package:sahariano_travel/Flight_app/pages/select_flight.dart';
import 'package:sahariano_travel/modeles/mylistModel.dart';
import 'package:sahariano_travel/shared/components/components.dart';
import 'package:sahariano_travel/shared/components/constants.dart';
final countryService = new CountryService();
class Multicity extends StatefulWidget {
      final int currentIndex;
    String datedepart;
  Multicity({Key key, this.currentIndex}) : super(key: key);

  @override
  _MulticityState createState() => _MulticityState();
}

class _MulticityState extends State<Multicity> {
   var Cabin = "ALL";
    int selectedRival;

  List cabins =[{
        "label":"All",
        "value":"ALL"
    },
    {
        "label":"Economy",
        "value":"ECONOMY"
    },
    {
        "label":"Premium economy",
        "value":"PREMIUM_ECONOMY"
    },
    {
        "label":"Business class",
        "value":"BUSINESS"
    },
    {
        "label":"First class",
        "value":"FIRST"
    }];
      void initState() {
             selectedRival =0;

    countryService.datedepart = null;
    countryService.selecedepart =null;
    countryService.selecedretur= null;  
    countryService.datedepart = null;
    countryService.departureDate = null;
    super.initState();
  }
 
  List flight = [];
  List<MyList> myList = [
      MyList(
       originLocationCode:countryService.selecedepart,
       destinationLocationCode:countryService.selecedretur,
       departureDate:countryService.datedepart,
      ),
      MyList(
      originLocationCode:countryService.selecedepart,
      destinationLocationCode:countryService.selecedretur,
      departureDate:countryService.datedepart,
      ),
];
  submitData(){
   myList.forEach((element) {
     flight.add(
      {
      "originLocationCode":"${element.originLocationCode}",
      "destinationLocationCode":"${element.destinationLocationCode}",
      "departureDate":"${element.departureDate}",
      "cabin": "${Cabin}",
      "range": 1
     
      }
     );
    });
    print(flight);
  }
  addDynamic() {
    if (myList.length >= 6) {
      return;
    }
    myList.add(
      MyList(
       originLocationCode:null,
       destinationLocationCode:null,
       departureDate:null,
      ),
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>FlightCubit(),
      child: BlocConsumer<FlightCubit,FlightStates>(
        listener:(context,state){},
        builder: (context,state){
          return  Scaffold(
            backgroundColor: Colors.white,
          bottomNavigationBar:buildButton(
                      text: 'Search Flights',
                      ontap: () {
                        if (countryService.selecedretur!=null&&countryService.selecedepart!=null&&countryService.departureDate!=null) {
                        if (flight.length>0){
                        flight =[];
                        submitData();
                        navigateTo(context, 
                        SelectFlight(
                        currentIndex: widget.currentIndex,
                        type:'multi_destination',
                        flight:flight,
                        qte_adults:countryService.adults,
                        qte_children:countryService.childerns,
                        qte_infants: countryService.infants,
                        isaddOneWayOffers: false,
                        depart: null,
                        retun: null,
                        departOneWay: null,
                        isCalendre: false,
                        isMulticity: true,
                         ));
                         }else{
                         submitData();
                        navigateTo(context, 
                        SelectFlight(
                        currentIndex: widget.currentIndex,
                        type:'multi_destination',
                        flight:flight,
                        qte_adults:countryService.adults,
                        qte_children:countryService.childerns,
                        qte_infants: countryService.infants,
                        isaddOneWayOffers: false,
                        depart: null,
                        retun: null,
                        departOneWay: null,
                        isCalendre: false,
                        isMulticity: true,
                         ));
                         }

                        }




                        // if (countryService.departureDate!=null&&countryService.selecedepart!=null&&countryService.selecedretur!=null) {
                        //    if (flight.length>0) {
                        //   submitData();
                        //   flightCubit.Multydestination(
                        //   flight,
                        //   qte_adults:countryService.adults,
                        //   qte_children:countryService.childerns,
                        //   qte_infants: countryService.infants,
                        //   );
                        //  }else{
              
                        //   submitData();
                        //   flightCubit.Multydestination(
                        //   flight,
                        //   qte_adults:countryService.adults,
                        //   qte_children:countryService.childerns ,
                        //   qte_infants: countryService.infants,);
                        //  }

                        // }
                        }
                          ),
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                  SizedBox(height: 20,),
                ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount:myList.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Padding(
                             padding: const EdgeInsets.only(left: 10,),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10, right: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        height: 30,
                                        width: 30,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5),
                                          color: appColor,
                                        ),
                                        child: Center(
                                            child: Text(
                                          '${index + 1}',
                                          style: TextStyle(color: Colors.white),
                                        )),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text('Flight',
                                          style: TextStyle(
                                              color: Color(0xFF38444a),
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600)),
                                    ],
                                  ),
                                  if(index>1)
                                  GestureDetector(
                                    onTap: (){
                                       myList.removeAt(index);
                                      setState(() {});
                                    },
                                    child: Icon(Icons.close))
                                ],
                              ),
                            ),
                          ),

                        Oneway(context,departdate:myList[index].departureDate,
                       onchange: (){
                          showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2040 - 05 - 01))
                    .then((value) {
                  setState(() {
                   countryService.datedepart =  DateFormat.MMMEd().format(value);
                   countryService.departureDate = DateFormat('yyyy-MM-dd').format(value);
                    myList[index].departureDate = countryService.departureDate;
                  });
                });
                     },
                        onconvert:(){
                        setState(() {
                        var pivot= myList[index].originLocationCode;
                         myList[index].originLocationCode=myList[index].destinationLocationCode;
                        myList[index].destinationLocationCode=pivot;
                       });},
                        hintdepart:myList[index].originLocationCode!=null? '${myList[index].originLocationCode}':'Choose Depart',
                        hintrutur:myList[index].destinationLocationCode!=null?'${myList[index].destinationLocationCode}':'Choose Arival',
                        ontapdepart:() async{
                     countryService.selecedepart =  await showSearch(
                            context: context,
                            delegate: CountrySearchDelegate());
                            setState(() {
                              myList[index].originLocationCode = countryService.selecedepart;
                            });
                      },
                        ontaprutur:  () async{
                     countryService.selecedretur =  await showSearch(
                            context: context,
                            delegate: CountrySearchDelegate());
                         setState(() {
                            myList[index].destinationLocationCode = countryService.selecedretur;
                         });
                      
                      },),
                        ],
                      );
                    }),
                SizedBox(
                  height: 10,
                ),
                myList.length < 6
                    ? Center(
                        child: GestureDetector(
                        onTap: addDynamic,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 30,right: 30),
                          child: Container(
                            height: 55,
                            width: double.infinity,
                            decoration: BoxDecoration(
                           boxShadow: [
                           BoxShadow(
                      blurRadius: 5,
                      color: appColor,
                      offset: Offset(1, 1),
                      spreadRadius: 0)
                          ],
                          border: Border.all(
                            color: appColor,
                            width: 2.5
                          ),
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                            child: Center(
                                child: Text('Add flight',
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 255, 136, 0),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700))),
                          ),
                        ),
                      ))
                    : SizedBox(height: 0),

                SizedBox(
                  height: 10,
                ),
                 Padding(
                   padding: const EdgeInsets.only(left: 10,bottom: 0),
                   child: buildTitel(title:'Persons',iconData: Icons.group),
                 ),
             Padding(
                      padding: const EdgeInsets.only(left: 30,right: 30,top: 10,bottom: 10),
                      child: Container(
                        height: 200,
                        width: double.infinity,
                        decoration: BoxDecoration(
                           boxShadow: [
                           BoxShadow(
                      blurRadius: 5,
                      color: appColor,
                      offset: Offset(1, 1),
                      spreadRadius: 0)
                          ],
                          border: Border.all(
                            color: appColor,
                            width: 2.5
                          ),
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            buildPersons(
                                title: 'Adults',
                                subtitle: '(>12 years)',
                                qty: countryService.adults,
                                bool: countryService.adults < 9,
                                ontapplus: () {
                                  if (countryService.adults < 9) {
                                    setState(() {
                                      countryService.adults++;
                                    });
                                  }
                                },
                                ontapmins: () {
                                  if (countryService.adults > 1) {
                                    setState(() {
                                      countryService.adults--;
                                    });
                                  }
                                }),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: double.infinity,
                              height: 1.5,
                              color: Colors.grey[200],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            buildPersons(
                                title: 'Children',
                                subtitle: '(2-12 years)',
                                qty: countryService.childerns,
                                bool: countryService.childerns < 4,
                                ontapplus: () {
                                  if (countryService.childerns < 4) {
                                    setState(() {
                                      countryService.childerns++;
                                    });
                                  }
                                },
                                ontapmins: () {
                                  if (countryService.childerns > 0) {
                                    setState(() {
                                      countryService.childerns--;
                                    });
                                  }
                                }),
                            SizedBox(
                              height: 15,
                            ),
                            Container(
                              width: double.infinity,
                              height: 1,
                              color: Colors.grey[200],
                            ),
                            SizedBox(
                              height: 13,
                            ),
                            buildPersons(
                                title: 'infants',
                                subtitle: '(<2 years)',
                                qty: countryService.infants,
                                bool: countryService.infants < 1,
                                ontapplus: () {
                                  if (countryService.infants < 1) {
                                    setState(() {
                                      countryService.infants++;
                                    });
                                  }
                                },
                                ontapmins: () {
                                  if (countryService.infants > 0) {
                                    setState(() {
                                      countryService.infants--;
                                    });
                                  }
                                }),
                          ],
                        ),
                      ),
                    ),
                   Padding(
                      padding: const EdgeInsets.only(left: 10,bottom: 0),
                      child: buildTitel(title: 'Cabin Class', iconData: Icons.chair),
                    ),
                   buildCabinClass(
                      cabins:[
                        ...cabins.map((e){
                              return  Padding(
                                 padding: const EdgeInsets.all(8.0),
                                 child: GestureDetector(
                                   onTap: (){
                                    setState((){
                                    Cabin = e['value'];
                                    selectedRival = cabins.indexOf(e);
                                    });
                                   },
                                   child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color:  selectedRival == cabins.indexOf(e)?appColor:Color.fromARGB(255, 243, 243, 243)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [ 
                            Text(
                              '${e['label']}',
                              style: TextStyle(
                                  color:selectedRival == cabins.indexOf(e)?Color.fromARGB(255, 255, 255, 255):Colors.black,
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold),
                            ),
                            
                          ],
                        ),
                                    ),
                                 ),
                               );
                             })
                      ]
                    ),
               SizedBox(height: 25,),
              ],
            ),
          ),
        );
        },
      ),
    );
  }
}

