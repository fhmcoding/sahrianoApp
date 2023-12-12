import 'package:flutter/material.dart';
import 'country_service.dart';
final countryService = new CountryService();

class CountrySearchDelegate extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
   return [
     IconButton(onPressed: (){
       this.query = '';
     }, icon: Icon(Icons.close))
   ];
  }
  @override
  Widget buildLeading(BuildContext context) {
    return GestureDetector(
      onTap: (){
      Navigator.pop(context);
      },
      child: Icon(Icons.arrow_back));
  }
  @override
  Widget buildResults(BuildContext context) {
    if (query.trim().length == 0) {
      return Text('No results found');
    }
   return FutureBuilder(
     future:countryService.getSearchAir(query),
     builder: (_,AsyncSnapshot snapshot){
       if (snapshot.hasData) {
          return ListView.builder(
            itemCount: countryService.search.length,
            itemBuilder: (context,index){
              final airport = countryService.search[index];
            return Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(0),color: Colors.white,),
                    child: ListTile(
                      onTap: (){
                       
                       this.close(context,airport['id'],);
                      },
                     trailing: Icon(Icons.local_airport,color: Colors.orange),
                        title: Text('${airport['id']}',style: TextStyle(fontWeight: FontWeight.bold,color:Colors.orange)),
                      subtitle:Text('${airport['text']}',style: TextStyle(fontWeight: FontWeight.bold,color:Color(0xFF8592a6))),
                    ),
                  ),
                );
          });
       }else{
         return Center(child: CircularProgressIndicator(),);
       }
      
     });
  }
  @override
  Widget buildSuggestions(BuildContext context) {
   return FutureBuilder(
     future:countryService.getSearchAir(query),
     builder: (_,AsyncSnapshot snapshot){
       if (snapshot.hasData) {
          return ListView.builder(
            itemCount:countryService.search.length,
            itemBuilder: (context,index){
             final airport = countryService.search[index];
            return Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(0),color: Colors.white,),
                    child: ListTile(
                      onTap: (){
                       this.close(context,airport['id'],);
                      },
                      trailing: Icon(Icons.local_airport,color: Colors.orange),
                        title: Text('${airport['id']}',style: TextStyle(fontWeight: FontWeight.bold,color:Colors.orange)),
                      subtitle:Text('${airport['text']}',style: TextStyle(fontWeight: FontWeight.bold,color:Color(0xFF8592a6))),
                    ),
                  ),
                );
          });
       }else{
         return Center(child: CircularProgressIndicator(),);
       }
      
     });
     }
  
}