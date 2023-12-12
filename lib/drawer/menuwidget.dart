import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

class MenuWidget extends StatefulWidget {
  final Color color;
  const MenuWidget({ Key key, this.color }) : super(key: key);

  @override
  State<MenuWidget> createState() => _MenuWidgetState();
}

class _MenuWidgetState extends State<MenuWidget> {
  @override
  Widget build(BuildContext context){
    return GestureDetector(
      onTap: (){
        setState(() {
         ZoomDrawer.of(context).toggle();
        });
      },
      child: Icon(Icons.menu,color: widget.color));
  }
}
