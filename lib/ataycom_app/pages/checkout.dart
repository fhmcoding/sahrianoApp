import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahariano_travel/ataycom_app/layout/cubit/cubit.dart';
import 'package:sahariano_travel/ataycom_app/layout/cubit/states.dart';
import 'package:sahariano_travel/ataycom_app/pages/paymentShopping.dart';
import 'package:sahariano_travel/localization/demo_localization.dart';
import 'package:sahariano_travel/shared/components/constants.dart';
import 'package:sahariano_travel/shared/network/remote/local/cache_helper.dart';

class Checkout extends StatefulWidget {
  String type;
  final int currentIndex;
  int subtotal;
   Checkout({ Key key,this.type,this.subtotal, this.currentIndex}) : super(key: key);

  @override
  _CheckoutState createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  var nameController = TextEditingController();
  var LastNameController = TextEditingController();
  var phoneController = TextEditingController();
  var addresController = TextEditingController();
  String access_token = Cachehelper.getData(key: "access_token");
   var fromkey = GlobalKey<FormState>();
      bool isloading = true;
  @override
  Widget build(BuildContext context) {
   nameController.text = Cachehelper.getData(key: "firstName");
   LastNameController.text = Cachehelper.getData(key: "lastName");
   phoneController.text = Cachehelper.getData(key: "phone");

   




   double Shipping_fee = 0.00;
   double Tax = 0.00;
    return BlocProvider(
      create: (BuildContext context) =>StoreCubit(),
      child: BlocConsumer<StoreCubit,StoreStates>(
        listener:(context,state){
          if (state is GetPaymentShopSucessfulState) {
           return  Navigator.push(
                context,
                MaterialPageRoute(
                builder: (context) => PaymentShop(
                PaymentMethods:state.PaymentMethods,
                reservation: state.reservation,
                itemsCart: state.itemsCart,
                total: state.total,
                type: widget.type,
                currentIndex: widget.currentIndex,
                )));
          }
        },
        builder:(context,state){
          return  Scaffold(
            bottomNavigationBar:Container(
    height: 85,
    width: double.infinity,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(0),
      boxShadow: [
        // !StoreCubit.get(context).isloading
        BoxShadow(
            blurRadius: 3,
            color: Colors.grey[350],
            offset: Offset(3, 4),
            spreadRadius: 7)
      ],
    ),
    child: Padding(
      padding: const EdgeInsets.only(left: 25, right: 25, top: 15, bottom: 15),
      child:GestureDetector(
               onTap: (){
                if (fromkey.currentState.validate()){
                   Cachehelper.saveData(key: "adress", value: addresController.text);
                    setState(() {
                   isloading = false;
                });
                   StoreCubit.get(context).CheckoutCart(
                     adress:addresController.text,
                     firstName: nameController.text,
                     lastName:LastNameController.text,
                     phone:phoneController.text,
                     type:widget.type,
                   );
                 }
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
                             color:widget.type==ataycom ?ataycomColor:parfumColor,
                           ),
                           height: 50,
                           child: Center(
                               child:isloading?Text(
                             DemoLocalization.of(context).getTranslatedValue('complet_order'),
                             style: TextStyle(
                                 color: Colors.white, fontSize: 16),
                           ):CircularProgressIndicator(color: Colors.white,)),
                           width: double.infinity,
                         ),
             )
    ),
  ),
            backgroundColor: Colors.grey[200],
          appBar: AppBar(
            elevation: 1,
            leading: GestureDetector(
              onTap: (){
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back,color: Colors.white)),
            backgroundColor: widget.type==ataycom ?ataycomColor:parfumColor,
            title: Text(DemoLocalization.of(context).getTranslatedValue('Checkout'),style: TextStyle(color: Colors.white)),
            centerTitle:true ,
          ),
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Form(
              key: fromkey,
              child: Column(
                children: [
                  SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.only(left: 15,right: 15,top: 15,),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white,
                      ),
                     
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                             decoration: BoxDecoration(
                        borderRadius:BorderRadius.only(topRight:Radius.circular(5) ,topLeft:Radius.circular(5),bottomLeft:Radius.circular(0),bottomRight:Radius.circular(0),),
                       color: widget.type==ataycom ?ataycomColor:parfumColor,
                      ),
                            
                            height: 40,
                            width: double.infinity,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10,top: 10,right: 10),
                              child: Text(DemoLocalization.of(context).getTranslatedValue('Checkout'),style: TextStyle(fontSize: 18,color: Colors.white),),
                            ),
                            ),
                            SizedBox(height: 8),
                            Padding(
                              padding: const EdgeInsets.only(left: 10,right: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(DemoLocalization.of(context).getTranslatedValue('subtotal'),style: TextStyle(fontSize: 18)),
                                  Text('${widget.subtotal} ${DemoLocalization.of(context).getTranslatedValue('currenc')}',style: TextStyle(color:widget.type==ataycom ?Color(0xFF7B919D):Color(0xFF7B919D),))
                                ],
                              ),
                          ),
                            //  SizedBox(height: 6,),
                             Padding(
                              padding: const EdgeInsets.only(left: 10,right: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(DemoLocalization.of(context).getTranslatedValue('shipping_fee'),style: TextStyle(fontSize: 18)),
                                  Text('${Shipping_fee} ${DemoLocalization.of(context).getTranslatedValue('currenc')}',style: TextStyle(color: widget.type==ataycom ?Color(0xFF7B919D):Color(0xFF7B919D),))
                                ],
                              ),
                          ),
                          //  SizedBox(height: 6,),
                             Padding(
                              padding: const EdgeInsets.only(left: 10,right: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(DemoLocalization.of(context).getTranslatedValue('tax'),style: TextStyle(fontSize: 18)),
                                  Text('${Tax} ${DemoLocalization.of(context).getTranslatedValue('currenc')}',style: TextStyle(color: widget.type==ataycom ?Color(0xFF7B919D):Color(0xFF7B919D),),)
                                ],
                              ),
                          ),
                          SizedBox(height: 5,),
                          Divider(height: 2,),
                           SizedBox(height: 6,),
                             Padding(
                              padding: const EdgeInsets.only(left: 10,right: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(DemoLocalization.of(context).getTranslatedValue('Total_Price'),style: TextStyle(fontSize: 18,)),
                                  Text('${Tax+Shipping_fee+widget.subtotal} ${DemoLocalization.of(context).getTranslatedValue('currenc')}',style: TextStyle(color: widget.type==ataycom ?tabatayColor:tabparfum),)
                                ],
                              ),
                          ),
                             SizedBox(height: 8,),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15,right: 15,top: 15),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white,
                      ),
                     
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            
                             decoration: BoxDecoration(
                        borderRadius:BorderRadius.only(topRight:Radius.circular(5) ,topLeft:Radius.circular(5),bottomLeft:Radius.circular(0),bottomRight:Radius.circular(0),),
                       color: widget.type==ataycom ?ataycomColor:parfumColor,
                      ),
                            
                            height: 40,
                            width: double.infinity,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10,top: 10,right: 10),
                              child: Text(DemoLocalization.of(context).getTranslatedValue('my_info'),style: TextStyle(fontSize: 18,color: Colors.white),),
                            ),
                            ),
                            SizedBox(height: 10),
                            Padding(
                              padding: const EdgeInsets.only(left: 10,right: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(DemoLocalization.of(context).getTranslatedValue('first_name')),
                                  SizedBox(height: 10,),
                                  TextFormField(
                                    controller: nameController,
                                      validator: (String value) {
                                        if (value.isEmpty) {
                                          return "search must be empty";
                                        }
                                        return null;
                                      },
                                      
                                      textInputAction: TextInputAction.search,
                                      decoration: InputDecoration(
                                          isDense: true,
                                           filled: true,
                                          fillColor: Colors.white,
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(5),
                                              borderSide: BorderSide(
                                                color:widget.type==ataycom ?ataycomColor:parfumColor,
                                              )),
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(5),
                                              borderSide: BorderSide(
                                                width: 2,
                                                color:Colors.grey[200],
                                              )),
                                          hintText:DemoLocalization.of(context).getTranslatedValue('first_name'),
                                          hintStyle: TextStyle(
                                            color: Color(0xFF7B919D),
                                          )),
                                    ),
                                  SizedBox(height: 10,),
                                  Text(DemoLocalization.of(context).getTranslatedValue('last_name')),
                                  SizedBox(height: 10,),
                                   TextFormField(
                                    controller: LastNameController,
                                      validator: (String value) {
                                        if (value.isEmpty) {
                                          return "search must be empty";
                                        }
                                        return null;
                                      },
                                      textInputAction: TextInputAction.search,
                                      decoration: InputDecoration(
                                          isDense: true,
                                          filled: true,
                                          fillColor: Colors.white,
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(5),
                                              borderSide: BorderSide(
                                                
                                                color:widget.type==ataycom ?ataycomColor:parfumColor,
                                              )),
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(5),
                                              borderSide: BorderSide(
                                                width: 2,
                                                color: Colors.grey[200],
                                              )),
                                          hintText: DemoLocalization.of(context).getTranslatedValue('last_name'),
                                          hintStyle: TextStyle(
                                            color: Color(0xFF7B919D),
                                          )),
                                    ),
                                     SizedBox(height: 10,),
                                  Text(DemoLocalization.of(context).getTranslatedValue('phone')),
                                  SizedBox(height: 10,),
                                   TextFormField(
                                    controller: phoneController,
                                      validator: (String value) {
                                        if (value.isEmpty) {
                                          return "search must be empty";
                                        }
                                        return null;
                                      },
                                      
                                      textInputAction: TextInputAction.search,
                                      decoration: InputDecoration(
                                          isDense: true,
                                          filled: true,
                                          fillColor: Colors.white,
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(5),
                                              borderSide: BorderSide( 
                                                color:Colors.grey[200],
                                              )),
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(5),
                                              borderSide: BorderSide(
                                                width: 2,
                                                color:Colors.grey[200],
                                              )),
                                          hintText: DemoLocalization.of(context).getTranslatedValue('phone'),
                                          hintStyle: TextStyle(
                                            color: Color(0xFF7B919D),
                                          )),
                                    ),
                                    SizedBox(height: 10,),
                                  Text(DemoLocalization.of(context).getTranslatedValue('adress')),
                                  SizedBox(height: 10,),
                                  Container(
                                    width: double.infinity,
                                    height: 70,
                                     
                                    decoration: BoxDecoration(
                                       borderRadius: BorderRadius.circular(5),
                                      border: Border.all(width: 2,color:Colors.grey[200]),
                                      color: Colors.white
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 0,bottom: 15),
                                      child: TextFormField(
                                      controller: addresController,
                                      
                                       validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Adress must not be empty";
                    }
                    return null;
                  },
                                        decoration: InputDecoration(
                                           focusedBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(5),
                                                borderSide: BorderSide(
                                                  
                                                  color:Colors.white,
                                                )),
                                           enabledBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(5),
                                                borderSide: BorderSide(
                                                  width: 2,
                                                  color: Colors.white,
                                                )),
                                          fillColor: Colors.white,
                                          filled: true,
                                          border: InputBorder.none,
                                          hintText: DemoLocalization.of(context).getTranslatedValue('adress')
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ),
                            SizedBox(height: 10,)
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 90,),
                 
                ],
              ),
            ),
          ),
      
        );
        } ,
        
      ),
    );
  }
}