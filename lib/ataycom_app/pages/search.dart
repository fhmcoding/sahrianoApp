import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahariano_travel/ataycom_app/layout/cubit/cubit.dart';
import 'package:sahariano_travel/ataycom_app/layout/cubit/states.dart';
import 'package:sahariano_travel/ataycom_app/pages/details_pages.dart';
import 'package:sahariano_travel/shared/components/constants.dart';

class Search extends StatefulWidget {
   final int currentIndex;
  final String type;
   Search({ Key key ,this.type, this.currentIndex}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>StoreCubit()..getProducts(type: widget.type),
      child: BlocConsumer<StoreCubit,StoreStates>(
        listener: (context,state){},
        builder: (context,state){
       
          return Scaffold(
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
                              child: TextFormField(
                                validator: (String value) {
                                  if (value.isEmpty) {
                                    return "search must be empty";
                                  }
                                  return null;
                                },
                                 onChanged: (value) {
                                 StoreCubit.get(context).getSearchData(value,widget.type);
                                 },
                                textInputAction: TextInputAction.search,
                                decoration: InputDecoration(
                                    isDense: true,
                                   
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
                                        )
                                        ),
                                    hintText: 'search',
                                    hintStyle: TextStyle(
                                      color: Color(0xFF7B919D),
                                    )),
                              ),
                            ),
                            centerTitle: true,
                           
                            elevation: 1,
                            backgroundColor:
                                widget.type == ataycom ? ataycomColor : parfumColor,
                          ),
          body: SingleChildScrollView(
            child: Column(
              
              children: [
                // if (state is GetSearchLoadingState)
                //         LinearProgressIndicator(),
               
                        SizedBox(height: 10),
              StoreCubit.get(context).search.length == 0 ? GridView.builder(
                physics:NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: StoreCubit.get(context).products.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              childAspectRatio: 3 / 5.7, 
                            ),
                 
                   itemBuilder: (context,index){
                     var storeCubit = StoreCubit.get(context);
                     return Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: InkWell(
                       onTap: (){
                          Navigator.push(context, MaterialPageRoute(
                               builder: (context)=>DetailsPage(
                               name:storeCubit.products[index]['name'],
                               image:storeCubit.products[index]['image'],
                               price:storeCubit.products[index]['price'],
                               oldprice:storeCubit.products[index]['old_price'],
                               brand:storeCubit.products[index]['brand'],
                               labelAttrbute:storeCubit.products[index]['labelAttrbute'],
                               id: storeCubit.products[index]['id'],
                               varition_id:storeCubit.varition_id,
                               type: widget.type,
                               currentIndex: widget.currentIndex,
                             )));
                       },
                       child: Container(
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
                             Image(image: NetworkImage('${StoreCubit.get(context).products[index]['image']}'),height: 100,),
                             SizedBox(height: 10,),
                             Text('${StoreCubit.get(context).products[index]['name']}', style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                overflow: TextOverflow.ellipsis,
                                height: 1.1),
                            textAlign: TextAlign.center,
                            maxLines: 2,),
                            Text(
                          '${StoreCubit.get(context).products[index]['brand']}',
                          style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              overflow: TextOverflow.ellipsis,
                              height: 1.1,
                              color: Colors.grey),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                        ),
                        SizedBox(height: 3,),
                         Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${StoreCubit.get(context).products[index]['price']} MAD',
                              style: TextStyle(
                                  fontSize: 11,
                                  color: widget.type == ataycom
                                      ? tabatayColor
                                      : tabparfum,
                                  fontWeight: FontWeight.w600
                                  ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                           if(StoreCubit.get(context).products[index]['old_price'] != null)
                               Text(
                                    '${StoreCubit.get(context).products[index]['old_price']} MAD',
                                    style: TextStyle(
                                        fontSize: 11,
                                        decoration: TextDecoration.lineThrough),
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
                                  color: widget.type == ataycom
                                      ? ataycomColor
                                      : parfumColor,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Center(
                                  child: Text(
                                'View products',
                                style: TextStyle(
                                  fontSize: 13,
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
                     ),
                   );
                
                   }
                   ):GridView.builder(
                       physics:NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: StoreCubit.get(context).search.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              childAspectRatio: 3 / 5.7, 
                            ),
                 
                   itemBuilder: (context,index){
                       var storeCubit = StoreCubit.get(context);
                     return Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: InkWell(
                       onTap: (){
                          Navigator.push(context, MaterialPageRoute(
                               builder: (context)=>DetailsPage(
                               name:storeCubit.search[index]['name'],
                               image:storeCubit.search[index]['image'],
                               price:storeCubit.search[index]['price'],
                               oldprice:storeCubit.search[index]['old_price'],
                               brand:storeCubit.search[index]['brand'],
                               labelAttrbute:storeCubit.search[index]['labelAttrbute'],
                               id: storeCubit.search[index]['id'],
                               varition_id:storeCubit.varition_id,
                               type: widget.type,
                               currentIndex: widget.currentIndex,
                             )));
                       },
                       child: Container(
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
                             Image(image: NetworkImage('${StoreCubit.get(context).search[index]['image']}'),height: 100,),
                             SizedBox(height: 10,),
                             Text('${StoreCubit.get(context).search[index]['name']}', style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                overflow: TextOverflow.ellipsis,
                                height: 1.1),
                            textAlign: TextAlign.center,
                            maxLines: 2,),
                            Text(
                          '${StoreCubit.get(context).search[index]['brand']}',
                          style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              overflow: TextOverflow.ellipsis,
                              height: 1.1,
                              color: Colors.grey),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                        ),
                        SizedBox(height: 3,),
                         Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${StoreCubit.get(context).search[index]['price']} MAD',
                              style: TextStyle(
                                  fontSize: 11,
                                  color: widget.type == ataycom
                                      ? tabatayColor
                                      : tabparfum,
                                  fontWeight: FontWeight.w600
                                  ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                           if(StoreCubit.get(context).search[index]['old_price'] != null)
                               Text(
                                    '${StoreCubit.get(context).search[index]['old_price']} MAD',
                                    style: TextStyle(
                                        fontSize: 11,
                                        decoration: TextDecoration.lineThrough),
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
                                  color: widget.type == ataycom
                                      ? ataycomColor
                                      : parfumColor,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Center(
                                  child: Text(
                                'View products',
                                style: TextStyle(
                                  fontSize: 13,
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
                     ),
                   );
                     
                     
                     
                  
                   }
                   )
              ],
            ),
          ),
        );
        },
      ),
    );
  }

}