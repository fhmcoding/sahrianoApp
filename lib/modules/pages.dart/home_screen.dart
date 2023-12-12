import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahariano_travel/Flight_app/home_flight/home_flight.dart';
import 'package:sahariano_travel/ataycom_app/layout/cubit/cubit.dart';
import 'package:sahariano_travel/ataycom_app/pages/homePage.dart';
import 'package:sahariano_travel/kerina.dart';
import 'package:sahariano_travel/layout/cubit/cubit.dart';
import 'package:sahariano_travel/layout/cubit/states.dart';
import 'package:sahariano_travel/main.dart';
import 'package:sahariano_travel/modules/pages.dart/notification/notification.dart';
import 'package:sahariano_travel/shared/components/constants.dart';
import 'package:sahariano_travel/shared/network/remote/local/cache_helper.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sahariano_travel/modification.dart';
import 'package:sahariano_travel/update.dart';


class HomeScreen extends StatefulWidget {
  int selectedIndex ;
   HomeScreen({ Key key, this.selectedIndex}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}
  String language = Cachehelper.getData(key: "langugeCode"); 
   TabController tabcontroller;
   int selected = 0;
    int count =0;
class _HomeScreenState extends State<HomeScreen>{
int SelectedIndex = service.indexId;
@override
  void initState() {
    SelectedIndex = widget.selectedIndex;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    List<Widget>screens=[
     Home_Flight(currentIndex:0),
     
    
     // FutureBuilder(
     //    future:checkupdate(),
     //    builder: (BuildContext context,snapshot){
     //      return snapshot.data==true?Update():HomePage(type:parfum,currentIndex:1,articleType:"Perfums",);
     //    },
     //  ),
      KerinaApp(currentIndex: 2),
     NotificationScreen(selectedIndex: 3,),
     Modification( currentIndex: 4,)

    ];


     showColor(int index){
     if (index == 0) {
       return appColor;
     }
     if (index == 1) {
       return parfumColor;
     }
     if (index == 2) {
       return appColor;
     }
      if (index == 3) {
       return appColor;
     };
    }


  return BlocProvider(
    create: (BuildContext context)=>AppCubit()..GetNotificationnuevo(estado: 'nuevo'),
    child: BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){
       if (state is GetNotificationPROCESSEDSuccessState) {
         state.count = count;
       }
      },
      builder: (context,state){
        var cubit = AppCubit.get(context);
         return  Scaffold(
          bottomNavigationBar:
          BottomNavigationBar(
            showSelectedLabels: true,
            selectedItemColor:showColor(SelectedIndex),
          
            type: BottomNavigationBarType.fixed,
            onTap: (index){
              
             setState(() {
                SelectedIndex = index ;
                cubit.GetNotificationnuevo(estado: 'nuevo');
             });
            },
            currentIndex:SelectedIndex ,
          items: [
            BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.planeUp),label: 'Voles'),
           // BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.sprayCanSparkles),label: 'Parfum'),
           BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.idCard),label: 'Kreina'),
           BottomNavigationBarItem(icon: Stack(
             children: [
               Icon(Icons.notifications),
             Service.oldNotification.length!=0?CircleAvatar(
               backgroundColor:Colors.red,
               radius: 7,child: Text('${Service.oldNotification.length}',style: TextStyle(fontSize: 11,fontWeight: FontWeight.bold,),),):SizedBox(height: 0),
             ],
           ),label: 'Notifications'),
           BottomNavigationBarItem(icon: Icon(Icons.edit),label: 'Demanded'),
          ]),
          
           body:screens[SelectedIndex]
                );
      },
          ),
  );
  }

}
