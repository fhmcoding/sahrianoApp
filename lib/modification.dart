import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sahariano_travel/shared/components/constants.dart';
import 'package:sahariano_travel/shared/network/remote/local/cache_helper.dart';
import 'drawer/menuwidget.dart';
import 'layout/cubit/cubit.dart';
import 'layout/cubit/states.dart';
import 'package:lottie/lottie.dart';

class Modification extends StatefulWidget {
    final int currentIndex;
  const Modification({ Key key, this.currentIndex }) : super(key: key);

  @override
  _ModificationState createState() => _ModificationState();
}

class _ModificationState extends State<Modification>with TickerProviderStateMixin{


  AnimationController controller;
  var fromkey = GlobalKey<FormState>();
   bool isupload = false;
   bool issend = true;
   String image;
   File imageFile;
   UploadTask uploadTask;
   String phone = Cachehelper.getData(key: "phone");

   List<XFile>imageFileList=[];
   final ImagePicker _picker = ImagePicker();  
  void selectImages()async{
    final List<XFile> selectedImages = await _picker.pickMultiImage();
    if (selectedImages.isNotEmpty) {
      imageFileList.addAll(selectedImages);
      setState(() {});
    }
  }
String img64;
Uint8List bytes;
List<String>images=[];


// uploadImage(){
//  firebase_storage.FirebaseStorage.instance.ref().child("images/${Uri.file(imageFile.path).pathSegments.last}").putFile(File(imageFile.path)).then((value) {
//    value.ref.getDownloadURL().then((value) {
//     setState(() {
//        isupload = false;
//     });
//     image = value;
//    });
//  });
// }

