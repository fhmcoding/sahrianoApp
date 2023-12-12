
import 'package:sahariano_travel/modeles/userModel.dart';

abstract class AppStates{}
class AppInitialState extends AppStates{}

class SocialGetUserLoadingState extends AppStates{}
class SocialGetUserSuccessState extends AppStates{}
class SocialGetUserErrorState extends AppStates{
  final String error;
  SocialGetUserErrorState(this.error);
}

class AppGetAllSupportSuccessState extends AppStates{}
class AppAllSupportErrorState extends AppStates{
  final String error;
 AppAllSupportErrorState(this.error);
}

class AppRegisterSuccessState extends AppStates{
  final RegisterModel
      userModel;

  AppRegisterSuccessState(this.userModel);
}

class AppRegisterErrorState extends AppStates{
  final String error;
  AppRegisterErrorState(this.error);
}

class AppLoginLoadingState extends AppStates{}
class AppLoginSuccessState extends AppStates{
//  final RegisterModelApi registerModelApi;
AppLoginSuccessState();
}
class AppLoginErrorState extends AppStates{
  final String error;
  AppLoginErrorState(this.error);
}
class AppFlightLoginLoadingState extends AppStates{}
class AppFlightLoginSuccessState extends AppStates{}
class AppFlightLoginErrorState extends AppStates{
  final String error;
  AppFlightLoginErrorState(this.error);
}
class AppRegisterFireBaseSuccessState extends AppStates{}
class AppRegisterFireBaseLoadingState extends AppStates{}
class AppRegisterFireBaseErrorState extends AppStates{
  final String error;
  AppRegisterFireBaseErrorState(this.error);
}
class AppProfileSuccessState extends AppStates{
   final RegisterModel
      userModel;
  AppProfileSuccessState(this.userModel);
}
class AppProfileLoadingState extends AppStates{}

class AppProfileErrorState extends AppStates{
  final String error;
  AppProfileErrorState(this.error);
}
class AppUpdateSuccessState extends AppStates{
  final RegisterModel
      userModel;
  AppUpdateSuccessState(this.userModel);
}
class AppUpdateLoadingState extends AppStates{}

class AppUpdateErrorState extends AppStates{
  final String error;
  AppUpdateErrorState(this.error);
}
class AppUpdateTokenSuccessState extends AppStates{
  final RegisterModel
      userModel;

   AppUpdateTokenSuccessState(this.userModel);
}
class AppUpdateTokenLoadingState extends AppStates{}

class AppUpdateTokenErrorState extends AppStates{
  final String error;
  AppUpdateTokenErrorState(this.error);
}
class getusersLoadingState extends AppStates{
}
class getusersSuccessState extends AppStates{
  final users;

  getusersSuccessState(this.users);
}

class getusersErrorState extends AppStates{
  final String error;
  getusersErrorState(this.error);
}

class AppClientsSuccessState extends AppStates{
}
class AppClientsLoadingState extends AppStates{}

class AppClientsErrorState extends AppStates{
  final String error;
  AppClientsErrorState(this.error);
}

class AppMessagesSuccessState extends AppStates{
}
class AppMessagesLoadingState extends AppStates{}

class AppMessagesErrorState extends AppStates{
  final String error;
  AppMessagesErrorState(this.error);
}
class SocialSendMessageSuccessState extends AppStates{}
class SocialSendMessageErrorState extends AppStates{
  final String error;
  SocialSendMessageErrorState(this.error);
}
class SocialGetMessagesSuccessState extends AppStates{
}

class GetMessagefromdbErrorState extends AppStates{
  final String error;
  GetMessagefromdbErrorState(this.error);
}
class SocialRegisterLoadingState extends AppStates{
}
class SocialRegisterErrorState extends AppStates{
  final String error;
  SocialRegisterErrorState(this.error);
}
class SocialCreateUserSuccessState extends AppStates{
   final String uId;
  
   SocialCreateUserSuccessState(this.uId);
}
class SocialCreateUserErrorState extends AppStates{
  final String error;
  SocialCreateUserErrorState(this.error);
}

class ReadAllLoadingState extends AppStates{}
class ReadAllTokenSuccessState extends AppStates{}
class ReadAllErrorState extends AppStates{
  final String error;
  ReadAllErrorState(this.error);
}
class ImageFileSuccessState extends AppStates{}
class ImageFileErrorState extends AppStates{}

class UploadFileSuccessState extends AppStates{}
class UploadFileErrorState extends AppStates{}
class ModificationPostLoadingState extends AppStates{}
class ModificationPostSuccessState extends AppStates{
  final int statusCode;

  ModificationPostSuccessState({this.statusCode});
}
class ModificationPostErrorState extends AppStates{
  final String error;
  ModificationPostErrorState(this.error);
}
class GetNotificationPROCESSEDLoadingState extends AppStates{}
class GetNotificationPROCESSEDSuccessState extends AppStates{
    int count;

  GetNotificationPROCESSEDSuccessState(this.count);
}
class GetNotificationPROCESSEDErrorState extends AppStates{
  final String error;
  GetNotificationPROCESSEDErrorState(this.error);
}
class GetNotificationnuevoLoadingState extends AppStates{}
class GetNotificationnuevoSuccessState extends AppStates{
  GetNotificationnuevoSuccessState(int length);
 
}
class GetNotificationnuevoErrorState extends AppStates{
  final String error;
  GetNotificationnuevoErrorState(this.error);
}
class UpdateNotificationLoadingState extends AppStates{}
class UpdateNotificationSuccessState extends AppStates{
}
class UpdateNotificationErrorState extends AppStates{
  final String error;
  UpdateNotificationErrorState(this.error);
}
class changeBottomNavBarState extends AppStates{}