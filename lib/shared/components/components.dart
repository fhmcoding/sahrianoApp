import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:sahariano_travel/Flight_app/widget/baggage.dart';
import 'package:sahariano_travel/modules/pages.dart/notification/notification_web.dart';
import 'package:sahariano_travel/shared/components/constants.dart';
import 'package:shimmer/shimmer.dart';
import 'package:jiffy/jiffy.dart';

void printFullText(String text) {
  final pattern = RegExp('.{1,800}');
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

void navigateTo(context, Widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => Widget));

Widget buildTitel({String title, IconData iconData, double fontSize}) {
  return Padding(
    padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
    child: Row(
      children: [
        Icon(iconData, color: Color(0xFF38444a), size: 23),
        SizedBox(
          width: 10,
        ),
        Text(
          title,
          style: TextStyle(
              color: Color(0xFF38444a),
              fontSize: fontSize,
              fontWeight: FontWeight.w600),
        )
      ],
    ),
  );
}

buildhint({String hintText}) {
  return Row(
    children: [
      Text('${hintText}: ',
          style: TextStyle(
              fontSize: 13,
              color: Color.fromARGB(234, 49, 45, 43),
              fontWeight: FontWeight.bold)),
      Text('*',
          style: TextStyle(
              fontSize: 13, color: Colors.red, fontWeight: FontWeight.bold)),
    ],
  );
}

Widget buildPersons(
    {String title,
    String subtitle,
    Function ontapplus,
    Function ontapmins,
    int qty,
    bool}) {
  return Padding(
    padding: const EdgeInsets.only(left: 20, right: 20, top: 0),
    child: Row(
      children: [
        Text(
          title,
          style: TextStyle(
              color: Color(0xFF38444a),
              fontSize: 16,
              fontWeight: FontWeight.w600),
        ),
        SizedBox(
          width: 5,
        ),
        Text(
          subtitle,
          style: TextStyle(
              color: Colors.grey[350],
              fontSize: 12,
              fontWeight: FontWeight.w600),
        ),
        Spacer(),
        Container(
          decoration: BoxDecoration(
              color: Color(0xFFfdf7f2),
              borderRadius: BorderRadius.circular(10)),
          height: 40,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 16),
                child: Container(
                  height: 25,
                  width: 25,
                  decoration: BoxDecoration(
                      color: bool ? Color(0xFFed6905) : Colors.grey,
                      borderRadius: BorderRadius.circular(5)),
                  child: GestureDetector(
                      onTap: ontapplus,
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 17,
                      )),
                ),
              ),
              Text(
                qty.toString(),
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    color: Color(0xFF38444a)),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10, left: 16),
                child: Container(
                  height: 25,
                  width: 25,
                  decoration: BoxDecoration(
                      color: Color(0xFFed6905),
                      borderRadius: BorderRadius.circular(5)),
                  child: GestureDetector(
                      onTap: ontapmins,
                      child: Icon(Icons.remove, color: Colors.white, size: 17)),
                ),
              )
            ],
          ),
        )
      ],
    ),
  );
}

Widget buildStops(
    {dynamic value, String text, Function onChanged, dynamic group}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Radio(
          activeColor: Color(0xFFF28300),
          value: value,
          groupValue: group,
          onChanged: onChanged),
      Text(
        text,
        style: TextStyle(
            color: Color(0xFF38444a),
            fontSize: 13,
            fontWeight: FontWeight.w600),
      ),
    ],
  );
}

Widget buildCabinClass({List<Widget> cabins}) {
  return Padding(
    padding: const EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 10),
    child: Container(
      width: double.infinity,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              blurRadius: 5,
              color: appColor,
              offset: Offset(1, 1),
              spreadRadius: 0)
        ],
        border: Border.all(color: appColor, width: 2.5),
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.white),
        width: double.infinity,
        child: GridView.count(
          crossAxisCount: 2,
          physics: NeverScrollableScrollPhysics(),
          mainAxisSpacing: 0,
          crossAxisSpacing: 0,
          childAspectRatio: 5 / 1.5,
          shrinkWrap: true,
          children: cabins,
        ),
      ),
    ),
  );
}

Widget buildButton({
  String text,
  Function ontap,
}) {
  return Container(
    height: 85,
    width: double.infinity,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(0),
      boxShadow: [
        BoxShadow(
            blurRadius: 3,
            color: Colors.grey[350],
            offset: Offset(3, 4),
            spreadRadius: 7)
      ],
    ),
    child: Padding(
      padding: const EdgeInsets.only(left: 25, right: 25, top: 15, bottom: 15),
      child: GestureDetector(
        onTap: ontap,
        child: Container(
          height: 55,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: appColor),
          width: double.infinity,
          child: Center(
              child: Text(
            text,
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          )),
        ),
      ),
    ),
  );
}

