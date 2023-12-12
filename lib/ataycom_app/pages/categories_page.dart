import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sahariano_travel/ataycom_app/layout/cubit/cubit.dart';
import 'package:sahariano_travel/ataycom_app/layout/cubit/states.dart';
import 'package:sahariano_travel/ataycom_app/pages/details_pages.dart';
import 'package:sahariano_travel/localization/demo_localization.dart';
import 'package:sahariano_travel/shared/components/constants.dart';
import 'package:sahariano_travel/shared/network/remote/local/cache_helper.dart';
enum _MenuValues {
  filter,
  sortby,
  
}
class Categories extends StatefulWidget {
  final int index;
  final String type;
  final int currentIndex;
  final String articleType;
  String category; 
  Categories({Key key, this.index, this.type, this.currentIndex, this.articleType, this.category}) : super(key: key);

  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> with TickerProviderStateMixin {
  HashSet selectBrands = new HashSet();
  HashSet selectSubcategories = new HashSet();
    List<dynamic> subcategories;
    List<dynamic> products;
    TabController _controller;
    int selectIndex = 0;
    bool isfilterd = false;
    ScrollController scrollController = ScrollController();
  List filterSubCategories = [];
  List subcat = [];
  List brands = [];
  List filterProducts = [];
  String language = Cachehelper.getData(key: "langugeCode");
  String rangePrice;
  String rangeAlphapic;
  dynamic max= 0;
  dynamic min= 0;
   var minController = TextEditingController();   
   var maxController = TextEditingController();

   var fromkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => StoreCubit()
        ..getCategories(type: widget.type,articletype:widget.articleType)
        ..getProducts(type: widget.type,articletype:widget.articleType)
        ..getCategoriesDetails(url:'${widget.type}/api/v1/categories/${widget.category}'),
      child: BlocConsumer<StoreCubit, StoreStates>(
        listener: (context, state) {
        if(state is getCategoriesDetailsSuccesState){
          subcategories = filterSubCategories = state.subcategories;
          products = filterProducts = state.products;
        }
        },
        builder: (context, state) {
         var storeCubit = StoreCubit.get(context);   
          return subcategories!=null? DefaultTabController(
                  length: StoreCubit.get(context).categories.length,
                  initialIndex: widget.index,
                  child: Scaffold(
                    backgroundColor: Color.fromARGB(255, 245, 245, 245),
                    appBar: AppBar(
                      bottom:TabBar(
                                indicatorWeight: 4,
                                physics: BouncingScrollPhysics(),
                                controller: _controller,
                                padding:EdgeInsets.only(top: 0, left: 0, right: 40),
                                indicatorColor: Colors.white,
                                isScrollable: true,
                                unselectedLabelColor: Colors.white,
                                labelColor: Colors.white,
                                onTap: (index){
                                var storeCubit = StoreCubit.get(context);
                                setState((){
                                    widget.category = storeCubit.categories[index]['name'];
                                    storeCubit.getCategoriesDetails(
                                    url:'${widget.type}/api/v1/categories/${widget.category}');
                                  });
                                },
                                
                                tabs:StoreCubit.get(context).categories.map((e) {
                                  return Tab(
                                    child: Text(
                                      '${e['name']}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                  );
                                }).toList()),
                      automaticallyImplyLeading: false,
                      toolbarHeight: 70,
                      title: Text('Categories',style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 18),),
                      centerTitle: true,
                      elevation: 1,
                      backgroundColor:
                          widget.type == ataycom ? ataycomColor : parfumColor,
                          leading: GestureDetector(
                            onTap: (){
                              Navigator.of(context).pop();
                            },
                            child: Icon(Icons.arrow_back,color: Colors.white)),
                            actions: [
                              GestureDetector(
                            onTap: (){
                              //  Navigator.push(
                              // context,
                              // MaterialPageRoute(
                              //     builder: (context) => Search(
                              //           currentIndex: widget.index,
                              //           type: widget.type,
                              //         )));
                            },
                            child: Icon(Icons.search,color: Colors.white)),
                        
                              !isfilterd?  PopupMenuButton<_MenuValues>(
                                  icon: Icon(Icons.filter_alt_rounded,color: Colors.white,),
          itemBuilder: (BuildContext context) => [
            PopupMenuItem(
              child: Row(
                children: [
                   Icon(Icons.filter_alt_rounded,color: Colors.black,),
                   SizedBox(width: 5,),
                   Text('Filter by'),
                 
                ],
              ),
              value: _MenuValues.filter,
            ),
            PopupMenuItem(
              child: Row(
                children: [
                  Icon(FontAwesomeIcons.sort,color: Colors.black,),
                  SizedBox(width: 5,),
                  Text('Order by'),
                ],
              ),
              value: _MenuValues.sortby,
            ),
          ],
          onSelected: (value) {
            switch (value) {
              case _MenuValues.filter:
               showModalBottomSheet(
                                 isScrollControlled:true,
                                 enableDrag: false,
                                 context: context,
                                 builder:(context){
                                   subcategories=filterSubCategories;
                                  
                                    isfilterd = false;
                                    List<String> brandsvalue = [];
                           products.forEach((product) { 
                         if (!brandsvalue.contains(product['brand'])) {
                          brandsvalue.add(product['brand']);
                          }
                        });
                                  return
                                    SafeArea(
                                    child: Scaffold(
                                    backgroundColor: Colors.white,
                                    bottomNavigationBar:Container(
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
                            padding: const EdgeInsets.only(left: 25, right: 25, top: 15, bottom: 15),
                            child: GestureDetector(
                             onTap:(){
                              setState(() {
                                print(minController.text.isEmpty);
                                 filterProducts = products.where((element) {
                                 return subcat.length>0?subcat.contains(element['sub_category']):true;})
                                 .where((element) => brands.length>0? brands.contains(element['brand']):true)
                                 .where((element) {
                                   if (minController.text.isNotEmpty) {
                                    // filterProducts.sort((a, b) => a["price"].compareTo(b["price"]));
                                     filterSubCategories.sort((a, b) =>getMinPriceInCategory(a["value"]).compareTo(getMinPriceInCategory(b["value"])));
                                    return element['price'].compareTo(int.parse(minController.text))>=0&&element['price'].compareTo(int.parse(maxController.text))<=0;
                                   }
                                  return element['price'].compareTo(getMinandMax(products)['min'])>=0&&element['price'].compareTo(getMinandMax(products)['max'])<=0;
                                 }).toList();
                                 isfilterd = true;
                                 Navigator.pop(context);
                                //  .where((element) => element['price'].compareTo(getMinandMax(products)['min'])>=0&&element['price'].compareTo(getMinandMax(products)['max'])<=0)
                              });
                             },
                              child: Container(
                                height: 55,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: parfumColor),
                                width: double.infinity,
                                child: Center(
                                    child: Text(
                                  "Filter",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                )),
                              ),
                            ),),
                        ),
                                    appBar: AppBar(
                                      backgroundColor: parfumColor,
                                       automaticallyImplyLeading: false,
                                            toolbarHeight: 70,
                                            title: Padding(
                                              padding: const EdgeInsets.only(top: 20),
                                              child: Text('Short & Filter',style: TextStyle(
                                                                  fontWeight: FontWeight.bold,
                                                                  color: Colors.white,
                                                                  fontSize: 19),),
                                            ),
                                            centerTitle: true,
                                            elevation: 1,
                                                            leading: Padding(
                                        padding: const EdgeInsets.only(top: 20),
                                        child: GestureDetector(
                                          onTap: (){
                                            
                                            Navigator.of(context).pop();
                                          },
                                          child: Icon(Icons.arrow_back,color: Colors.white,)),
                                      ),
                                    ),
                                    body: Padding(
                                      padding: const EdgeInsets.only(left:15,top: 10,right: 10),
                                      child: Filter(brandsvalue),
                                    ),
                                  ));
                                }
                               );
                break;
              case _MenuValues.sortby:
               showModalBottomSheet(
                                 isScrollControlled:true,
                                 enableDrag: false,
                                 context: context,
                                 builder:(context){
                                    subcategories=filterSubCategories;
                                    isfilterd = false;
                                    rangePrice =null;
                                    rangeAlphapic =null;
                                    
                                  return SafeArea(
                                    child: Scaffold(
                                    backgroundColor: Colors.white,
                                    bottomNavigationBar:Container(
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
                            padding: const EdgeInsets.only(left: 25, right: 25, top: 15, bottom: 15),
                            child: GestureDetector(
                             onTap:(){
                              setState(() {
                                 if (rangePrice=='hightTolow') {
                                   products.sort((a, b) =>b["price"].compareTo(a["price"]));
                                   filterSubCategories.sort((a, b) =>getMaxPriceInCategory(b["value"]).compareTo(getMaxPriceInCategory(a["value"])));
                                 }
                                 if (rangePrice=='lowTohight') {
                                   filterProducts.sort((a, b) => a["price"].compareTo(b["price"]));
                                   filterSubCategories.sort((a, b) =>getMinPriceInCategory(a["value"]).compareTo(getMinPriceInCategory(b["value"])));
                                 }
                                //  filterProducts.sort((a, b) => a["price"].compareTo(b["price"]));
                                //  filterSubCategories.sort((a, b) =>getMinPriceInCategory(a["value"]).compareTo(getMinPriceInCategory(b["value"])));
                                // from hight price to low price
                               
                                //  from Z to a
                                

                                //  subcategories.sort((a, b) => -a["name"].compareTo(b["name"]));
                                //  from a to z
                                 if(rangeAlphapic=='A-Z'){
                                 subcategories.sort((a, b) => a["name"].compareTo(b["name"]));
                                }
                                if(rangeAlphapic=='Z-A'){
                                  subcategories.sort((a, b) => -a["name"].compareTo(b["name"]));
                                }
                                //  subcategories.sort((a, b) => a["name"].compareTo(b["name"]));
                                //  from low price to hight price
                                
                                
                                
                                 isfilterd = true;
                                 Navigator.pop(context);
                              });
                             },
                              child: Container(
                                height: 55,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: parfumColor),
                                width: double.infinity,
                                child: Center(
                                    child: Text(
                                  "Order by",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                )),
                              ),
                            ),),
                        ),
                                    appBar: AppBar(
                                      backgroundColor: parfumColor,
                                       automaticallyImplyLeading: false,
                                            toolbarHeight: 70,
                                            title: Padding(
                                              padding: const EdgeInsets.only(top: 20),
                                              child: Text('Order by',style: TextStyle(
                                                                  fontWeight: FontWeight.bold,
                                                                  color: Colors.white,
                                                                  fontSize: 19),),
                                            ),
                                            centerTitle: true,
                                            elevation: 1,
                                                            leading: Padding(
                                        padding: const EdgeInsets.only(top: 20),
                                        child: GestureDetector(
                                          onTap: (){
                                            
                                            Navigator.of(context).pop();
                                          },
                                          child: Icon(Icons.arrow_back,color: Colors.white,)),
                                      ),
                                    ),
                                    body: Padding(
                                      padding: const EdgeInsets.only(left:15,top: 10,right: 10),
                                      child: Orderby(),
                                    ),
                                  ));
                                }
                               );
                break;
            }
          },
        ):GestureDetector(
                                onTap: (){
                                 setState(() {
                                    subcategories.sort((a, b) => a["name"].compareTo(b["name"]));
                                    subcat.clear();
                                    brands.clear();
                                     minController.clear();
                                     maxController.clear();
                                    filterProducts = products;
                                    filterSubCategories = subcategories;
                                    selectBrands.clear();
                                    selectSubcategories.clear();
                                    isfilterd =false;
                                 });
                                },
                                child: Image.asset('assets/filter-parfum.png',color:Colors.white)),
                            ],
                    ),
                    body:state is! getCategoriesDetailsLoadingState? SingleChildScrollView(
                      
                      child:filterProducts.length>0? Column(
                        children: [
                         ...filterSubCategories.map((e){
                          return Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Column(
                              children: [
                                if (filterProducts.where((element) => element['sub_category']==e['value']).length > 0)
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                         crossAxisAlignment: CrossAxisAlignment.start,
                                         mainAxisAlignment: MainAxisAlignment.start,
                                       children: [
                                         SizedBox(height: 5,),
                                         Text('${e['name']}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                                         if (filterProducts.where((element) => element['sub_category']==e['value']).length > 0)
                                         SizedBox(height: 5,),
                                         Container(
                                            height: 300,
                                           width: double.infinity,
                                           child:ListView.builder(
                                             scrollDirection: Axis.horizontal,
                                             shrinkWrap: true,
                                             itemCount: filterProducts.where((element) => element['sub_category']==e['value']).length,
                                             itemBuilder: (contex,index){
                                               
                                               
                                               var list2 = filterProducts.where((element) => element['sub_category']==e['value']).toList();
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
                                           })
                                         )
                                       ],
                                  ),
                                ),
                              ],
                            ),
                          );
                         })
                        ],
                      ):Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height/3,),
                     Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: Text('There is no data available with this filter try again',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                     )
                      ],
                  ),
                ),
                    ):Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      
                      CircularProgressIndicator()
                      ],
                  ),
                ),
                  ),
                )
              : Scaffold(
                backgroundColor: Color(0xFFFAFAFA),
                appBar: AppBar(
                  automaticallyImplyLeading: false,
                  toolbarHeight: 70,
                  title:Text('Categories',style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 18),),
                  leading: GestureDetector(
                            onTap: (){
                              Navigator.of(context).pop();
                            },
                            child: Icon(Icons.arrow_back,color: Colors.white)),
                            actions: [
                              Padding(
                                padding: const EdgeInsets.only(right: 10,left: 10),
                                child: GestureDetector(
                            onTap: (){
                                //  Navigator.push(
                                // context,
                                // MaterialPageRoute(
                                //     builder: (context) => Search(
                                //           currentIndex: widget.index,
                                //           type: widget.type,
                                //         )));
                            },
                            child: Icon(Icons.search,color: Colors.white)),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 10,left: 10),
                                child: GestureDetector(
                            onTap: (){
                               
                            },
                            child: Icon(Icons.filter_alt_rounded,color: Colors.white,)),
                              ),
                            ],
                  centerTitle: true,
                  elevation: 1,
                  backgroundColor:
                      widget.type == ataycom ? ataycomColor : parfumColor,
                ),
                body: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [CircularProgressIndicator()],
                  ),
                ),
              );
        },
      ),
    );
  }

  ListView Orderby() {
    return ListView(
    children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text('Range Price',style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold)),
      ),
      StatefulBuilder(builder: (context,state){
     return Column(
       children: [
         RadioListTile(
           value:"hightTolow",
          title: Text('Price hight To low'),
           groupValue: rangePrice,
            toggleable: true,
            onChanged: (value) {
              state(() {
                rangePrice = value;
                print(rangePrice);
              });
            },
    ),
     RadioListTile(
           value:"lowTohight",
          title: Text('Price low To hight'),
           groupValue: rangePrice,
            toggleable: true,
            onChanged: (value) {
              state(() {
                rangePrice = value;
                print(rangePrice);
              });
            },
    ),
     
       ],
     );
    }),
       Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text('Order by alphabet',style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold)),
      ),
      StatefulBuilder(builder: (context,state){
     return Column(
       children: [
         RadioListTile(
             value: "A-Z",
          title: Text('Order by A-Z'),
           groupValue: rangeAlphapic,
            toggleable: true,
            onChanged: (value) {
             state(() {
                rangeAlphapic = value;
                print(rangeAlphapic);
              });
            },
    ),
        
     RadioListTile(
          value: "Z-A",
          title: Text('Order by Z-A'),
           groupValue: rangeAlphapic,
            toggleable: true,
            onChanged: (value) {
             state(() {
                rangeAlphapic = value;
                print(rangeAlphapic);
              });
            },
    ),
       ],
     );
    }),

    SizedBox(height: 25,)
    ],
  );
  }

  ListView Filter(List<String> brandsvalue) {
    return ListView(
    children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text('Subcategories',style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold)),
      ),
      StatefulBuilder(builder: (context,state){
     return
       Padding(
        padding: const EdgeInsets.all(8.0),
        child: Wrap(
          spacing: 10.0,
runSpacing: 10.0,
direction: Axis.horizontal,
children: [
  ...filterSubCategories.map((e){
    return GestureDetector(
      onTap: (){
       state(() {
      if (selectSubcategories.contains(e['value'])) {
        selectSubcategories.remove(e['value']);
      } else {
        selectSubcategories.add(e['value']);
      }
    });
      state(() {
   if(subcat.contains(e['value'])){
  subcat.remove(e['value']);
 }else{
   subcat.add(e['value']);
 }
});
      },
      child: Container(
           decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color:selectSubcategories.contains(e['value'])?parfumColor:Color.fromARGB(255, 196, 194, 194),width: 1.3),
            
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text('${e['name']}',style: TextStyle(color: selectSubcategories.contains(e['value']) ?parfumColor:Colors.black),),
          )),
    );
  }),
],
),
      );
    }),
       Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text('Brands',style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold)),
      ),
    StatefulBuilder(builder: (context,state){
     return  Padding(
        padding: const EdgeInsets.all(8.0),
        child: Wrap(
          spacing: 10.0,
runSpacing: 10.0,
direction: Axis.horizontal,
children: [
  ...brandsvalue.map((e){
    return GestureDetector(
      onTap: (){
      state(() {
      if (selectBrands.contains(e)) {
        selectBrands.remove(e);
      } else {
        selectBrands.add(e);
      }
    });
      state(() {
   if(brands.contains(e)){
  brands.remove(e);
 }else{
   brands.add(e);
 }
});
      },
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
             border: Border.all(color:selectBrands.contains(e)?parfumColor:Color.fromARGB(255, 196, 194, 194),width: 1.3),
          ),
          
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text('${e}',style: TextStyle(color: selectBrands.contains(e)?parfumColor:Colors.black),),
          )),
    );
  }),
],
),
      );
    }),
   Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text('Price',style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold)),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Form(
          key: fromkey,
          child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Container(
                                                height:50,
                                                child:TextFormField(
            keyboardType: TextInputType.phone,
            controller: minController,
            decoration: InputDecoration(
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(
                width: 1,
                color: Colors.red,
              )),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(
                width:  1.3,
                color: Color.fromARGB(255, 196, 194, 194),
              )),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(
                width:  1.3,
                color: Color.fromARGB(255, 196, 194, 194),
              )),
          hintText: 'Min ${getMinandMax(products)['min']} MAD',
          hintStyle: TextStyle(color: Color(0xFF7B919D), fontSize: 14,fontWeight: FontWeight.bold)),
          )
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                              child: Container(
                                                height:50,
                                                child:TextFormField(
            keyboardType: TextInputType.phone,
            controller: maxController,
            decoration: InputDecoration(
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(
                width: 1,
                color: Colors.red,
              )),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(
                width:  1.3,
                color: Color.fromARGB(255, 196, 194, 194),
              )),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(
                width:  1.3,
                color: Color.fromARGB(255, 196, 194, 194),
              )),
          hintText: 'Max ${getMinandMax(products)['max']} MAD',
          hintStyle: TextStyle(color: Color(0xFF7B919D), fontSize: 14,fontWeight: FontWeight.bold)),
          )
                                              ),
                                            ),
                                          ],
                                        ),
        ),
      ),
    // Text('${min}'),
    // Text('${max}')
    SizedBox(height: 25,)
    ],
  );
  }


 getMinPriceInCategory(category_value) {
   return getMinandMax(filterProducts.where((element) => element['sub_category']==category_value).toList())['min'];
}
getMaxPriceInCategory(category_value) {
 return getMinandMax(filterProducts.where((element) => element['sub_category']==category_value).toList())['max'];
}

 getMinandMax(products){
   var min=0;
   var max =0;
           if(subcategories!=null){
           for (var i = 0; i <products.length ; i++) {
                if (i==0 || products[i]['price'] > max) {
                  
                   max = products[i]['price'];
                 
                }
                if( i==0 || products[i]['price'] < min){
                  min = products[i]['price'];
                }
         } 
              }
           return {
           "min":min,
           "max":max
           };
        }

}






