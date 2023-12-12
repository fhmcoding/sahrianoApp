import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahariano_travel/ataycom_app/layout/cubit/cubit.dart';
import 'package:sahariano_travel/ataycom_app/layout/cubit/states.dart';
import 'package:sahariano_travel/ataycom_app/pages/cart_page.dart';
import 'package:sahariano_travel/layout/home.dart';
import 'package:sahariano_travel/localization/demo_localization.dart';
import 'package:sahariano_travel/shared/components/constants.dart';
import 'package:shimmer/shimmer.dart';
class DetailsPage extends StatefulWidget {
  final String articalType;
  final String categorie;
  final int currentIndex;
  final String name;
  final String labelAttrbute;
  final String image;
  int price;
  final int oldprice;
  final String brand;
  final int id;
  final String type;
   final int varition_id ;
   DetailsPage({ Key key,this.name,this.image,this.price,this.oldprice,this.type,this.id,this.brand,this.labelAttrbute,this.varition_id, this.currentIndex, this.articalType, this.categorie}) : super(key: key);

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
List<dynamic> itemsCart =[];
int currentIndex;
int selectimage = 0;
int selectedItem = 0;
  @override
  Widget build(BuildContext context) {
    
    var price = widget.price;
    return BlocProvider(
      create: (BuildContext context) =>StoreCubit()..getProductDetails(url:'${widget.type}/api/v1/products/${widget.id}')..getProducts(type:widget.type,articletype: widget.articalType)..getCartItem(type: widget.type),
      child: BlocConsumer<StoreCubit,StoreStates>(
        listener: (context,state){
if (state is AddToCartSuccesState) {
   StoreCubit.get(context).getCartItem(type: widget.type);
    }
        },
        builder: (context,state){         
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
               actions: [
              GestureDetector(
                   onTap: (){
                   Navigator.push(context,MaterialPageRoute(builder: (context)=>CartPage(type: widget.type,currentIndex:widget.currentIndex)));
                   },
                   child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 20),
                              child:  Icon(
                                  Icons.shopping_cart_outlined,
                                  color:  widget.type==ataycom ?ataycomColor:parfumColor,
                                  size: 22
                                ),
                            ),
                            Positioned(
                              top: 10,
                              left: 10,
                              child: CircleAvatar(
                                backgroundColor: Color.fromARGB(255, 10, 84, 145),
                                child: Text(
                                "${StoreCubit.get(context).itemsCart.length}",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10),
                                ),
                                minRadius: 8,
                              ),
                            ),
                          ],
                        ),
                 ),
              
             ],
            backgroundColor: Colors.white,
            elevation: 0,
            leading: GestureDetector(
              onTap: (){
               Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>Home(Index:service.indexId=widget.currentIndex,)), (route) => route.isFirst);
              },
              child: Icon(Icons.arrow_back,color: Colors.black,)),
          ),
          bottomNavigationBar: Container(
            height: 80,
            width: double.infinity,
            color: Colors.white,
            child: Row(
              children: [
                SizedBox(width: 5,),
                BuildCondition(
                  builder: (context){
                    return Container(
                  width: MediaQuery.of(context).size.width-200,
                  child:Padding(
                                 padding: const EdgeInsets.all(8.0),
                                 child: StoreCubit.get(context).items.length!=0 ?
                                 GestureDetector(
                                   onTap: (){
                                    StoreCubit.get(context).AddToCart(
                                        qty:StoreCubit.get(context).qty,
                                        varition_id: StoreCubit.get(context).varition_id,
                                        type: widget.type
                                      );

                                    },
                                   child:
                                   Container(
                                     height: 50,
                                     
                                     decoration: BoxDecoration(color:StoreCubit.get(context).items.length!=0 ? widget.type==ataycom ?ataycomColor:parfumColor:Colors.grey,borderRadius: BorderRadius.circular(5)),
                                     child: Center(child: Padding(
                                       padding: const EdgeInsets.all(8.0),
                                       child: Row(
                                         mainAxisAlignment: MainAxisAlignment.spaceAround,
                                         children: [
                                          Text(DemoLocalization.of(context).getTranslatedValue('add_tocart'),style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600,color: Colors.white,),textAlign: TextAlign.center,),
                                          SizedBox(width: 5,),
                                          Text('${price * StoreCubit.get(context).qty} ${DemoLocalization.of(context).getTranslatedValue('currenc')}',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600,color: Colors.white,),textAlign: TextAlign.center,)
                                         ],
                                       ),
                                     )),
                                                      
                                   ),
                                 ): Container(
                                   height: 50,

                                   decoration: BoxDecoration(color:StoreCubit.get(context).items.length!=0 ? widget.type==ataycom ?ataycomColor:parfumColor:Colors.grey,borderRadius: BorderRadius.circular(5)),
                                   child: Center(child: Padding(
                                     padding: const EdgeInsets.all(8.0),
                                     child: Row(
                                       mainAxisAlignment: MainAxisAlignment.spaceAround,
                                       children: [
                                         Text(DemoLocalization.of(context).getTranslatedValue('add_tocart'),style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600,color: Colors.white,),textAlign: TextAlign.center,),
                                         SizedBox(width: 5,),
                                         Text('${price * StoreCubit.get(context).qty} ${DemoLocalization.of(context).getTranslatedValue('currenc')}',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600,color: Colors.white,),textAlign: TextAlign.center,)
                                       ],
                                     ),
                                   )),

                                 ),
                               )
                );
                  },
                  condition: state is!AddToCartLoadingState,
                  fallback: (context){
                  return Container(
                     width: MediaQuery.of(context).size.width-200,
                  child:Padding(
                                 padding: const EdgeInsets.all(8.0),
                                 child: GestureDetector(
                                   onTap: (){
                                      StoreCubit.get(context).AddToCart(
                                        qty:StoreCubit.get(context).qty,
                                        varition_id: StoreCubit.get(context).varition_id,
                                        type: widget.type
                                      );
                                   },
                                   child: Container(
                                     height: 50,
                                     decoration: BoxDecoration(color:Colors.grey,borderRadius: BorderRadius.circular(5)),
                                     child: Center(child: Padding(
                                       padding: const EdgeInsets.all(8.0),
                                       child: Row(
                                         mainAxisAlignment: MainAxisAlignment.spaceAround,
                                         children: [
                                          Text(DemoLocalization.of(context).getTranslatedValue('add_tocart'),style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600,color: Colors.white,),textAlign: TextAlign.center,),
                                          SizedBox(width: 5,),
                                          Text('${price * StoreCubit.get(context).qty} ${DemoLocalization.of(context).getTranslatedValue('currenc')}',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600,color: Colors.white,),textAlign: TextAlign.center,)
                                         ],
                                       ),
                                     )),
                                                      
                                   ),
                                 ),
                               )
                );
                  },
                ),
                 Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: 10,left: 20),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(5)
                    ),
                    height: 50,
                    width: 155,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10,right: 10),
                          child: GestureDetector(
                            onTap: (){
                               StoreCubit.get(context).plus();
                            },
                            child: Container(
                              height: 30,
                              width: 30,
                               decoration: BoxDecoration(
                                 color:Colors.white,
                                 borderRadius: BorderRadius.circular(3)),
                              child: Icon(Icons.add,color: Colors.black,size: 18,),
                            ),
                          ),
                        ),
                        Text('${StoreCubit.get(context).qty}',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 18),),
                         Padding(
                           padding: const EdgeInsets.only(right: 10,left: 10),
                           child: GestureDetector(
                             onTap: (){
                                StoreCubit.get(context).minus();
                             },
                             child: Container(
                                height: 30,
                              width: 30,
                               decoration: BoxDecoration(
                                 color:Colors.white,
                                 borderRadius: BorderRadius.circular(3)),
                               
                              child: Icon(Icons.remove,color: Colors.black,size: 18,),
                                                   ),
                           ),
                         )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                StoreCubit.get(context).images.length!=0?Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Container(
                        height: 280,
                        width: double.infinity,
                        color:  Colors.white,
                        child:Image.network('${StoreCubit.get(context).images[selectimage]['src']}',)
                      ),
                      widget.type!=ataycom?Padding(padding:EdgeInsets.only(right: 10,top: 0),
                child:StoreCubit.get(context).gender != 'unisex'?Image.asset(StoreCubit.get(context).gender != 'woman'?'assets/man.png':'assets/girl.png',color:StoreCubit.get(context).gender != 'woman'? parfumColor:Colors.blue,):Image.asset('assets/female-and-male-shapes-silhouettes.png',color:parfumColor,)
                ,):SizedBox(height: 0,)
                ],
                ):Container(
                    height:260,
                    width: double.infinity,
                    child: Center(child: CircularProgressIndicator())
                  ),
                  Container(
                    height: 90,
                    width: double.infinity,
                    child: BuildCondition(
                      condition: StoreCubit.get(context).images.length!=0,
                      builder: (context){
                        return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount:StoreCubit.get(context).images.length,
                        itemBuilder: (context,index){
                        return GestureDetector(
                               onTap: (){
                                 setState(() {
                                   selectimage = index;
                                 });
                               },
                               child: Padding(
                                 padding: const EdgeInsets.all(8.0),
                                 child: Container(
                                   decoration: BoxDecoration(
                                     borderRadius: BorderRadius.circular(5),
                                   border: Border.all(color:selectimage==index
                                   ?widget.type==ataycom ?ataycomColor:parfumColor:Colors.grey[200],
                                   width:selectimage==index? 1.6:1)),
                                   height: 80,
                                   width: 80,
                                   child: Image.network('${StoreCubit.get(context).images[index]['src']}'),
                                 ),
                               ),
                             );
                      });
                      },
                     fallback: (context){
                       return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount:2,
                        itemBuilder: (context,index){
                        return GestureDetector(
                               onTap: (){
                                 setState(() {
                                   selectimage = index;
                                 });
                               },
                               child: Padding(
                                 padding: const EdgeInsets.all(8.0),
                                 child: Shimmer.fromColors(
                                      baseColor: Colors.grey[300],
                                      highlightColor: Colors.grey[100],
                                       period:Duration(seconds: 2),
                                   child: Container(
                                     decoration: BoxDecoration(
                                         color: Colors.white,
                                         borderRadius: BorderRadius.circular(5)
                                    ),
                                     height: 80,
                                     width: 80,
                                   
                                   ),
                                 ),
                               ),
                             );
                      });
                     },
                    ),
                  ),
                  Container(height: 0.2,width: double.infinity,color: Colors.grey[300],),
                  Padding(
                    padding: const EdgeInsets.only(left: 15,top: 10,right:8,),
                    child: Text('${widget.name}',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600),),
                  ),
                  
                  SizedBox(height: 5,),
                  Padding(
                    padding: const EdgeInsets.only(left: 15,top: 0,right:8,),
                    child: Text('${widget.brand}',style: TextStyle(fontSize: 12,color: Colors.grey),),
                  ),
                     SizedBox(height: 5,),
                  Padding(
                    padding: const EdgeInsets.only(left: 15,top: 0,right: 8),
                    child:StoreCubit.get(context).subname != null? Text('${StoreCubit.get(context).subname}',style: TextStyle(fontSize: 14),):SizedBox(height: 0,),
                  ),
                   Container(
                    height: 90,
                    width: double.infinity,
                    child:  BuildCondition(
                      condition:StoreCubit.get(context).items.length!=0,
                      builder: (context){
                        return  ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount:StoreCubit.get(context).items.length,
                        itemBuilder: (context,index){
                        return GestureDetector(
                               onTap: (){
                                 setState(() {
                                  widget.price = StoreCubit.get(context).items[index]['price'];
                                  StoreCubit.get(context).varition_id = StoreCubit.get(context).items[index]['id'];
                                 
                                  currentIndex = StoreCubit.get(context).images.indexWhere((image)=> image['id'] == StoreCubit.get(context).items[index]['image_id']);  
                                  selectimage = currentIndex;
                                  selectedItem = index;
                                });
                               },
                               child: Padding(
                                 padding: const EdgeInsets.all(8.0),
                                 child: Container(
                                   decoration: BoxDecoration(
                                     borderRadius: BorderRadius.circular(10),
                                     border:
                                    Border.all(color:selectedItem == index?
                                  widget.type==ataycom ?ataycomColor:parfumColor:Colors.grey[200],
                                    width:1.5
                                    )
                                    ),
                                   
                                    width: 150,
                                   child: Column(
                                     children:[
                                      Container(
                                        decoration: BoxDecoration(
                                          color:widget.type==ataycom ?ataycomColor:parfumColor,
                                          borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10),
                                        )),
                                        child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                         StoreCubit.get(context).items[index]['size']!=null?Text('${StoreCubit.get(context).items[index]['size']} ${widget.labelAttrbute}',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600,color: Colors.white),):SizedBox(height: 0),
                                         if(widget.type==ataycom?countryService.productsAtay[index]['old_price']!= null:countryService.productsParfum[index]['old_price'] != null)
                                            Text('-${StoreCubit.get(context).items[index]['offer']} %',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600,color: Colors.white),)
                                          ],
                                        )
                                      ),width: double.infinity,),
                                     Row(
                                       children:[
                                         Padding(
                                           padding:const EdgeInsets.only(left: 10,top: 10,right: 8),
                                           child:Image.network('${StoreCubit.get(context).items[index]['image']}',height: 25,fit: BoxFit.cover),
                                         ),
                                         Spacer(),
                                          
                                   
                                         
                                         Padding(
                                           padding: const EdgeInsets.only(top: 5,right: 8,left: 8),
                                           child: Column(
                                             children: [
                                         StoreCubit.get(context).items[index]['price']!= null?Text('${StoreCubit.get(context).items[index]['price']} ${DemoLocalization.of(context).getTranslatedValue('currenc')}',style: TextStyle(fontSize: 10,fontWeight: FontWeight.w600),):SizedBox(height: 0,),
                                         if(widget.type==ataycom?countryService.productsAtay[index]['old_price']!= null:countryService.productsParfum[index]['old_price'] != null)
                                         Text('${widget.type==ataycom?countryService.productsAtay[index]['old_price']:countryService.productsParfum[index]['old_price']} ${DemoLocalization.of(context).getTranslatedValue('currenc')}',style: TextStyle(fontSize: 10,fontWeight: FontWeight.w600,color: Colors.grey,decoration: TextDecoration.lineThrough),)
                                             ],
                                           ),
                                         )
                                       ],
                                     )
                                         
                                     ],
                                   ),
                                  
                                 ),
                               ),
                             );
                      });
                      },
                      fallback: (context){
                        return  ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount:1,
                        itemBuilder: (context,index){
                        return GestureDetector(
                               child: Padding(
                                 padding: const EdgeInsets.all(8.0),
                                 child: Shimmer.fromColors(
                                     baseColor: Colors.grey[300],
                                        highlightColor: Colors.grey[100],
                                       period:Duration(seconds: 2),
                                   child: Container(
                                     decoration: BoxDecoration(
                                       borderRadius: BorderRadius.circular(10),
                                         color:Colors.grey,
                                     
                                      ),
                                     height: 80,
                                      width: 145,
                                     child: Column(
                                       children:[
                                        Container(
                                          decoration: BoxDecoration(
                                            color:Colors.grey,
                                            borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10),
                                          )),
                                        ),
                                       Row(
                                         children: [
                                         
                                           Spacer(),
                                            SizedBox(width: 5,),
                                         SizedBox(height: 0),
                                           SizedBox(width: 5,),
                                           Padding(
                                             padding: const EdgeInsets.only(top: 15,right: 5),
                                             child: Column(
                                               children: [
                                        
                                               ],
                                             ),
                                           )
                                         ],
                                       )
                                           
                                       ],
                                     ),
                                    
                                   ),
                                 ),
                               ),
                             );
                      });
                      },
                    ),
                  ),
              // StoreCubit.get(context).items.length==0?SizedBox(height:0):Text('${StoreCubit.get(context).items[currentIndex]['upsell']}'),
                //  Image.network('${StoreCubit.get(context).items[selectimage]['size']}',),
              //  Text('${StoreCubit.get(context).items[selectedItem]['upsell']}'):SizedBox(height: 0),


              //  StoreCubit.get(context).items.length!=0?Padding(padding: EdgeInsets.only(left: 15,top: 10),
              //  child:StoreCubit.get(context).items[selectedItem]['upsell'].length!=0?
              //  Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     mainAxisAlignment: MainAxisAlignment.start,
              //    children: [
              //    Text('You can take advantage of the following discounts for the purchase of several items',style: TextStyle(fontSize: 15),),
                 
              //      ...StoreCubit.get(context).items[selectedItem]['upsell'].map((upsell){
                  
              //        return Padding(
              //          padding: const EdgeInsets.all(8.0),
              //          child: Container(
                         
              //            child: Row(
              //              children: [
                             
              //                Text('${StoreCubit.get(context).items[selectedItem]['size']} ${widget.labelAttrbute}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14,color: Colors.grey)),
              //                SizedBox(width: 15,),
              //               Text('x${upsell['quantity']}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),
              //                SizedBox(width: 15,),
              //                Text('${upsell['price']} MAD',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: Colors.grey)),
              //                Spacer(),
              //                Text('${upsell['quantity']*upsell['price']} MAD',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),
              //                Padding(
              //                  padding: const EdgeInsets.all(8.0),
              //                  child: GestureDetector(
              //                    onTap: () {
              //                         StoreCubit.get(context).AddToCart(
              //                             qty:upsell['quantity'],
              //                             varition_id: StoreCubit.get(context).varition_id,
              //                             type: widget.type
              //                           );
              //                    }, 
              //                    child: Container(
              //                      height:35,
              //                      width:80,
              //                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),
              //                      color: parfumColor,
              //                      ),
                                   
              //                      child: Center(child: Text('Add to cart',textAlign: TextAlign.center,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 13),)),
              //                    ),
              //                  ),
              //                )
              //              ],
              //            ),
              //          ),
              //        );
              //      })
              //  ],
              //  ):SizedBox(height: 0))
              //  :SizedBox(height: 0),
                  SizedBox(height: 5,),
                 Container(
                   child:BuildCondition(
                     condition:widget.type==ataycom?countryService.productsAtay.length!=0:countryService.productsParfum.length!=0,
                    builder: (context){
                      return  Padding(
                   padding: const EdgeInsets.only(left: 15,right: 10),
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       Text('${widget.categorie}',style: TextStyle(
                              fontSize: 15,fontWeight: FontWeight.w600,
                              color: widget.type==ataycom?ataycomColor:parfumColor,
                                    )),
                     ],
                   ),
                 );
                    },
                    fallback: (context){
                      return Shimmer.fromColors(
                         baseColor: Colors.grey[300],
                         highlightColor: Colors.grey[100],
                        period:Duration(seconds: 2),
                        child: Padding(
                           padding: const EdgeInsets.only(left: 15,right: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: 10,
                                width: 120,
                                color: Colors.grey,
                              ),
                             
                              
                            ],
                          ),
                        ),
                      );
                    },
                 )),
              
               
               SizedBox(height: 15,),
                Container(
                                 height: 300,
                                 width: double.infinity,
                                
                                 child: ListView.builder(
                                   shrinkWrap: true,
                                   
                                   scrollDirection: Axis.horizontal,
                                   itemCount:widget.type==ataycom?countryService.productsAtay.where((element) => element['category']==widget.categorie)
                                    .where((element) => element['category']==widget.categorie).length:countryService.productsParfum.where((element) => element['category']==widget.categorie)
                                    .where((element) => element['category']==widget.categorie).length,
                                   itemBuilder: (context,index){
                                      var storeCubit = StoreCubit.get(context);
                                      var list2 = widget.type==ataycom?countryService.productsAtay.where((element) => element['category']==widget.categorie)
                                      .where((element) => element['category']==widget.categorie).toList():countryService.productsParfum.where((element) => element['category']==widget.categorie)
                                      .where((element) => element['category']==widget.categorie).toList();
                                      return Padding(
                           padding:EdgeInsets.symmetric(vertical:5,horizontal: 5),
                           child: Stack(
                             children: [ 
                               InkWell(
                                 onTap: (){
                                 Navigator.push(context, MaterialPageRoute(
                                   builder: (context)=>DetailsPage(
                                   articalType: widget.articalType,
                                   categorie: widget.categorie,
                                   name:widget.type==ataycom?list2[index]['name']:list2[index]['name'],
                                   image:widget.type==ataycom?list2[index]['image']:list2[index]['image'],
                                   price:widget.type==ataycom?list2[index]['price']:list2[index]['price'],
                                   oldprice:widget.type==ataycom?list2[index]['old_price']:list2[index]['old_price'],
                                   brand:widget.type==ataycom?list2[index]['brand']:list2[index]['brand'],
                                   labelAttrbute:widget.type==ataycom?list2[index]['labelAttrbute']:list2[index]['labelAttrbute'],
                                   id: widget.type==ataycom?list2[index]['id']:list2[index]['id'],
                                   varition_id:storeCubit.varition_id,
                                   type: widget.type,
                                   currentIndex: widget.currentIndex,
                                 )));
                                
                                 },
                                 child: Container(  
                                   width: 145,
                                   decoration: BoxDecoration( color: Colors.white,borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                     BoxShadow(
                                       blurRadius: 2.2,
                                        color: Color.fromARGB(255, 218, 218, 218),
                                        offset: Offset(0.5,2.2),
                                         spreadRadius: 1.0)
                                         ],),
                                   child: Column(
                                     children: [
                               Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child:Image.network('${widget.type==ataycom?list2[index]['image']:list2[index]['image']}',fit: BoxFit.cover,height: 110,)
                                ),
                                       Padding(
                                         padding: const EdgeInsets.all(4.0),
                                         child: Text('${widget.type==ataycom?list2[index]['name']:list2[index]['name']}',style: TextStyle(fontSize: 12,fontWeight: FontWeight.w600,overflow: TextOverflow.ellipsis,height: 1.1),textAlign: TextAlign.center,maxLines: 2,),
                                       ),
                                       Text('${widget.type==ataycom?list2[index]['brand']:list2[index]['brand']}',style: TextStyle(fontSize: 12,fontWeight: FontWeight.w600,overflow: TextOverflow.ellipsis,height: 1.1,color: Colors.grey),textAlign: TextAlign.center,maxLines: 2,),
                                       SizedBox(height: 5,),
                                        Text('${widget.type==ataycom?list2[index]['size']:list2[index]['size']} ${widget.type==ataycom?list2[index]['labelAttrbute']:list2[index]['labelAttrbute']}',style: TextStyle(fontSize: 12,fontWeight: FontWeight.w600,overflow: TextOverflow.ellipsis,height: 1.1,),textAlign: TextAlign.center,maxLines: 2,),
                                       SizedBox(height: 5,),
                                       Row(
                                         mainAxisAlignment: MainAxisAlignment.center,
                                         children: [
                                          Text('${widget.type==ataycom?list2[index]['price']:list2[index]['price']} MAD',style: TextStyle(fontSize: 12,color: widget.type == ataycom ? tabatayColor : tabparfum,fontWeight: FontWeight.w600),textAlign: TextAlign.center,),
                                          SizedBox(width: 10,),
                                          if(widget.type==ataycom?list2[index]['old_price']!= null:list2[index]['old_price'] != null)
                                          Text('${widget.type==ataycom?list2[index]['old_price']:list2[index]['old_price']} MAD',style: TextStyle(fontSize: 12,decoration: TextDecoration.lineThrough),textAlign: TextAlign.center,),
                                         ],
                                       ),
                                       Spacer(),
                                       Padding(
                                         padding: const EdgeInsets.all(8.0),
                                         child: InkWell(
                                           onTap: (){
                                            Navigator.push(context, MaterialPageRoute(
                                                builder: (context)=>DetailsPage(
                                                 articalType: widget.articalType,
                                                  categorie: widget.categorie,
                                                  name:widget.type==ataycom?list2[index]['name']:list2[index]['name'],
                                                  image:widget.type==ataycom?list2[index]['image']:list2[index]['image'],
                                                  price:widget.type==ataycom?list2[index]['price']:list2[index]['price'],
                                                  oldprice:widget.type==ataycom?list2[index]['old_price']:list2[index]['old_price'],
                                                  brand:widget.type==ataycom?list2[index]['brand']:list2[index]['brand'],
                                                  labelAttrbute:widget.type==ataycom?list2[index]['labelAttrbute']:list2[index]['labelAttrbute'],
                                                  id: widget.type==ataycom?list2[index]['id']:list2[index]['id'],
                                                  varition_id:storeCubit.varition_id,
                                                  type: widget.type,
                                                  currentIndex: widget.currentIndex,
                                              )));
                                           },
                                           child: Container(
                                             height: 40,
                                             decoration: BoxDecoration(color:widget.type==ataycom ?ataycomColor:parfumColor,borderRadius: BorderRadius.circular(5)),
                                             child: Center(child: Text(DemoLocalization.of(context).getTranslatedValue('view_product'),style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600,color: Colors.white,),textAlign: TextAlign.center,)),

                                           ),
                                         ),
                                       )
                                     ],
                                   ),
                                 ),
                               ),
                          if(widget.type==ataycom?list2[index]['old_price']!= null:list2[index]['old_price'] != null)
                          Padding(
                                 padding: const EdgeInsets.all(8.0),
                                 child: Container(
                                   height: 35,
                                   width: 45,
                                   decoration: BoxDecoration(
                                      color: Color(0xFFb89d67),
                                     borderRadius: BorderRadius.circular(5)),
                                   child: Padding(
                                     padding: const EdgeInsets.all(4.0),
                                     child: Center(child: Text('- ${widget.type==ataycom?list2[index]['offer']:list2[index]['offer']} %',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 12),textAlign: TextAlign.center,)),
                                   ),
                                 ),
                               ),
                             ],
                           ),
                         );
                                   }),
                               )
     
                ],
              ),
            ),
          ),
        );
        },
      ),
    );
  }
}



//  ListView.builder(
//                                 physics: NeverScrollableScrollPhysics(),
//                                 shrinkWrap: true,
//                                 controller:scrollController,
//                                 itemCount: StoreCubit.get(context)
//                                     .brandProduct
//                                     .length,
//                                 itemBuilder: (_, index) {
//                                   return Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Wrap(
//                                         direction: Axis.horizontal,
//                                         children: [
//                                          buildDishets(StoreCubit.get(context)
//                                     .brandProduct[index],context)
//                                         ],
//                                       ),
//                                     ],
//                                   );
//                                 }),