class RegisterModelApi{
  int statusCode;
  String access_token;
  String token_type;
  UserData user;
  RegisterModelApi.fromJson(Map<String,dynamic>json){
    statusCode = json["statusCode"];
    access_token = json["access_token"];
    token_type = json["token_type"];
    user = json["user"] != null ? UserData.fromJson(json["user"]):null;
  }
}

class UserData{
  String firstName;
  String lastName;
  String phone;
  String password;
  UserData.fromJson(Map<String,dynamic>json){
    firstName = json["firstName"];
    lastName = json["lastName"];
    phone = json["phone"];
    password = json["password"];
  }
 Map<String,dynamic>toMap(){
   return {

  "firstName":firstName,
	"lastName":lastName,
	"phone":phone,
  "password":password,
   };
 }
}