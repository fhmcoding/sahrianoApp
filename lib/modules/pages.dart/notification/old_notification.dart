import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:sahariano_travel/layout/cubit/cubit.dart';
import 'package:sahariano_travel/layout/cubit/states.dart';
import 'package:sahariano_travel/localization/demo_localization.dart';
import 'package:sahariano_travel/modules/pages.dart/notification/notification_web.dart';
import 'package:sahariano_travel/shared/components/components.dart';
import 'package:sahariano_travel/shared/components/constants.dart';

class OldNotification extends StatefulWidget {
  const OldNotification({ Key key,  }) : super(key: key);

  @override
  _OldNotificationState createState() => _OldNotificationState();
}

class _OldNotificationState extends State<OldNotification> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>AppCubit()..GetNotificationnuevo(estado: 'nuevo'),
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (context,state){
         
        },
        builder: (context,state){
         //  final retVal = list1.removeAt(index);
        var list2 = Service.newNotification;
         print('New notification:${list2.length}');
           return SingleChildScrollView(
          child: Column(
            children: [
              buildContainer(
                  notification:list2,
                   text: DemoLocalization.of(context).getTranslatedValue('new_notificationtoday'),
                   notificationWidget: [
                      BuildCondition(
                   condition:AppCubit.get(context).isloading,
                   builder: (context){
                     return list2.length>0?ListView.builder(
                       physics: NeverScrollableScrollPhysics(),
                          itemCount: list2.length,
                          shrinkWrap: true,
                          itemBuilder: (context,index){
                          return buildNotification(
                            list2[index],
                            isRead: false,
                            onTap: (){
                              showDialog(context: context, builder: (context){
                              final Date1 = DateTime.parse(list2[index]['publication_date_time']);
                              final date =  DateFormat('yyyy-MM-dd').format(Date1); 
                              return StatefulBuilder(
                              builder: (BuildContext context,setState) {
                              return Dialog(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                       color: Colors.white,
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Stack(
                                          alignment: AlignmentDirectional.topEnd,
                                          children: [
                                            Container(
                                              height: 200,
                                              width: double.infinity,
                                              child:ClipRRect(
                                                borderRadius: BorderRadius.only(
                                                  bottomLeft: Radius.circular(0),
                                                  bottomRight: Radius.circular(0),
                                                  topLeft: Radius.circular(5),
                                                  topRight: Radius.circular(5),
                                                ),
                                                child: Image.network("${list2[index]["img"]}",fit: BoxFit.fill,)),
                                            ),
                                                Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: GestureDetector(
                                                    onTap: (){
                                                      Navigator.of(context).pop();
                                                    },
                                                    child: CircleAvatar(
                                                      maxRadius: 17,
                                                      backgroundColor: Colors.red,
                                                      child: Icon(Icons.close)),
                                                  ),
                                                )
                                          ],
                                          ),
                                           SizedBox(height: 5,),
                                          
                                           Padding(
                                                   padding: const EdgeInsets.only(left: 15,right: 15),
                                                   child: Text("${list2[index]['titel']}",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold)),
                                                 ),
                                                  SizedBox(height: 5,),
                                                
                                                 Padding(
                                                  padding: const EdgeInsets.only(left: 15,right: 15),
                                                   child: Text(Jiffy(date).fromNow(),style: TextStyle(fontSize: 14,color: Color.fromARGB(255, 86, 85, 85)),),
                                                 ),
                                                 SizedBox(height: 6,),
                                         ...list2[index]['body'].map((e){
                                           return Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                 
                                                e['type']=='text' ?Padding(
                                                    padding: const EdgeInsets.only(left: 15,right: 15),
                                                    child: Text("${e['content']}",style: TextStyle(fontSize: 16,color: Color.fromARGB(255, 49, 49, 49),fontWeight: FontWeight.w400),),
                                                  ):SizedBox(height: 0),
                                                   e['type']=='button' ? Padding(
                                            padding: const EdgeInsets.only(left: 15,right: 15,top: 15,bottom: 15),
                                            child: GestureDetector(
                                              onTap: (){
                                              Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                              builder: (context) => NotificationWeb(url:'${e['content']}',)));
                                              },
                                              child: Container(
                                                    height: 55,
                                                    decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(5),
                                                    color: Color(0xFFF28300)),
                                                    width: double.infinity,
                                                    child: Center(
                                                        child: Text(
                                                      "${e['label']}",
                                                      style: TextStyle(
                                                        fontSize: 20,
                                                        color: Colors.white,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                      textAlign: TextAlign.center,
                                                    )),
                                                  ),
                                            ),
                                         ):SizedBox(height: 0),
                                                ],
                                              );
                                         }),
                                                  
                                        
                                      
                                       
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                              },
                            
                          );
                        });
                            },
                             context: context,
                            
                            );
                        }): Column(
         crossAxisAlignment: CrossAxisAlignment.center,
         mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: MediaQuery.of(context).size.height/4),
          Center(child: Icon(Icons.notifications_off,size: 200,color: appColor,)),
          SizedBox(height: 10,),
          Text('There is no notification new today',
          style: TextStyle(color:appColor,fontSize: 26,fontWeight: FontWeight.bold,),textAlign:TextAlign.center),
        ],
      );
               },
               fallback: (context){
                 return Column(
                   crossAxisAlignment: CrossAxisAlignment.center,
         mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     SizedBox(height: MediaQuery.of(context).size.height/2.5,),
                  Center(child: CircularProgressIndicator())
                   ],
                 );
               },
                 )
                    
                   ]
                 ),
            ],
          ),
        );
        },
      ),
    );
  }
}