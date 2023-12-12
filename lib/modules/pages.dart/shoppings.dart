import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sahariano_travel/ataycom_app/layout/cubit/cubit.dart';
import 'package:sahariano_travel/drawer/menuwidget.dart';
import 'package:sahariano_travel/layout/home.dart';
import 'package:sahariano_travel/shared/components/constants.dart';
class Shopping extends StatefulWidget {
     final int selectedIndex ;
  const Shopping({ Key key, this.selectedIndex }) : super(key: key);
  @override
  _ShoppingState createState() => _ShoppingState();
}

class _ShoppingState extends State<Shopping> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading:MenuWidget(),
        title: Text('Services',style: TextStyle(color: appColor),),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        
          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>Home(Index: service.indexId=2,)));
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 40,right: 40,top: 40),
              child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color:appColor,
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                            Icon(FontAwesomeIcons.idCard,color: Colors.white),
                              SizedBox(width: 10,),
                              Text(
                               'Krena',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          height: 60,
                          width: double.infinity,
                        ),
            ),
          ),
                    // GestureDetector(
                    //   onTap: (){
                    //   Navigator.push(context, MaterialPageRoute(builder: (context)=>Home(Index: service.indexId=1,)));
                    //   },
                    //   child: Padding(
                    //     padding: const EdgeInsets.only(left: 40,right: 40,top: 40),
                    //     child: Container(
                    //       decoration: BoxDecoration(
                    //         borderRadius: BorderRadius.circular(10),
                    //         color:Color(0xFFec008c),
                    //       ),
                    //       child: Row(
                    //         crossAxisAlignment: CrossAxisAlignment.center,
                    //         mainAxisAlignment: MainAxisAlignment.center,
                    //         children: [
                    //          Icon(FontAwesomeIcons.sprayCanSparkles,color: Colors.white),
                    //           SizedBox(width: 10,),
                    //           Text(
                    //            'Parfum    ',
                    //             style: TextStyle(
                    //                 color: Colors.white,
                    //                 fontSize: 20,
                    //                 fontWeight: FontWeight.bold),
                    //           ),
                    //         ],
                    //       ),
                    //       height: 60,
                    //       width: double.infinity,
                    //     ),
                    //   ),
                    // ),
                    GestureDetector(
                      onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Home(Index: service.indexId=0,)));
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 40,right: 40,top: 40),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color:appColor,
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                             Icon(FontAwesomeIcons.planeUp,color: Colors.white),
                              SizedBox(width: 10,),
                              Text(
                               'Voles    ',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          height: 60,
                          width: double.infinity,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                       Navigator.push(context, MaterialPageRoute(builder: (context)=>Home(Index: service.indexId=4,)));
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 40,right: 40,top: 40),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color:appColor,
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                            Icon(Icons.mode_edit,color: Colors.white),
                              SizedBox(width: 10,),
                              Text(
                               'Demanded    ',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          height: 60,
                          width: double.infinity,
                        ),
                      ),
                    ),
                   
                
                  
        ],
      ),
    );
  }
}