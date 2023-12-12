import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahariano_travel/drawer/menuwidget.dart';
import 'package:sahariano_travel/layout/cubit/cubit.dart';
import 'package:sahariano_travel/layout/cubit/states.dart';
import 'package:sahariano_travel/modules/pages.dart/chat_screen.dart';
import 'package:sahariano_travel/shared/components/components.dart';
import 'package:sahariano_travel/shared/components/constants.dart';
import 'package:sahariano_travel/shared/network/remote/local/cache_helper.dart';

class Users extends StatefulWidget {
  final int id;
    final int selectedIndex ;

  const Users({ Key key ,this.id, this.selectedIndex,}) : super(key: key);

  @override
  _UsersState createState() => _UsersState();
}

class _UsersState extends State<Users> {
  bool isSearch = false;
  List usersFilter = [];
  List list = [];
  String type = Cachehelper.getData(key: "type");
  @override

  void filterUsers(value){
    setState(() {
      usersFilter = list.where((element) => element['user']['firstName'].toLowerCase().contains(value.toLowerCase()) || element['user']['lastName'].toLowerCase().contains(value.toLowerCase())|| element['user']['phone'].toLowerCase().contains(value.toLowerCase())).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>AppCubit()..getUsers(),
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (context,state){
          if(state is getusersSuccessState){
            list = usersFilter = state.users;
          }
        },
        builder: (context,state){
          return Scaffold(
            backgroundColor:Colors.white,
          appBar:AppBar(
            centerTitle: true,
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child:isSearch == false?
                GestureDetector(
                  onTap: (){
                     setState(() {
                       isSearch = true;
                     });
                  },
                  child: Icon(Icons.search,color: Colors.black,)):GestureDetector(
                    onTap: (){
                      setState(() {
                        isSearch = false;
                        usersFilter = list;
                      });
                    },
                    child:isSearch == false? Icon(Icons.search,color: Colors.black,):Icon(Icons.close,color: Colors.black,)),
              )
            ],
            elevation: 0.6,
            leading: MenuWidget(),
            backgroundColor:Colors.white,
            title:isSearch == false?Text("Contact us",style: TextStyle(color: appColor),):TextField(
              decoration: InputDecoration(
                hintText: 'Search'
              ),
              autofocus:true,
              onChanged: (value){
                filterUsers(value);
              },
            )),
          body:  SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
              BuildCondition(
               condition:AppCubit.get(context).isloading,
               builder: (context){
                 return usersFilter.length>0? ListView.builder(
             physics: BouncingScrollPhysics(),
             itemCount: usersFilter.length,
             shrinkWrap: true,
             itemBuilder: (context,index){
              var users = usersFilter[index];
             return  GestureDetector(
               onTap: (){
               Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatScreen("${users["user"]["firstName"]}", "${users["user"]["lastName"]}", "${users["lastMessage"]}", "${users["lastMessageDate"]}",users["user"]["id"],users["user"]["firebaseUid"],users["user"]["phone"])));
               },
               child: buildUsers(
              context,usersFilter[index]),
             );
            }
            ): Column(
         crossAxisAlignment: CrossAxisAlignment.center,
         mainAxisAlignment: MainAxisAlignment.center,
        children: [
           SizedBox(height: MediaQuery.of(context).size.height/5),
          Center(child: Icon(Icons.error,size: 100,color: appColor,)),
          SizedBox(height: 10,),
          Text('There is no agent with this name',
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
            ],
            ),
          )
        );
        },
      ),
    );
  }
}
Widget buildUsers(context,users){
  return Padding(
    padding: const EdgeInsets.all(5.0),
    child:
    Container(
      color: Colors.white,
      margin: EdgeInsets.only(top: 10),
      child: Row(
        children:[
          Stack(
            alignment: Alignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child:CircleAvatar(radius: 28,
                backgroundColor: Color(0xFFf37021),
                child: Text("${users["user"]["firstName"][0]} ${users["user"]["lastName"][0]}",style: TextStyle(color: Colors.white),),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 45,top: 26),
                child: CircleAvatar(radius: 8,
                backgroundColor: Colors.white,
                ),
              ),
               Padding(
                padding: const EdgeInsets.only(left: 45,top: 25),
                child: CircleAvatar(radius: 6,
                backgroundColor: Colors.green,
                ),
              ),
            ],
          ),
          
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Text("${users["user"]["firstName"]} ${users["user"]["lastName"]}",style:TextStyle(color: Colors.black,fontSize: 18) ,),
                ),
               
             users["lastMessage"]!=null ? SizedBox(
                  height: 15,
                  child:Text("${users["lastMessage"]}",maxLines: 1,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),)):SizedBox(height: 0,)
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
             users["lastMessage"]!=null ? Text("${users["lastMessageDate"]}",style: TextStyle(color: Colors.grey,fontSize: 13),):SizedBox(height: 0,),
                SizedBox(height: 5,),
              users["lastMessage"]!=null && users["unreadCount"] != 0 ? CircleAvatar(minRadius: 10,child: Text("${users["unreadCount"]}",style: TextStyle(color: Colors.white,fontSize: 13),),backgroundColor: Color(0xFFf37021),):SizedBox(height: 15,)
              ],
            ),
          )
        ],
      ),
    ),
  );
}