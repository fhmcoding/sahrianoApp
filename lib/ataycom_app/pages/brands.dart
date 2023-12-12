import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahariano_travel/ataycom_app/layout/cubit/cubit.dart';
import 'package:sahariano_travel/ataycom_app/layout/cubit/states.dart';
import 'package:sahariano_travel/ataycom_app/pages/details_pages.dart';
import 'package:sahariano_travel/shared/components/constants.dart';
import 'package:sahariano_travel/shared/network/remote/local/cache_helper.dart';

class Brands extends StatefulWidget {
  final int index;
  final String type;
  int id;
  Brands({Key key, this.index, this.type, this.id}) : super(key: key);

  @override
  _BrandsState createState() => _BrandsState();
}

class _BrandsState extends State<Brands> with TickerProviderStateMixin {
  TabController _controller;
  int selectIndex = 0;
  double offsetFrom = 0;
  ScrollController scrollController = ScrollController();
  String language = Cachehelper.getData(key: "langugeCode");
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => StoreCubit()
        ..getBrands(type: widget.type)
        ..getbrandsDetails(url: '${widget.type}/api/v1/brands/${widget.id}'),
      child: BlocConsumer<StoreCubit, StoreStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return StoreCubit.get(context).brands.length != 0
              ? DefaultTabController(
                  length: StoreCubit.get(context).brands.length,
                  initialIndex: widget.index,
                  child: Scaffold(
                    backgroundColor: Colors.grey[200],
                    appBar: AppBar(
                      automaticallyImplyLeading: false,
                      toolbarHeight: 70,
                      title: GestureDetector(
                        onTap: (){
                          //  Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => Search(
                          //               currentIndex: widget.index,
                          //               type: widget.type,
                          //             )));
                        },
                        child: Container(
                            height: 47,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.white,
                            ),
                            width: double.infinity,
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  'search',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.grey),
                                )
                              ],
                            )),
                      ),
                      centerTitle: true,
                      elevation: 1,
                      backgroundColor:
                          widget.type == ataycom ? ataycomColor : parfumColor,
                    ),
                    body: SingleChildScrollView(
                      controller: scrollController,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            color: widget.type == ataycom
                                ? tabatayColor
                                : tabparfum,
                            height: 60,
                            width: double.infinity,
                            child: TabBar(
                                indicatorWeight: 4,
                                physics: BouncingScrollPhysics(),
                                controller: _controller,
                                padding:
                                    EdgeInsets.only(top: 0, left: 0, right: 40),
                                indicatorColor: Colors.white,
                                isScrollable: true,
                                unselectedLabelColor: Colors.white,
                                labelColor: Colors.white,
                                onTap: (index) {
                                  var storeCubit = StoreCubit.get(context);
                                   setState((){
                                    widget.id = storeCubit.brands[index]['id'];
                                    storeCubit.getbrandsDetails(url:'${widget.type}/api/v1/brands/${widget.id}');
                                  });

                               
                                },
                                tabs: StoreCubit.get(context).brands.map((e) {
                                  return Tab(
                                    child: Text(
                                      '${e['name']}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        
                                          ),
                                    ),
                                  );
                                }).toList()),
                          ),
                          GridView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount:
                                  StoreCubit.get(context).brandProduct.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                childAspectRatio: 3 / 5.6,
                              ),
                              itemBuilder: (context, index) {
                                var storeCubit = StoreCubit.get(context);
                                return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: (){
           Navigator.push(context, MaterialPageRoute(
                                 builder: (context)=>DetailsPage(
                                 name:storeCubit.brandProduct[index]['name'],
                                 image:storeCubit.brandProduct[index]['image'],
                                 price:storeCubit.brandProduct[index]['price'],
                                 oldprice:storeCubit.brandProduct[index]['old_price'],
                                 brand:storeCubit.brandProduct[index]['brand'],
                                 labelAttrbute:storeCubit.brandProduct[index]['labelAttrbute'],
                                 id: storeCubit.brandProduct[index]['id'],
                                 varition_id:storeCubit.varition_id,
                                 type: widget.type,
                               )));
        },
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                      blurRadius: 2,
                      color: Colors.grey.shade300,
                      offset: Offset(1, 3),
                      spreadRadius: 0)
                ],
                color: Colors.white,
              ),
              child: Column(
                children: [
                  SizedBox(height: 5,),
                  storeCubit.brandProduct[index]['image'] != null
                      ? Image(
                          image: NetworkImage('${storeCubit.brandProduct[index]['image']}'),
                          height: 100,
                        )
                      : Image.asset('assets/logo.png',
                          height: 100, color: ataycomColor),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    '${storeCubit.brandProduct[index]['name']}',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        overflow: TextOverflow.ellipsis,
                        height: 1.1),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                  ),
                  Text(
                    '${storeCubit.brandProduct[index]['brand']}',
                    style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        overflow: TextOverflow.ellipsis,
                        height: 1.1,
                        color: Colors.grey),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${storeCubit.brandProduct[index]['price']} MAD',
                        style: TextStyle(
                            fontSize: 11,
                            color: widget.type == ataycom ? tabatayColor : tabparfum,
                            fontWeight: FontWeight.w600),
                        textAlign: TextAlign.center,
                      ),
                       SizedBox(
                        width: 10,
                      ),
                      if (storeCubit.brandProduct[index]['old_price'] !=null)
                        Text(
                          '${storeCubit.brandProduct[index]['old_price']} MAD',
                          style: TextStyle(
                              fontSize: 12,
                              decoration:
                                  TextDecoration
                                      .lineThrough),
                          textAlign: TextAlign.center,
                        ),
                    ],
                  ),
                  
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {},
                      child: Container(
                        height: 38,
                        decoration: BoxDecoration(
                            color:
                                widget.type == ataycom ? ataycomColor : parfumColor,
                            borderRadius: BorderRadius.circular(5)),
                        child: Center(
                            child: Text(
                          'View products',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        )),
                      ),
                    ),
                  )
                ],
              ),
            ),
             if(widget.type==ataycom?storeCubit.brandProduct[index]['old_price']!= null:storeCubit.brandProduct[index]['old_price'] != null)
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
                                     child: Center(child: Text('- ${widget.type==ataycom?storeCubit.brandProduct[index]['offer']:storeCubit.brandProduct[index]['offer']} %',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 12),textAlign: TextAlign.center,)),
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
                )
              : DefaultTabController(
                  length: StoreCubit.get(context).brands.length,
                  initialIndex: widget.index,
                  child: Scaffold(
                    backgroundColor: Color(0xFFFAFAFA),
                    appBar: AppBar(
                      automaticallyImplyLeading: false,
                      toolbarHeight: 70,
                      title: Container(
                          height: 47,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white,
                          ),
                          width: 420,
                          child: Row(
                            children: [
                              SizedBox(
                                width: 15,
                              ),
                              Text(
                                'search',
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey),
                              )
                            ],
                          )),
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
                  ),
                );
        },
      ),
    );
  }




}
