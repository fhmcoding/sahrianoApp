import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahariano_travel/Flight_app/country_service.dart';
import 'package:sahariano_travel/Flight_app/pages/servies.dart';
import 'package:sahariano_travel/ataycom_app/layout/cubit/states.dart';
import 'package:sahariano_travel/modeles/registerModel.dart';
import 'package:sahariano_travel/shared/components/components.dart';
import 'package:sahariano_travel/shared/components/constants.dart';
import 'package:sahariano_travel/shared/network/remote/dio_helper.dart';
import 'package:sahariano_travel/shared/network/remote/local/cache_helper.dart';
import 'package:http/http.dart' as http;
final countryService = new CountryService();
final service =  IndexChange();
class StoreCubit extends Cubit<StoreStates>{
  StoreCubit() : super(StoreInitialState());
  static StoreCubit get(context) => BlocProvider.of(context);
   RegisterModelApi registerModelApi;

List<dynamic> brands =[];
List<dynamic> sliders =[];
List<dynamic> products =[];
List<dynamic> dishes =[];
List<dynamic> categories =[];
List<dynamic> subcategories=[];
List<dynamic> brandProduct=[];
List<dynamic> items =[];
List<dynamic> itemsCart =[];
List<dynamic> images =[];
String subname = '';
String gender;
String language = Cachehelper.getData(key: "langugeCode"); 
String access_token = Cachehelper.getData(key: "access_token");
bool isloading = false;
  void getBrands({
  String type
}){
      emit(GetBrandsLoadingState());
       DioHelper.getData(
        url:'${type}/api/v1/brands')
       .then((value) {
      brands = value.data['data']['data'];
       if (type==ataycom) {
        countryService.brandsAtay = value.data['data']['data'];
        print(countryService.brandsAtay.length);
      } else {
        countryService.brandsParfum = value.data['data']['data'];
         print(countryService.brandsParfum.length);
      }
      emit(GetBrandsSuccesState());
       }).catchError((error){
           print(error.toString());
           emit(GetBrandsErrorState(error.toString()));
       });
    }
     
void getbrandsDetails({
  String type,
  String url
}){
      emit(getCategoriesDetailsLoadingState());
       DioHelper.getData(
        url:url)
       .then((value) {
      print('=============================');
       brandProduct = value.data['data']['products'];
       countryService.brandProduct =  value.data['data']['products'];
      //  products = value.data['data']['categories'];
      //  print(subcategories);
      print('=============================');
      
     emit(getCategoriesDetailsSuccesState());
       }).catchError((error){
           print(error.toString());
          emit(getCategoriesDetailsErrorState(error.toString()));
       });
    }

   

void getSliders({
  String type
}){  
  emit(getSlidersLoadingState());
   DioHelper.getData(
        url:'${type}/api/v1/sliders')
       .then((value) {
        
       if (type==ataycom) {
        countryService.SlidersAtay = value.data['data'];
      } else {
        countryService.SlidersParfum = value.data['data'];
        
        print(countryService.SlidersParfum);
      }
      emit(getSlidersSuccesState());
     
       }).catchError((error){
           print(error.toString());
          emit(getSlidersErrorState(error.toString()));
  });
}

void getCategories({
  String type,
  String articletype
}){
      isloading = false;
      emit(getCategoriesLoadingState());
     

      
        DioHelper.getData(
        url:'${type}/api/v1/categories?articletype=${articletype}')
       
       .then((value) {
       categories = value.data;
       countryService.categoriesparfum =value.data;
       print('category data:');
       printFullText(categories.toString());
       isloading = true;
     emit(getCategoriesSuccesState());
       }).catchError((error){
           print(error.toString());
          emit(getCategoriesErrorState(error.toString()));
       });
    }


void getProducts({
  String type,
  String articletype
}){
     isloading = false;
     emit(getProductsLoadingState());

       DioHelper.getData(
        url:'${type}/api/v1/products?articletype=${articletype}&categories=Homme,Femme,Kids,Unisex,Tester&group_limit=10'
        ).then((value) {
      products = value.data['data'];
      printFullText(products.toString());
      if (type==ataycom) {
         countryService.productsAtay = value.data['data'];
      } else {
         countryService.productsParfum = value.data['data'];
         printFullText(products.toString());
      }

      isloading =true;
      
      emit(getProductsSuccesState());
       }).catchError((error){
           print(error.toString());
           print('error is :${error.toString()}');
           emit(getProductsErrorState(error.toString()));
       });
     
       
    }
int varition_id;
void getProductDetails({
  String type,
  String url
}){
   emit(getProductDetailsLoadingState());
       DioHelper.getData(url:url)
       .then((value){
    emit(getProductDetailsSuccesState());
    items = value.data['items'];
    varition_id = items[0]['id'];
    images = value.data['images'];
    subname = value.data['subname'];
    gender = value.data['gender'];
    
    if (type==ataycom) {
       countryService.itemsataycom = value.data['items'];
        countryService.varition_idataycom = items[0]['id'];
        countryService.imagesataycom = value.data['images'];
        countryService.subnameataycom = value.data['subname'];
        countryService.genderataycom = value.data['gender'];
       }else{
         countryService.itemsparfum = value.data['items'];
         countryService.varition_idparfum = items[0]['id'];
         countryService.imagesparfum = value.data['images'];
         countryService.subnameparfum = value.data['subname'];
         countryService.genderparfum = value.data['gender'];
       }



    }).catchError((error){
           print(error.toString());
            emit(getProductDetailsErrorState(error.toString()));
          
       });
    }


void getCategoriesDetails({
  String type,
  String url
}){
      emit(getCategoriesDetailsLoadingState());
       DioHelper.getData(
        url:url)
       .then((value) {
      //  subcategories = value.data;
      //  print(subcategories);
     emit(getCategoriesDetailsSuccesState(products: value.data['products'],subcategories:value.data['categories'] ));
       }).catchError((error){
           print(error.toString());
          emit(getCategoriesDetailsErrorState(error.toString()));
       });
    }
    
Future AddToCart({
  int qty,
  int varition_id,
  String type,
}) async {
   emit(AddToCartLoadingState());
    final response = await http.post(
      Uri.parse('${type}/api/v1/cart'),
      headers: {
        'Authorization': 'Bearer ' + access_token,
      },
       body: {
         "productId":"${varition_id}", "qty":"${qty}"
       },
      
    ).then((response) {
        var responsebody = jsonDecode(response.body);
        print(responsebody);
        print(access_token);
        emit(AddToCartSuccesState());
      
    }).catchError((error){
       print(error.toString());
       emit(AddToCartErrorState(error.toString()));
    });
   
   return response;
  }

void incremment({
  int id,
}){
  emit(incremmentLoadingState());
  http.put(
      Uri.parse("http://ataycom.backend.elsahariano.com/api/v1/cart/${id}/incremment"),
       headers:{
       'Authorization': 'Bearer ' + access_token,
     },
      body: {
 	      "id":"${id}",
      },
   ).then((http.Response response) {
      print('=====================');
      var responsebody = jsonDecode(response.body);
     print(responsebody);
        print('=====================');
  emit(incremmentSuccesState());
   }).catchError((error){
      print(error.toString());
         emit(incremmentErrorState(error.toString()));
   });
  }
void disincremment({
  int id,
}){
      emit(disincremmentLoadingState());

http.put(
      Uri.parse("http://ataycom.backend.elsahariano.com/api/v1/cart/${id}/disincremment"),
       headers:{
       'Authorization': 'Bearer ' + access_token,
     },
      body: {
 	      "id":"${id}",
 },
   ).then((http.Response response) {
      print('=====================');

      var responsebody = jsonDecode(response.body);
     print(responsebody);
        print('=====================');

   emit(disincremmentSuccesState());
   }).catchError((error){
      print(error.toString());
    emit(disincremmentErrorState(error.toString()));
   });
    }

void ClearCart(){
      emit(ClearCartLoadingState());
http.delete(
      Uri.parse("http://ataycom.backend.elsahariano.com/api/v1/cart/clear"),
       headers:{
       'Authorization': 'Bearer ' + access_token,
     },
      body: {
 	      
 },
   ).then((http.Response response) {
      print('=====================');
      var responsebody = jsonDecode(response.body);
      countryService.itemsCart = [];
     print(responsebody);
        print('=====================');
 emit(ClearCartSuccesState());
   }).catchError((error){
      print(error.toString());
    emit(ClearCartErrorState(error.toString()));
   });
    }
int total = 0;
void getCartItem({
  String type
}){ 
     isloading = false;
     emit(getCartItemLoadingState());

    http.get(
      Uri.parse("${type}/api/v1/cart"),
       headers:{
       'Authorization': 'Bearer ' + access_token,
     },
   ).then((http.Response response) {
      var responsebody = jsonDecode(response.body);
     itemsCart = responsebody['cart'];
     
     countryService.itemsCart = responsebody['cart'];
     print(responsebody);
     countryService.total = responsebody['total'];
     total = responsebody['total'];
     isloading =true;
 emit(getCartItemSuccesState());
   }).catchError((error){
      print(error.toString());
   emit(getCartItemErrorState(error.toString()));
   });
    }

