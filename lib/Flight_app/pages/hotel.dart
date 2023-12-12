

// import 'package:flutter/material.dart';
// import 'package:flutter/painting.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:sahariano_travel/ataycom_app/layout/cubit/cubit.dart';
// import 'package:sahariano_travel/ataycom_app/layout/cubit/states.dart';
// import 'package:sahariano_travel/ataycom_app/pages/details_pages.dart';
// import 'package:sahariano_travel/ataycom_app/pages/search.dart';
// import 'package:sahariano_travel/shared/components/components.dart';
// import 'package:sahariano_travel/shared/components/constants.dart';
// import 'package:sahariano_travel/shared/network/remote/local/cache_helper.dart';

// const productHeight = 270.0;

// class Categories extends StatefulWidget {
//   final int index;
//   final String type;
//   final int currentIndex;
//   final String articleType;
//   String category; 
//   Categories({Key key, this.index, this.type, this.currentIndex, this.articleType, this.category}) : super(key: key);

//   @override
//   _CategoriesState createState() => _CategoriesState();
// }

// class _CategoriesState extends State<Categories> with TickerProviderStateMixin {
//   TabController _controller;
//   int selectIndex = 0;
//   double offsetFrom = 0;
//   ScrollController scrollController = ScrollController();
//   String language = Cachehelper.getData(key: "langugeCode");
//   List names=[
//     '100',
//     'Bulgari',
//   ];
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (BuildContext context) => StoreCubit()
//         ..getCategories(type: widget.type,articletype:widget.articleType)
//         ..getProducts(type: widget.type,articletype:widget.articleType)
//         ..getCategoriesDetails(url:'${widget.type}/api/v1/categories/${widget.category}'),
//       child: BlocConsumer<StoreCubit, StoreStates>(
//         listener: (context, state) {},
//         builder: (context, state) {
//           var cubit = StoreCubit.get(context);
//           return StoreCubit.get(context).categories.length>0
//               ? DefaultTabController(
//                   length: StoreCubit.get(context).categories.length,
//                   initialIndex: widget.index,
//                   child: Scaffold(
//                     backgroundColor: Color.fromARGB(255, 245, 245, 245),

//                     appBar: AppBar(
//                       bottom:TabBar(
//                                 indicatorWeight: 4,
//                                 physics: BouncingScrollPhysics(),
//                                 controller: _controller,
//                                 padding:EdgeInsets.only(top: 0, left: 0, right: 40),
//                                 indicatorColor: Colors.white,
//                                 isScrollable: true,
//                                 unselectedLabelColor: Colors.white,
//                                 labelColor: Colors.white,
//                                 onTap: (index){
//                                 var storeCubit = StoreCubit.get(context);
//                                 setState((){
//                                     widget.category = storeCubit.categories[index]['name'];
//                                     storeCubit.getCategoriesDetails(
//                                     url:'${widget.type}/api/v1/categories/${widget.category}');
//                                   });
//                                 },
                                
//                                 tabs:StoreCubit.get(context).categories.map((e) {
//                                   return Tab(
//                                     child: Text(
//                                       '${e['name']}',
//                                       style: TextStyle(
//                                           fontWeight: FontWeight.bold,
//                                           fontSize: 18),
//                                     ),
//                                   );
//                                 }).toList()),
//                       automaticallyImplyLeading: false,
//                       toolbarHeight: 70,
//                       title: GestureDetector(
//                         onTap: () {
//                           Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => Search(
//                                         currentIndex: widget.index,
//                                         type: widget.type,
//                                       )));
//                         },
                        
