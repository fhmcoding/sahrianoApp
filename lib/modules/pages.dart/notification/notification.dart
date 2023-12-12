import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahariano_travel/drawer/menuwidget.dart';
import 'package:sahariano_travel/layout/cubit/cubit.dart';
import 'package:sahariano_travel/layout/cubit/states.dart';
import 'package:sahariano_travel/localization/demo_localization.dart';
import 'package:sahariano_travel/modules/pages.dart/notification/old_notification.dart';
import 'package:sahariano_travel/modules/pages.dart/notification/vue_notification.dart';
import 'package:sahariano_travel/shared/components/constants.dart';

class NotificationScreen extends StatefulWidget {
     final int selectedIndex ;
  const NotificationScreen({ Key key, this.selectedIndex }) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen>  with SingleTickerProviderStateMixin{
   TabController tabcontroller;
   @override
  void initState() {
     tabcontroller  = TabController(length: 2, vsync: this);
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
          return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            leading:MenuWidget(),
            elevation: 0,
            backgroundColor: Colors.white,
            centerTitle: true,
            bottom: TabBar(
              unselectedLabelColor: Colors.grey[600],
              indicatorColor: appColor,
               labelColor: appColor,
              controller: tabcontroller,
              tabs: [
              Tab(
                child: Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.notifications_off),
                    SizedBox(width: 5,),
                    Text('new notification'),
                  ],
                ),
                
              ),
               Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.notifications_off),
                     SizedBox(width: 5,),
                    Text('old notification'),
                  ],
                ),
                
              ),
            ]),
            title: Text(DemoLocalization.of(context).getTranslatedValue('notification_vue'),style: TextStyle(color: appColor),),
          ),
          body:TabBarView(
          controller:tabcontroller,
          children: [
            NewNotification(),
            OldNotification()
          ]
        ),
        );
        },
      ),
    );
  }
}