   List search = [];
  void getSearchData(String value,String type) {
    emit(GetSearchLoadingState());
    DioHelper.getData(
        url: '${type}/api/v1/products?search=${value}',
      ).then((value) {
       search = value.data['data']['data'];
      print(search);
      emit(GetSearchSucessfulState());
    }).catchError((error){
      print(error.toString());
      emit(GetSearchErrorState(error.toString()));
    });
  }
int id;
int user_id;
void CheckoutCart({
  String adress,
  String phone,
  String firstName,
  String lastName,
  String type
}){
      isloading = false;
      emit(CheckoutCartLoadingState());
      http.post(
      Uri.parse("${type}/api/v1/checkout"),
       headers:{
       'Authorization': 'Bearer ' + access_token,
     },
     body:{
	        "adress":adress,
        	"phone":phone,
        	"firstName":firstName,
        	"lastName":lastName
},
   ).then((http.Response response){
     
      var responsebody = jsonDecode(response.body);
      id = responsebody['order']['id'];
      print('=====================');
      printFullText(responsebody.toString());
      
      print('=====================');
      getPaymentShop(booking_id: id,firstName: firstName,lastName: lastName,total:responsebody['order']['total']);
 emit(CheckoutCartSucessfulState());
   }).catchError((error){
    print(error.toString());
   emit(CheckoutCartErrorState(error.toString()));
   });
    }
  Future getPaymentShop({
  int booking_id,  
  String firstName,
  String lastName,
  dynamic total,
  }) {
    
  emit(GetPaymentShopLoadingState());
  return DioHelper.postData(
      url: 'https://backend.elsahariano.com/unipay_v2/public/api/payment_methods',
      data:{
	         "booking_id":booking_id,
	         "service_id":110000000,
	         "customer_first_name":"${firstName}",
	         "customer_last_name":"${lastName}",
	         "price":total,
	         "currency":"MAD",
	         "client_id":1
}
    ).then((value) {
    print('---------------------------');
    print(countryService.itemsCart);
    print('---------------------------'); 
     isloading = true; 
      emit(GetPaymentShopSucessfulState(
        PaymentMethods:value.data['availablePaymentMethods'],
        reservation:value.data['reservation'],
        itemsCart:countryService.itemsCart,
        total: countryService.total
        ));
    }).catchError((error) {
      print(error.toString());
      emit(GetPaymentShopErrorState(error.toString()));
    });
  }

  int qty = 1;
  void minus(){
    if (qty>1) {
      qty--;
      emit(QtyMinusState());
    }
  }
  void plus(){
    qty++;
    emit(QtyPlusState());
  }
bool isRegister = false;
 






















   }