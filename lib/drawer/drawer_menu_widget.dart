import 'package:flutter/material.dart';

class DrawerMenuWidget extends StatelessWidget {
  final VoidCallback onClicked;
  final IconData icon;
  const DrawerMenuWidget({ Key key ,this.onClicked,this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(icon,color: Colors.black,),
      onPressed: onClicked,
    );
  }
}