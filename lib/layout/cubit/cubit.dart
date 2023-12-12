import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahariano_travel/Flight_app/country_service.dart';
import 'package:sahariano_travel/Flight_app/flightservice.dart';
import 'package:sahariano_travel/layout/cubit/states.dart';
import 'package:sahariano_travel/modeles/registerModel.dart';
import 'package:sahariano_travel/modeles/userModel.dart';
import 'package:sahariano_travel/modules/pages.dart/notification/old_notification.dart';
import 'package:sahariano_travel/modules/pages.dart/notification/vue_notification.dart';
import 'package:sahariano_travel/shared/components/components.dart';
import 'package:sahariano_travel/shared/components/constants.dart';
import 'package:sahariano_travel/shared/network/remote/dio_helper.dart';
import 'package:sahariano_travel/shared/network/remote/local/cache_helper.dart';

final countryService = new CountryService();
final Service = new FlightServices();
// final _firestore = FirebaseFirestore.instance;

class AppCubit extends Cubit<AppStates>{
  AppCubit() : super(AppInitialState());
  static AppCubit get(context) => BlocProvider.of(context);
  
 RegisterModel userModel;


 RegisterModelApi registerModelApi;


String phoneNumber;
String name;
int Uid;
bool isloading = false;
List<dynamic> users = [];
String usersType="client";
  int id = Cachehelper.getData(key: "id");
  String phone = Cachehelper.getData(key: "phone");
  String type = Cachehelper.getData(key: "type");




void userRegister({
  String fcmToken,
  String firstName,
  String lastName,
  String phone,
  String device_id,
})
{
  var data = {
    "given_name":"${firstName}",
    "surname":"${lastName}",
    "phone_number":phone.replaceAll("+", "0"),
    "uid":FirebaseAuth.instance.currentUser.uid,
    "device":{
      "token_firebase":"${fcmToken}",
      "device_id":"${device_id}",
      "device_name":"iphone",
      "ip_address":"192.168.1.1",
      "mac_address":"192.168.1.1"
    }
  };
  print(data);
DioHelper.postData(
  url:"${elsaharianoUrl}/auth/register.php",
  data:data
).then((value) {
  printFullText('register: ${value.data.toString()}');
userModel = RegisterModel.fromJson(value.data);
   emit(AppRegisterSuccessState(userModel));
}).catchError((error){
  print(error.toString());
   emit(AppRegisterErrorState(error.toString()));
});
}






void updateUser({
  int id,
  String currency,
  String language,
}){
  emit(AppUpdateLoadingState());
DioHelper.putData(
  url:"${elsaharianoUrl}/auth/update.php",
   data:{
  "id":id,
	"currency":currency,
	"language":language 
   }
   ).then((value){
     userModel = RegisterModel.fromJson(value.data);
     
      emit(AppUpdateSuccessState(userModel));
   }).catchError((error){
        print(error.toString());
        emit(AppUpdateErrorState(error.toString()));
   });
}


void updateToken({
  int id,
  String firebaseUid,
})async{
  emit(AppUpdateTokenLoadingState());
DioHelper.putData(
  url:"${elsaharianoUrl}/auth/refreshFirebaseUid.php",
   data:{
  "id":id,
	"firebaseUid":await FirebaseMessaging.instance.getToken()
   }
   ).then((value){
     userModel = RegisterModel.fromJson(value.data);
    //  print(value.data);
      emit(AppUpdateTokenSuccessState(userModel));
   }).catchError((error){
    print(error.toString());
    emit(AppUpdateTokenErrorState(error.toString()));
   });
}

void getProfile({
  int id
}){
  emit(AppProfileLoadingState());
  DioHelper.getData(url:"${elsaharianoUrl}/auth/profile.php?user_id=${id}").
  then((value){
    userModel = RegisterModel.fromJson(value.data);
    type = value.data["data"]["type"];
    printFullText(value.data.toString());
    emit(AppProfileSuccessState(userModel));
  }).catchError((error){
    print(error.toString());
    emit(AppProfileErrorState(error.toString()));
    print(error.toString());
  });
}

void ReadAll({
  String user_id,
  String seconde_user_id,
}){
  emit(ReadAllLoadingState());
DioHelper.putData(
  url:"${elsaharianoUrl}/chat/readall.php",
   data:{
  "user_id":user_id,
	"seconde_user_id":seconde_user_id
   }
   ).then((value){
    //  print('read all');
      emit(ReadAllTokenSuccessState());
   }).catchError((error){
    print(error.toString());
    emit(ReadAllErrorState(error.toString()));
   });
}

