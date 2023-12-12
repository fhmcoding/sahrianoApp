import 'package:flutter/material.dart';
import 'package:sahariano_travel/drawer/menuwidget.dart';

class Vols extends StatefulWidget {
  const Vols({ Key key }) : super(key: key);

  @override
  _VolsState createState() => _VolsState();
}

class _VolsState extends State<Vols> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
     appBar: AppBar(
 leading:MenuWidget(),
     ),
    );
  }
}