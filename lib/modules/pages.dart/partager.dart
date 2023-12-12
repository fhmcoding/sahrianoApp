import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahariano_travel/drawer/menuwidget.dart';
import 'package:sahariano_travel/layout/cubit/cubit.dart';
import 'package:sahariano_travel/layout/cubit/states.dart';





class Partager extends StatefulWidget {
 Partager({ Key key ,}) : super(key: key);
  @override
  _PartagerState createState() => _PartagerState();
}
class _PartagerState extends State<Partager> {
   // UserModel model;
  // double xoffset ;
  // double yoffset;
  // double scaleFactor;
  // bool isDragging = false;
  // bool isDrawerOpen;
  // // DrawerItem item = DrawerItems.home;
  // String uid;
  // String token;
  // String selectelang = ENGLSIH;
  // String language = Cachehelper.getData(key: "langugeCode"); 
  //   String currency = Cachehelper.getData(key: "currency");
  //     String firstName = Cachehelper.getData(key: "firstName");
  // String lastName = Cachehelper.getData(key: "lastName");
  // String phone = Cachehelper.getData(key: "phone");
  // String access_token = Cachehelper.getData(key: "access_token");
  // @override
  // void initState() {
     
  //   // var token = FirebaseMessaging.instance.getToken().then((value) {
  //   //  Cachehelper.saveData(key: "token", value: token);
  //   // });
    
  //   // uid = FirebaseAuth.instance.currentUser.uid;
  //   Cachehelper.saveData(key: "uid", value: uid);
    
  //   print(uid);
  //  closeDrawer();
  //   super.initState();
  // }
  // void openDrawer()=>setState(() {
  //   String language = Cachehelper.getData(key: "langugeCode"); 
  //   print(language);
  //  xoffset =language == 'ar'?-180:270;
  //  yoffset = 90;
  //  scaleFactor =0.8;
  //  isDrawerOpen = true;
  // });
  // void closeDrawer()=>setState(() {
    
  //  xoffset = 0;
  //  yoffset = 0;
  //  scaleFactor = 1;
  //  isDrawerOpen = false;
  // });
  
  // int id = Cachehelper.getData(key: "id");
  
    
 

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>AppCubit(),
      child: BlocConsumer<AppCubit,AppStates>(
        listener:(context,state){} ,
        builder: (context,state){          
          return Scaffold(           
           appBar:AppBar(
            leading:  MenuWidget(),
           ),
          );
        },
      ),
    );
  }
}
 

