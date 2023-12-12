abstract class StoreStates{}
class StoreInitialState extends StoreStates{}

class GetBrandsLoadingState extends StoreStates{}
class GetBrandsSuccesState extends StoreStates{}
class GetBrandsErrorState extends StoreStates{
  final String error;

  GetBrandsErrorState(this.error);
}

class getProductDetailsLoadingState extends StoreStates{}
class getProductDetailsSuccesState extends StoreStates{}
class getProductDetailsErrorState extends StoreStates{
  final String error;
  getProductDetailsErrorState(this.error);
}

class getSlidersLoadingState extends StoreStates{}
class getSlidersSuccesState extends StoreStates{}
class getSlidersErrorState extends StoreStates{
  final String error;
  getSlidersErrorState(this.error);
}

class getProductsLoadingState extends StoreStates{}
class getProductsSuccesState extends StoreStates{}
class getProductsErrorState extends StoreStates{
  final String error;
  getProductsErrorState(this.error);
}

class getCategoriesLoadingState extends StoreStates{}
class getCategoriesSuccesState extends StoreStates{}
class getCategoriesErrorState extends StoreStates{
  final String error;
  getCategoriesErrorState(this.error);
}
class getCategoriesDetailsLoadingState extends StoreStates{}
class getCategoriesDetailsSuccesState extends StoreStates{
final  List<dynamic> subcategories;
final List<dynamic> products;
final  Map<String, dynamic> Subcategories;
  getCategoriesDetailsSuccesState( {this.subcategories, this.products,this.Subcategories,});
}
class getCategoriesDetailsErrorState extends StoreStates{
  final String error;
  getCategoriesDetailsErrorState(this.error);
}
class AddItemSuccesState extends StoreStates{}
class AddItemErrorState extends StoreStates{
  final String error;
  AddItemErrorState(this.error);
}
class RemoveItemSuccesState extends StoreStates{}
class RemoveItemErrorState extends StoreStates{
  final String error;
  RemoveItemErrorState(this.error);
}
class QtyMinusState extends StoreStates{}
class QtyPlusState extends StoreStates{}


class AddToCartLoadingState extends StoreStates{}
class AddToCartSuccesState extends StoreStates{}
class AddToCartErrorState extends StoreStates{
  final String error;
  AddToCartErrorState(this.error);
}
class incremmentLoadingState extends StoreStates{}
class incremmentSuccesState extends StoreStates{
  incremmentSuccesState();
}
class incremmentErrorState extends StoreStates{
  final String error;
  incremmentErrorState(this.error);
}
class disincremmentLoadingState extends StoreStates{}
class disincremmentSuccesState extends StoreStates{}
class disincremmentErrorState extends StoreStates{
  final String error;
  disincremmentErrorState(this.error);
}

class ClearCartLoadingState extends StoreStates{}
class ClearCartSuccesState extends StoreStates{}
class ClearCartErrorState extends StoreStates{
  final String error;
  ClearCartErrorState(this.error);
}
class getCartItemLoadingState extends StoreStates{}
class getCartItemSuccesState extends StoreStates{}
class getCartItemErrorState extends StoreStates{
  final String error;
  getCartItemErrorState(this.error);
}
class GetSearchLoadingState extends StoreStates{}
class GetSearchSucessfulState extends StoreStates{}
class GetSearchErrorState extends StoreStates{
  final String error;
  GetSearchErrorState(this.error);
}
class CheckoutCartLoadingState extends StoreStates{}
class CheckoutCartSucessfulState extends StoreStates{}
class CheckoutCartErrorState extends StoreStates{
  final String error;
 CheckoutCartErrorState(this.error);
}
class GetPaymentShopLoadingState extends StoreStates{}
class GetPaymentShopSucessfulState extends StoreStates{
  
  final List<dynamic> itemsCart;
  final List<dynamic> PaymentMethods;
  final Map<String, dynamic> reservation;
  final int total;
  GetPaymentShopSucessfulState({this.PaymentMethods,this.reservation,this.itemsCart,this.total});
}
class GetPaymentShopErrorState extends StoreStates{
  final String error;
 GetPaymentShopErrorState(this.error);
}

class AppLoginLoadingState extends StoreStates{}
class AppLoginSuccessState extends StoreStates{}
class AppLoginErrorState extends StoreStates{
  final String error;
 AppLoginErrorState(this.error);
}