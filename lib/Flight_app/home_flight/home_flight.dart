import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahariano_travel/Flight_app/home_flight/multicity.dart';
import 'package:sahariano_travel/Flight_app/home_flight/oneWay.dart';
import 'package:sahariano_travel/Flight_app/home_flight/roundTrip.dart';
import 'package:sahariano_travel/drawer/menuwidget.dart';
import 'package:sahariano_travel/layout/cubit/cubit.dart';
import 'package:sahariano_travel/layout/cubit/states.dart';
import 'package:sahariano_travel/shared/components/constants.dart';
import 'package:sahariano_travel/shared/network/remote/local/cache_helper.dart';

class Home_Flight extends StatefulWidget {
  final int currentIndex;
  const Home_Flight({ Key key ,this.currentIndex}) : super(key: key);

  @override
  _Home_FlightState createState() => _Home_FlightState();
}
class _Home_FlightState extends State<Home_Flight> with SingleTickerProviderStateMixin{
       String firstName = Cachehelper.getData(key: "firstName");
  String lastName = Cachehelper.getData(key: "lastName");
  String phone = Cachehelper.getData(key: "phone");
   TabController tabcontroller;
   @override
  void initState() {
     tabcontroller  = TabController(length: 3, vsync: this);
    super.initState();
  }
   @override
void dispose(){
     tabcontroller.dispose();
     super.dispose();
}
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>AppCubit(),
      child: BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){},
        builder: (context,state){
          return  Scaffold(
           backgroundColor: Colors.white,
          appBar: AppBar(
            bottom: TabBar(
              padding: EdgeInsets.only(left: 20,right: 10,top: 0,bottom: 0),
                     unselectedLabelColor: Colors.grey[600],
                     labelColor: Colors.white,
                      indicator: BoxDecoration(
                        color: appColor,
                        borderRadius: BorderRadius.circular(10)
                      ),
                      controller: tabcontroller,
                      tabs: [
                        Tab(
                         child: Text('One Way',style: TextStyle(fontSize: 12,),),
                        ),
                         Tab(
                         child: Text('Round Trip',style: TextStyle(fontSize: 12),),
                        ),
                        Tab(
                         child: Text('Multicity',style: TextStyle(fontSize: 12),),
                        ),
                        
                      ],
                    ),
            centerTitle: true,
            backgroundColor: Colors.white,
            elevation: 0,
            title: Text('Search Flights',style: TextStyle(color: appColor,fontSize: 22,),),
            leading: MenuWidget(color: Colors.black),
          ),
          body:TabBarView(
              controller:tabcontroller,
              children: [
                One_Way(currentIndex: widget.currentIndex),
                Round_trip(currentIndex: widget.currentIndex),
                Multicity(currentIndex: widget.currentIndex)
              ]
            ),
          
        );
        },
      ),
    );
  }
}