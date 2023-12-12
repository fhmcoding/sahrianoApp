import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sahariano_travel/Flight_app/pages/reservations_page.dart';
import 'package:sahariano_travel/shared/components/components.dart';
import 'package:sahariano_travel/shared/components/constants.dart';

class Baggage extends StatefulWidget {
Baggage({@required this.bag, this.index, this.travler, this.optionId, this.id});

 final List bag;
 final int index;
 final dynamic travler;
 final int optionId;
 final int id;

  @override
  State<Baggage> createState() => _BaggageState();
}

class _BaggageState extends State<Baggage> {
  int select;

  @override
  Widget build(BuildContext context) {
    
    List bags = widget.bag[widget.index]['bags'];
    return (widget.id == widget.optionId) != false? bags.length > 0 ? Container(
                decoration: BoxDecoration(
                    border: Border.all(color: appColor, width: 1.3),
                    borderRadius: BorderRadius.circular(5)),
                child: ListView.separated(
                  separatorBuilder: (context, index) {
                    return Divider(
                      color: appColor,
                    );
                  },
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: bags.length,
                  itemBuilder: (context, index) {
                    return RadioListTile(
                      toggleable: true,
                      dense: true,
                        title: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 2),
                              child: Icon(FontAwesomeIcons.suitcase,
                                  size: 13, color: appColor),
                            ),
                            Text.rich(TextSpan(children: [
                            bags[index]['unit']==null? TextSpan(
                                  text: '  ${bags[index]['quantity']}x',
                                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13)): TextSpan(
                                  text: '  ${bags[index]['quantity']} ${bags[index]['unit']}',
                                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13)),
                               TextSpan(text: '  Checked Baggage',
                                style: TextStyle(fontWeight: FontWeight.bold,fontSize: 10)
                               ),
                               TextSpan(text: '   ${bags[index]['amount']} ${bags[index]['currencyCode']}', 
                               style: TextStyle(
                               fontWeight: FontWeight.bold,
                               color: Colors.green,fontSize: 12))
                            ])),
                           
                           
                          ],
                        ),
                        value: index,
                        groupValue: select,
                        onChanged: (newValue) {
                          setState(() => select = index);
                           var key=-1;
                           for (var i = 0; i < ReservationPage.trying.length; i++){
                             if (widget.travler==ReservationPage.trying[i]['traveler'] && widget.optionId==ReservationPage.trying[i]['option'] ) {
                               key=i;
                               break;
                             }
                           }
                           if (key!=-1) {
                             ReservationPage.trying[key] = {
                                                 "id":bags[index]['id'],
                                                 "traveler":widget.travler,
                                                 "option":widget.optionId,
                                                 "price":bags[index]['amount'],
                                                 "quantity":bags[index]['quantity']
                                               };
                           }
                           else{
                             ReservationPage.trying.add({
                                 "id": bags[index]['id'],
                                 "traveler":widget.travler,
                                 "option":widget.optionId,
                                 "price":bags[index]['amount'],
                                 "quantity":bags[index]['quantity']
                               });
                           }
                          
                        });
                  },
                ),
              )
            : SizedBox(
                height: 0,
              )
        : SizedBox(
            height: 0,
          );
  }
}
