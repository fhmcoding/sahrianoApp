

import 'package:buildcondition/buildcondition.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahariano_travel/ataycom_app/layout/cubit/cubit.dart';
import 'package:sahariano_travel/ataycom_app/layout/cubit/states.dart';
import 'package:sahariano_travel/ataycom_app/pages/categories_page.dart';
import 'package:sahariano_travel/ataycom_app/pages/category.dart';
import 'package:sahariano_travel/ataycom_app/pages/cart_page.dart';
import 'package:sahariano_travel/ataycom_app/pages/details_pages.dart';
import 'package:sahariano_travel/drawer/menuwidget.dart';
import 'package:sahariano_travel/localization/demo_localization.dart';
import 'package:sahariano_travel/shared/components/components.dart';
import 'package:sahariano_travel/shared/components/constants.dart';
import 'package:sahariano_travel/shared/network/remote/local/cache_helper.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomePage extends StatefulWidget {
final String type;
final String articleType;
final int currentIndex;
const HomePage({Key key,this.type, this.currentIndex,this.articleType}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final auth =FirebaseAuth.instance;

     String firstName = Cachehelper.getData(key: "firstName");
  String lastName = Cachehelper.getData(key: "lastName");
  String phone = Cachehelper.getData(key: "phone");


int activeDot = 0;
int qty = 0;
  List<String>categorie=[
    'Homme',
    'Femme',
    'Kids',
    'Unisex',
    "Tester"
  ];
  
 String language = Cachehelper.getData(key: "langugeCode");
 String access_token = Cachehelper.getData(key: "access_token");
  @override
  Widget build(BuildContext context){
    return BlocProvider(
      create: (BuildContext context)=>StoreCubit()..getSliders(type:widget.type)..getCategories(type: widget.type,articletype: widget.articleType)..getProducts(type: widget.type,articletype: widget.articleType)..getCartItem(type:widget.type),
      child: BlocConsumer<StoreCubit,StoreStates>(
        listener: (context,state){},
        builder: (context,state){
          var list = widget.type==ataycom?countryService.productsAtay:countryService.productsParfum;
        return Scaffold(
             backgroundColor: Color(0xFFf8f8f8),
             appBar: AppBar(
              leading:MenuWidget(color: Colors.white),
              backgroundColor:widget.type==ataycom ?ataycomColor:parfumColor,
              elevation: 0,
              centerTitle: true,
              title: Text(widget.type==ataycom ?DemoLocalization.of(context).getTranslatedValue('atay_title'):DemoLocalization.of(context).getTranslatedValue('parfum_title'),style: TextStyle(color: Colors.white,fontSize: 20),),
              actions: [
              GestureDetector(
                   onTap: (){
                   Navigator.push(context,MaterialPageRoute(builder: (context)=>CartPage(type: widget.type,currentIndex:widget.currentIndex)));
                   },
                   child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child:Icon(
                                  Icons.shopping_cart_outlined,
                                  color: Colors.white,
                                  size: 20
                                ),
                            ),
                            Positioned(
                              top: 10,
                              left: 17,
                              child: CircleAvatar(
                                backgroundColor: Color.fromARGB(255, 10, 84, 145),
                                child: Text(
                                "${countryService.itemsCart.length}",
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
               GestureDetector(
                 onTap: (){
                  //  Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //           builder: (context) => Search(
                  //                type: widget.type,
                  //                currentIndex: widget.currentIndex,
                  //               )));
                 },
                 child: Padding(
                   padding: const EdgeInsets.only(right: 10,left: 10),
                   child: Icon(Icons.search,size: 22,color: Colors.white,),
                 )),
             ],
            ),
          body:SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              CarouselSlider(
             items:widget.type==ataycom?countryService.SlidersAtay.map((image){
             return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                             color: Colors.grey[200],
                          ),
                          height: 180,
                          width: double.infinity,
                           child: ClipRRect(
                             borderRadius:BorderRadius.circular(10) ,
                             child: Image.network(image['src'],fit: BoxFit.cover)),
                        ),
                      );
             }).toList():countryService.SlidersParfum.map((image){
             return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                             color: Colors.grey[200],
                          ),
                          height: 180,
                          width: double.infinity,
                           child: ClipRRect(
                             borderRadius:BorderRadius.circular(10) ,
                             child: Image.network(image['src'],fit: BoxFit.cover)),
                        ),
                      );
             }).toList(),
             options: CarouselOptions(
             onPageChanged: (index,reason){
             setState(() {
             activeDot = index;
             });
             },
              height: 160,
              viewportFraction: 1,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
            autoPlayAnimationDuration: Duration(milliseconds: 800),
              scrollDirection: Axis.horizontal,
             )
           ),
        Center(
            child: AnimatedSmoothIndicator(
            activeIndex: activeDot,
            effect: WormEffect(
              dotColor: Color(0xFFafafaf),
              dotHeight: 8,
              dotWidth: 8,
              activeDotColor: widget.type==ataycom?ataycomColor:parfumColor,
            ),
             count: widget.type==ataycom?countryService.SlidersAtay.length:countryService.SlidersParfum.length
             ),
          ),
              
                  Container(
                   child:BuildCondition(
                    condition:widget.type==ataycom?countryService.productsAtay.length!=0:countryService.productsParfum.length!=0,
                    builder: (context){
                    return Padding(
                   padding:EdgeInsets.only(left: 10,right: 10),
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       Text(DemoLocalization.of(context).getTranslatedValue('categorie_title'),style:TextStyle(
                        fontSize: 15,fontWeight: FontWeight.w600,
                        color: widget.type==ataycom?ataycomColor:parfumColor,
                         )),
                       GestureDetector(
                        onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>CategoryPage(
                              type:widget.type,
                              articleType: widget.articleType,
                              currentIndex: widget.currentIndex,
                              
                              )));
                         },
                         child:Text(DemoLocalization.of(context).getTranslatedValue('seemore_title'),style: TextStyle(fontSize: 12,color:widget.type==ataycom ?ataycomColor:parfumColor,),)
                         )
                     ],
                   )
                 );
                    },
                    fallback: (context){
                      return Shimmer.fromColors(
                         baseColor: Colors.grey[300],
                         highlightColor: Colors.grey[100],
                        period:Duration(seconds: 2),
                        child: Padding(
                           padding: const EdgeInsets.only(left: 10,right: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: 10,
                                width: 120,
                                color: Colors.grey,
                              ),
                                Container(
                                height: 10,
                                width: 60,
                                color: Colors.grey,
                              ),
                              
                            ],
                          ),
                        ),
                      );
                    },
                 )),
                 SizedBox(height: 10,),
                  
                   Container(
                   height:language == 'ar'?120:85,
                   width: double.infinity,
                   child:Container(
                    child:BuildCondition(
                    condition:widget.type==ataycom?countryService.categoriesatay.length!=0:countryService.categoriesparfum.length!=0,
                    builder:(context){
                     return list.length>0? ListView.separated(
                      separatorBuilder: (context,index){
                      return SizedBox(width: 0,);
                      },
                      physics: BouncingScrollPhysics(),
                      itemCount:widget.type==ataycom?countryService.categoriesatay.length:countryService.categoriesparfum.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context,index){
                      return Padding(
                        padding: const EdgeInsets.only(left: 10,right: 10),
                        child: GestureDetector(
                          onTap: (){
                             Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Categories(
                                    articleType: widget.articleType,
                                    index: index,
                                    type: widget.type,
                                    currentIndex: widget.currentIndex,
                                    category:widget.type==ataycom?countryService.categoriesatay[index]['name']:countryService.categoriesparfum[index]['name'],
                                  )));
                                      },
                          child: Container(
                          color: Color(0xFFf8f8f8),
                          width: 90,
                          child: Column(
                              children: [
                              Container(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(7),
                                  child:Image.network('${widget.type==ataycom?countryService.categoriesatay[index]['image']:countryService.categoriesparfum[index]['image']}',fit: BoxFit.cover)                            
                                  ),
                                decoration: BoxDecoration(
                                   boxShadow: [
                                      BoxShadow(
                                        blurRadius: 3,
                                         color: Colors.grey.shade300,
                                         offset: Offset(2, 2),
                                          spreadRadius: 0)
                                          ],
                                  borderRadius: BorderRadius.circular(7),color: Colors.grey[100]),
                                height: 55,
                                width: 90,
                                ),
                                SizedBox(height: 7,),
                                Container(
                                  height: 20,
                                  width: 90,
                                  color:Colors.grey[100],
                                  child: Text('${widget.type==ataycom?countryService.categoriesatay[index]['slug']:countryService.categoriesparfum[index]['slug']}',textAlign: TextAlign.center,maxLines: 2,style: TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: appColor
                                  ),),
                                ),
                              ],
                          ),
                          ),
                        ),
                      );
                    }):SizedBox(height: 0,);
                   },
                   fallback: (context){
                     return buildConditionModel();
                   },
                 ))
                 ),
               list.length>0?Padding(
                  padding: const EdgeInsets.only(left: 5,right: 10,top: 5),
                  child:Column(
                    children: [
                      ...categorie.map((e){
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            if(countryService.productsParfum.where((element) => element['category']==e).length>0)
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('${e}',style: TextStyle(color: widget.type == ataycom ? ataycomColor : parfumColor,fontSize: 16,fontWeight: FontWeight.bold),),
                            ),
                            if(countryService.productsParfum.where((element) => element['category']==e).length>0)
                              Container(
                                 height: 300,
                                 width: double.infinity,
                                 child: ListView.builder(
                                   shrinkWrap: true,
                                   scrollDirection: Axis.horizontal,
                                   itemCount:widget.type==ataycom?countryService.productsAtay.where((element) => element['category']==e)
                                    .where((element) => element['category']==e).length:countryService.productsParfum.where((element) => element['category']==e)
                                    .where((element) => element['category']==e).length,
                                   itemBuilder: (context,index){
                                      var storeCubit = StoreCubit.get(context);
                                      var list2 = widget.type==ataycom?countryService.productsAtay.where((element) => element['category']==e)
                                      .where((element) => element['category']==e).toList():countryService.productsParfum.where((element) => element['category']==e)
                                      .where((element) => element['category']==e).toList();
                                      return Padding(
                           padding:EdgeInsets.symmetric(vertical:5,horizontal: 5),
                           child: Stack(
                             children: [ 
                               InkWell(
                                 onTap: (){
                                 Navigator.push(context, MaterialPageRoute(
                                   builder: (context)=>DetailsPage(
                                    categorie:widget.type==ataycom?list2[index]['category']:list2[index]['category'] ,
                                   articalType: widget.articleType,
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
                                                articalType: widget.articleType,
                                                 categorie:widget.type==ataycom?list2[index]['category']:list2[index]['category'] ,
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
                        );
                      })
                    ],
                  )
                 ):Column(
                   children: [
                     Container(
                       height: 250,
                      //  color: Colors.blue,
                       child: ListView.separated(
                         shrinkWrap: true,
                              separatorBuilder:(context,index){
                                 return SizedBox(width: 0,);
                               },
                               physics: BouncingScrollPhysics(),
                               itemCount: 3,
                               scrollDirection: Axis.horizontal,
                               itemBuilder: (context,index){
                               return Padding(
                                 padding:EdgeInsets.symmetric(vertical: 0,horizontal: 5),
                                 child: Stack(
                                   children: [ 
                                     Container(
                                     height: 235,
                                     width: 145,                      
                                     decoration: BoxDecoration(
                                         color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                         boxShadow: [
                                       BoxShadow(
                                         blurRadius: 2,
                                          color: Color(0xFFaeaeae),
                                          offset: Offset(1, 3),
                                           spreadRadius: 0)
                                           ],),
                                     child: Column(
                                       children: [
                                         SizedBox(height: 15,),
                                          Shimmer.fromColors(
                                           baseColor: Colors.grey[300],
                                           highlightColor: Colors.grey[100],
                                           period:Duration(seconds: 2),
                                          child: Container(
                                            decoration: BoxDecoration(
                                            color: Colors.grey,
                                              borderRadius: BorderRadius.circular(10)
                                            ),
                                            height: 110,width: 130,)),
                                              
                                        
                                        SizedBox(height: 5,),
                                         Padding(
                                           padding: const EdgeInsets.all(4.0),
                                           child:  Shimmer.fromColors(
                                   baseColor: Colors.grey[300],
                                   highlightColor: Colors.grey[100],
                                   period:Duration(seconds: 2),
                                   child: Container(
                                     height: 10,
                                   decoration: BoxDecoration(borderRadius: BorderRadius.circular(7),color: Colors.grey),  
                                   child: Text('Boss The Scent  Scent',textAlign: TextAlign.center,maxLines: 1,style: TextStyle(
                                   overflow: TextOverflow.ellipsis,
                                  fontSize: 11
                                       ),),
                                     ),
                                   ),
                                         ),
                                        SizedBox(height: 1,),
                                         Padding(
                                           padding: const EdgeInsets.all(4.0),
                                           child:  Shimmer.fromColors(
                                   baseColor: Colors.grey[300],
                                   highlightColor: Colors.grey[100],
                                   period:Duration(seconds: 2),
                                   child: Container(
                                     height: 9,
                                   decoration: BoxDecoration(borderRadius: BorderRadius.circular(7),color: Colors.grey),  
                                   child: Text('Boss The Scent  ',textAlign: TextAlign.center,maxLines: 1,style: TextStyle(
                                   overflow: TextOverflow.ellipsis,
                                  fontSize: 10
                                       ),),
                                     ),
                                   ),
                                         ),
                                         Spacer(),
                                         Padding(
                                           padding: const EdgeInsets.all(8.0),
                                           child: InkWell(
                                             onTap: (){
                                            
                                             },
                                             child: Shimmer.fromColors(
                                                baseColor: Colors.grey[300],
                                               highlightColor: Colors.grey[100],
                                               period:Duration(seconds: 2),
                                               child: Container(
                                                 height: 40,
                                                 decoration: BoxDecoration(color:Colors.grey,borderRadius: BorderRadius.circular(5)),
                                                 child: Center(child: Text('View products',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600,color: Colors.white,),textAlign: TextAlign.center,)),
                                               ),
                                             ),
                                           ),
                                         )
                                       ],
                                     ),
                                       ),
                                   ],
                                 ),
                               );
                             }),
                     ),
                     Container(
                       height: 280,
                       child: ListView.separated(
                         shrinkWrap: true,
                              separatorBuilder:(context,index){
                                 return SizedBox(width: 0,);
                               },
                               physics: BouncingScrollPhysics(),
                               itemCount: 3,
                               scrollDirection: Axis.horizontal,
                               itemBuilder: (context,index){
                               return Padding(
                                 padding:EdgeInsets.symmetric(vertical: 0,horizontal: 5),
                                 child: Stack(
                                   children: [ 
                                     Container(
                                     height: 235,
                                     width: 145,                      
                                     decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                         boxShadow: [
                                       BoxShadow(
                                         blurRadius: 2,
                                          color: Color(0xFFaeaeae),
                                          offset: Offset(1, 3),
                                           spreadRadius: 0)
                                           ],),
                                     child: Column(
                                       children: [
                                         SizedBox(height: 15,),
                                          Shimmer.fromColors(
                                           baseColor: Colors.grey[300],
                                           highlightColor: Colors.grey[100],
                                           period:Duration(seconds: 2),
                                          child: Container(
                                            decoration: BoxDecoration(
                                            color: Colors.grey,
                                              borderRadius: BorderRadius.circular(10)
                                            ),
                                            height: 110,width: 130,)),
                                              
                                        
                                        SizedBox(height: 5,),
                                         Padding(
                                           padding: const EdgeInsets.all(4.0),
                                           child:  Shimmer.fromColors(
                                   baseColor: Colors.grey[300],
                                   highlightColor: Colors.grey[100],
                                   period:Duration(seconds: 2),
                                   child: Container(
                                     height: 10,
                                   decoration: BoxDecoration(borderRadius: BorderRadius.circular(7),color: Colors.grey),  
                                   child: Text('Boss The Scent  Scent',textAlign: TextAlign.center,maxLines: 1,style: TextStyle(
                                   overflow: TextOverflow.ellipsis,
                                  fontSize: 11
                                       ),),
                                     ),
                                   ),
                                         ),
                                        SizedBox(height: 1,),
                                         Padding(
                                           padding: const EdgeInsets.all(4.0),
                                           child:  Shimmer.fromColors(
                                   baseColor: Colors.grey[300],
                                   highlightColor: Colors.grey[100],
                                   period:Duration(seconds: 2),
                                   child: Container(
                                     height: 9,
                                   decoration: BoxDecoration(borderRadius: BorderRadius.circular(7),color: Colors.grey),  
                                   child: Text('Boss The Scent  ',textAlign: TextAlign.center,maxLines: 1,style: TextStyle(
                                   overflow: TextOverflow.ellipsis,
                                  fontSize: 10
                                       ),),
                                     ),
                                   ),
                                         ),
                                         Spacer(),
                                         Padding(
                                           padding: const EdgeInsets.all(8.0),
                                           child: InkWell(
                                             onTap: (){
                                            
                                             },
                                             child: Shimmer.fromColors(
                                                baseColor: Colors.grey[300],
                                               highlightColor: Colors.grey[100],
                                               period:Duration(seconds: 2),
                                               child: Container(
                                                 height: 40,
                                                 decoration: BoxDecoration(color:Colors.grey,borderRadius: BorderRadius.circular(5)),
                                                 child: Center(child: Text('View products',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600,color: Colors.white,),textAlign: TextAlign.center,)),
                                               ),
                                             ),
                                           ),
                                         )
                                       ],
                                     ),
                                       ),
                                   ],
                                 ),
                               );
                             }),
                     ),
                   ],
                 ),
                //  BuildCondition(
                //   condition:widget.type==ataycom?countryService.productsAtay.length!=0:categorie.length!=0,
                //   builder: (context){
                //      return  
                //    },
                //    fallback: (context){
                //      return Shimmer.fromColors(
                //         baseColor: Colors.grey[300],
                //         highlightColor: Colors.grey[100],
                //        period:Duration(seconds: 2),
                //        child: Padding(
                //           padding: const EdgeInsets.only(left: 15,right: 10),
                //          child: Row(
                //            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //            children: [
                //              Container(
                //                height: 10,
                //                width: 120,
                //                color: Colors.grey,
                //              ),
                            
                             
                //            ],
                //          ),
                //        ),
                //      );
                //    },
                //  ),
               SizedBox(height: 15,),
//                 Container(
//                      height: 280,
//                      width: double.infinity,
//                      child: BuildCondition(
//                        condition:widget.type==ataycom?countryService.productsAtay.length!=0:countryService.productsParfum.length!=0,
//                        builder: (context){
//                          return  ListView.separated(
//                        separatorBuilder:(context,index){
//                          return SizedBox(width: 0,);
//                          },
//                          physics: BouncingScrollPhysics(),
//                          itemCount: widget.type==ataycom?countryService.productsAtay.length:countryService.productsParfum.length,
//                          scrollDirection: Axis.horizontal,
//                          itemBuilder: (context,index){
//                            var storeCubit = StoreCubit.get(context);
//                          return Padding(
//                            padding:EdgeInsets.symmetric(vertical:5,horizontal: 5),
//                            child: Stack(
//                              children: [ 
//                                InkWell(
//                                  onTap: (){
//                                  Navigator.push(context, MaterialPageRoute(
//                                    builder: (context)=>DetailsPage(
//                                    name:widget.type==ataycom?countryService.productsAtay[index]['name']:countryService.productsParfum[index]['name'],
//                                    image:widget.type==ataycom?countryService.productsAtay[index]['image']:countryService.productsParfum[index]['image'],
//                                    price:widget.type==ataycom?countryService.productsAtay[index]['price']:countryService.productsParfum[index]['price'],
//                                    oldprice:widget.type==ataycom?countryService.productsAtay[index]['old_price']:countryService.productsParfum[index]['old_price'],
//                                    brand:widget.type==ataycom?countryService.productsAtay[index]['brand']:countryService.productsParfum[index]['brand'],
//                                    labelAttrbute:widget.type==ataycom?countryService.productsAtay[index]['labelAttrbute']:countryService.productsParfum[index]['labelAttrbute'],
//                                    id: widget.type==ataycom?countryService.productsAtay[index]['id']:countryService.productsParfum[index]['id'],
//                                    varition_id:storeCubit.varition_id,
//                                    type: widget.type,
//                                    currentIndex: widget.currentIndex,
//                                  )));
                                
//                                  },
//                                  child: Container(  
//                                    width: 145,
//                                    decoration: BoxDecoration( color: Colors.white,borderRadius: BorderRadius.circular(10),
//                                     boxShadow: [
//                                      BoxShadow(
//                                        blurRadius: 2.2,
//                                         color: Color.fromARGB(255, 218, 218, 218),
//                                         offset: Offset(0.5,2.2),
//                                          spreadRadius: 1.0)
//                                          ],),
//                                    child: Column(
//                                      children: [
//                                Padding(
//                                     padding: const EdgeInsets.all(8.0),
//                                     child:Image.network('${widget.type==ataycom?countryService.productsAtay[index]['image']:countryService.productsParfum[index]['image']}',fit: BoxFit.cover,height: 110,)
//                                 ),
//                                        Padding(
//                                          padding: const EdgeInsets.all(4.0),
//                                          child: Text('${widget.type==ataycom?countryService.productsAtay[index]['name']:countryService.productsParfum[index]['name']}',style: TextStyle(fontSize: 12,fontWeight: FontWeight.w600,overflow: TextOverflow.ellipsis,height: 1.1),textAlign: TextAlign.center,maxLines: 2,),
//                                        ),
//                                        Text('${widget.type==ataycom?countryService.productsAtay[index]['brand']:countryService.productsParfum[index]['brand']}',style: TextStyle(fontSize: 12,fontWeight: FontWeight.w600,overflow: TextOverflow.ellipsis,height: 1.1,color: Colors.grey),textAlign: TextAlign.center,maxLines: 2,),
//                                        SizedBox(height: 5,),
//                                         Text('${widget.type==ataycom?countryService.productsAtay[index]['size']:countryService.productsParfum[index]['size']} ${widget.type==ataycom?countryService.productsAtay[index]['labelAttrbute']:countryService.productsParfum[index]['labelAttrbute']}',style: TextStyle(fontSize: 12,fontWeight: FontWeight.w600,overflow: TextOverflow.ellipsis,height: 1.1,),textAlign: TextAlign.center,maxLines: 2,),
//                                        SizedBox(height: 5,),
//                                        Row(
//                                          mainAxisAlignment: MainAxisAlignment.center,
//                                          children: [
//                                           Text('${widget.type==ataycom?countryService.productsAtay[index]['price']:countryService.productsParfum[index]['price']} MAD',style: TextStyle(fontSize: 12,color: widget.type == ataycom ? tabatayColor : tabparfum,fontWeight: FontWeight.w600),textAlign: TextAlign.center,),
//                                           SizedBox(width: 10,),
//                                           if(widget.type==ataycom?countryService.productsAtay[index]['old_price']!= null:countryService.productsParfum[index]['old_price'] != null)
//                                           Text('${widget.type==ataycom?countryService.productsAtay[index]['old_price']:countryService.productsParfum[index]['old_price']} MAD',style: TextStyle(fontSize: 12,decoration: TextDecoration.lineThrough),textAlign: TextAlign.center,),
//                                          ],
//                                        ),
//                                        Spacer(),
//                                        Padding(
//                                          padding: const EdgeInsets.all(8.0),
//                                          child: InkWell(
//                                            onTap: (){
//                                             Navigator.push(context, MaterialPageRoute(
//                                                 builder: (context)=>DetailsPage(
//                                                 name:widget.type==ataycom?countryService.productsAtay:countryService.productsParfum[index]['name'],
//                                                 image:widget.type==ataycom?countryService.productsAtay:countryService.productsParfum[index]['image'],
//                                                 price:widget.type==ataycom?countryService.productsAtay:countryService.productsParfum[index]['price'],
//                                                 oldprice:widget.type==ataycom?countryService.productsAtay:countryService.productsParfum[index]['old_price'],
//                                                 brand:widget.type==ataycom?countryService.productsAtay:countryService.productsParfum[index]['brand'],
//                                                 labelAttrbute:widget.type==ataycom?countryService.productsAtay:countryService.productsParfum[index]['labelAttrbute'],
//                                                 id: widget.type==ataycom?countryService.productsAtay:countryService.productsParfum[index]['id'],
//                                                 varition_id:storeCubit.varition_id,
//                                                 type: widget.type,
//                                                 currentIndex: widget.currentIndex,
//                                               )));
//                                            },
//                                            child: Container(
//                                              height: 40,
//                                              decoration: BoxDecoration(color:widget.type==ataycom ?ataycomColor:parfumColor,borderRadius: BorderRadius.circular(5)),
//                                              child: Center(child: Text(DemoLocalization.of(context).getTranslatedValue('view_product'),style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600,color: Colors.white,),textAlign: TextAlign.center,)),

//                                            ),
//                                          ),
//                                        )
//                                      ],
//                                    ),
//                                  ),
//                                ),
//                           if(widget.type==ataycom?countryService.productsAtay[index]['old_price']!= null:countryService.productsParfum[index]['old_price'] != null)
//                           Padding(
//                                  padding: const EdgeInsets.all(8.0),
//                                  child: Container(
//                                    height: 35,
//                                    width: 45,
//                                    decoration: BoxDecoration(
//                                       color: Color(0xFFb89d67),
//                                      borderRadius: BorderRadius.circular(5)),
//                                    child: Padding(
//                                      padding: const EdgeInsets.all(4.0),
//                                      child: Center(child: Text('- ${widget.type==ataycom?countryService.productsAtay[index]['offer']:countryService.productsParfum[index]['offer']} %',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 12),textAlign: TextAlign.center,)),
//                                    ),
//                                  ),
//                                ),
//                              ],
//                            ),
//                          );
//                        });
//                        },
//                        fallback: (context){
//                          return  ListView.separated(
//                         separatorBuilder:(context,index){
//                            return SizedBox(width: 0,);
//                          },
//                          physics: BouncingScrollPhysics(),
//                          itemCount: 3,
//                          scrollDirection: Axis.horizontal,
//                          itemBuilder: (context,index){
//                          return Padding(
//                            padding:EdgeInsets.symmetric(vertical: 0,horizontal: 10),
//                            child: Stack(
//                              children: [ 
//                                Container(
//                                height: 235,
//                                width: 145,                      
//                                decoration: BoxDecoration(
//                                   color: Colors.white,
//                                   borderRadius: BorderRadius.circular(10),
//                                    boxShadow: [
//                                  BoxShadow(
//                                    blurRadius: 2,
//                                     color: Color(0xFFaeaeae),
//                                     offset: Offset(1, 3),
//                                      spreadRadius: 0)
//                                      ],),
//                                child: Column(
//                                  children: [
//                                    SizedBox(height: 15,),
//                                     Shimmer.fromColors(
//                                      baseColor: Colors.grey[300],
//                                      highlightColor: Colors.grey[100],
//                                      period:Duration(seconds: 2),
//                                     child: Container(
//                                       decoration: BoxDecoration(
//                                       color: Colors.grey,
//                                         borderRadius: BorderRadius.circular(10)
//                                       ),
//                                       height: 110,width: 130,)),
                                        
                                  
//                                   SizedBox(height: 5,),
//                                    Padding(
//                                      padding: const EdgeInsets.all(4.0),
//                                      child:  Shimmer.fromColors(
//                              baseColor: Colors.grey[300],
//                              highlightColor: Colors.grey[100],
//                              period:Duration(seconds: 2),
//                              child: Container(
//                                height: 10,
//                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(7),color: Colors.grey),  
//                              child: Text('Boss The Scent  Scent',textAlign: TextAlign.center,maxLines: 1,style: TextStyle(
//                              overflow: TextOverflow.ellipsis,
//                             fontSize: 11
//                                  ),),
//                                ),
//                              ),
//                                    ),
//                                   SizedBox(height: 1,),
//                                    Padding(
//                                      padding: const EdgeInsets.all(4.0),
//                                      child:  Shimmer.fromColors(
//                              baseColor: Colors.grey[300],
//                              highlightColor: Colors.grey[100],
//                              period:Duration(seconds: 2),
//                              child: Container(
//                                height: 9,
//                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(7),color: Colors.grey),  
//                              child: Text('Boss The Scent  ',textAlign: TextAlign.center,maxLines: 1,style: TextStyle(
//                              overflow: TextOverflow.ellipsis,
//                             fontSize: 10
//                                  ),),
//                                ),
//                              ),
//                                    ),
//                                    Spacer(),
//                                    Padding(
//                                      padding: const EdgeInsets.all(8.0),
//                                      child: InkWell(
//                                        onTap: (){
                                      
//                                        },
//                                        child: Shimmer.fromColors(
//                                           baseColor: Colors.grey[300],
//                                          highlightColor: Colors.grey[100],
//                                          period:Duration(seconds: 2),
//                                          child: Container(
//                                            height: 40,
//                                            decoration: BoxDecoration(color:Colors.grey,borderRadius: BorderRadius.circular(5)),
//                                            child: Center(child: Text('View products',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600,color: Colors.white,),textAlign: TextAlign.center,)),
//                                          ),
//                                        ),
//                                      ),
//                                    )
//                                  ],
//                                ),
//                                  ),
//                              ],
//                            ),
//                          );
//                        });
//                        },
//                      ),
//                    ),
//                 SizedBox(height: 15,),
//                  Container(
//                    child:BuildCondition(
//                      condition:widget.type==ataycom?countryService.productsAtay.length!=0:countryService.productsParfum.length!=0,
//                     builder: (context){
//                       return  Padding(
//                    padding: const EdgeInsets.only(left: 15,right: 10),
//                    child: Text('Offers Today',style: TextStyle(
//    fontSize: 15,fontWeight: FontWeight.w600,
//    color: widget.type==ataycom?ataycomColor:parfumColor,
// )),
//                  );
//                     },
//                     fallback: (context){
//                       return Shimmer.fromColors(
//                          baseColor: Colors.grey[300],
//                          highlightColor: Colors.grey[100],
//                         period:Duration(seconds: 2),
//                         child: Padding(
//                            padding: const EdgeInsets.only(left: 15,right: 10),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Container(
//                                 height: 10,
//                                 width: 120,
//                                 color: Colors.grey,
//                               ),
//                             ],
//                           ),
//                         ),
//                       );
//                     },
//                  )),
//                SizedBox(height: 15,),
//                 Container(
//                      height: 280,
//                      width: double.infinity,
//                      child: BuildCondition(
//                        condition:widget.type==ataycom?countryService.productsAtay.length!=0:countryService.productsParfum.length!=0,
//                        builder: (context){
//                          return  ListView.separated(
//                         separatorBuilder:(context,index){
//                            return SizedBox(width: 0,);
//                          },
//                          physics: BouncingScrollPhysics(),
//                          itemCount: widget.type==ataycom?countryService.productsAtay.length:countryService.productsParfum.length,
//                          scrollDirection: Axis.horizontal,
//                          itemBuilder: (context,index){
//                            var storeCubit = StoreCubit.get(context);
//                          return Padding(
//                            padding:EdgeInsets.symmetric(vertical:5,horizontal: 5),
//                            child: Stack(
//                              children: [ 
//                                InkWell(
//                                  onTap: (){
//                                  Navigator.push(context, MaterialPageRoute(
//                                    builder: (context)=>DetailsPage(
//                                    name:storeCubit.products[index]['name'],
//                                    image:storeCubit.products[index]['image'],
//                                    price:storeCubit.products[index]['price'],
//                                    oldprice:storeCubit.products[index]['old_price'],
//                                    brand:storeCubit.products[index]['brand'],
//                                    labelAttrbute:storeCubit.products[index]['labelAttrbute'],
//                                    id: storeCubit.products[index]['id'],
//                                    varition_id:storeCubit.varition_id,
//                                    type: widget.type,
//                                  )));
//                                  },
//                                  child: Container(
//                                    height: 250,
//                                    width: 145,
//                                    decoration: BoxDecoration( color: Colors.white,borderRadius: BorderRadius.circular(10),
//                                     boxShadow: [
//                                      BoxShadow(
//                                        blurRadius: 2,
//                                         color: Colors.grey.shade300,
//                                         offset: Offset(1, 1),
//                                          spreadRadius: 0)
//                                          ],),
//                                    child: Column(
//                                      children: [
//                                  Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child:Image.network('${widget.type==ataycom?countryService.productsAtay[index]['image']:countryService.productsParfum[index]['image']}',fit: BoxFit.cover,height: 110,)
//                                 ),
//                                        Padding(
//                                          padding: const EdgeInsets.all(4.0),
//                                          child: Text('${widget.type==ataycom?countryService.productsAtay[index]['name']:countryService.productsParfum[index]['name']}',style: TextStyle(fontSize: 12,fontWeight: FontWeight.w600,overflow: TextOverflow.ellipsis,height: 1.1),textAlign: TextAlign.center,maxLines: 2,),
//                                        ),
//                                        Text('${widget.type==ataycom?countryService.productsAtay[index]['brand']:countryService.productsParfum[index]['brand']}',style: TextStyle(fontSize: 12,fontWeight: FontWeight.w600,overflow: TextOverflow.ellipsis,height: 1.1,color: Colors.grey),textAlign: TextAlign.center,maxLines: 2,),
//                                        SizedBox(height: 5,),
//                                        Row(
//                                          mainAxisAlignment: MainAxisAlignment.center,
//                                          children: [
//                                           Text('${widget.type==ataycom?countryService.productsAtay[index]['price']:countryService.productsParfum[index]['price']} MAD',style: TextStyle(fontSize: 12,color: widget.type == ataycom ? tabatayColor : tabparfum,fontWeight: FontWeight.w600),textAlign: TextAlign.center,),
//                                           SizedBox(width: 10,),
//                                           if(widget.type==ataycom?countryService.productsAtay[index]['old_price']!= null:countryService.productsParfum[index]['old_price'] != null)
//                                           Text('${widget.type==ataycom?countryService.productsAtay[index]['old_price']:countryService.productsParfum[index]['old_price']} MAD',style: TextStyle(fontSize: 12,decoration: TextDecoration.lineThrough),textAlign: TextAlign.center,),
//                                          ],
//                                        ),
//                                        Spacer(),
//                                        Padding(
//                                          padding: const EdgeInsets.all(8.0),
//                                          child: InkWell(
//                                            onTap: (){
//                                             Navigator.push(context, MaterialPageRoute(
//                                                 builder: (context)=>DetailsPage(
//                                                 name:storeCubit.products[index]['name'],
//                                                 image:storeCubit.products[index]['image'],
//                                                 price:storeCubit.products[index]['price'],
//                                                 oldprice:storeCubit.products[index]['old_price'],
//                                                 brand:storeCubit.products[index]['brand'],
//                                                 labelAttrbute:storeCubit.products[index]['labelAttrbute'],
//                                                 id: storeCubit.products[index]['id'],
//                                                 varition_id:storeCubit.varition_id,
//                                                 type: widget.type,
//                                               )));
//                                            },
//                                            child: Container(
//                                              height: 40,
//                                              decoration: BoxDecoration(color:widget.type==ataycom?ataycomColor:parfumColor,borderRadius: BorderRadius.circular(5)),
//                                              child: Center(child: Text(DemoLocalization.of(context).getTranslatedValue('view_product'),style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600,color: Colors.white,),textAlign: TextAlign.center,)),
//                                            ),
//                                          ),
//                                        )
//                                      ],
//                                    ),
//                                  ),
//                                ),
//                           if(widget.type==ataycom?countryService.productsAtay[index]['old_price']!= null:countryService.productsParfum[index]['old_price'] != null)
//                           Padding(
//                                  padding: const EdgeInsets.all(8.0),
//                                  child: Container(
//                                    height: 35,
//                                    width: 45,
//                                    decoration: BoxDecoration(
//                                       color: Color(0xFFb89d67),
//                                      borderRadius: BorderRadius.circular(5)),
//                                    child: Padding(
//                                      padding: const EdgeInsets.all(4.0),
//                                      child: Center(child: Text('- ${widget.type==ataycom?countryService.productsAtay[index]['offer']:countryService.productsParfum[index]['offer']} %',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 12),textAlign: TextAlign.center,)),
//                                    ),
//                                  ),
//                                ),
//                              ],
//                            ),
//                          );
//                        });
//                        },
//                        fallback: (context){
//                          return  ListView.separated(
//                         separatorBuilder:(context,index){
//                            return SizedBox(width: 0,);
//                          },
//                          physics: BouncingScrollPhysics(),
//                          itemCount: 3,
//                          scrollDirection: Axis.horizontal,
//                          itemBuilder: (context,index){
//                          return Padding(
//                            padding:EdgeInsets.symmetric(vertical: 0,horizontal: 10),
//                            child: Stack(
//                              children: [ 
//                                Container(
//                                height: 235,
//                                width: 145,                      
//                                decoration: BoxDecoration(
//                                   color: Colors.white,
//                                   borderRadius: BorderRadius.circular(10),
//                                    boxShadow: [
//                                  BoxShadow(
//                                    blurRadius: 2,
//                                     color: Colors.grey.shade300,
//                                     offset: Offset(1, 3),
//                                      spreadRadius: 0)
//                                      ],),
//                                child: Column(
//                                  children: [
//                                    SizedBox(height: 15,),
//                                     Shimmer.fromColors(
//                                      baseColor: Colors.grey[300],
//                                      highlightColor: Colors.grey[100],
//                                      period:Duration(seconds: 2),
//                                     child: Container(
//                                       decoration: BoxDecoration(
//                                       color: Colors.grey,
//                                         borderRadius: BorderRadius.circular(10)
//                                       ),
//                                       height: 110,width: 130,)),
                                        
                                  
//                                   SizedBox(height: 5,),
//                                    Padding(
//                                      padding: const EdgeInsets.all(4.0),
//                                      child:  Shimmer.fromColors(
//                              baseColor: Colors.grey[300],
//                              highlightColor: Colors.grey[100],
//                              period:Duration(seconds: 2),
//                              child: Container(
//                                height: 10,
//                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(7),color: Colors.grey),  
//                              child: Text('Boss The Scent  Scent',textAlign: TextAlign.center,maxLines: 1,style: TextStyle(
//                              overflow: TextOverflow.ellipsis,
//                             fontSize: 11
//                                  ),),
//                                ),
//                              ),
//                                    ),
//                                   SizedBox(height: 1,),
//                                    Padding(
//                                      padding: const EdgeInsets.all(4.0),
//                                      child:  Shimmer.fromColors(
//                              baseColor: Colors.grey[300],
//                              highlightColor: Colors.grey[100],
//                              period:Duration(seconds: 2),
//                              child: Container(
//                                height: 9,
//                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(7),color: Colors.grey),  
//                              child: Text('Boss The Scent  ',textAlign: TextAlign.center,maxLines: 1,style: TextStyle(
//                              overflow: TextOverflow.ellipsis,
//                             fontSize: 10
//                                  ),),
//                                ),
//                              ),
//                                    ),
//                                    Spacer(),
//                                    Padding(
//                                      padding: const EdgeInsets.all(8.0),
//                                      child: Shimmer.fromColors(
//                                         baseColor: Colors.grey[300],
//                                        highlightColor: Colors.grey[100],
//                                        period:Duration(seconds: 2),
//                                        child: Container(
//                                          height: 40,
                                        
//                                          decoration: BoxDecoration(color:Colors.grey,borderRadius: BorderRadius.circular(5)),
//                                          child: Center(child: Text('View products',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600,color: Colors.white,),textAlign: TextAlign.center,)),
                                                          
//                                        ),
//                                      ),
//                                    )
//                                  ],
//                                ),
//                               ),
                          
//                              ],
//                            ),
//                          );
//                        });
//                        },
//                      ),
//                    ),       
                           
              ],
            ),
          )
          
          
        );
        }, 
        
      ),
    );   
  }
}