Widget buildButtonConditon({String text}) {
  return Container(
    height: 85,
    width: double.infinity,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(0),
      boxShadow: [
        BoxShadow(
            blurRadius: 3,
            color: Colors.grey[350],
            offset: Offset(3, 4),
            spreadRadius: 7)
      ],
    ),
    child: Padding(
      padding: const EdgeInsets.only(left: 25, right: 25, top: 15, bottom: 15),
      child: Container(
        height: 55,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Color(0xFFF28300)),
        width: double.infinity,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(color: Colors.white),
          ],
        ),
      ),
    ),
  );
}

Widget Oneway(context,
    {Function ontapdepart,
    Function ontaprutur,
    String hintdepart,
    String hintrutur,
    Function onconvert,
    Function onchange,
    String departdate}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 20, top: 5, right: 20, bottom: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildChooseWay(context, ontapdepart, hintdepart, ontaprutur,
                hintrutur, onconvert),
            SizedBox(height: 15),
            GestureDetector(
              onTap: onchange,
              child: Container(
                height: 60,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 5,
                        color: appColor,
                        offset: Offset(1, 1),
                        spreadRadius: 0)
                  ],
                  border: Border.all(color: appColor, width: 2.3),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 20, bottom: 0, right: 20),
                  child: Row(
                    children: [
                      Icon(
                        Icons.calendar_today,
                        color: Color.fromARGB(255, 84, 90, 97),
                        size: 20,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      departdate != null
                          ? Text(
                              '${departdate}',
                              style: TextStyle(fontSize: 17),
                            )
                          : Text('Select Date')
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget buildChooseWay(context, Function ontapdepart, String hintdepart,
    Function ontaprutur, String hintrutur, Function onconvert) {
  return Container(
    height: 60,
    width: double.infinity,
    decoration: BoxDecoration(
      boxShadow: [
        BoxShadow(
            blurRadius: 5,
            color: appColor,
            offset: Offset(1, 1),
            spreadRadius: 0)
      ],
      borderRadius: BorderRadius.circular(10),
      color: Colors.white,
      border: Border.all(color: appColor, width: 1.9),
    ),
    child: Stack(
      alignment: Alignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Container(
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(7),
                    bottomRight: Radius.circular(0),
                    topLeft: Radius.circular(7),
                    topRight: Radius.circular(0),
                  ),
                ),
                child: Row(
                  children: [
                    Row(
                      children: [
                        Transform.rotate(
                          angle: 1,
                          child: Icon(
                            Icons.airplanemode_active,
                            color: Color.fromARGB(255, 84, 90, 97),
                            size: 24,
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        GestureDetector(
                            onTap: ontapdepart,
                            child: Text(
                              hintdepart == null ? 'Choose Depart' : hintdepart,
                            )),
                      ],
                    ),
                  ],
                ),
              ),
              Spacer(),
              SizedBox(
                width: 5,
              ),
              Container(
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(5),
                    bottomRight: Radius.circular(0),
                    topLeft: Radius.circular(7),
                    topRight: Radius.circular(0),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Row(
                        children: [
                          Transform.rotate(
                          angle: 2,
                          child: Icon(
                            Icons.airplanemode_active,
                            color: Color.fromARGB(255, 84, 90, 97),
                            size: 24,
                          ),
                        ),
                          SizedBox(
                            width: 5,
                          ),
                          GestureDetector(
                              onTap: ontaprutur,
                              child: Text(
                                hintrutur == null ? 'Choose Arival' : hintrutur,
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 60,
          width: 2,
          color: appColor,
        ),
        ClipOval(
          child: Container(
              height: 40,
              width: 40,
              color: appColor,
              child: GestureDetector(
                onTap: onconvert,
                child: Icon(
                  Icons.connecting_airports_rounded,
                  color: Colors.white,
                  size: 22,
                ),
              )),
        ),
      ],
    ),
  );
}

Widget buildRound_trip(context,
    {Function ontapdepart,
    Function ontaprutur,
    String hintdepart,
    String hintrutur,
    Function onconvert,
    Function onchangeDateArival,
    Function onchangeDateDepart,
    String departdate,
    String arivaldate}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Padding(
        padding:
            const EdgeInsets.only(left: 20, top: 15, right: 20, bottom: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildChooseWay(context, ontapdepart, hintdepart, ontaprutur,
                hintrutur, onconvert),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 60,
              width: double.infinity,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      blurRadius: 5,
                      color: appColor,
                      offset: Offset(1, 1),
                      spreadRadius: 0)
                ],
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                border: Border.all(color: appColor, width: 1.9),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Container(
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(7),
                              bottomRight: Radius.circular(0),
                              topLeft: Radius.circular(7),
                              topRight: Radius.circular(0),
                            ),
                          ),
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: onchangeDateDepart,
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 10,
                                    ),
                                    departdate != null
                                        ? Text(
                                            '${departdate}',
                                            style: TextStyle(fontSize: 17),
                                          )
                                        : Text('Select Date')
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Spacer(),
                        SizedBox(
                          width: 5,
                        ),
                        Container(
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(5),
                              bottomRight: Radius.circular(0),
                              topLeft: Radius.circular(7),
                              topRight: Radius.circular(0),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                GestureDetector(
                                  onTap: onchangeDateArival,
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 10,
                                      ),
                                      arivaldate != null
                                          ? Text(
                                              '${arivaldate}',
                                              style: TextStyle(fontSize: 17),
                                            )
                                          : Text('Select Date')
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 60,
                    width: 2,
                    color: appColor,
                  ),
                  ClipOval(
                    child: Container(
                        height: 40,
                        width: 40,
                        color: appColor,
                        child: GestureDetector(
                          onTap: onconvert,
                          child: Icon(
                            Icons.calendar_month,
                            color: Colors.white,
                            size: 22,
                          ),
                        )),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ),
  );
}

Widget buildAppBar({String text, context, Function ontap}) {
  return AppBar(
    leading: GestureDetector(
        child: Icon(
          Icons.arrow_back,
          color: Colors.black,
        ),
        onTap: () {
          Navigator.pop(context);
        }),
    backgroundColor: Colors.white,
    centerTitle: true,
    title: Text(
      text,
      style: TextStyle(color: Color(0xFFf37021), fontSize: 22),
    ),
    elevation: 0,
  );
}


  Widget buildTextFiled(
    {String hintText,
    TextEditingController controller,
    Function ontap,
    String valid,
    Function onSaved,
    TextInputType keyboardType}) {
  return TextFormField(
    keyboardType: keyboardType,
    onSaved: onSaved,
    validator: (value) {
      if (value == null || value.isEmpty) {
        return '${valid} is not to be empty';
      }
      return null;
    },
    onTap: ontap,
    controller: controller,
    decoration: InputDecoration(
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(
              width: 1,
              color: Colors.red,
            )),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(
              width: 2,
              color: Color(0xFFf37021),
            )),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(
              width: 2,
              color: Color(0xFFf37021),
            )),
        hintText: '${hintText} listed in travel document',
        hintStyle: TextStyle(color: Color(0xFF7B919D), fontSize: 14)),
  );
}

