

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:sahariano_travel/layout/cubit/cubit.dart';
// import 'package:sahariano_travel/layout/cubit/states.dart';
// import 'package:sahariano_travel/localization/demo_localization.dart';
// import 'package:sahariano_travel/main.dart';
// import 'package:sahariano_travel/modules/pages.dart/login_page.dart';
// import 'package:sahariano_travel/modules/pages.dart/notification/notification.dart';
// import 'package:sahariano_travel/modules/pages.dart/partager.dart';
// import 'package:sahariano_travel/modules/pages.dart/profile.dart';
// import 'package:sahariano_travel/modules/pages.dart/shoppings.dart';
// import 'package:sahariano_travel/modules/pages.dart/users.dart';
// import 'package:sahariano_travel/shared/network/remote/local/cache_helper.dart';


// class DrawerWidget extends StatelessWidget {
//   //  final ValueChanged<DrawerItem>onSelectedItem;
//    DrawerWidget({ Key key,}) : super(key: key);

//   @override
//  Widget build(BuildContext context) {
//     return  BlocProvider(
//       create: (BuildContext context)=>AppCubit(),
//       child: BlocConsumer<AppCubit,AppStates>(
//        listener: (context,state){},
//        builder: (context,state){
//          return SafeArea(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   SizedBox(height: 180,),
//                   buildDrawerItems(context)
//                 ],
//               ),
//           );
//        },
//       ),
//     );
//   }
// }
 
// Widget buildDrawerItems(BuildContext context) {
//    int id = Cachehelper.getData(key: "id");
//   var cubit = AppCubit.get(context);
//   return Padding(
//     padding: const EdgeInsets.only(right: 15,left: 15),
//     child: Column(
//         children: [
//            GestureDetector(
//              onTap: (){
//                 Navigator.push(context, MaterialPageRoute(builder: (context)=>InializeWidget()));
//              },
//              child: ListTile(
               
//                  title: Text(DemoLocalization.of(context)
//                                   .getTranslatedValue('home_layout'),style: TextStyle(color: Color(0xFFf37021),fontSize:18,fontWeight: FontWeight.bold),),
//                  leading:Icon(Icons.home,size: 25,color:Color(0xFFf37021)),
//                ),
//            ),
//          GestureDetector(
//              onTap: (){
//                Navigator.push(context, MaterialPageRoute(builder: (context)=>Profile(id:id,)));
//              },
//              child: ListTile(
//                  title: Text(DemoLocalization.of(context)
//                                   .getTranslatedValue('profile_account'),style: TextStyle(color:Color(0xFFf37021),fontSize:18,fontWeight: FontWeight.bold),),
//                  leading:Icon(Icons.person_rounded,size: 25,color:Color(0xFFf37021),),
//                ),
    
//            ),
//          GestureDetector(
//              onTap: (){
//               //  Navigator.push(context, MaterialPageRoute(builder: (context)=>Profile()));
//              },
//              child: ListTile(
//                  title: Text(DemoLocalization.of(context)
//                                   .getTranslatedValue('vols_ticket'),style: TextStyle(color: Color(0xFFf37021),fontSize:18,fontWeight: FontWeight.bold),),
//                  leading:Icon(Icons.flight_outlined,size: 25,color:Color(0xFFf37021),),
//                ),
//            ),
//             GestureDetector(
//              onTap: (){
//                Navigator.push(context, MaterialPageRoute(builder: (context)=>Shopping()));
//              },
//              child: ListTile(
//                  title: Text(DemoLocalization.of(context)
//                                   .getTranslatedValue('shoppings_store'),style: TextStyle(color: Color(0xFFf37021),fontSize:18,fontWeight: FontWeight.bold),),
//                  leading:Icon(Icons.shopping_cart_rounded,size: 25,color:Color(0xFFf37021),)
//                ),
//            ),
//             GestureDetector(
//              onTap: (){
//                Navigator.push(context, MaterialPageRoute(builder: (context)=>NotificationScreen()));
//              },
//              child: ListTile(
//                  title: Text(DemoLocalization.of(context)
//                                   .getTranslatedValue('notification_vue'),style: TextStyle(color: Color(0xFFf37021),fontSize:18,fontWeight: FontWeight.bold),),
//                 leading:Icon(Icons.notifications,size: 25,color:Color(0xFFf37021),),
//                ),
//            ),
//             GestureDetector(
//              onTap: (){
//                Navigator.push(context, MaterialPageRoute(builder: (context)=>Users(id:cubit.Uid,)));
//              },
//              child: ListTile(
//                  title: Text(DemoLocalization.of(context)
//                                   .getTranslatedValue('contact_us'),style: TextStyle(color: Color(0xFFf37021),fontSize:18,fontWeight: FontWeight.bold),),
//                  leading:Icon(Icons.phone,size: 25,color:Color(0xFFf37021),),
//                ),
//            ),
//             GestureDetector(
//              onTap: (){
//              Navigator.push(context, MaterialPageRoute(builder: (context)=>Partager()));
//              },
//                child: ListTile(
//                  title: Text(DemoLocalization.of(context)
//                                   .getTranslatedValue('partager_app'),style: TextStyle(color: Color(0xFFf37021),fontSize:18,fontWeight: FontWeight.w600),),
//                  leading:Icon(Icons.share,size: 25,color:Color(0xFFf37021),),
//                ),
    
//            ),
//             GestureDetector(
//              onTap: (){
//               FirebaseAuth.instance.signOut();
//               Cachehelper.removeData(key: "id");
//               Cachehelper.removeData(key: "firstName");
//               Cachehelper.removeData(key: "lastName");
//               Cachehelper.removeData(key: "currency");
//               Cachehelper.removeData(key: "phone");
//               Cachehelper.removeData(key: "language");
//               Cachehelper.removeData(key: "type");
//               Cachehelper.removeData(key: "access_token");
//               Cachehelper.removeData(key: "token_type");
//               Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));
//              },
//              child: ListTile(
//                  title: Text(DemoLocalization.of(context)
//                                   .getTranslatedValue('log_out'),style: TextStyle(color:Color(0xFFf37021),fontSize:18,fontWeight: FontWeight.bold),),
//                  leading:Icon(Icons.logout_outlined,size: 25,color:Color(0xFFf37021),),
//                ),
//            ),
    
//         ]
    
//       ),
//   );
// }

