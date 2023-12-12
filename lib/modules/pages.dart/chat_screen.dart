


import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sahariano_travel/layout/cubit/cubit.dart';
import 'package:sahariano_travel/layout/cubit/states.dart';
import 'package:sahariano_travel/shared/components/constants.dart';
import 'package:sahariano_travel/shared/network/remote/local/cache_helper.dart';


final _firestore = FirebaseFirestore.instance;

class ChatScreen extends StatefulWidget {
final String firstName;
final int id;
final String phone;
final String firebaseUid;
final String lastName;
final String dateMessage;
final String message;
ChatScreen(this.firstName,this.lastName,this.message,this.dateMessage,this.id,this.firebaseUid,this.phone);
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
     int id = Cachehelper.getData(key: "id");
    final ScrollController messageScroller = ScrollController();
  // File imageFile;
  // ImagePicker _picker = ImagePicker();
  // File file;
  bool isloading = false;
    bool isupload = false;
   String image;
   String video;
  File imageFile;
  File videoFile;
  UploadTask uploadTask;
  _getFromGallery() async {
    PickedFile pickedFile = await ImagePicker().getImage(
        source: ImageSource.camera,
        maxWidth: 1800,
        maxHeight: 1800,
    );
    if (pickedFile != null) {
       imageFile = File(pickedFile.path);
        print(Uri.file(imageFile.path).pathSegments.last);
        setState(() {
          isupload = true;
        });
        uploadImage();
    }
}

  List<XFile>imageFileList=[];
   final ImagePicker _picker = ImagePicker();  
   void selectImages()async{
    final List<XFile> selectedImages = await _picker.pickMultiImage();
    if (selectedImages.isNotEmpty) {
      imageFileList.addAll(selectedImages);
      setState(() {});
    }
  }



uploadImage(){
 firebase_storage.FirebaseStorage.instance.ref().child("images/${Uri.file(imageFile.path).pathSegments.last}").putFile(imageFile).then((value) {
   value.ref.getDownloadURL().then((value){
       _firestore.collection('chat').add({
                   'msgImage':value,
                   'msg':'',
                   'from':id,
                   'to':widget.id,
                   'datetime':DateFormat('yyyy-MM-dd KK:mm:ss a').format(DateTime.now())
                 });
    setState(() {
       isupload = false;
    });
    
     image = value;
      print(image);
   });
 });
 
}

uploadvideo(){
 firebase_storage.FirebaseStorage.instance.ref().child("video/${Uri.file(videoFile.path).pathSegments.last}").putFile(videoFile).then((value) {
   value.ref.getDownloadURL().then((value) {
       _firestore.collection('chat').add({
                   'msgImage':value,
                   'msg':'',
                   'from':id,
                   'to':widget.id,
                   'datetime':DateFormat('yyyy-MM-dd KK:mm:ss a').format(DateTime.now())
                 });
    setState(() {
       isupload = false;
    });
    
     video = value;
      print(video);
   });
 });
 
}






//   getImage(source)async{
//     var image = await picker.getImage(source: source);
//       if (image !=null) {
        
      
//        _image = croppedFile = await ImageCropper.cropImage(
//       sourcePath: image.path);
//      setState(() {
//        _image = croppedFile;
//        });
//    if (croppedFile != null) {     
//     firebase_storage.FirebaseStorage.instance.
//  ref().
//  child('images/${Uri.file(croppedFile.path).pathSegments.last}')
//  .putFile(croppedFile)
//  .then((value){
//   value.ref.getDownloadURL().then((value){
//     _firestore.collection('chat').add({
//                    'msgImage':value,
//                    'msg':'',
//                    'from':id,
//                    'to':widget.id,
//                    'datetime':DateFormat('yyyy-MM-dd KK:mm:ss a').format(DateTime.now())
//                  });
//   }).catchError((error){

//   });
//  }).catchError((error){
   
//  });
//     }
//       }
//   }
getVideo()async{
      PickedFile pickedFilevideo = await ImagePicker().getVideo(
         source: ImageSource.camera,
      );
      if (pickedFilevideo !=null) {
         videoFile = File(pickedFilevideo.path);
         print(Uri.file(videoFile.path).pathSegments.last);
         uploadvideo();
       
    
    }
    
  }




// getVideo(source)async{
//     var video = await picker.getVideo(source: source);
//       if (video !=null) {
        
      
       
//     firebase_storage.FirebaseStorage.instance.
//  ref().
//  child('images/${Uri.file(video.path).pathSegments.last}')
//  .putFile(croppedFile)
//  .then((value){
//   value.ref.getDownloadURL().then((value){
//     _firestore.collection('chat').add({
//                    'msgImage':value,
//                    'msg':'',
//                    'from':id,
//                    'to':widget.id,
//                    'datetime':DateFormat('yyyy-MM-dd KK:mm:ss a').format(DateTime.now())
//                  });
//   }).catchError((error){

//   });
//  }).catchError((error){
   
//  });
//     }
    
//   }





 
  
