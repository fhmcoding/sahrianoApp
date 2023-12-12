
import 'package:flutter/material.dart';
import 'package:sahariano_travel/Flight_app/pages/reservations_page.dart';
import 'shared/components/components.dart';
import 'shared/components/constants.dart';

class Voles extends StatefulWidget {
  final segment;
  final option;
  final travelerId;
  final chairs;
  Voles({ Key key, this.segment,this.option,this.travelerId,this.chairs}) : super(key: key);
  @override
  State<Voles> createState() => _VolesState();
}

class _VolesState extends State<Voles>{
  String selectseat;
  String seatAvailabilityStatus;
  dynamic price;
  Map seat;
  @override
  Widget build(BuildContext context) {
   Widget setChair({seats,x,y,travelerId,}){
     var number = null;
     var seatAvailability=null;
     var priceSeat= null;
     var contain = widget.chairs.where((e){
       return e['option'] == widget.option['optionId'] && e['segment']==widget.segment['segmentId'];
     }).toList();
     if(contain.isEmpty){
       selectseat = null;
       seatAvailabilityStatus =null;
       priceSeat =null;
     }else{
       contain.forEach((t){
         selectseat = t['number'];
         seatAvailabilityStatus = t['seatAvailabilityStatus'];
         priceSeat = t['price'];
       });

     }


    var chair = seats['seats'].where((seat) {
      return seat['coordinates']['x']==x&&seat['coordinates']['y']==y;
    }).toList();
     
   chair.forEach((e){
    e['travelerPricing'].forEach((element){
      if (element['travelerId']==travelerId.toString()){
       number = e['number'];
       seatAvailability = element['seatAvailabilityStatus'];
       priceSeat = element['price'];
      }else{
        return null;
      }
    });
    });

     return number!=null? GestureDetector(
       onTap: (){
        setState(() {
          selectseat = number;
          seatAvailabilityStatus = seatAvailability;
          price =priceSeat;
          var key=-1;
          for(var i = 0; i < widget.chairs.length; i++){
            if (widget.travelerId==widget.chairs[i]['traveler'] && widget.option['optionId']==widget.chairs[i]['option']&&widget.segment['segmentId']==widget.chairs[i]['segment']) {
              key=i;
              break;
            }
          }
          if (key!=-1) {
            widget.chairs[key] = {
              "segment": widget.segment['segmentId'],
              "option": widget.option['optionId'],
              "price": price!=null?price['total']:0,
              "traveler": widget.travelerId,
              "number": number,
              "seatAvailabilityStatus":seatAvailability
            };
          }
          else{
            widget.chairs.add(
                {
                  "segment": widget.segment['segmentId'],
                  "option": widget.option['optionId'],
                  "price":price!=null?price['total']:0,
                  "traveler":widget.travelerId,
                  "number": number,
                  "seatAvailabilityStatus":seatAvailability
                }
            );
          }


        });
        // showModalBottomSheet(context: context, builder: (context){
        //  return Padding(
        //    padding: const EdgeInsets.only(left: 20,top: 15,right:20 ),
        //     child: Column(
        //                                                     mainAxisSize: MainAxisSize.min,
        //                                                     crossAxisAlignment: CrossAxisAlignment.start,
        //                                                     mainAxisAlignment: MainAxisAlignment.start,
        //                                                     children: [
        //                                                       Row(
        //                                                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                                                         children: [
        //                                                           Text('Seat number :',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 11.50)),
        //                                                           Text('${number}',style: TextStyle(color: appColor,fontWeight: FontWeight.bold,fontSize: 14.50)),
        //                                                         ],
        //                                                       ),
        //                                                     SizedBox(height: 10,),
        //                                                       Row(
        //                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                                                         children: [
        //                                                           Row(
        //                                                             crossAxisAlignment: CrossAxisAlignment.start,
        //                                                             mainAxisAlignment: MainAxisAlignment.start,
        //                                                             children: [
        //                                                               Icon(Icons.chair,size: 17,color:seatAvailabilityStatus=='AVAILABLE'? Colors.orange:Color(0xFF7B919D)),
        //                                                             SizedBox(width: 6,),
        //                                                               Text('${seatAvailabilityStatus}',style: TextStyle(color: Color.fromARGB(255, 68, 71, 71),fontWeight: FontWeight.w600,fontSize: 14,),maxLines: 1,),
        //                                                             ],
        //                                                           ),
        //                                                         price!=null?  Text('${price['total'].toString()} MAD',style: TextStyle(color: appColor,fontWeight: FontWeight.bold,fontSize: 14.50)):SizedBox(height: 0),
        //                                                         ],
        //                                                       ),
        //                                                       SizedBox(height: 10,),
        //                                                           GestureDetector(
        //                                                             onTap: (){
        //                                                             Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>ReservationPage()), (route) => route.isFirst);
        //
        //                                                             // widget.maps = seats;
        //                                                             // seatAvailabilityStatus=='AVAILABLE'? print('hey'):null;
        //                                                             // Navigator.of(context).pop();
        //                                                             },
        //                                                             child: Container(
        //                                                               decoration: BoxDecoration(
        //                                                                 color: seatAvailabilityStatus=='AVAILABLE'? Colors.red:Color.fromARGB(255, 179, 179, 179),
        //                                                                 borderRadius: BorderRadius.circular(5)
        //                                                               ),
        //                                                               height: 50,
        //                                                               width: double.infinity,
        //                                                               child: Center(child: Text(seatAvailabilityStatus=='AVAILABLE'?'Select Seat':'Unselectable Seat',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 16),))),
        //                                                           ),
        //                                                        SizedBox(height: 10,)
        //                                                           ],
        //                                                         ),
        //   );
        // });
       },
       child:selectseat==number?Image.asset('assets/chair.png',height: 20,color: seatAvailability=='AVAILABLE'? Colors.red:Color(0xFF7B919D),):Image.asset('assets/chair.png',height: 20,color: seatAvailability=='AVAILABLE'? Colors.orange[300]:Color(0xFF7B919D),)):SizedBox(height: 0,);
    }
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.only(left: 20,top: 15,right:20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                selectseat!=null? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Seat number :',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 11.50)),
                    Text('${selectseat}',style: TextStyle(color: appColor,fontWeight: FontWeight.bold,fontSize: 14.50)),
                  ],
                ):SizedBox(height: 0,),
                selectseat!=null?SizedBox(height: 10,):SizedBox(height: 0,),
                selectseat!=null?Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.chair,size: 17,color:seatAvailabilityStatus=='AVAILABLE'? appColor:Color(0xFF7B919D)),
                        SizedBox(width: 6,),
                        Text(seatAvailabilityStatus,style: TextStyle(color: Color.fromARGB(255, 68, 71, 71),fontWeight: FontWeight.w600,fontSize: 14,),maxLines: 1,),
                      ],
                    ),
                    price!=null?Text('${price['total']} MAD',style: TextStyle(color: appColor,fontWeight: FontWeight.bold,fontSize: 14.50)):Text('0 MAD',style: TextStyle(color: appColor,fontWeight: FontWeight.bold,fontSize: 14.50)),
                  ],
                ):SizedBox(height: 0,),
                selectseat!=null?SizedBox(height: 10,):SizedBox(height: 0,),
                GestureDetector(
                  onTap: (){
                    setState(() {

                    });
                    seatAvailabilityStatus=='AVAILABLE'? Navigator.of(context).pop(seat):null;
                  },
                  child: Container(
                      decoration: BoxDecoration(
                          color:seatAvailabilityStatus=='AVAILABLE'?selectseat!=null? Colors.red:Color.fromARGB(255, 179, 179, 179):Color.fromARGB(255, 179, 179, 179),
                          borderRadius: BorderRadius.circular(5)
                      ),
                      height: 50,
                      width: double.infinity,
                      child: Center(child: Text('Select Seat',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 16),))),
                ),
                SizedBox(height: 10,)
              ],
            ),
          ),
        ),
        backgroundColor: Color(0xFF474747),
          appBar: AppBar(
            elevation: 0,
            toolbarHeight: 80,
            automaticallyImplyLeading: false,
            title: Column(
              children: [
                SizedBox(height: 30,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(height: 10,),
                   Column(
                     children: [
                       Image.asset('assets/chair.png',height: 20,color: Colors.red,),
                       Text('Your seat',style: TextStyle(fontSize: 13,fontWeight: FontWeight.w600),)
                     ],
                   ),
                    Column(
                     children: [
                       Image.asset('assets/chair.png',height: 20,color: appColor,),
                       Text('Avaiable',style: TextStyle(fontSize: 13,fontWeight: FontWeight.w600),)
                     ],
                   ),
                    Column(
                     children: [
                      //  Icon(Icons.chair,color: Color(0xFF7B919D),),
                      Image.asset('assets/chair.png',height: 20,color: Color(0xFF7B919D),),
                       Text('Unavaiable',style: TextStyle(fontSize: 13,fontWeight: FontWeight.w600),)
                     ],
                   ),
                    SizedBox(width: 10,)
                  ],
                ),
              ],
            ),
            centerTitle: true,
            backgroundColor: Colors.white,
          ),
         body: SingleChildScrollView(
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.center,
             mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                                     padding: const EdgeInsets.only(left: 0,right: 0),
                                    child: Stack(
                                      children: [
                                        Container(height: 129,width: double.infinity, decoration: BoxDecoration(
                                          //       border: Border.all(
                                          //    width: 1.4,
                                          //      color: Color.fromARGB(255, 238, 238, 238),
                                          //  ),
                                               borderRadius: BorderRadius.only(topLeft: Radius.circular(0),topRight:Radius.circular(0) ,bottomLeft:Radius.circular(0) ,bottomRight:Radius.circular(0) ,)
                                             ),child: Image.asset('assets/easy.jpg',fit: BoxFit.cover,height: 1,),),
                                      ],
                                    ),
                                  ),
                                    Padding(
                                    padding: const EdgeInsets.only(left: 24,right: 24),
                                    child: Container(
                                    decoration: BoxDecoration(
                                         color: Colors.white,
                                          //  border: Border.all(
                                          //    width: 2.5,
                                          //      color: Color.fromARGB(255, 231, 231, 231),
                                          //  ),
                                           borderRadius: BorderRadius.only(topLeft: Radius.circular(0),topRight:Radius.circular(0) ,bottomLeft:Radius.circular(0) ,bottomRight:Radius.circular(0))
                                         ),
                                         child: Column(
                                           children: [
                                            Container(width: double.infinity,height: 1,color: Color.fromARGB(255, 231, 231, 231),),
                                            SizedBox(height: 10,),
                                             ...widget.segment['decks'].map((deck){
                                               print(deck['deckConfiguration']['width']);
                                               return ListView.builder(
                                                padding: EdgeInsets.only(left: 5,right: 5),
                                                 physics: NeverScrollableScrollPhysics(),
                                                 shrinkWrap: true,
                                                 itemCount: deck['deckConfiguration']['length'],
                                                 itemBuilder: (context,x){
                                                   
                                                 return Container(
                                                   height: 50,
                                                   child: ListView.builder(
                                                     scrollDirection: Axis.horizontal,
                                                     shrinkWrap: true,
                                                     itemCount: deck['deckConfiguration']['width'],
                                                     itemBuilder: (context,y){
                                                      if (deck['deckConfiguration']['width']==11||deck['deckConfiguration']['width']==10||deck['deckConfiguration']['width']==12) {
                                                        return Padding(
                                                        padding: const EdgeInsets.only(left:0,right: 0,top:0,bottom: 15),
                                                        child:Container(
                                                          width: 30,
                                                          // color: Colors.red,
                                                           child:Center(child: setChair(seats:deck,x: x,y: y,travelerId: 1,)),
                                                        ),
                                                      );
                                                      }
                                                     return Padding(
                                                        padding: const EdgeInsets.only(left:14,right: 5,top:0,bottom: 15),
                                                        child:Container(
                                                          width: 30,
                                                          // color: Colors.red,
                                                           child:Center(child: setChair(seats:deck,x: x,y: y,travelerId: 1,)),
                                                        ),
                                                      );
                                                      
                                                     }),
                                                    color: Colors.white,
                                                 );
                                               }
                                               );
                                             }),
                                          Image.asset('assets/back.jpg',fit: BoxFit.cover,),
                                            
                                           ],
                                         ),
                                                                   ),
                                  ),
                                  
    
            ],
               ),
         ),
      ),
    );
  }
}