import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sahariano_travel/drawer/draweitem_menu.dart';
import 'package:sahariano_travel/shared/network/remote/local/cache_helper.dart';
 String language = Cachehelper.getData(key: "langugeCode");
class MenuItems{
static var home = language != 'ar' ? MenuItem('Home', Icons.home):MenuItem('الصفحة الرئيسية', Icons.home);
static var profile =  language != 'ar' ? MenuItem('Profile', Icons.person):MenuItem('الملف الشخصي', Icons.person);
static var  shoppings = language != 'ar'? MenuItem('Services', Icons.settings):MenuItem('التسوق', Icons.shopping_cart);
static var  krina = language != 'ar'? MenuItem('Kerina', FontAwesomeIcons.idCard):MenuItem('كيرينا', FontAwesomeIcons.idCard);
static var notification = language != 'ar'?MenuItem('Notifications', Icons.notifications):MenuItem('إشعارات', Icons.notifications);
static var contactus =language != 'ar'? MenuItem('Contact us', Icons.phone):MenuItem('اتصل بنا', Icons.phone);
static var shareapp =language != 'ar'? MenuItem('Share app', Icons.share):MenuItem('مشاركة تطبيق', Icons.share);


static final List<MenuItem> all =[
  home,
  profile,
  shoppings,
  krina,
  notification,
  contactus,
  shareapp,

];
}

class MenuPage extends StatelessWidget {
  final MenuItem currentItem;
  final ValueChanged<MenuItem>onSelectedItem;
   MenuPage({ Key key,this.currentItem,this.onSelectedItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFFF28300),
        // Color(0xFFF28300),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
             
              ...MenuItems.all.map((buildMenuItem)).toList()
            ],
          ),
        ),
      ),
    );
    
  }
  Widget buildMenuItem(MenuItem item)=>ListTileTheme(
    selectedColor: Color(0xFFf37021),
    child: Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color:currentItem == item?Colors.white:Color(0xFFF28300),),
      
      child: ListTile(
        //  selectedTileColor: Colors.blue[200],
        iconColor:  Color(0xFFf37021),
        selected: currentItem == item,
        minLeadingWidth: 15,
        leading: Icon(item.icon,color:currentItem == item? Color(0xFFed6905): Color(0xFFf0ebe4),),
        title: Text(item.title,style: TextStyle(color:currentItem == item ? Color(0xFFed6905):Color(0xFFf0ebe4),fontWeight: FontWeight.bold,fontSize: 17,),),
        onTap: ()=>onSelectedItem(item),
      ),
    ),
  );
}