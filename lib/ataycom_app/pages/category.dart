import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahariano_travel/ataycom_app/layout/cubit/cubit.dart';
import 'package:sahariano_travel/ataycom_app/layout/cubit/states.dart';
import 'package:sahariano_travel/ataycom_app/pages/categories_page.dart';
import 'package:sahariano_travel/shared/components/constants.dart';

class CategoryPage extends StatefulWidget {
  final String type;
  final int currentIndex;
  final String articleType;
  const CategoryPage({Key key, this.type, this.currentIndex, this.articleType}) : super(key: key);

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => StoreCubit()..getBrands(type: widget.type)..getCategories(type: widget.type,articletype: widget.articleType),
      child: BlocConsumer<StoreCubit, StoreStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Color(0xFFf8f8f8),
            appBar: AppBar(
               leading: GestureDetector(
                onTap: (){
                Navigator.pop(context);
                },
                child: Icon(Icons.arrow_back,color: Colors.white,)),
              title: Text(
                widget.type == ataycom ? 'Ataycom' : 'Parfum',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              centerTitle: true,              
              elevation: 0,
              backgroundColor: widget.type==ataycom ?ataycomColor:parfumColor
            ),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Padding(
                  //   padding:
                  //       const EdgeInsets.only(left: 15, top: 15, right: 15),
                  //   child: Text(
                  //     'Brands',
                  //     style:
                  //         TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 10,
                  // ),
                  // GridView.builder(
                  //     shrinkWrap: true,
                  //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  //       crossAxisCount: 4,
                  //     ),
                  //     scrollDirection: Axis.vertical,
                  //     itemCount: widget.type==ataycom?countryService.brandsAtay.length:countryService.brandsParfum.length,
                  //     physics: BouncingScrollPhysics(),
                  //     itemBuilder: (context, index) {
                          
                  //       return Padding(
                  //  padding: const EdgeInsets.only(left: 5,right: 5),
                  //  child: InkWell(
                  //    onTap: (){
                  //       Navigator.push(context, MaterialPageRoute(
                  //         builder: (context)=>Brands(
                  //         index:index,
                  //         type: widget.type,
                  //         id:widget.type==ataycom?countryService.brandsAtay[index]['id']:countryService.brandsParfum[index]['id'],
                  //         )));
                  //    },
                  //    child: Container(
                       
                  //      width: 60,
                  //      child: Column(
                  //        children: [
                  //          Container(
                  //          decoration: BoxDecoration(
                  //          shape: BoxShape.circle,
                  //          boxShadow: [
                  //            BoxShadow(
                  //              blurRadius: 2,
                  //               color: Colors.grey.shade300,
                  //               offset: Offset(1, 1),
                  //               spreadRadius: 0)
                  //               ],
                  //          ),
                  //          child:Container(
                  //            decoration: BoxDecoration(
                  //              boxShadow: [
                  //                   BoxShadow(
                  //                     blurRadius:2.0,
                  //                        color: Color.fromARGB(255, 238, 133, 196),
                  //                      offset: Offset(2.0, 3),
                  //                       spreadRadius: 1)
                  //                       ],
                  //              borderRadius: BorderRadius.circular(10),color: Colors.white,),
                  //            height: 60,
                  //            width: 90,
                  //            child: ClipRRect(
                  //              borderRadius: BorderRadius.circular(10),
                  //              child: Image.network('${widget.type==ataycom?countryService.brandsAtay[index]['logo']:countryService.brandsParfum[index]['logo']}',)),
                  //          )
                  //            ),
                  //            SizedBox(height: 10,),
                  //            Text('${widget.type==ataycom?countryService.brandsAtay[index]['name']:countryService.brandsParfum[index]['name']}',
                  //            textAlign: TextAlign.center,maxLines: 2,style: TextStyle(
                  //           overflow: TextOverflow.ellipsis,
                  //            fontSize: 15,
                  //            fontWeight: FontWeight.w600,
                  //            color: Colors.black
                  //             ),)
                  //        ],
                  //      ),
                  //    ),
                  //  ),
                  //  );
                  //     }),
                      // SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.only(left: 15,right: 15,top: 15),
                    child: Text(
                      'All Categories',
                      style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  GridView.builder(
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 0
                      ),
                      scrollDirection: Axis.vertical,
                      itemCount:widget.type==ataycom?countryService.categoriesatay.length:countryService.categoriesparfum.length,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        var storeCubit = StoreCubit.get(context);
                        return Padding(
                          padding: const EdgeInsets.only(right: 5,left: 5),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Categories(
                                        articleType: widget.articleType,
                                            currentIndex: widget.currentIndex,
                                            index: index,
                                            type: widget.type,
                                            category: storeCubit.categories[index]
                                              ['name'],
                                          )));
                            },
                            child: Container(
                       width: 65,
                       child: Column(
                           children: [
                           Container(
                             decoration: BoxDecoration(
                               boxShadow: [
                                    BoxShadow(
                                      blurRadius:2.0,
                                       color: Color.fromARGB(255, 238, 133, 196),
                                       offset: Offset(2.0, 3),
                                        spreadRadius: 1)
                                        ],
                               borderRadius: BorderRadius.circular(10),color: Colors.white),
                             height: 60,
                             width: 90,
                             child: ClipRRect(
                               borderRadius: BorderRadius.circular(10),
                               child: Image.network('${widget.type==ataycom?countryService.categoriesatay[index]['image']:countryService.categoriesparfum[index]['image']}',fit: BoxFit.cover,)),
                           ),
                             SizedBox(height: 10,),
                             Text('${widget.type==ataycom?countryService.categoriesatay[index]['name']:countryService.categoriesparfum[index]['name']}',
                             textAlign: TextAlign.center,maxLines: 2,style: TextStyle(
                            overflow: TextOverflow.ellipsis,
                             fontSize: 15,
                             fontWeight: FontWeight.w600,
                             color: Colors.black
                              ),),
                           ],
                       ),
                     ),
                          ),
                        );
                      }),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
