class UserModel{
  String firstName;
  String lastName;
  String uId;
  UserModel({
  this.firstName,
  this.lastName,
  this.uId
  });
  UserModel.fromJson(Map<String,dynamic>json){
   
    firstName = json["firstName"];
    lastName = json["lastName"];
    uId = json["uId"];
    
  }
 Map<String,dynamic>toMap(){
   return {
 
  "firstName":firstName,
	"lastName":lastName,
  "uId":uId,
	
   };
 }
}