Widget buildticketCard(
    {String departureAirport,
    arrivalAirport,
    departureDateTime,
    arrivalDateTime,
    duration,
    datedeparture,
    flightNumber,
    DateArival,
    arrivalAirportTerminal,
    departureAirportTerminal,
    int stops,
    logo,
    cabin,
    dynamic bagageCount,
    String weightUnit,
    int weight,
    String pnr,
    String operaitedby}) {
  return
    Column(
    children: [
      Container(
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  blurRadius: 0,
                  color: Colors.grey[350],
                  offset: Offset(0, 0),
                  spreadRadius: 0),
            ],
            borderRadius: BorderRadius.circular(5)),
        padding: EdgeInsets.only(left: 10, right: 10, top: 10),
        child: Column(
          children: <Widget>[
            // SizedBox(height: 20,),
            Row(
              children: <Widget>[
                Text(
                  "${departureAirport} ${departureDateTime}",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                SizedBox(
                  width: 14,
                ),
                SizedBox(
                  height: 6,
                  width: 6,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Stack(
                      children: <Widget>[
                        SizedBox(
                          height: 24,
                          child: LayoutBuilder(
                            builder: (context, constraints) {
                              return Flex(
                                children: List.generate(
                                    (constraints.constrainWidth() / 6).floor(),
                                    (index) => SizedBox(
                                          height: 1,
                                          width: 3,
                                          child: DecoratedBox(
                                            decoration: BoxDecoration(
                                                color: Colors.grey.shade300),
                                          ),
                                        )),
                                direction: Axis.horizontal,
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                              );
                            },
                          ),
                        ),
                        Center(
                            child: Transform.rotate(
                          angle: 1.5,
                          child: Icon(
                            Icons.local_airport,
                            color: Color(0xFFF28300),
                            size: 24,
                          ),
                        ))
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 6,
                  width: 6,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                SizedBox(
                  width: 14,
                ),
                Row(
                  children: [
                    Text(
                      "${arrivalAirport} ${arrivalDateTime}",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    SizedBox(
                      width: 25,
                    ),
                    Container(
                        height: 26,
                        width: 26,
                        child: Image.network(
                          'https://s1.travix.com/global/assets/airlineLogos/${logo}_mini.png',
                          height: 23,
                        )),
                  ],
                )
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SizedBox(
                    width: 90,
                    child: Text(
                      "${datedeparture}",
                      style: TextStyle(
                          fontSize: 11,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold),
                    )),
                Text(
                  duration != null ? "${duration}" : "${pnr}",
                  style: TextStyle(
                      fontSize: duration != null ? 9 : 13,
                      fontWeight: FontWeight.bold,
                      color: duration != null
                          ? Color.fromARGB(255, 32, 26, 24)
                          : appColor),
                ),
                Row(
                  children: [
                    //  SizedBox(width: 10,),
                    SizedBox(
                        width: 90,
                        child: Text(
                          "${DateArival}",
                          textAlign: TextAlign.end,
                          style: TextStyle(
                              fontSize: 10,
                              color: Colors.grey,
                              fontWeight: FontWeight.bold),
                        )),
                    SizedBox(
                      width: 23,
                    ),
                    Text(
                      '${logo}${flightNumber}',
                      style:
                          TextStyle(fontSize: 7, fontWeight: FontWeight.bold),
                    ),
                    
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 13,
            ),
            Row(

                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    departureAirportTerminal != null
                        ? "Terminal ${departureAirportTerminal}"
                        : "Terminal 0",
                    style: TextStyle(
                      fontSize: 10,
                      color: appColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment:CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          bagageCount != null
                              ? bagageCount!=0?Icon(FontAwesomeIcons.suitcase,
                                  size: 10, color: appColor)
                              : SizedBox(height: 0):SizedBox(height: 0),
                          bagageCount != null
                              ? SizedBox(
                                  width:bagageCount==0?30:5,
                                )
                              : SizedBox(
                                  width: 0,
                                ),

                               bagageCount != null
                                  ? Row(
                                 mainAxisAlignment: MainAxisAlignment.center,
                                 crossAxisAlignment:CrossAxisAlignment.center,
                                    children: [
                                      bagageCount!=0? Text(
                                          "${bagageCount}",
                                          style: TextStyle(
                                            fontSize: 9,
                                            color: appColor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ):SizedBox(height: 0),
                                    ],
                                  )
                                  : weight!=null?Row(
                                       mainAxisAlignment: MainAxisAlignment.center,
                                       crossAxisAlignment:CrossAxisAlignment.center,
                                      children: [
                                        Icon(FontAwesomeIcons.suitcase,
                                            size: 10, color: appColor),
                                        SizedBox(width: 3,),
                                        Text(
                                          "${weight}",
                                          style: TextStyle(
                                            fontSize: 9,
                                            color: appColor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 2,
                                        ),
                                        weightUnit!=null? Text(
                                          "${weightUnit}",
                                          style: TextStyle(
                                            fontSize: 9,
                                            color: appColor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ):SizedBox(height:0),
                                      ],
                                    ):SizedBox(height: 0,)

                        ],
                      ),
                      SizedBox(width: 5,),
                      // bagageCount != null
                      //     ? SizedBox(
                      //         width: 10,
                      //       )
                      //     : SizedBox(
                      //         width: 0,
                      //       ),
                      Text(
                        "stop ${stops}",
                        style: TextStyle(
                          fontSize: 9,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        arrivalAirportTerminal != null
                            ? "Terminal ${arrivalAirportTerminal}"
                            : "Terminal 0",
                        style: TextStyle(
                          fontSize: 9,
                          color: appColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Text(
                        "${cabin}",
                        style: TextStyle(
                          fontSize: 7,
                          color: appColor,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        width: 0,
                      ),
                    ],
                  ),
                ]),
            SizedBox(
              height: 8,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  operaitedby!=null?'Operated By ${operaitedby}':"Operated By ${logo}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 0,
            )
          ],
        ),
      ),

    ],
  );
}

Widget buildCategorieModel({String ImageCat, String NameCat}) {
  return Container(
    color: Color(0xFFf8f8f8),
    width: 90,
    child: Column(
      children: [
        Container(
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
                blurRadius: 2.0,
                color: Color.fromARGB(255, 238, 133, 196),
                offset: Offset(1.0, 2),
                spreadRadius: 1)
          ], borderRadius: BorderRadius.circular(7), color: Colors.white),
          height: 55,
          width: 90,
          child: ClipRRect(
              borderRadius: BorderRadius.circular(7),
              child: Image.network(
                '${ImageCat}',
                fit: BoxFit.fill,
              )),
        ),
        SizedBox(
          height: 7,
        ),
        Text(
          '${NameCat}',
          textAlign: TextAlign.center,
          maxLines: 2,
          style: TextStyle(
              overflow: TextOverflow.ellipsis,
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Colors.black),
        ),
      ],
    ),
  );
}

Widget buildConditionModel() {
  return ListView.separated(
      separatorBuilder: (context, index) {
        return SizedBox(
          width: 0,
        );
      },
      physics: BouncingScrollPhysics(),
      itemCount: 3,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Container(
            color: Color(0xFFf8f8f8),
            width: 90,
            child: Column(
              children: [
                Shimmer.fromColors(
                  baseColor: Colors.grey[300],
                  highlightColor: Colors.grey[100],
                  period: Duration(seconds: 2),
                  child: Container(
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 3,
                              color: Colors.grey.shade300,
                              offset: Offset(2, 2),
                              spreadRadius: 0)
                        ],
                        borderRadius: BorderRadius.circular(7),
                        color: Colors.grey[100]),
                    height: 55,
                    width: 90,
                  ),
                ),
                SizedBox(
                  height: 7,
                ),
                Shimmer.fromColors(
                  baseColor: Colors.grey[300],
                  highlightColor: Colors.grey[100],
                  period: Duration(seconds: 2),
                  child: Container(
                    height: 10,
                    width: 90,
                    color: Colors.grey[100],
                    child: Text(
                      'hhhdhhdd',
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: appColor),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      });
}

Widget buildDirction({String departureAirport, String arrivalAirport}) {
  return Padding(
    padding: const EdgeInsets.only(left: 10, right: 10, bottom: 5, top: 10),
    child: Row(
      children: [
        Text('${departureAirport}',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600)),
        SizedBox(
          width: 5,
        ),
        Transform.rotate(
            angle: 1, child: Icon(Icons.airplanemode_active, color: appColor)),
        SizedBox(
          width: 5,
        ),
        Text('${arrivalAirport}',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600))
      ],
    ),
  );
}

Widget buildAditionalBag({List bags}) {
  return ListView.builder(
      shrinkWrap: true,
      itemCount: bags.length,
      itemBuilder: (context, index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(left: 5, right: 5, bottom: 5, top: 0),
              child: Container(
                height: 40,
                margin: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: appColor, width: 1.4)),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 2),
                        child: Icon(FontAwesomeIcons.suitcase,
                            size: 13, color: appColor),
                      ),
                      Text.rich(TextSpan(children: [
                        TextSpan(
                            text: '  ${bags[index]['quantity']}x',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 13)),
                        TextSpan(
                          text: '  Checked Baggage',
                        ),
                      ])),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      });
}