//                       ),
//                       actions: [
//                         Padding(
//                           padding: const EdgeInsets.only(right: 20,left: 20),
//                           child: GestureDetector(
//                             onTap: (){
//                               showModalBottomSheet(
//                                 isScrollControlled:true,
//                                  enableDrag: false,
//                                 context: context, builder: (BuildContext context){
//                                  return Filter(
//                                     context: context,
//                                     onTap: (){
//                                   setState((){
//                                   Navigator.pop(context);
//                                   });
//                                   },
//                                   data:cubit.subcategories,
//                                   category: widget.category
//                                   );
//                               });
//                             },
//                             child: Icon(FontAwesomeIcons.filter,color: Colors.white)),
//                         )
//                       ],
//                       centerTitle: true,
//                       elevation: 1,
//                       backgroundColor:
//                           widget.type == ataycom ? ataycomColor : parfumColor,
//                     ),
//                     body: SingleChildScrollView(
//                       controller: scrollController,
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [

//                           // Container(
//                           //   color: widget.type == ataycom
//                           //       ? tabatayColor
//                           //       : tabparfum,
//                           //   height: 60,
//                           //   width: double.infinity,
//                           //   child: TabBar(
//                           //       indicatorWeight: 4,
//                           //       physics: BouncingScrollPhysics(),
//                           //       controller: _controller,
//                           //       padding:EdgeInsets.only(top: 0, left: 0, right: 40),
//                           //       indicatorColor: Colors.white,
//                           //       isScrollable: true,
//                           //       unselectedLabelColor: Colors.white,
//                           //       labelColor: Colors.white,
//                           //       onTap: (index){
//                           //       var storeCubit = StoreCubit.get(context);
//                           //       setState((){
//                           //           widget.category = storeCubit.categories[index]['name'];
//                           //           storeCubit.getCategoriesDetails(
//                           //           url:'${widget.type}/api/v1/categories/${widget.category}');
//                           //         });
//                           //       },
                                
//                           //       tabs:StoreCubit.get(context).categories.map((e) {
//                           //         return Tab(
//                           //           child: Text(
//                           //             '${e['name']}',
//                           //             style: TextStyle(
//                           //                 fontWeight: FontWeight.bold,
//                           //                 fontSize: 18),
//                           //           ),
//                           //         );
//                           //       }).toList()),
//                           // ),
                         
//                       //  state is! getCategoriesDetailsLoadingState?   Container(
//                       //       height: 65,
//                       //       color: Color(0xFFFAFAFA),
//                       //       width: double.infinity,
//                       //       child: ListView.builder(
//                       //           scrollDirection: Axis.horizontal,
//                       //           itemCount: StoreCubit.get(context)
//                       //               .subcategories
//                       //               .length,
//                       //           itemBuilder: (_, index) {
//                       //             return Row(
//                       //               children: [
//                       //                 if (StoreCubit.get(context)
//                       //                         .subcategories[index]['products']
//                       //                         .length >
//                       //                     0)
//                       //                   GestureDetector(
//                       //                       onTap: () {
//                       //                         setState(() {
//                       //                           selectIndex = StoreCubit.get(
//                       //                                   context)
//                       //                               .subcategories
//                       //                               .indexOf(StoreCubit.get(
//                       //                                       context)
//                       //                                   .subcategories[index]);
//                       //                           print(StoreCubit.get(context)
//                       //                               .subcategories[index]);
//                       //                           offsetFrom = StoreCubit.get(
//                       //                                       context)
//                       //                                   .subcategories[index]
//                       //                                       ['products']
//                       //                                   .length *
//                       //                               productHeight *
//                       //                               10.5 *
//                       //                               StoreCubit.get(context)
//                       //                                   .subcategories
//                       //                                   .indexOf(StoreCubit.get(
//                       //                                               context)
//                       //                                           .subcategories[
//                       //                                       index]);
//                       //                           print(offsetFrom);
//                       //                         });
//                       //                         scrollController.animateTo(
//                       //                             offsetFrom,
//                       //                             duration: Duration(
//                       //                                 milliseconds: 500),
//                       //                             curve: Curves.easeIn);
//                       //                       },
//                       //                       child: Padding(
//                       //                         padding:
//                       //                             const EdgeInsets.all(4.0),
//                       //                         child: Padding(
//                       //                             padding:
//                       //                                 const EdgeInsets.only(
//                       //                                     left: 9),
//                       //                             child: Container(
//                       //                                 decoration: BoxDecoration(
//                       //                                   boxShadow: [
//                       //                                     BoxShadow(
//                       //                                         blurRadius: 2,
//                       //                                         color: Colors.grey
//                       //                                             .shade300,
//                       //                                         offset:
//                       //                                             Offset(1, 1),
//                       //                                         spreadRadius: 0)
//                       //                                   ],
//                       //                                   borderRadius:
//                       //                                       BorderRadius
//                       //                                           .circular(5),
//                       //                                   color: selectIndex ==
//                       //                                           index
//                       //                                       ? widget.type ==
//                       //                                               ataycom
//                       //                                           ? tabatayColor
//                       //                                           : tabparfum
//                       //                                       : Colors.white,
//                       //                                 ),
//                       //                                 height: 40,
                                                     
//                       //                                 child: Center(
//                       //                                     child: Padding(
//                       //                                       padding: const EdgeInsets.all(8.0),
//                       //                                       child: Text(
//                       //                                   '${StoreCubit.get(context).subcategories[index]['name']}',
//                       //                                   style: TextStyle(
//                       //                                         color:
//                       //                                             selectIndex ==
//                       //                                                     index
//                       //                                                 ? Colors
//                       //                                                     .white
//                       //                                                 : Colors
//                       //                                                     .black,
//                       //                                         fontWeight:
//                       //                                             FontWeight.w600,
//                       //                                         fontSize: 12),
//                       //                                 ),
//                       //                                     )))),
//                       //                       ))
//                       //               ],
//                       //             );
//                       //           }),
//                       //     ):Center(child: Column(
//                       //       crossAxisAlignment: CrossAxisAlignment.center,
//                       //       mainAxisAlignment: MainAxisAlignment.center,
//                       //       children: [
//                       //         SizedBox(height: MediaQuery.of(context).size.height/3,),
//                       //         Center(child: CircularProgressIndicator())
//                       //       ],
//                       //     )),


//                       state is! getCategoriesDetailsLoadingState?ListView.builder(
//                               physics:NeverScrollableScrollPhysics(),
//                               shrinkWrap: true,
//                               controller:scrollController,
//                               itemCount:StoreCubit.get(context).subcategories['categories'].length,
//                               itemBuilder: (_, index) {
//                                 var storeCubit = StoreCubit.get(context);
//                                 return  Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Padding(
//                                       padding: const EdgeInsets.all(8.0),
//                                       child: Text('${StoreCubit.get(context).subcategories['categories'][index]['name']}',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
//                                     ),
//                                     if (StoreCubit.get(context)
//                                             .subcategories['products']
//                                             .length > 0)
                                      
//                                     // Text('${StoreCubit.get(context).subcategories['products']}'),
//                                     Wrap(
//                                       alignment: WrapAlignment.start,
//                                       direction: Axis.horizontal,
//                                       children: [
//                                         ...StoreCubit.get(context)
//                                             .subcategories['products']
//                                             .map((product) {
//                                           return Padding(
//                                             padding: const EdgeInsets.only(
//                                                 left: 15, top: 10),
//                                             child: GestureDetector(
//                                               onTap: () {
//                                                 Navigator.push(
//                                                     context,
//                                                     MaterialPageRoute(
//                                                         builder: (context) =>
//                                                             DetailsPage(
//                                                               articalType: widget.articleType,
//                                                               categorie: widget.category,
//                                                               currentIndex: widget.currentIndex,
//                                                               name: product[
//                                                                   'name'],
//                                                               image: product[
//                                                                   'image'],
//                                                               price: product[
//                                                                   'price'],
//                                                               oldprice: product[
//                                                                   'old_price'],
//                                                               brand: product[
//                                                                   'brand'],
//                                                               labelAttrbute:
//                                                                   product[
//                                                                       'labelAttrbute'],
//                                                               id: product['id'],
//                                                               varition_id:
//                                                                   storeCubit
//                                                                       .varition_id,
//                                                               type: widget.type,
//                                                             )));
//                                               },
//                                               child: Container(
//                                                 height: 235,
//                                                 width: 140,
//                                                 decoration: BoxDecoration(
//                                                   borderRadius:
//                                                       BorderRadius.circular(10),
//                                                   boxShadow: [
//                                                     BoxShadow(
//                                                         blurRadius: 2,
//                                                         color: Colors
//                                                             .grey.shade300,
//                                                         offset: Offset(1, 3),
//                                                         spreadRadius: 0)
//                                                   ],
//                                                   color: Colors.white,
//                                                 ),
//                                                 child: Column(
//                                                   children: [
//                                                     SizedBox(
//                                                       height: 5,
//                                                     ),
//                                                     Image(
//                                                       image: NetworkImage(
//                                                           '${product['image']}'),
//                                                       height: 100,
//                                                     ),
//                                                     SizedBox(
//                                                       height: 10,
//                                                     ),
//                                                     Text(
//                                                       '${product['name']}',
//                                                       style: TextStyle(
//                                                           fontSize: 14,
//                                                           fontWeight:
//                                                               FontWeight.w600,
//                                                           overflow: TextOverflow
//                                                               .ellipsis,
//                                                           height: 1.1),
//                                                       textAlign:
//                                                           TextAlign.center,
//                                                       maxLines: 2,
//                                                     ),
//                                                     Text(
//                                                       '${product['brand']}',
//                                                       style: TextStyle(
//                                                           fontSize: 12,
//                                                           fontWeight:
//                                                               FontWeight.w600,
//                                                           overflow: TextOverflow
//                                                               .ellipsis,
//                                                           height: 1.1,
//                                                           color: Colors.grey),
//                                                       textAlign:
//                                                           TextAlign.center,
//                                                       maxLines: 2,
//                                                     ),
//                                                     SizedBox(
//                                                       height: 3,
//                                                     ),
//                                                     Row(
//                                                       mainAxisAlignment:
//                                                           MainAxisAlignment
//                                                               .center,
//                                                       children: [
//                                                         Text(
//                                                           '${product['price']} MAD',
//                                                           style: TextStyle(
//                                                               fontSize: 12,
//                                                               color: widget
//                                                                           .type ==
//                                                                       ataycom
//                                                                   ? tabatayColor
//                                                                   : tabparfum,
//                                                               fontWeight:
//                                                                   FontWeight
//                                                                       .w600),
//                                                           textAlign:
//                                                               TextAlign.center,
//                                                         ),
//                                                         SizedBox(
//                                                           width: 10,
//                                                         ),
//                                                         if (product['old_price'] !=null)
//                                                           Text(
//                                                             '${product['old_price']} MAD',
//                                                             style: TextStyle(
//                                                                 fontSize: 12,
//                                                                 decoration:
//                                                                     TextDecoration
//                                                                         .lineThrough),
//                                                             textAlign: TextAlign.center,
//                                                           ),
//                                                       ],
//                                                     ),
//                                                     Spacer(),
//                                                     Padding(
//                                                       padding:
//                                                           const EdgeInsets.all(
//                                                               8.0),
//                                                       child: InkWell(
//                                                         onTap: () {},
//                                                         child: Container(
//                                                           height: 38,
//                                                           decoration: BoxDecoration(
//                                                               color: widget
//                                                                           .type ==
//                                                                       ataycom
//                                                                   ? ataycomColor
//                                                                   : parfumColor,
//                                                               borderRadius:
//                                                                   BorderRadius
//                                                                       .circular(
//                                                                           5)),
//                                                           child: Center(
//                                                               child: Text(
//                                                             'View products',
//                                                             style: TextStyle(
//                                                               fontSize: 13,
//                                                               fontWeight:
//                                                                   FontWeight
//                                                                       .w600,
//                                                               color:
//                                                                   Colors.white,
//                                                             ),
//                                                             textAlign: TextAlign
//                                                                 .center,
//                                                           )),
//                                                         ),
//                                                       ),
//                                                     )
//                                                   ],
//                                                 ),
//                                               ),
//                                             ),
//                                           );
//                                         })
//                                       ],
//                                     ),
//                                     SizedBox(
//                                       height: 5,
//                                     )
//                                   ],
//                                 );
//                               }): Center(child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               SizedBox(height: MediaQuery.of(context).size.height/3,),
//                               Center(child: CircularProgressIndicator())
//                             ],
//                           )),
//                       // Text('${StoreCubit.get(context).subcategories}'),
                     
//                         ],
//                       ),
//                     ),
//                   ),
//                 )
//               : DefaultTabController(
//                   length:1,
//                   initialIndex: widget.index,
//                   child: Scaffold(
//                     backgroundColor: Color(0xFFFAFAFA),
//                     appBar: AppBar(
//                       automaticallyImplyLeading: false,
//                       toolbarHeight: 70,
//                       title: GestureDetector(
//                         onTap: () {
//                           Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => Search(
//                                         type: widget.type,
//                                       )));
//                         },
//                         child: Container(
//                             height: 47,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(7),
//                               color: Colors.white,
//                             ),
//                             width: 420,
//                             child: Row(
//                               children: [
//                                 SizedBox(
//                                   width: 15,
//                                 ),
//                                 Text(
//                                   'search',
//                                   style: TextStyle(
//                                       fontSize: 15,
//                                       fontWeight: FontWeight.w600,
//                                       color: Colors.grey),
//                                 )
//                               ],
//                             )),
//                       ),
//                       centerTitle: true,
//                       elevation: 1,
//                       backgroundColor:
//                           widget.type == ataycom ? ataycomColor : parfumColor,
//                     ),
//                     body: Center(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [CircularProgressIndicator()],
//                       ),
//                     ),
//                   ),
//                 );
//         },
//       ),
//     );
//   }

//   // Widget buildMenu(menu) {
//   //   return Container(
//   //     child: Padding(
//   //       padding: const EdgeInsets.only(left: 15, top: 5, right: 15),
//   //       child: Text(
//   //         '${menu['name']}',
//   //         style: TextStyle(
//   //             fontWeight: FontWeight.w600,
//   //             color: widget.type==ataycom?ataycomColor:parfumColor,
//   //             fontSize: 15.8),
//   //       ),
//   //     ),
//   //   );
//   // }
// }
// // StoreCubit.get(context).subcategories.where((element) {
// //                         return names.contains(element['name']);
// //                        }).toList()
// Widget Filter({context,Function onTap,data,category}){
//   return SafeArea(
//                                    child:Scaffold(
//                                      bottomNavigationBar:Container(
                            
//                          width: double.infinity,
//                                     decoration: BoxDecoration(
//                                       color: Colors.white,
//                                       borderRadius: BorderRadius.circular(0),
//                                       boxShadow: [
//                       BoxShadow(
//                         blurRadius: 3,
//                         color: Colors.grey[350],
//                         offset: Offset(3, 4),
//                         spreadRadius: 7)
//                                       ],
//                                     ),
//                           child: Padding(
//                             padding: const EdgeInsets.only(left: 25, right: 25, top: 15, bottom: 15),
//                             child: GestureDetector(
//                              onTap:onTap,
//                               child: Container(
//                                 height: 55,
//                                 decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(5),
//                                     color: parfumColor),
//                                 width: double.infinity,
//                                 child: Center(
//                                     child: Text(
//                                   "Filter",
//                                   style: TextStyle(
//                                     fontSize: 20,
//                                     color: Colors.white,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                   textAlign: TextAlign.center,
//                                 )),
//                               ),
//                             ),),
//                         ),
                        
//                                    appBar: AppBar(
//                                      elevation: 0,
//                                      centerTitle: true,
//                                      leading: GestureDetector(
//                                        onTap: (){
//                                          Navigator.of(context).pop();
//                                        },
//                                        child: Icon(Icons.arrow_back,color: Colors.white)),
//                                      backgroundColor: parfumColor,
//                                      title: Text('Filter',style: TextStyle(color: Colors.white),)),
//                                      body: ListView(
//                                         physics: BouncingScrollPhysics(),
//                                         shrinkWrap: true,
//                                         children: [
//                                         Padding(
//                                           padding: const EdgeInsets.all(8.0),
//                                           child: Text('SubCategories :',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600)),
//                                         ),
                                        
//                                       //  Wrap(
//                                       //    spacing: 20.0,
//                                       //    runSpacing: 10.0,
//                                       //    children: [
//                                       //     ...data['categories'].map((e){
//                                       //     return Container(
//                                       //       color: Colors.cyan,
//                                       //       child: Padding(
//                                       //         padding: const EdgeInsets.all(8.0),
//                                       //         child: Text('${e['name']}'),
//                                       //       ));
//                                       //   })
//                                       //  ],)
                                       
//                                        ],
//                                      ),
//                                  ),
                                 
//                                  );
// }