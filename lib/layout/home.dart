import 'package:flutter/material.dart';
import 'package:sahariano_travel/ataycom_app/layout/cubit/cubit.dart';
import 'package:sahariano_travel/drawer/draweitem_menu.dart';
import 'package:sahariano_travel/drawer/menupage.dart';
import 'package:sahariano_travel/kerina.dart';
import 'package:sahariano_travel/main.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:sahariano_travel/modules/pages.dart/home_screen.dart';
import 'package:sahariano_travel/modules/pages.dart/notification/notification.dart';
import 'package:sahariano_travel/modules/pages.dart/profile.dart';
import 'package:sahariano_travel/modules/pages.dart/shoppings.dart';
import 'package:sahariano_travel/modules/pages.dart/users.dart';
import 'package:sahariano_travel/share_app.dart';
import 'package:sahariano_travel/shared/network/remote/local/cache_helper.dart';
import 'package:sahariano_travel/update.dart';

class Home extends StatefulWidget {
   int Index;
   final  String firstName;
   final String lastName;
   final String phone;
   final String password;
   Home({Key key,this.Index, this.firstName, this.lastName, this.phone, this.password}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}
class _HomeState extends State<Home> {
 String phone = Cachehelper.getData(key:"phone");

   String language = Cachehelper.getData(key: "langugeCode");
    int id = Cachehelper.getData(key: "id");
     MenuItem currentItem = MenuItems.home;
void initState() {   
   setState(() {
      widget.Index = service.indexId;
   });
    super.initState();
  }
     @override
  
  Widget build(BuildContext context){
    
    return ZoomDrawer(
    style: DrawerStyle.Style1,
    borderRadius: 40,
    showShadow: true,
    shadowLayer1Color: Color(0xFFed6905),
    // Color(0xFFed6905)
    
    slideWidth:language =='ar'? MediaQuery.of(context).size.width*0.4:MediaQuery.of(context).size.width*0.5,
    backgroundColor: Colors.grey[100],
    angle: -0.00,
    isRtl:language == 'ar'? true:false,
    menuScreen: Builder(
      builder: (context) {
        return MenuPage(
          currentItem:currentItem,
          onSelectedItem:(item){
             setState(() {
               currentItem = item;
               ZoomDrawer.of(context).close();
             });
            
          } 
        );
      }
    ),
    mainScreen: getScreen(),
    );
  }
    Widget getScreen(){
     if (currentItem ==MenuItems.home){
      return FutureBuilder(
        future:checkupdate(),
        builder: (BuildContext context,snapshot){
          return snapshot.data==true?Update():HomeScreen(selectedIndex: widget.Index,);
        },
      );
     }if (currentItem ==MenuItems.profile){
      return Profile(id:id,selectedIndex:widget.Index);
     }if (currentItem ==MenuItems.shoppings){
      return Shopping(selectedIndex:widget.Index);
     }if (currentItem ==MenuItems.krina){
      return KerinaApp(currentIndex:widget.Index);
     }if (currentItem ==MenuItems.notification){
      return NotificationScreen(selectedIndex:widget.Index);
     }if (currentItem ==MenuItems.shareapp){
      return ShereApp(selectedIndex:widget.Index);
     }if (currentItem ==MenuItems.contactus){
      return Users(id: id,selectedIndex:widget.Index);
     }
    return InializeWidget();


      
    }
}