Widget buildShowPrice({departPrice, returnPrice, Function onTap}) {
  return Padding(
    padding: const EdgeInsets.only(top: 13, right: 8, left: 8, bottom: 8),
    child: Container(
        height: 80,
        width: double.infinity,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                blurRadius: 3,
                color: Colors.grey[350],
                offset: Offset(0, 0),
                spreadRadius: 2)
          ],
          borderRadius: BorderRadius.circular(5),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 17),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    ' ${departPrice + returnPrice} MAD',
                    style: TextStyle(
                        color: Colors.orange,
                        fontWeight: FontWeight.w600,
                        fontSize: 20),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Prix aller-retour',
                    style: TextStyle(color: Colors.grey, fontSize: 15),
                  )
                ],
              ),
              GestureDetector(
                onTap: onTap,
                child: Container(
                  height: 45,
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Color(0xFFF28300),
                  ),
                  child: Center(
                      child: Text(
                    'Booking',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 16),
                  )),
                ),
              ),
            ],
          ),
        )),
  );
}

Widget buildBaggage(
    {int optionId,
    flightResult,
    departureAirport,
    arrivalAirport,
    traveler,
    includedCheckedBags,
    weight,
    weightUnit,
    baggage}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
       baggage!=null?baggage['options'].length>0?
       traveler['PassengerTypeCode'] != 'INF'? Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text('${departureAirport}',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w600)),
                  SizedBox(
                    width: 5,
                  ),
                  Transform.rotate(
                      angle: 1,
                      child: Icon(Icons.airplanemode_active, color: appColor)),
                  SizedBox(
                    width: 5,
                  ),
                  Text('${arrivalAirport}',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w600))
                ],
              ),
            )
          : SizedBox(height: 0): SizedBox(height: 0):SizedBox(height: 0),
            Column(
              children: [
                      baggage!=null?baggage['options'].length>0?Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [

                             traveler['PassengerTypeCode'] != 'INF'? SizedBox(height: 10):SizedBox(height: 0),
                              traveler['PassengerTypeCode'] != 'INF'
                                  ? Text(
                                      'Additional baggage',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14),
                                    )
                                  : SizedBox(height: 0),
                              traveler['PassengerTypeCode'] != 'INF'
                                  ? SizedBox(height: 15)
                                  : SizedBox(height: 0),
                             
                                 traveler['PassengerTypeCode'] != 'INF'?  ListView.builder(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: baggage['options'].length,
                                      itemBuilder: (context, index) {
                                        List data = baggage['options'];
                                        return (baggage['options'][index]
                                                    ['bags'][index]['travelers']
                                                .contains(traveler['TravelerRefNumber']))
                                            
                                          ? Column(
                                                children: [
                                                 
                                               baggage['options'][index]
                                                    ['bags']!=null? Baggage(
                                                    bag: data,
                                                    index: index,
                                                    travler: traveler['TravelerRefNumber'],
                                                    optionId: optionId,
                                                    id: baggage['options']
                                                        [index]['id'],
                                                  ):SizedBox(height: 0),
                                                ],
                                              ): Column(
                                                children: [
                                                baggage['options'][index]
                                                    ['bags']!=null? Baggage(
                                                    bag: data,
                                                    index: index,
                                                    travler: traveler['TravelerRefNumber'],
                                                    optionId: optionId,
                                                    id: baggage['options']
                                                        [index]['id'],
                                                  ):SizedBox(height: 0),
                                                ],
                                              );
                                      }):SizedBox(height: 0,)
                                   ],
                          ):SizedBox(height: 0,):SizedBox(height: 0,)
                        
                
        
              ],
            ),
         
      SizedBox(height: 10)
    ],
  );
}

