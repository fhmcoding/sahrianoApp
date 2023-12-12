abstract class FlightStates{}
class FlightInitialState extends FlightStates{}
class SearchFlightLoadingState extends FlightStates{}
class SearchFlightSuccessState extends FlightStates{
    final List<dynamic> flights;
    final List<dynamic> filterdata;
    final String departAirport;
    final String arivalAirport;
    final String dateDepart;
    final Map<String, dynamic> parm;
    final Map<String, dynamic> result;
  final Map<String, dynamic> flight;
  final List<dynamic> FlightOneWay;
  final List<dynamic> FILTERDATA;
  final List<dynamic> filghtoneway;
  final List<dynamic> FILTERound;
    List<dynamic> flightsRetun = null;
  List<dynamic> flightdepart =null;
  final List<dynamic> rangeData;
  final List<dynamic> flightsAR;
  SearchFlightSuccessState({this.rangeData, this.flightsAR,this.flight, this.FlightOneWay, this.FILTERDATA, this.filghtoneway, this.FILTERound,this.flights,this.filterdata, this.departAirport, this.arivalAirport,this.parm,this.dateDepart,this.result,this.flightdepart,this.flightsRetun});
}
class SearchFlightErrorState extends FlightStates{
  final String error;

  SearchFlightErrorState(this.error);
}

class SearchFlightShtLoadingState extends FlightStates{}
class SearchFlightShtSuccessState extends FlightStates{
  final List<dynamic> filghtoneway;
  final List<dynamic> flightRetunService;
  final List<dynamic> flightdepartService;
  final List<dynamic> FILTERDATA;


  SearchFlightShtSuccessState( {this.filghtoneway,this.FILTERDATA,this.flightRetunService,this.flightdepartService});
}
class SearchFlightShtErrorState extends FlightStates{
  final String error;

  SearchFlightShtErrorState(this.error);
}

class getPriceLoadingState extends FlightStates{
  

}
class getPriceSuccessState extends FlightStates{
    double price = 0.0;
    int adult = 0;
    int childern = 0;
    int infans = 0;
    double adultprice = 0.0;
    double childernprice = 0.0;
    double infansprice = 0.0;
    final List<dynamic> bagsSelected ;
  final Map<String, dynamic> flights;
  final Map<String, dynamic> getPriceResult;
  final dynamic bookingresult;
  final dynamic total;
  List<dynamic> sequence_number;
  Map<String, dynamic> flightResult;
  Map<String, dynamic> baggage;
  final List<dynamic> filterdata;
  final List<dynamic> rangeData;
  final Map<String, dynamic> parm;
  final List<dynamic> flightsAR;
  List<dynamic> flightsRetun = null;
  List<dynamic> flightdepart =null;
 final dynamic TotalPrice;
 final double TotalTaxes;
 final double TotalFees;

 final double adultFee;
 final double childernFee;
 final double infansFee;
 final double adultTaxes;
 final double childernTaxes;
 final double infansTaxes;
  final Map<String, dynamic> flight;
  final List<dynamic> FlightOneWay;
  final List<dynamic> FILTERDATA;
  final List<dynamic> filghtoneway;
  final List<dynamic> FILTERound;

   getPriceSuccessState( {
     this.filterdata, this.rangeData,
      this.parm,
       this.flightsAR, 
       this.TotalPrice,
        this.TotalTaxes, 
        this.TotalFees, 
        this.adultFee,
         this.childernFee,
          this.infansFee,
           this.adultTaxes,
            this.childernTaxes,
             this.infansTaxes,
              this.flight,
               this.FlightOneWay,
                this.FILTERDATA,
                 this.filghtoneway,
                  this.FILTERound,
                  
     this.bagsSelected,
     this.flights,
     this.getPriceResult,
     this.bookingresult,
     this.total,
     this.adult,
     this.childern,
     this.infans,
     this.adultprice,
     this.childernprice,
     this.infansprice,
     this.sequence_number,
     this.price
     });
}
class getPriceErrorState extends FlightStates{
  final String error;
 String message;
  // final Map<String, dynamic> parm;
  getPriceErrorState(this.error,this.message,);
}
class GetServicesLoadingState extends FlightStates{}
class GetServicesSucessfulState extends FlightStates{
    Map<String, dynamic> baggage;
    Map<String, dynamic> flightResult;
  final Map<String, dynamic> flight;
  final Map<String, dynamic> flightreponse;
    double adultTaxes = 0.0;
    double childernTaxes = 0.0;
    double infansTaxes = 0.0;
    double adultMarkup = 0.0;
    double childernFee = 0.0;
    double infansFee = 0.0;
    String sourceRequrment;

  final List<dynamic> flights;
  List<dynamic> flightsRetun = null;
  List<dynamic> flightdepart =null;
final dynamic TotalPrice ;
final  double TotalTaxes ;
final  double TotalFees ;
final  int adult ;
final  int childern ;
final  int infans ;
final  double adultprice ;
final  double childernprice ;
final  double infansprice ;
final  double adultFee ;
 



  final  double price;
  final List<dynamic> bagsSelected ;
  final Map<String, dynamic> getPriceResult;
  final dynamic bookingresult;
  final dynamic total;
  final List<dynamic> sequence_number;

  GetServicesSucessfulState({
    this.TotalPrice, this.TotalTaxes, this.TotalFees, this.adult, this.childern, this.infans, this.adultprice, this.childernprice, this.infansprice, this.adultFee,

    this.flights,this.price, this.bagsSelected, this.getPriceResult, this.bookingresult, this.total, this.sequence_number,
    this.flight,this.flightResult,this.baggage,this.flightreponse,this.adultTaxes,this.childernTaxes,this.infansTaxes,this.adultMarkup,this.childernFee,this.infansFee,this.sourceRequrment});
}
class GetServicesErrorState extends FlightStates{
  final String error;