 ModificationPost({String issue,String description,List images,String tel}){
  emit(ModificationPostLoadingState());
  var json ={
	"issue":"${issue}",
	"description":"${description}",
  "images":images,
	"tel":tel
};

DioHelper.postData(
  url:"${elsaharianoUrl}/order_modification.php",
   data:json
   ).then((value){
     print(json);
    printFullText(value.data.toString());
    emit(ModificationPostSuccessState(statusCode:value.data['statusCode']));
   }).catchError((error){
    print(error.toString());
    emit(ModificationPostErrorState(error.toString()));
   });
}


 GetNotificationPROCESSED({String estado}){

    isloading = false;
  emit(GetNotificationPROCESSEDLoadingState());
DioHelper.getData(
  url:"${elsaharianoUrl}/notifications/notifications.php?estado=${estado}&tel=${phone.replaceAll("+", "0")}&is_read=0",
   ).then((value){
     Service.oldNotification = value.data['data'];
      isloading = true;
    emit(GetNotificationPROCESSEDSuccessState(Service.oldNotification.length)
    );
   }).catchError((error){
    print(error.toString());
    emit(GetNotificationPROCESSEDErrorState(error.toString()));
   });
}


 GetNotificationnuevo({String estado}){
   isloading = false;
  emit(GetNotificationnuevoLoadingState());
   
DioHelper.getData(
  url:"${elsaharianoUrl}/notifications/notifications.php?estado=${estado}&tel=${phone.replaceAll("+", "0")}&is_read=1",
   ).then((value){
     Service.newNotification = value.data['data'];
     print('new notification:${Service.newNotification}');
     
      isloading = true;
    emit(GetNotificationnuevoSuccessState(Service.newNotification.length)
    );
   }).catchError((error){
    
    print(error.toString());
    emit(GetNotificationnuevoErrorState(error.toString()));
   });
}

  int SelectedIndex =0;
  List<Widget>screens=[
    NewNotification(),
    OldNotification()
    ];
void changeBottomNavBar(int index){
  SelectedIndex = index;
  emit(changeBottomNavBarState());
}

UpdateNotification({String index}){
  emit(UpdateNotificationLoadingState());
DioHelper.putData(
  url:"${elsaharianoUrl}/notifications/notification_readed.php/${index}"
   ).then((value){
     print(value.data);
    emit(UpdateNotificationSuccessState()
    );
   }).catchError((error){
    print(error.toString());
    emit(UpdateNotificationErrorState(error.toString()));
   });
}


 void getUsers(){
  if(type=="client"){
    usersType = "support";
  }
  isloading = false;
  emit(getusersLoadingState());
   DioHelper.getData(
     url:"${elsaharianoUrl}/chat/users.php?user_id=${id}&type=${usersType}",
     ).then((value){
       print(id);
     users = value.data['data'];
    //  print(users);
    print(users);
     isloading = true;
    //  print(id);
     emit(getusersSuccessState(users));
     }).catchError((error){
       print(error.toString());
       emit(getusersErrorState(error.toString()));
     });
}
  

// void getMessages({
//   int resendId
// }){
//   emit(AppMessagesLoadingState());
//    DioHelper.getData(
//      url:"${elsaharianoUrl}/chat/conversation.php?user_id=${id}&seconde_user_id=${resendId}",
//      ).then((value){
//     messages = value.data['data'];
//      print(messages);
//      emit(AppMessagesSuccessState());
//      }).catchError((error){
//        print(error.toString());
//        emit(AppMessagesErrorState(error.toString()));
//      });
// }


void sendMessages({
  int resendId,
   int id,
   String msg
}){
  emit(AppMessagesLoadingState());
   DioHelper.postData(
     data: {
       "from":id,
       "to":resendId,
       "msg":msg
     },
     url:"${elsaharianoUrl}/chat/sendMessage.php",
     ).then((value){
     emit(AppMessagesSuccessState());
     }).catchError((error){
       print(error.toString());
       emit(AppMessagesErrorState(error.toString()));
     });
}


 void LoginParfum({
  String firstName,
  String lastName,
  String phone,
  String password,
})
{  
emit(AppLoginLoadingState());

DioHelper.postData(
  url:"${parfum}/api/v1/register",
  data: {
	"firstName":firstName,
	"lastName":lastName,
	"phone":phone,
	"password":phone
}
).then((value) {
  printFullText('login: ${value.data.toString()}');
  registerModelApi = RegisterModelApi.fromJson(value.data);
  Cachehelper.sharedPreferences.setString("access_token",registerModelApi.access_token);
  Cachehelper.saveData(key: "access_token", value:registerModelApi.access_token);
  Cachehelper.saveData(key: "token_type", value:registerModelApi.token_type);
  Cachehelper.saveData(key: "token", value:value.data['access_token']);
  
  emit(AppLoginSuccessState());
}).catchError((error){
  print(error.toString());
   emit(AppLoginErrorState(error.toString()));
});
}




 
}


































             

                