Widget buildItem(
    {Function onTap,
    int selected,
    int index,
    dynamic DepartureDateOneWay,
    dynamic type}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: 55,
      width: 90,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(5),
            bottomRight: Radius.circular(5),
            topRight: Radius.circular(5),
            topLeft: Radius.circular(5)),
        border: Border.all(
            color: selected == index ? Colors.orange : Colors.grey, width: 1.5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${DateFormat.MMMEd().format(DepartureDateOneWay)}',
              style: TextStyle(
                  color: Color.fromARGB(255, 23, 27, 29),
                  fontWeight: FontWeight.w500,
                  fontSize: 10),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              "${type}",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 10,
                  color: Colors.black),
            )
          ],
        ),
      ),
    ),
  );
}

Widget buildPriceCart(
    {String text,
    dynamic subtext,
    double fontSizeText = 15,
    double fontSizePrice = 15,
    Color colorText,
    Color colorPrice}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text('${text} :',
          style: TextStyle(
              fontSize: fontSizeText,
              color: colorText,
              fontWeight: FontWeight.w600)),
      Text('${subtext}',
          style: TextStyle(
              fontSize: fontSizePrice,
              color: colorPrice,
              fontWeight: FontWeight.w600))
    ],
  );
}

Widget buildCartTotalPrice(
    {dynamic Totalprice,
    int adt,
    dynamic adtprice,
    dynamic adtTaxes,
    dynamic adultFee,

    dynamic AdtService_Fee_Cedido,
    dynamic ChdService_Fee_Cedido,
    dynamic InfService_Fee_Cedido,

    dynamic AdtService_Fee,
    dynamic ChdService_Fee,
    dynamic InfService_Fee,

    dynamic Adt_markup,
    dynamic Chd_markup,
    dynamic Inf_markup,

    dynamic markup,
    int chd,
    dynamic chdprice,
    dynamic chdTaxes,
    dynamic childernFee,
    int inf,
    dynamic infprice,
    dynamic infTaxes,
    dynamic infansFee,
    dynamic additionalServices}) {
  return Padding(
    padding: EdgeInsets.only(left: 0, right: 0),
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
              blurRadius: 4,
              color: Colors.grey[350],
              offset: Offset(0, 0),
              spreadRadius: 1)
        ],
        color: Colors.white,
      ),
      width: double.infinity,
      child: Padding(
        padding:
            const EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            buildPriceCart(
              colorText: Color(0xFF0f294d),
              colorPrice: Color(0xFF0f294d),
              subtext: "${adt * adtprice} MAD",
              text: "Adults (${adt})",
            ),
            SizedBox(
              height: 10,
            ),
          
                 buildPriceCart(
                    colorPrice: Color(0xFF8592a6),
                    colorText: Color(0xFF8592a6),
                    fontSizePrice: 14,
                    subtext: "${adtTaxes} MAD",
                    text: "Taxes",
                  ),
               
            SizedBox(
              height: 10,
            ),
             buildPriceCart(
                    fontSizePrice: 14,
                    colorPrice: Color(0xFF8592a6),
                    colorText: Color(0xFF8592a6),
                    subtext: "${AdtService_Fee} MAD",
                    text: "Service fee",
                  ),
            SizedBox(
              height: 10,
            ),
            buildPriceCart(
              fontSizePrice: 14,
              colorPrice: Color(0xFF8592a6),
              colorText: Color(0xFF8592a6),
              subtext: "${AdtService_Fee_Cedido} MAD",
              text: "Service Fee Cedido",
            ),
            SizedBox(height: 10),
            buildPriceCart(
              fontSizePrice: 14,
              colorPrice: Color(0xFF8592a6),
              colorText: Color(0xFF8592a6),
              subtext: "${Adt_markup} MAD",
              text: "markup",
            ),
            SizedBox(height: 10),
            buildDivider(),
            chd != 0
                ? SizedBox(
                    height: 10,
                  )
                : SizedBox(
                    height: 0,
                  ),
            chd != 0
                ? buildPriceCart(
                    colorText: Color(0xFF0f294d),
                    colorPrice: Color(0xFF0f294d),
                    subtext: "${chdprice} MAD",
                    text: "Children (${chd})",
                  )
                : SizedBox(height: 0),
            chd != 0 ? SizedBox(height: 10) : SizedBox(height: 0),
            chd != 0
                ? buildPriceCart(
                    subtext: "${chdTaxes} MAD",
                    colorPrice: Color(0xFF8592a6),
                    colorText: Color(0xFF8592a6),
                    text: "Taxes",
                  )
                : SizedBox(height: 0),
            chd != 0 ? SizedBox(height: 10) : SizedBox(height: 0),
            chd != 0
                ? buildPriceCart(
                    subtext: "${ChdService_Fee} MAD",
                    colorPrice: Color(0xFF8592a6),
                    colorText: Color(0xFF8592a6),
                    text: "Service fee",
                  )
                : SizedBox(height: 0),
            SizedBox(height: 10),
            chd != 0?buildPriceCart(
              fontSizePrice: 14,
              colorPrice: Color(0xFF8592a6),
              colorText: Color(0xFF8592a6),
              subtext: "${ChdService_Fee_Cedido} MAD",
              text: "Service Fee Cedido",
            ):SizedBox(height: 0),

            chd != 0 ? SizedBox(height: 10) : SizedBox(height: 0),
            chd != 0 ? buildPriceCart(
              fontSizePrice: 14,
              colorPrice: Color(0xFF8592a6),
              colorText: Color(0xFF8592a6),
              subtext: "${Chd_markup} MAD",
              text: "markup",
            ): SizedBox(height: 0),
            SizedBox(height: 10),
            chd != 0 ?  buildDivider():SizedBox(height: 0),
            chd != 0 ? SizedBox(height: 10):SizedBox(height: 0),
             inf != 0.0?   SizedBox(
              height: 10,
            ):SizedBox(
              height: 0,
            ),
            chd != 0 ? SizedBox(height: 10) : SizedBox(height: 0),
            inf != 0.0
                ? buildPriceCart(
                    colorText: Color(0xFF0f294d),
                    colorPrice: Color(0xFF0f294d),
                    subtext: "${infprice} MAD",
                    text: "Infants (${inf})",
                  )
                : SizedBox(height: 0),
            inf != 0? SizedBox(height: 10):SizedBox(height: 0),
            inf != 0.0
                ? buildPriceCart(
                    subtext: "${infTaxes} MAD",
                    colorPrice: Color(0xFF8592a6),
                    colorText: Color(0xFF8592a6),
                    text: "Taxes",
                  )
                : SizedBox(height: 0),
            inf != 0 ? SizedBox(height: 10) : SizedBox(height: 0),
            inf != 0
                ? buildPriceCart(
              subtext: "${InfService_Fee} MAD",
              colorPrice: Color(0xFF8592a6),
              colorText: Color(0xFF8592a6),
              text: "Service fee",
            )
                : SizedBox(height: 0),
            inf != 0? SizedBox(height: 10):SizedBox(height: 0),
            inf != 0?buildPriceCart(
              fontSizePrice: 14,
              colorPrice: Color(0xFF8592a6),
              colorText: Color(0xFF8592a6),
              subtext: "${InfService_Fee_Cedido} MAD",
              text: "Service Fee Cedido",
            ):SizedBox(height: 0),

            inf != 0 ? SizedBox(height: 10) : SizedBox(height: 0),
            inf != 0 ? buildPriceCart(
              fontSizePrice: 14,
              colorPrice: Color(0xFF8592a6),
              colorText: Color(0xFF8592a6),
              subtext: "${Inf_markup} MAD",
              text: "markup",
            ): SizedBox(height: 0),
            inf != 0 ? SizedBox(height: 5) : SizedBox(height: 0),
            inf != 0
                ? buildDivider()
                : SizedBox(
                    height: 0,
                  ),
            inf != 0 ? SizedBox(height: 10) : SizedBox(height: 0),
            inf != 0? SizedBox(height: 10):SizedBox(height: 0),
            buildPriceCart(
              colorText: Color(0xFF0f294d),
              colorPrice: Color(0xFF0f294d),
              subtext: "${(adtprice + chdprice + infprice).toStringAsFixed(2)} MAD",
              text: "Price",
            ),
            SizedBox(
              height: 10,
            ),
             buildPriceCart(
              colorText: Color(0xFF0f294d),
              colorPrice: Color(0xFF0f294d),
              subtext: "${ adtTaxes + chdTaxes + infTaxes} MAD",
              text: "Taxes",
            ),
            SizedBox(
              height: 10,
            ),
            buildPriceCart(
              colorText: Color(0xFF0f294d),
              colorPrice: Color(0xFF0f294d),
              subtext: "${adultFee + childernFee + infansFee} MAD",
              text: "Fees",
            ),
            additionalServices != null
                ? SizedBox(
                    height: 10,
                  )
                : SizedBox(height: 0),
            additionalServices != null
                ? buildPriceCart(
                    colorText: Color(0xFF0f294d),
                    colorPrice: Color(0xFF0f294d),
                    subtext: "${additionalServices} MAD",
                    text: "Additional Services",
                  )
                : SizedBox(height: 0),
            SizedBox(
              height: 5,
            ),
            buildDivider(),
            SizedBox(
              height: 7,
            ),
            buildPriceCart(
              colorPrice: appColor,
              colorText: Color(0xFF0f294d),
              text: 'Total',
              fontSizeText: 18,
              fontSizePrice: 18,
              subtext: "${Totalprice} MAD",
            ),
            SizedBox(
              height: 0,
            ),
          ],
        ),
      ),
    ),
  );
}