  GetServicesErrorState(this.error);
}
class GetSearchAirLoadingState extends FlightStates{}
class GetSearchAirSucessfulState extends FlightStates{}
class GetSearchAirErrorState extends FlightStates{
  final String error;

  GetSearchAirErrorState(this.error);
}
class bookingLoadingState extends FlightStates{}
class bookingSuccessState extends FlightStates{
 final List<dynamic> bookings;
 final Map<String, dynamic> bookingResult;

  bookingSuccessState({this.bookings,this.bookingResult});
}
class bookingErrorState extends FlightStates{
  final String error;
  
  bookingErrorState(this.error);
}
class GetPaymentLoadingState extends FlightStates{}
class GetPaymentSucessfulState extends FlightStates{
final List<dynamic> PaymentMethods;
final Map<String, dynamic> reservation;
final Map<String, dynamic> bookingResult;
GetPaymentSucessfulState({this.PaymentMethods,this.reservation,this.bookingResult});
}
class GetPaymentErrorState extends FlightStates{
  final String error;
  
  GetPaymentErrorState(this.error);
}
class bookingTicketLoadingState extends FlightStates{}
class bookingTicketSuccessState extends FlightStates{
final List<dynamic> PaymentMethods;

 final Map<String, dynamic> customer;

  bookingTicketSuccessState({this.PaymentMethods,this.customer});
}
class bookingTicketErrorState extends FlightStates{
  final String error;
  
  bookingTicketErrorState(this.error);
}
class CalculateServiceChargeLoadingState extends FlightStates{}
class CalculateServiceChargeSucessfulState extends FlightStates{
  Map<String, dynamic> flightResult;
  Map<String, dynamic> baggage;
  final List<dynamic> flights;
  final List<dynamic> filterdata;
  final List<dynamic> rangeData;
  final Map<String, dynamic> parm;
  final List<dynamic> flightsAR;
  List<dynamic> flightsRetun = null;
  List<dynamic> flightdepart =null;
 final dynamic TotalPrice;
 final double TotalTaxes;
 final double TotalFees;
 final int adult ;
 final int childern ;
 final int infans ;
 final double adultprice;
 final double childernprice;
 final double infansprice;
 final double adultFee;
 final double childernFee;
 final double infansFee;
 final double adultTaxes;
 final double childernTaxes;
 final double infansTaxes;
  final Map<String, dynamic> flight;
  final List<dynamic> FlightOneWay;
  final List<dynamic> FILTERDATA;
  final List<dynamic> filghtoneway;
  final List<dynamic> FILTERound;


  final  double price;
  final List<dynamic> bagsSelected ;
  final Map<String, dynamic> getPriceResult;
  final dynamic bookingresult;
  final dynamic total;
  final List<dynamic> sequence_number;

  CalculateServiceChargeSucessfulState( {
    this.bagsSelected,
    this.price,
    this.sequence_number,
    this.getPriceResult,
    this.bookingresult,
    this.total, 
    this.filghtoneway,
    this.FILTERound,
    this.FILTERDATA,
   this.FlightOneWay,
   this.flights,
   this.filterdata,
   this.rangeData,
   this.parm,
   this.flightdepart,
   this.flightsAR,
   this.flightsRetun,
   this.adult,
   this.adultprice,
   this.childern,
   this.childernprice,
   this.infans,
   this.infansprice,
   this.TotalPrice,
   this.flight,
   this.TotalTaxes,
   this.baggage,
   this.flightResult,
   this.adultFee,
   this.childernFee,
   this.infansFee,
      this.adultTaxes,
   this.childernTaxes,
   this.infansTaxes,
   this.TotalFees
   });
}
class CalculateServiceChargeErrorState extends FlightStates{
  final String error;
    CalculateServiceChargeErrorState(this.error);
}
class UpdatePNRLoadingState extends FlightStates{}
class UpdatePNRSucessfulState extends FlightStates{
final Map<String, dynamic> fligtresult;

  UpdatePNRSucessfulState({this.fligtresult});

}
class UpdatePNRErrorState extends FlightStates{
  final String error;
    UpdatePNRErrorState(this.error);
}
class CheckoutLoadingState extends FlightStates{}
class CheckoutSuccessState extends FlightStates{
  Map<String, dynamic> Checkout;

  CheckoutSuccessState({this.Checkout});
}
class CheckoutErrorState extends FlightStates{
  final String error;

  CheckoutErrorState(this.error);
}
class GetPNRLoadingState extends FlightStates{}
class GetPNRSucessfulState extends FlightStates{
final Map<String, dynamic> fligtresukt;

  GetPNRSucessfulState({this.fligtresukt});

}
class GetPNRErrorState extends FlightStates{
  final String error;
    GetPNRErrorState(this.error);
}


class getAirlineOperatedState extends FlightStates{}
class getAirlineOperatedSucessfulState extends FlightStates{
  }
class getAirlineOperatedErrorState extends FlightStates{
  final String error;

  getAirlineOperatedErrorState(this.error);
}
class bookingShtLoadingState extends FlightStates{}
class bookingShtSucessfulState extends FlightStates{
final Map<String, dynamic> fligtresult;
 bookingShtSucessfulState({this.fligtresult});
}
class bookingShtErrorState extends FlightStates{
  final String error;
    bookingShtErrorState(this.error);
}