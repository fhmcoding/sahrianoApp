import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sahariano_travel/ataycom_app/layout/cubit/cubit.dart';
import 'package:sahariano_travel/ataycom_app/model/customer.dart';
import 'package:sahariano_travel/ataycom_app/model/invoice.dart';
import 'package:sahariano_travel/ataycom_app/model/supplier.dart';
import 'package:sahariano_travel/ataycom_app/pages/pdfApi.dart';
import 'package:sahariano_travel/ataycom_app/pages/pdfApiInvoice.dart';
import 'package:sahariano_travel/layout/home.dart';
import 'package:sahariano_travel/shared/components/constants.dart';
import 'package:sahariano_travel/shared/network/remote/local/cache_helper.dart';

class OrderTicket extends StatefulWidget {
  final  Map<String, dynamic> Checkout;
  final String payment_method;
  final List<dynamic> itemsCart;
  final int total;
  final double priceMethod;
  final String type;
  final int currentIndex;
  const OrderTicket({ Key key ,this.Checkout,this.payment_method,this.itemsCart,this.total,this.priceMethod,this.type, this.currentIndex}) : super(key: key);

  @override
  _OrderTicketState createState() => _OrderTicketState();
}

class _OrderTicketState extends State<OrderTicket> with SingleTickerProviderStateMixin {
     AnimationController controller;
     bool isloading = true;
  Timer timer;
  //  void initState() {
  //  controller = AnimationController(vsync: this,duration: Duration(seconds:3));
  //  controller.addStatusListener((status)async { 
  //  if (status==AnimationStatus.completed) {
  //    Navigator.pop(context);
  //    controller.reset();
  //  }
  //  });
  //   timer = Timer(Duration(seconds: 3),
  // (){
  //                                                   showDialog(
  //                                                        barrierDismissible: false,
  //                                                        context: context, builder: (context){
  //                                                       return Dialog(
  //                                                           child: Container(
  //                                                             width: double.infinity,
  //                                                             decoration: BoxDecoration(
  //                                                               borderRadius: BorderRadius.circular(5),
  //                                                               color: Colors.white,
  //                                                             ),
  //                                                             height: 200,
  //                                                             child: Column(
  //                                                               crossAxisAlignment: CrossAxisAlignment.center,
  //                                                               mainAxisAlignment: MainAxisAlignment.center,
  //                                                               children: [
  //                                                               //   Lottie.asset('assets/done.json',
  //                                                               //   height: 130,
  //                                                               //   width: 130,
  //                                                               //   repeat: false,
  //                                                               //   controller: controller,
  //                                                               //   onLoaded:(LottieComposition){
                                                                 
  //                                                               //   controller.forward();
  //                                                               //   }),
  //                                                               // Text('Your request has been successfully registered',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.green),)
                                                                
                                                                
  //                                                               ],
  //                                                             ),
  //                                                           ),
  //                                                         );
  //                       });
  //                                                     setState(() {
                                                          
  //                                                     });
  // }
  // );  
  //   super.initState();
  // }
   var nameController = TextEditingController();
  var LastNameController = TextEditingController();
  var phoneController = TextEditingController();
  var addresController = TextEditingController();
   PaymentMethods(String payment_method) {
    if (payment_method == 'method_amanpay') {
      return 'amanpay';
    }
    if (payment_method == 'method_cashplus'){
      return 'cashplus';
    }
    if (payment_method == 'method_agencia') {
      return 'agencia';
    }
    if (payment_method == 'method_redsysbbva') {
      return 'redsysbbva';
    }
    else{
      return 'kiosk';
    }
  }
  
