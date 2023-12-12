class RequestSafer{
  Map RequestSafersys;
  String sourceRequrment;
  Map<String, dynamic> customer;
  List<dynamic> airlines = [];
  var operaitedby;
  airline(List airline,String logo){
                                
                                airline.forEach((value) { 
                                  if (value['iata_code']==logo) {
                                   operaitedby = value['name']; 
                                  }
                                });
                                return operaitedby;
                                 }

}