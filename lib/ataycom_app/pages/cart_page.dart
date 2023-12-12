import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahariano_travel/ataycom_app/layout/cubit/cubit.dart';
import 'package:sahariano_travel/ataycom_app/layout/cubit/states.dart';
import 'package:sahariano_travel/ataycom_app/pages/checkout.dart';
import 'package:sahariano_travel/layout/home.dart';
import 'package:sahariano_travel/localization/demo_localization.dart';
import 'package:sahariano_travel/shared/components/constants.dart';
import 'package:sahariano_travel/shared/network/remote/local/cache_helper.dart';

class CartPage extends StatefulWidget {
 final String type;
 final int currentIndex;
 CartPage({ Key key ,this.type,this.currentIndex}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage>with SingleTickerProviderStateMixin {
  // String qty = Cachehelper.getData(key: "qty");
  String access_token = Cachehelper.getData(key: "access_token");
  @override
  void initState() {
  
  super.initState();
  }
 
 
  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (BuildContext context) =>StoreCubit()..getCartItem(type: widget.type),
      child: BlocConsumer<StoreCubit,StoreStates>(
      listener: (context,state){
        // if (state is incremmentLoadingState) {
        //   showAboutDialog(context: context);
        // }
        if (state is incremmentSuccesState) {
           StoreCubit.get(context).getCartItem(type: widget.type);
        }
         if (state is disincremmentSuccesState) {
           StoreCubit.get(context).getCartItem(type: widget.type);
        }
         if (state is ClearCartSuccesState) {
           StoreCubit.get(context).getCartItem(type: widget.type);
        }
      },
      builder: (context,state){
        return  Scaffold(
                      backgroundColor: Colors.white,
                      appBar: AppBar(
                      elevation: 0,
                      leading: GestureDetector(
                        onTap: (){
               Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>Home(Index:service.indexId=widget.currentIndex,)), (route) => route.isFirst);
                        },
                        child: Icon(Icons.arrow_back,color: Colors.white)),
                       backgroundColor:widget.type==ataycom ?ataycomColor:parfumColor,
                        title: Text(
                          'My Cart',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w600),
                        ),
                        centerTitle: true,
                       actions: [
                       countryService.itemsCart.length!=0?  Padding(
                           padding: const EdgeInsets.only(right: 10),
                           child: IconButton(icon:Icon(Icons.delete,color: Colors.white,),onPressed:(){
                            StoreCubit.get(context).ClearCart();
                          
                           },),
                         ):SizedBox(height: 0,)
                       ],
                        
                      ),
                      body: SingleChildScrollView(
                          physics: BouncingScrollPhysics(),
                          child: Column(
                            children: [
                          
                            BuildCondition(
                            condition:countryService.itemsCart.length!=0,
                            builder: (context){
                            return countryService.itemsCart.length!=0?ListView.builder(
                                  physics: BouncingScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount:countryService.itemsCart.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.only(left: 15,right: 15,top: 25,bottom: 5),
                                      child: Container(
                                        decoration: BoxDecoration(border: Border.all(width: 1.5,color: Colors.grey),borderRadius: BorderRadius.circular(8)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: 60,
                                                height: 60,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(5),
                                                  image: DecorationImage(
                                                  image: NetworkImage('${countryService.itemsCart[index]['image']}'),fit: BoxFit.cover),
                                                ),
                                              ),
                                              Expanded(
                                                child: Padding(
                                                  padding: const EdgeInsets.only(left: 13, top: 0,right: 13),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                       SizedBox(height: 5,),
                                                      Text(
                                                        '${countryService.itemsCart[index]['name']}',
                                                        style: TextStyle(fontSize: 13.7, fontWeight: FontWeight.bold),
                                                      ),
                                                        SizedBox(height: 5,),
                                                      Text(
                                                        '${countryService.itemsCart[index]['size']}',
                                                        style: TextStyle(fontSize: 14, color: Colors.grey,),
                                                      ),
                                                      SizedBox(height: 5,),
                                                      Row(
                                                        children: [
                                                          Text(
                                                            '${countryService.itemsCart[index]['price']} ${DemoLocalization.of(context).getTranslatedValue('currenc')}',
                                                            style: TextStyle(
                                                              fontSize: 15,
                                                              fontWeight: FontWeight.w600,
                                                              color: widget.type==ataycom ?ataycomColor:parfumColor,
                                                            ),
                                                          ),
                                                          SizedBox(width: 6,),
                                                          Text(
                                                            'x${countryService.itemsCart[index]['quantity']}',
                                                            style: TextStyle(
                                                              fontSize: 13.5,
                                                              fontWeight: FontWeight.bold,
                                                              color: Colors.black,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                           
                                              Padding(
                                                padding: const EdgeInsets.only(right: 13,top: 5,),
                                                child: Container(
                                                  height: 55,width: 35,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(7),
                                                    border: Border.all(color: Colors.grey,width: 1.5)
                                                  ),
                                                  child: Column(
                                                    children: [
                                                      SizedBox(height: 6,),
                                                      
                                                        BuildCondition(
                                                          condition:state is! incremmentLoadingState,
                                                          fallback: (context){
                                                           return CircleAvatar(
                                                            maxRadius: 8,
                                                            backgroundColor: Colors.white,
                                                             child: GestureDetector(
                                                                                                                   onTap: (){
                                                                                                                   StoreCubit.get(context).incremment(id:StoreCubit.get(context).itemsCart[index]['id']);
                                                                                                                   setState(() {
                                                                                                                     
                                                                                                                   });
                                                                                                                   },
                                                                                                                   child: CircularProgressIndicator()),
                                                           );
                                                          },
                                                          builder: (context) {
                                                            return GestureDetector(
                                                        onTap: (){
                                                        StoreCubit.get(context).incremment(id:StoreCubit.get(context).itemsCart[index]['id']);
                                                        setState(() {
                                                          
                                                        });
                                                        },
                                                        child: Icon(Icons.add,size: 20,));
                                                          },
                                                        ),
                                                        
                                                      BuildCondition(
                                                          condition:state is! disincremmentLoadingState,
                                                          fallback: (context){
                                                           return CircleAvatar(
                                                            maxRadius: 8,
                                                            backgroundColor: Colors.white,
                                                             child: CircularProgressIndicator()
                                                           );
                                                          },
                                                          builder: (context) {
                                                            return GestureDetector(
                                                        onTap: (){
                                                        StoreCubit.get(context).disincremment(id:StoreCubit.get(context).itemsCart[index]['id']);
                                                        setState(() {
                                                          
                                                        });
                                                      },
                                                      child: Icon(Icons.remove,size: 20,));
                                                          },
                                                        ),
                                                    ],
                                                  ),
                                                  ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
        }):Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          SizedBox(height: 280,),
           Center(
             child: CircleAvatar(
               maxRadius: 90,
               backgroundColor: Color(0xFFf3f4f6),
               child: Icon(Icons.shopping_cart_sharp,size: 90,color: Color(0xFF6b7280)),
             ),
           ),
            SizedBox(height: 20,),
         Text('Your cart is empty',style: TextStyle(color:Color(0xFF6b7280),fontSize: 23 ,fontWeight: FontWeight.bold),),
          SizedBox(height: 20,),
          GestureDetector(
            onTap: (){
               Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>Home(Index:service.indexId=widget.currentIndex,)), (route) => route.isFirst);
            },
            child: Container(
              height: 60,
              width: 200,
              child: Center(child: Text('Start shopping',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),textAlign:TextAlign.center)),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color:widget.type==ataycom ?ataycomColor:parfumColor,),
             
            ),
          )
         ],
        );
                         },
                         fallback: (context){
                           return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          SizedBox(height: 280,),
           Center(
             child: CircleAvatar(
               maxRadius: 90,
               backgroundColor: Color(0xFFf3f4f6),
               child: Icon(Icons.shopping_cart_sharp,size: 90,color: Color(0xFF6b7280)),
             ),
           ),
            SizedBox(height: 20,),
         Text('Your cart is empty',style: TextStyle(color:Color(0xFF6b7280),fontSize: 26,fontWeight: FontWeight.bold),),
          SizedBox(height: 20,),
          GestureDetector(
            onTap: (){
               Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>Home(Index:service.indexId=widget.currentIndex,)), (route) => route.isFirst);
            },
            child: Container(
              height: 60,
              width: 200,
              child: Center(child: Text('Start shopping',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),textAlign:TextAlign.center)),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color:widget.type==ataycom?ataycomColor:parfumColor,),
             
            ),
          )
         ],
        );
                         },
                       )
         ],
              )),
                      bottomNavigationBar:countryService.itemsCart.length != 0 ?  
                      Container(
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),
                        color: Colors.white,
                        boxShadow: [
                                       BoxShadow(
                                       blurRadius: 3,
                                       color: Color.fromARGB(255, 148, 146, 146),
                                       offset: Offset(1, 3),
                                       spreadRadius: 3)
                                       ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 25),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 20, right: 20,top: 0,bottom: 20),
                                child: Row(
                                  children: [
                                    Text(
                                      DemoLocalization.of(context).getTranslatedValue('Total_Price'),
                                      style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Spacer(),
                                    Text(
                                      "${countryService.total} ${DemoLocalization.of(context).getTranslatedValue('currenc')}",
                                        style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        color: widget.type==ataycom ?ataycomColor:parfumColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            
                              Padding(
                                padding: const EdgeInsets.only(left: 20, right: 20,bottom: 15),
                                child: Row(
                                  children: [
                                    Text(
                                     DemoLocalization.of(context).getTranslatedValue('delivery_fee'),
                                      style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Spacer(),
                                    Text(
                                       DemoLocalization.of(context).getTranslatedValue('free'),
                                      style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        color: widget.type==ataycom ?ataycomColor:parfumColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 10,),
                              Padding(
                                padding: const EdgeInsets.only(left: 20,right: 20,bottom: 20),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Checkout(
                                        currentIndex: widget.currentIndex,
                                        subtotal:countryService.total,
                                        type: widget.type,
                                          )));
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                       boxShadow: [
                                       BoxShadow(
                                       blurRadius: 2,
                                       color: Colors.grey.shade300,
                                       offset: Offset(1, 3),
                                       spreadRadius: 0)
                                       ],
                                      borderRadius: BorderRadius.circular(5),
                                      color: widget.type==ataycom ?ataycomColor:parfumColor,
                                    ),
                                    height: 50,
                                    child: Center(
                                        child: Text(
                                      DemoLocalization.of(context).getTranslatedValue('Checkout'),
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16),
                                    )),
                                    width: double.infinity,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ):SizedBox(height: 0,),
                    );

      },
            ),
    );
  }
}