Widget buildDivider() {
  return LayoutBuilder(
    builder: (context, constraints) {
      return Flex(
        children: List.generate(
            (constraints.constrainWidth() / 10).floor(),
            (index) => SizedBox(
                  height: 1,
                  width: 5,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 175, 176, 177)),
                  ),
                )),
        direction: Axis.horizontal,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
      );
    },
  );
}

Widget buildPassangerInfo({Passanger}) {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: buildPriceCart(
          colorText: appColor,
          colorPrice: Color(0xFF0f294d),
          subtext: Passanger['NamePrefix'],
          text: "NamePrefix",
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: buildPriceCart(
          colorText: appColor,
          colorPrice: Color(0xFF0f294d),
          subtext: Passanger['FirstName'],
          text: "FirstName",
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: buildPriceCart(
          colorText: appColor,
          colorPrice: Color(0xFF0f294d),
          subtext: Passanger['LastName'],
          text: "LastName",
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: buildPriceCart(
          colorText: appColor,
          colorPrice: Color(0xFF0f294d),
          subtext: Passanger['Contact']['Email'],
          text: "Email",
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: buildPriceCart(
          colorPrice: Color(0xFF0f294d),
          colorText: appColor,
          subtext: Passanger['Contact']['Phones'][0]['number'],
          text: "Telephone",
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: buildPriceCart(
          colorText: appColor,
          colorPrice: Color(0xFF0f294d),
          subtext: Passanger['BirthDate'],
          text: "BirthDate",
        ),
      ),
    ],
  );
}

Widget buildContainer(
    {List<Widget> notificationWidget, String text, List notification}) {
  return Container(
    color: Colors.white,
    child: Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: notificationWidget,
        ),
        SizedBox(
          height: 20,
        )
      ],
    ),
  );
}