  @override
  Widget build(BuildContext context) {
   nameController.text = Cachehelper.getData(key: "firstName");
   LastNameController.text = Cachehelper.getData(key: "lastName");
   phoneController.text = Cachehelper.getData(key: "phone");
   addresController.text = Cachehelper.getData(key: "adress");
    return WillPopScope(
      onWillPop: (){
        return Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>Home(Index: service.indexId=0)), (route) => route.isFirst);
      },
      child: Scaffold(
        backgroundColor: Colors.white,
         bottomNavigationBar:Container(
      height: 85,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(0),
        boxShadow: [
          BoxShadow(
              blurRadius: 3,
              color: Colors.grey[350],
              offset: Offset(3, 4),
              spreadRadius: 7)
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 25, right: 25, top: 10, bottom: 15),
        child: GestureDetector(
          onTap: ()async {
                      final date = DateTime.now();
                      final dueDate = date.add(Duration(days: 7));
                      final invoice = Invoice(
                        supplier: Supplier(
                          name: 'Marocco,Laayoune 5000',
                          address: 'contact@elsahariano.com',
                          phone: '+223 434 954 783',
                          paymentInfo: '${PaymentMethods(widget.payment_method)}',
                          paymentPrice: widget.priceMethod,
                          type: widget.type
                        ),
                        customer: Customer(
                          firstname: '${nameController.text}',
                          lastname: '${LastNameController.text}',
                          phone: '${phoneController.text}',
                          address: '${addresController.text}',
                        ),
                          info: InvoiceInfo(
                          date: date,
                          dueDate: dueDate,
                          description: 'My Orders',
                        ),
                        items:widget.itemsCart.map((item){
                        return InvoiceItem(
                           ProductName:item['name'],
                           Brand:'Hugo Boss',
                           Price:item['price'],
                           Size:item['size'],
                           quantity:item['quantity']
                          );
                        }).toList(),
                      );

                      final pdfFile = await PdfInvoiceApi.generate(invoice);
                      
                      PdfApi.openFile(pdfFile);
                      
                      
                    },
          child: Container(
            height: 55,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: widget.type==ataycom ?ataycomColor:parfumColor,),
                width: double.infinity,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                   isloading? Text(
                    'Download Invoice',
                    style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ):Center(child: CircularProgressIndicator(color: Colors.white,)),
            SizedBox(width: 10),
          isloading?  Icon(Icons.download,color: Colors.white,):SizedBox(height: 0,)
                  ],
                ),
          ),
        ),
      ),
      ),
          appBar: AppBar(
      backgroundColor: Colors.white,
      leading: GestureDetector(
        onTap: (){
          return Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>Home(Index:service.indexId=0)), (route) => route.isFirst);
        },
        child: Icon(Icons.arrow_back)),
      centerTitle: true,
      title: Text(
        'My Orders',
        style: TextStyle(color:widget.type==ataycom ?ataycomColor:parfumColor, fontSize: 22),
      ),
      elevation: 0,
      ),
        body:SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child:Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              widget.payment_method != 'method_redsysbbva' ? Padding(
                padding: const EdgeInsets.only(left: 15,right: 15,top: 15),
                child: Container(
                  height: 150,
                  decoration: BoxDecoration(
                    boxShadow: [
                          BoxShadow(
                              blurRadius: 3,
                              color: widget.type==ataycom ?ataycomColor:parfumColor,
                              offset: Offset(0, 0),
                              spreadRadius: 2)
                        ],
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    
        
                  ),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Payment Code :',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w700,color:Color.fromARGB(255, 196, 196, 196))),
                      SizedBox(height: 10,),
                    widget.Checkout['transaction_token']!=null?  Text('${widget.Checkout['transaction_token']}',style: TextStyle(fontSize: 25,fontWeight: FontWeight.w700,color:widget.type==ataycom ?ataycomColor:parfumColor)):Text('${widget.Checkout['booking_id']}',style: TextStyle(fontSize: 25,fontWeight: FontWeight.w700,color:widget.type==ataycom ?ataycomColor:parfumColor)),
                    ],
                  ),
                  
                ),
              ):SizedBox(height: 0),
              
               Padding(
                  padding: const EdgeInsets.only(left: 15,right: 15,top: 20),
                  child: Text('My orders :',
                      style: TextStyle(
                          color: Color(0xFF38444a),
                          fontSize: 18,
                          fontWeight: FontWeight.bold)),
                ),
              Padding(
               padding: const EdgeInsets.only(left: 15,right: 15,top: 20),
                child: Container(
                 
                  width: double.infinity,
                  decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                  color: Colors.white,
                  boxShadow: [
                  BoxShadow(
                  blurRadius: 4,
                  color: widget.type==ataycom ?ataycomColor:parfumColor,
                  offset: Offset(0, 0),
                  spreadRadius: 1)
                  ],
                  ),
                  child: Column(
                    children: [
                      ListView.builder(
                                    physics: BouncingScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount:widget.itemsCart.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.only(left: 15,right: 15,top: 15,bottom: 5),
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
                                                  image: NetworkImage('${widget.itemsCart[index]['image']}'),fit: BoxFit.cover),
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
                                                        '${widget.itemsCart[index]['name']}',
                                                        style: TextStyle(fontSize: 13.7, fontWeight: FontWeight.bold),
                                                      ),
                                                        SizedBox(height: 5,),
                                                      Text(
                                                        'size ${widget.itemsCart[index]['size']} ml',
                                                        style: TextStyle(fontSize: 14, color: Colors.grey,),
                                                      ),
                                                      SizedBox(height: 5,),
                                                      Row(
                                                        children: [
                                                          Text(
                                                            '${widget.itemsCart[index]['price']} MAD',
                                                            style: TextStyle(
                                                              fontSize: 15,
                                                              fontWeight: FontWeight.w600,
                                                              color:widget.type==ataycom ?ataycomColor:parfumColor,
                                                            ),
                                                          ),
                                                          SizedBox(width: 6,),
                                                          Text(
                                                            'x${widget.itemsCart[index]['quantity']} ',
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
                                            ],
                                          ),
                                        ),
                                      );
                      })
                    ],
                  ),
                  ),
              ),
               Padding(
                  padding: EdgeInsets.only(left: 15,right: 15,top: 20),
                  child: Text('Price Order :',
                      style: TextStyle(
                          color: Color(0xFF38444a),
                          fontSize: 18,
                          fontWeight: FontWeight.bold)),
                ),  
                Padding(
                  padding: EdgeInsets.only(left: 15,right: 15,top: 20),
                  child: Container(
                  
                    width: double.infinity,
                    decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    color: Colors.white,
                    boxShadow: [
                    BoxShadow(
                    blurRadius: 4,
                    color: widget.type==ataycom ?ataycomColor:parfumColor,
                    offset: Offset(0, 0),
                    spreadRadius: 1)
                    ],
                    ),
                    child: Column(
                      children: [
                         Padding(
                          padding: const EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 10),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Order Shipping :',
                                    style: TextStyle(
                                        fontSize: 17,
                                        color: Color.fromARGB(255, 37, 33, 32),
                                        fontWeight: FontWeight.w600)),
                                Text('Free Shipping',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color:widget.type==ataycom ?ataycomColor:parfumColor,
                                        
                                        fontWeight:FontWeight.w600))
                              ],
                            ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 10),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('${PaymentMethods(widget.payment_method)} :',
                                    style: TextStyle(
                                        fontSize: 17,
                                        color: Color.fromARGB(255, 37, 33, 32),
                                        fontWeight: FontWeight.w600)),
                                Text('${widget.priceMethod} MAD',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color:widget.type==ataycom ?ataycomColor:parfumColor,
                                        
                                        fontWeight: FontWeight.w600))
                              ],
                            ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 10),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Total Price :',
                                    style: TextStyle(
                                        fontSize: 17,
                                        color: Color.fromARGB(255, 37, 33, 32),
                                        fontWeight: FontWeight.w600)),
                                Text('${(widget.total + widget.priceMethod).toStringAsFixed(2)} MAD',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: widget.type==ataycom ?ataycomColor:parfumColor,
                                        
                                        fontWeight: FontWeight.w600))
                              ],
                            ),
                        ),
                        
                       
                      ],
                    ),
                    ),
                ),
                SizedBox(height: 15,),
               Padding(
                padding: EdgeInsets.only(left: 15,right: 15,top: 15),
                child: Container(
                  height: 300,
                  width: double.infinity,
                  decoration: BoxDecoration(
                     boxShadow: [
                        BoxShadow(
                            blurRadius: 4,
                            color:widget.type==ataycom ?ataycomColor:parfumColor,
                            offset: Offset(0, 0),
                            spreadRadius: 1)
                      ],
                    borderRadius: BorderRadius.circular(5),
                     color: Colors.white,
                     ),
                    child: Column(
                      children: [
                        SizedBox(height: 15,),
                        Text('How to pay ?',style: TextStyle(fontSize: 27,color: widget.type==ataycom ?ataycomColor:parfumColor,),),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Column(
                          children: [
                            Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                            Container(
                              height: 50,
                              width: 50,
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(25),color: widget.type==ataycom ?ataycomColor:parfumColor,),
                                 child: Image.asset('assets/travel-agency.png',),
                              ),
                              SizedBox(width: 20,),
                              Expanded(child: Container(
                                child: RichText(
                                  text:TextSpan(
                                    style: TextStyle(color: Colors.black),
                                  children: [
                                    TextSpan(
                                      text: '1- Go to one of the '
                                    ),
                                     TextSpan(
                                      text: '${PaymentMethods(widget.payment_method)} ',
                                      style: TextStyle(
                                        color: widget.type==ataycom ?ataycomColor:parfumColor,
                                      )
                                    ),
                                      TextSpan(
                                      text: 'bills ',
                                       style: TextStyle(
                                        color: widget.type==ataycom ?ataycomColor:parfumColor,
                                      )
                                    ),
                                      TextSpan(
                                      text: 'or ',
                                    ),
                                     TextSpan(
                                      text: 'cash guarantee ',
                                       style: TextStyle(
                                        color: widget.type==ataycom ?ataycomColor:parfumColor,
                                      )
                                    ),
                                  
                                     TextSpan(
                                      text: 'with the payment code above.'
                                    ),
                              ]
                              )
                              )
                              )
                              )
                            ],
                          ),
                        ),
                         SizedBox(height: 20,),
                         Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                            Container(
                              height: 50,
                              width: 50,
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(25),color: widget.type==ataycom ?ataycomColor:parfumColor,),
                                child: Image.asset('assets/payment-method.png'),
                              ),
                             SizedBox(width: 20,),
                              Expanded(child: Container(child:RichText(
                                  text:TextSpan(
                                    style: TextStyle(color: Colors.black),
                                  children: [
                                    TextSpan(
                                      text: '2- Show the  '
                                    ),
                                     TextSpan(
                                      text: 'payment code ',
                                      style: TextStyle(
                                        color: widget.type==ataycom ?ataycomColor:parfumColor,
                                      )
                                    ),
                                      TextSpan(
                                      text: 'for ',
                                      
                                    ),
                                      TextSpan(
                                      text: 'the cash plus agent, ',
                                     
                                    ),
                                      TextSpan(
                                      text: ' bills ',
                                       style: TextStyle(
                                        color: widget.type==ataycom ?ataycomColor:parfumColor,
                                      )
                                    ),
                                     TextSpan(
                                      text: 'or ',
                                    ),
                                     TextSpan(
                                      text: 'cash guarantee.',
                                       style: TextStyle(
                                        color: widget.type==ataycom ?ataycomColor:parfumColor,
                                      )
                                    ),
                              ]
                              )
                              )
                              ))
                            ],
                          ),
                        ),
                         SizedBox(height: 20,),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                            Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(25),color: widget.type==ataycom ?ataycomColor:parfumColor,),
                               child: Image.asset('assets/banking.png',),
                              ),
                              SizedBox(width: 20,),
                              Expanded(child: Container(child:RichText(
                                  text:TextSpan(
                                    style: TextStyle(color: Colors.black),
                                  children: [
                                    TextSpan(
                                      text: '3- After payment, you will receive the final ticket  '
                                    ),
                                     TextSpan(
                                      text: 'via ',
                                     
                                    ),
                                      TextSpan(
                                      text: 'SMS ',
                                       style: TextStyle(
                                        color: widget.type==ataycom ?ataycomColor:parfumColor,
                                      )
                                    ),
                                      TextSpan(
                                      text: 'or ',
                                     
                                    ),
                                      TextSpan(
                                      text: ' e-mail ',
                                       style: TextStyle(
                                        color: widget.type==ataycom ?ataycomColor:parfumColor,
                                      )
                                    ),
                                     TextSpan(
                                      text: 'after payment. ',
                                    ),
                              ]
                              )
                              ))),
                              
                            ],
                          ),
                        ),
                          ],
                        ),
                      )
                      ],
                    ), 
                ),
              ),
               SizedBox(height: 20,),
            ],
          ) ,
        ),
      ),
    );
  }
}