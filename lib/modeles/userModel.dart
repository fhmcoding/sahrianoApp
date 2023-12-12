class RegisterModel{
  int statusCode;
  UserData user;
  RegisterModel.fromJson(Map<String,dynamic>json){
    statusCode = json["statusCode"];
    user = json["user"] != null ? UserData.fromJson(json["user"]):null;
  }
}
class UserData{
  int id;
  String uId;
  String firstName;
  String lastName;
  String phone;
  String referralCode;
  String currency;
  String firebaseUid;
  String language;
  String password;
  String type;
  UserData.fromJson(Map<String,dynamic>json){
    id = json["id"];
    uId = json["uId"];
    firstName = json["firstName"];
    lastName = json["lastName"];
    phone = json["phone"].replaceAll("+", "0");
    referralCode = json["referralCode"];
    currency = json["currency"];
    firebaseUid = json["firebaseUid"];
    language = json["language"];
    password = json["password"];
    type = json["type"];
  }
 Map<String,dynamic>toMap(){
   return {
  "id":id,
  "uId":uId,
  "firstName":firstName,
	"lastName":lastName,
	"phone":phone,
	"referralCode":referralCode,
	"currency":currency,
	"firebaseUid":firebaseUid,
	"language":language,
  "password":password,
  "type":type
   };
 }




}