Widget buildNotification(notification,
    {Function onTap, bool isRead, context, Function onDelet}) {
  final Date1 = DateTime.parse(notification['publication_date_time']);
  final date = DateFormat('yyyy-MM-dd').format(Date1);
  return Column(
    children: [
      GestureDetector(
        onTap: onTap,
        child: Container(
          margin: EdgeInsets.only(top: 20, left: 20, right: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                  blurRadius: 1.2,
                  color: Colors.grey[400],
                  offset: Offset(1, 1),
                  spreadRadius: 1.0)
            ],
            color: Colors.white,
          ),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 120,
                width: double.infinity,
                child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(0),
                      bottomRight: Radius.circular(0),
                      topLeft: Radius.circular(7),
                      topRight: Radius.circular(7),
                    ),
                    child: Image.network(
                      "${notification["img"]}",
                      fit: BoxFit.fill,
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("${notification["titel"]}",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w700),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis),
                          isRead
                              ? GestureDetector(
                                  onTap: onDelet,
                                  child: Icon(
                                    Icons.delete_forever,
                                    color: Colors.red,
                                    size: 30,
                                  ))
                              : SizedBox(
                                  height: 0,
                                )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      Jiffy(date).fromNow(),
                      style: TextStyle(fontSize: 11, color: Colors.grey),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 0),
                      child: Text("${notification["subtitel"]}",
                          style:
                              TextStyle(fontSize: 13, color: Color(0xFF7B919D)),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}
Widget buildCondition({String text}){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
                     children: [
                       Container(
                                        height: 45,
                                        decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.bottomCenter,
                                        end: Alignment.topCenter,
                                        colors: [
                                          Color.fromARGB(255, 255, 185, 106),
                                          Color.fromARGB(255, 255, 137, 1),
                                        ],
                                      ),
                                        boxShadow: [
                                        BoxShadow(
                                              blurRadius: 2.8,
                                              color: Color(0xFFF28300),
                                              offset: Offset(0, 0),
                                              spreadRadius: 0)
                                        ],
                                        color: Color(0xFFF28300),
                                        borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(0),
                                          bottomRight: Radius.circular(0),
                                          topLeft: Radius.circular(11),
                                          topRight: Radius.circular(11),
                                        )),
                                        width: double.infinity,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                           Padding(
                                             padding: const EdgeInsets.only(left: 7,right: 7),
                                             child: Text(text,style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.w600),),
                                           )
                                           
                                          ],
                                        ),
                                      ),
                       Container(
                                              height: 100,
                                              child: Center(
                                              child:CircularProgressIndicator(),
                                              ),
                                              decoration: BoxDecoration(
                                               boxShadow: [
                                               BoxShadow(
                                              blurRadius: 2.8,
                                              color: Color(0xFFF28300),
                                              offset: Offset(0, 0),
                                              spreadRadius: 0)
                                                ],
                                                borderRadius:BorderRadius.only(
                                                  bottomLeft:Radius.circular(7),
                                                  bottomRight:Radius.circular(7),
                                                  topLeft:Radius.circular(0),
                                                  topRight:Radius.circular(0),),
                                                color: Colors.white,
                                               ),
                                             ),
                     ],
                   );
}
Color changeColor(e) {
  if(e=='AMA'){
    return Colors.blue;
  }
  if(e=='ARA'){
    return Colors.red;
  }
  if(e=='SHT'){
    return Color(0xFFed6905);
  }
}