 var textController = TextEditingController();
  var other = TextEditingController();
  String dropdownvalue = 'Select your request';
  var items = [
    "Ticket Confirmation",
    "Ticket modification",
    "Ticket cancellation",
    "Confirm hotel",
    "Others",
  ];
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>AppCubit(),
      child:  BlocConsumer<AppCubit,AppStates>(
        listener: (context,state){
          if (state is ModificationPostSuccessState) {
            if (state.statusCode==200) {
              controller = AnimationController(vsync: this,duration: Duration(seconds:1));
              controller.addStatusListener((status)async { 
              if (status==AnimationStatus.completed) {
                Navigator.pop(context);
                controller.reset();
              }
              });
                                                         showDialog(
                                                         barrierDismissible: false,
                                                         context: context, builder: (context){
                                                        return Dialog(
                                                            child: Container(
                                                              width: double.infinity,
                                                              decoration: BoxDecoration(
                                                                borderRadius: BorderRadius.circular(5),
                                                                color: Colors.white,
                                                              ),
                                                              height: 200,
                                                              child: Column(
                                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                children: [
                                                                  Lottie.asset('assets/done.json',
                                                                  height: 130,
                                                                  width: 130,
                                                                  repeat: false,
                                                                  controller: controller,
                                                                  onLoaded:(LottieComposition){
                                                                   controller.forward();
                                                                   setState(() {
                                                                    other.clear();
                                                                    textController.clear();
                                                                    imageFileList.clear();
                                                                    dropdownvalue = 'Select your demande';
                                                                   });
                                                                  }),
                                                                Text('Your demande has been successfully',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.green),)
                                                                
                                                                
                                                                ],
                                                              ),
                                                            ),
                                                          );
                        });
            }
          }
        },
        builder: (context,state){
          var cubit = AppCubit.get(context);
          return Scaffold(
            bottomNavigationBar: Container(
                     child: Row(
                     crossAxisAlignment: CrossAxisAlignment.center,
                     mainAxisAlignment: MainAxisAlignment.end,
                     children: [
                       TextButton(
                         onPressed: (){
                          selectImages();
                         },
                         child:CircleAvatar(
                           backgroundColor:appColor,
                         child:  Icon(FontAwesomeIcons.image,color: Colors.white,)
                       )),
                      // TextButton(
                      //    onPressed: (){
                          
                          
                      //    }, 
                      //    child:CircleAvatar(
                      //      backgroundColor:appColor,
                      //    child:  Icon(FontAwesomeIcons.microphone,color: Colors.white,)
                      //  )),
                        TextButton(
                         onPressed: !isupload?(){
                       
                          if (fromkey.currentState.validate()) {
                             if (dropdownvalue != 'Select your demande') {
                               
                              setState(() {
                          issend = false;
                        });
                        
                          imageFileList.forEach((element){
                          bytes =File(element.path).readAsBytesSync();
                          img64 = base64Encode(bytes);
                          images.add(img64);
                         });

                          cubit.ModificationPost(
                          issue:dropdownvalue!='Others'?dropdownvalue:other.text,
                          description:textController.text,
                          images:images,
                          tel: phone.replaceAll("+", "")
                        );
                         FocusScope.of(context).unfocus();
                          }                        
                          }
                         }:(){
                            
                         }, 
                         child:CircleAvatar(
                           backgroundColor:state is! ModificationPostLoadingState?Colors.green:Colors.grey,
                         child:state is! ModificationPostLoadingState?Icon(
                        Icons.send,
                        size: 22,
                        color: Colors.white,
                                ):Padding(
                           padding: const EdgeInsets.all(8.0),
                           child: CircularProgressIndicator(color: Colors.white),
                         ),
                       )),
                       
                     ],
                     ),
                   ),
            backgroundColor: Colors.white,
          appBar: AppBar(
             backgroundColor: appColor,
            elevation: 0,
            centerTitle: true,
            title: Text('Demande de services',style: TextStyle(color: Colors.white)),
            leading: MenuWidget(color: Colors.white),
          ),
          body: SingleChildScrollView(
            child: Padding(
               padding: const EdgeInsets.only(left: 20,right: 20,top: 20),
              child: Form(
                key: fromkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                        height: 58,
                        width: double.infinity,
                        decoration: BoxDecoration(
                           boxShadow: [
                           BoxShadow(
                      blurRadius: 5,
                      color: appColor,
                      offset: Offset(1, 1),
                      spreadRadius: 0)
                          ],
                          border: Border.all(
                            color: appColor,
                            width: 2.0
                          ),
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white,
                        ),
                        child: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: DropdownButton(
                                onChanged: (String newValue) {
                                setState(() {
                                  dropdownvalue = newValue;
                                });
                              },
                                  
                                icon: Icon(
                                  Icons.keyboard_arrow_down,
                                  color: Color(0xFF7B919D),
                                ),
                                underline: SizedBox(),
                                isExpanded: true,
                                hint: Padding(
                                  padding: const EdgeInsets.only(right: 30, top: 0),
                                  child: Text(
                                    '${dropdownvalue}',style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                           color: Color(0xFF7B919D),
                        )
                                  ),
                                ),
                                items: items.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items,style: TextStyle(
                          fontSize: 14,
                          
                         
                        )),
                      );
                    }).toList(),
                                    
                              ),
                            )
                          ],
                        )
                        ),
                        SizedBox(height: 10,),
                      dropdownvalue=='Others' ? Container(
                        height: 60,
                        decoration: BoxDecoration(
                           boxShadow: [
                           BoxShadow(
                      blurRadius: 5,
                      color: appColor,
                      offset: Offset(1, 1),
                      spreadRadius: 0)
                          ],
                          border: Border.all(
                            color: appColor,
                            width: 2
                          ),
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white,
                        ),
                        child: TextFormField(   
                          controller:other,
                    validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'demande is not to be empty';
                                    }
                                    return null;
                                  },
                  decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(
                  width: 0,
                  color: Color(0xFFf37021),
                ),
                          ),
                          errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(
                  width:0,
                  color: Color(0xFFf37021),
                ),
                
                
                
                ),
                enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(
                  width:0,
                  color: Color(0xFFf37021),
                ),
                ),
                hintText: 'Tell us what this your demande',
                hintStyle: TextStyle(
                  color: Color(0xFF7B919D),
                  fontSize: 13
                )),
                ),
                      ): SizedBox(height: 0,),
                 SizedBox(height: 10,),
                    Container(
                      color: Colors.white,
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: 165,
                            width: double.infinity,
                            decoration: BoxDecoration(
                           boxShadow: [
                           BoxShadow(
                      blurRadius: 5,
                      color: appColor,
                      offset: Offset(1, 1),
                      spreadRadius: 0)
                          ],
                          border: Border.all(
                            color: appColor,
                            width: 2
                          ),
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white,
                        ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10,right: 10),
                              child: Column(
                                children: [
                                  Expanded(
                                  child: TextFormField(
                                    
                                    controller: textController,
                                     validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'request is not to be empty';
                                }
                                return null;
                                  },
                                    maxLines: null,
                                    expands: true,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Please Enter your request here, well detailed: Names, dates, document numbers .....',hintMaxLines:4,hintStyle: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: Color(0xFF7B919D),),)
                                  ),
                                  ),
                                ],
                              ),
                            )
                          ),
                           SizedBox(height: 10,),
                          
                      imageFileList.length>0? GridView.builder(
                           physics: NeverScrollableScrollPhysics(),
                           shrinkWrap: true,
                           itemCount:imageFileList.length,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                          itemBuilder: (context,index){
                            return  Stack(
                                 alignment:  AlignmentDirectional.topEnd,
                                 children: [
                                 Padding(
                                   padding: const EdgeInsets.all(8.0),
                                   child: GestureDetector(
                                     onTap: (){
                                      showModalBottomSheet(context: context, builder: (context){
                                         return Container(
                                         decoration: BoxDecoration(
                                           borderRadius: BorderRadius.circular(5),
                                           color: Colors.grey[200],
                                         ),
                                       
                                        
                                        child: Image.file(File(imageFileList[index].path),fit: BoxFit.cover),
                                                                );
                                      });
                                     },
                                     child: Container(
                                         decoration: BoxDecoration(
                                           borderRadius: BorderRadius.circular(5),
                                           color: Colors.grey[200],
                                         ),
                                        height: 200,
                                        width: 135,
                                        child: ClipRRect(
                                           borderRadius: BorderRadius.circular(5),
                                          child: Image.file(File(imageFileList[index].path),fit: BoxFit.cover,)),
                                                                ),
                                   ),
                                 ),
                           Padding(
                             padding: const EdgeInsets.all(10.0),
                             child: CircleAvatar(backgroundColor: Colors.white,child: GestureDetector(
                               onTap: (){
                                 setState(() {
                                 imageFileList.removeAt(index);
                                 });
                               },
                               child:Icon(Icons.close,color: appColor)),maxRadius: 15),
                           ),
                                 ],
                               );
                          }
                          ):SizedBox(height: 0),
                         
                         ],
                      ),
                    ),
                    SizedBox(height: 20,)
                  ],
                ),
              ),
            ),
          )
        );
        },
         
      ),
    );
  }
}