  String messagetext;
 CollectionReference chat = FirebaseFirestore.instance.collection('chat');
   var messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>AppCubit()..ReadAll(user_id: id.toString(),seconde_user_id: widget.id.toString()),
      child: BlocConsumer<AppCubit,AppStates>(
        listener:(context,state){} ,
        builder:(context,state){
          print(id);
          print(widget.id);
          return Scaffold(
            // Color(0xFFb3dad8),
            backgroundColor: Colors.white,
          appBar: AppBar(
            leading: IconButton(onPressed: (){
              Navigator.pop(context);
            }, icon: Icon(Icons.arrow_back,color: Color(0xFF173242))),
            elevation: 0.7,
            backgroundColor:Colors.white,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${widget.firstName} ${widget.lastName}',style: TextStyle(color:Color(0xFF173242)),),
                Row(
                  children: [
                    Text('Active Now',style: TextStyle(
                      color: Color(0xFF173242),
                      fontSize: 12
                    ),),
                    SizedBox(width: 5,),
                    CircleAvatar(minRadius: 5,backgroundColor: Color(0xFF52ce5f),)
                  ],
                )
              ],
            ),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
                 
               StreamBuilder<QuerySnapshot>(
                 stream:chat.where('from',whereIn:[widget.id,id]).orderBy('datetime',descending:false).limit(100).snapshots(),
                 builder:(context,snapshot){
                  List<MessageBox> messageWidgets =[];
                   if (!snapshot.hasData) {
                     return SizedBox(height: 0,);
                   }

                   final messages = snapshot.data.docs.reversed.where((i)=> (i.get('to') == widget.id && i.get('from') == id) || (i.get('to') == id && i.get('from') == widget.id));

                   for (var message in messages){
                     final from = message.get('from');
                     print(from);

                     final to = message.get('to');
                     print(to);
                     final mesagetext =  message.get('msg');
                     final mesageimage =  message.get('msgImage');
                     final datetime = message.get('datetime');

                     final messageWidget = MessageBox(
                     datetime:datetime,
                     from:from,
                     to:to,
                     msg:mesagetext,
                     img:mesageimage,
                     isMe:id == from,
                     isupload:isupload,
                    );
                    messageWidgets.add(messageWidget);
                    }
                   return Expanded(
                     child: ListView(
                       reverse: true,
                       children:messageWidgets
                     ),
                   );
                 }
               ),
          
              Container(
           decoration: BoxDecoration(
             border: Border(
               top: BorderSide(
                 color: Colors.grey,
                 width: 1,
               )
             )
           ),
           child: Row(
             crossAxisAlignment: CrossAxisAlignment.center,
             children: [
              
               TextButton(
                 onPressed: (){
                 selectImages();
                //  getVideo();
                 }, 
                 child:CircleAvatar(
                   backgroundColor:appColor,
                 child:  Icon(
                Icons.camera_alt,
                color: Colors.white,
                        ),
               )),
               TextButton(
                       onPressed: (){
                     
                       }, 
                       child:CircleAvatar(
                         backgroundColor:appColor,
                       child:  Icon(FontAwesomeIcons.microphone,color: Colors.white,)
                     )),
               Expanded(child: TextField(
                 controller: messageController,
                 onChanged:(value){
                  messagetext = value;
                },
                 decoration: InputDecoration(
                   contentPadding: EdgeInsets.symmetric(
                     vertical: 10,
                     horizontal: 20,
                   ),
                   hintText: "Write your messsage here...",
                   border: InputBorder.none
                 ),
                )),
                MaterialButton(
                 height: 10,
                 padding: EdgeInsets.only(right: 15),
                 onPressed: ()  {
                  //  AppCubit.get(context).uploadImageToStorage();
                   if (messageController.text.isEmpty)return null;
                   AppCubit.get(context).sendMessages(
                     id: id,
                     resendId: widget.id,
                     msg:messagetext
                   );
                   _firestore.collection('chat').add({
                   'msgImage':null,
                   'msg':messagetext,
                   'from':id,
                   'to':widget.id,
                   'datetime':DateFormat('yyyy-MM-dd KK:mm:ss a').format(DateTime.now())
                 });

                  messageController.clear();
                  FocusScope.of(context).requestFocus(FocusScopeNode());
               },                   
                elevation: 0,
                minWidth: 0,
                child: Icon(
                Icons.send,
                color: Colors.green
                ),
                ),
               
             ],
           ),
         )
            ],
          )
        );
        } ,
      ),
    );
    
  }

}
class MessageBox extends StatelessWidget {
  final int from;
  final String datetime;
  final int to;
  final String msg;
  final String img;
  final bool isMe;
  final bool isupload;
  MessageBox({Key key,this.msg,this.from,this.isMe,this.to,this.datetime,this.img, this.isupload}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
           child: Column(
                       children: [
                       isMe?
                       Align(
                          alignment: AlignmentDirectional.topEnd,
                          child:msg==''? Padding(
                            padding: const EdgeInsets.only(left: 10,right: 10),
                            child:!isupload?Container(
                              decoration: BoxDecoration(
                                borderRadius:BorderRadiusDirectional.only(
                                  bottomStart:Radius.circular(10),
                                  topEnd:Radius.circular(10),
                                  topStart:Radius.circular(10),
                                ),
                                color:isMe?Color(0xFFf0932b) : Color(0xFFf1f2f6)),
                              padding: EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 5
                              ),
                              child:Padding(
                                padding: const EdgeInsets.all(8.0),
                                child:Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                   mainAxisAlignment: MainAxisAlignment.start,
                                  children: [

                                    Image.network('${msg}',width: 290),
                                    SizedBox(height: 5,),
                                    Text("${datetime}",style: TextStyle(color:Color(0xFFf1f2f6),fontSize: 11),
                                    ),],
                                ),
                              )
                              ):CircularProgressIndicator()):Padding(
                             padding: const EdgeInsets.only(left: 10,right: 10),
                            child:Container(
                              decoration: BoxDecoration(
                                borderRadius:BorderRadiusDirectional.only(
                                  bottomStart:Radius.circular(10) ,
                                  topEnd:Radius.circular(10),
                                  topStart:Radius.circular(10) ,
                                ),
                                color:isMe? Color(0xFFf0932b) : Color(0xFFf1f2f6)),
                              padding: EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 5
                              ),
                              child:Padding(
                                padding: const EdgeInsets.all(8.0),
                                child:Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                   mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text('${msg}',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 16)),
                                    SizedBox(height: 5,),
                                    Text("${datetime}",style: TextStyle(color:Color(0xFFf1f2f6),fontSize: 11),
                                    ),],
                                ),
                              )
                              )),
                    ):
                       Align(
                          alignment: AlignmentDirectional.topStart,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10,right: 0),
                            child:Container(
                              decoration: BoxDecoration(
                                borderRadius:BorderRadiusDirectional.only(
                                  bottomStart:Radius.circular(0) ,
                                  topEnd:Radius.circular(10),
                                  topStart:Radius.circular(10),
                                  bottomEnd:Radius.circular(10)
                                ),
                                color:isMe ? Color(0xFFdff9fb): Color(0xFFf1f2f6),
                              ),
                              padding: EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 5
                              ),
                              child:Padding(
                                padding: const EdgeInsets.all(8.0),
                                child:Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                   mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                     Text("${msg}",style: TextStyle(color:  Color(0xFF173242))
                                    ),
                                    SizedBox(height: 5,),
                                    Text("${datetime}",style: TextStyle(color:  Color(0xFF999b9f),fontSize: 11,fontWeight: FontWeight.w600),

                                    ),
                                  ],
                                ),
                              )
                              )
                          ),
                    ),

                  ],
                     ),
    );
  }
}