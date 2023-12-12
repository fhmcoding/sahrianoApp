import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';
import 'package:sahariano_travel/ataycom_app/model/invoice.dart';
import 'package:sahariano_travel/ataycom_app/model/supplier.dart';
import 'package:sahariano_travel/ataycom_app/pages/pdfApi.dart';
import 'package:sahariano_travel/shared/components/constants.dart';


class PdfInvoiceApiFlight{
  
  static Future<File> generate(Invoice invoice) async {
    final type = invoice.supplier.type;
    final pdf = Document();
    final logo = (await rootBundle.load(type==ataycom?'assets/atay.png':'assets/parfum.png')).buffer.asUint8List();
    final fligh = (await rootBundle.load('assets/airplane.png')).buffer.asUint8List();
  //  final netImage = await mt.networkImage('https://www.nfet.net/nfet.jpg');
    pdf.addPage(MultiPage(
      build: (context) => [
        buildHeader(invoice,logo),
        SizedBox(height: 0.5 * PdfPageFormat.cm),
        // buildTotalcomule(invoice),
        SizedBox(height: 0.9 * PdfPageFormat.cm),
        buildTicket(invoice: invoice,fligh: fligh),
        // buildInvoice(invoice),
        SizedBox(height: 0.3 * PdfPageFormat.cm),
        Divider(),
         SizedBox(height: 0.9 * PdfPageFormat.cm),
        // buildTotal(invoice),
        
      ],
      footer: (context) => buildFooter(invoice),
    ));

    return PdfApi.saveDocument(name: 'my_invoice.pdf', pdf: pdf);
  }
 
  static Widget buildHeader(Invoice invoice,logo) {
      final type = invoice.supplier.type;
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: pw.MainAxisAlignment.start,
        children: [
          SizedBox(height: 1 * PdfPageFormat.cm),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            Container(
                width: 480,
                height: 80,
                
                child: Padding(
                padding: pw.EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                   Container(height: 80,width: 80,child: Image(pw.MemoryImage(logo))),
                    pw.SizedBox(width: 5),
                 Text('Facture',style: TextStyle(fontWeight: FontWeight.bold,color:type==ataycom ?PdfColors.green:PdfColors.pink,fontSize: 20)),
                 pw.SizedBox(width: 3),
                buildSupplierAddress(invoice.supplier),
                
                ])),
                decoration: BoxDecoration(  
                color: PdfColors.white,
                borderRadius: BorderRadius.circular(5),
                border:Border.all(color:type==ataycom ?PdfColors.green:PdfColors.pink,width: 1.5))),
            ],
          ),
          SizedBox(height: 0.4 * PdfPageFormat.cm),
          
        ],
      );
  }

  // static Widget buildCustomerAddress(Customer customer) => Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Text('Delivery To :', style: TextStyle(fontWeight: FontWeight.bold,color: PdfColors.grey,fontSize: 9)),
  //         SizedBox(height: 1.2 * PdfPageFormat.mm),
  //         Text(customer.firstname, style: TextStyle(fontWeight: FontWeight.bold,color: PdfColors.grey400,fontSize: 8)),
  //          SizedBox(height: 1 * PdfPageFormat.mm),
  //         Text(customer.lastname, style: TextStyle(fontWeight: FontWeight.bold,color: PdfColors.grey400,fontSize: 8)),
  //            SizedBox(height: 1 * PdfPageFormat.mm),
  //         Text(customer.phone, style: TextStyle(fontWeight: FontWeight.bold,color: PdfColors.grey400,fontSize: 8)),
  //           SizedBox(height: 1 * PdfPageFormat.mm),
  //         Text(customer.address,style: TextStyle(fontWeight: FontWeight.bold,color: PdfColors.grey400,fontSize: 8)),
  //       ],
  //     );
    
  static Widget buildSupplierAddress(Supplier supplier) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           SizedBox(height: 5 * PdfPageFormat.mm),
          Text(supplier.name, style: TextStyle(fontWeight: FontWeight.bold,fontSize: 8,color:PdfColors.grey400, )),
          SizedBox(height: 1 * PdfPageFormat.mm),
          Text(supplier.address,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 8,color:PdfColors.grey400)),
           SizedBox(height: 1 * PdfPageFormat.mm),
          Text(supplier.phone,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 8,color:PdfColors.grey400)),
        ],
      );
  static Widget buildInvoice(Invoice invoice) {
    final headers = [
      'travlers',
      'type',
      'flighs',
      'baggage',
    ];
    final data = invoice.items.map((item) {
      return [
        item.ProductName,
        item.Brand,
        '${item.Size} ',
        '${item.quantity}',
      ];
    }).toList();
    return Table.fromTextArray(
      headers: headers,
      data: data,
      border: null,
      
      headerStyle: TextStyle(fontWeight: FontWeight.bold,color: PdfColors.white),
      headerDecoration: BoxDecoration(color:PdfColors.pink),
      cellHeight: 30,
      cellAlignments: {
        0: Alignment.centerLeft,
        1: Alignment.center,
        2: Alignment.center,
        3: Alignment.center,
        4: Alignment.center,
        5: Alignment.center,
      },
    );
  }
  static Widget buildTicket({Uint8List fligh,Invoice invoice
}){
   return Container(
    height: 100,
    decoration: pw.BoxDecoration(
      borderRadius:pw.BorderRadius.circular(5),
      border: pw.Border.all(
        color:  PdfColors.black,
        width: 1
      ),
    ),
    width: double.infinity,
    child: pw.Column(
      children: [
      pw.Row(
        children: [
          Text(
                  "ORY 13:00",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color:PdfColors.black),
                ),
                SizedBox(
                  width: 14,
                ),
                SizedBox(
                  height: 6,
                  width: 6,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color:PdfColors.black,
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
                                                color: PdfColors.grey300),
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
                            child: Image(
                              pw.MemoryImage(fligh),
                              
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
                      color: PdfColors.grey300,
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
                      "NCE 01:00",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color:PdfColors.black),
                    ),
                    SizedBox(width: 20,),
                  
                  Container(
                    height: 26,
                    width: 26,
                    ),
              ],
            ),
        ]
      ),
       SizedBox(
              height: 5,
            ),
            pw.Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                 SizedBox(
                    width: 90,
                    child: Text(
                      "2022-10-01",
                      style: TextStyle(
                          fontSize: 11,
                          color:PdfColors.black,
                          fontWeight: FontWeight.bold),
                    )),
                     Text(
                 "PUHJIK",
                  style: TextStyle(
                      fontSize:13,
                      fontWeight: FontWeight.bold,
                      color:PdfColors.orange ),
                ),
                pw.Row(
                  children: [
                    SizedBox(
                        width: 10,
                        child: Text(
                          "2022-10-01",
                          textAlign:pw.TextAlign.right,
                          style: TextStyle(
                              fontSize: 10,
                              color: PdfColors.black,
                              fontWeight: FontWeight.bold),
                        )),
                        SizedBox(width:20 ,),
                        Text('87878',style: TextStyle(
                              fontSize: 7,
                              fontWeight: FontWeight.bold),),
                  ],
                ),
              
            
            SizedBox(
              height: 13,
            ),
           
              ]
            )
      ]
    )
   );
  }
  //  static Widget buildTotal(Invoice invoice) {
  //   final netTotal = invoice.items
  //       .map((item) => item.Price * item.quantity)
  //       .reduce((item1, item2) => item1 + item2);   

  //   final total = netTotal;
  //   final paymentPrice = invoice.supplier.paymentPrice;
  //   final type = invoice.supplier.type;
  //   return Container(
  //     alignment: Alignment.centerRight,
  //     child: Row(
  //       children: [
  //         Spacer(flex: 6),
  //         Expanded(
  //           flex: 4,
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               buildPiceTotal(
  //                 title: 'SubTotal',
  //                 value: '${total} MAD',
  //                  titleStyle:TextStyle(
  //                   fontSize: 14,
  //                   fontWeight: FontWeight.bold,
  //                   color: type==ataycom ?PdfColors.green:PdfColors.pink 
  //                 ),
  //                 unite: true,
  //               ),
  //               pw.SizedBox(height: 8,),
  //                 buildPiceTotal(
  //                 title: '${invoice.supplier.paymentInfo}',
  //                 titleStyle:TextStyle(
  //                   fontSize: 14,
  //                   fontWeight: FontWeight.bold,
  //                   color: type==ataycom ?PdfColors.green:PdfColors.pink 
  //                 ),
  //                 value: '${paymentPrice} MAD',
  //                 unite: true,
  //               ),
  //               Divider(),
  //               buildPiceTotal(
  //                 title: 'Total',
  //                 titleStyle:TextStyle(
  //                   fontSize: 14,
  //                   fontWeight: FontWeight.bold,
  //                   color: type==ataycom ?PdfColors.green:PdfColors.pink 
  //                 ),
  //                 value: '${total + paymentPrice} MAD',
  //                 unite: true,
  //               ),
  //               SizedBox(height: 2 * PdfPageFormat.mm),
               
            
  //             ],
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
  // static Widget buildTotalcomule(Invoice invoice) {
  //   final netTotal = invoice.items
  //       .map((item) => item.Price * item.quantity)
  //       .reduce((item1, item2) => item1 + item2);
   

  //   final total = netTotal;
  //   final paymentPrice = invoice.supplier.paymentPrice;
  //   final type = invoice.supplier.type;
  //   return Row(
  //          crossAxisAlignment: CrossAxisAlignment.end,
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             // buildCustomerAddress(invoice.customer),
  //             Container(
  //               width: 150,
  //               height: 60,
                
  //               child: Padding(
  //               padding: pw.EdgeInsets.all(10),
  //               child: pw.Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 mainAxisAlignment: MainAxisAlignment.start,
  //              children: [
  //               pw.SizedBox(height: 3),
  //               pw.Row(
  //                  crossAxisAlignment: CrossAxisAlignment.end,
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                 children: [
  //                       Text('Total comule:',style: TextStyle(fontWeight: FontWeight.bold,color:PdfColors.black,fontSize: 9)),
  //                       Text('${total + paymentPrice}',style: TextStyle(fontWeight: FontWeight.bold,color:type==ataycom ?PdfColors.green:PdfColors.pink,fontSize: 10)),
  //                   ]),
  //                    pw.SizedBox(height: 3),
  //                   pw.Row(
  //                     crossAxisAlignment: CrossAxisAlignment.end,
  //                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                     children: [
  //                     Text('Devise',style: TextStyle(fontWeight: FontWeight.bold,color:PdfColors.black ,fontSize: 9)),
  //                     Text('MAD',style: TextStyle(fontWeight: FontWeight.bold,color:type==ataycom ?PdfColors.green:PdfColors.pink,fontSize: 10)),
  //                   ])
                
  //               ])),
  //               decoration: BoxDecoration(  
  //               color: PdfColors.white,
  //               borderRadius: BorderRadius.circular(5),
  //               border:Border.all(color:type==ataycom ?PdfColors.green:PdfColors.pink,width: 1.5))),
                
  //           ],
  //         );
  // }
  static Widget buildFooter(Invoice invoice) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Divider(),
          SizedBox(height: 2 * PdfPageFormat.mm),
          buildSimpleText(title: 'Address', value: invoice.supplier.address),
          SizedBox(height: 1 * PdfPageFormat.mm),
          buildSimpleText(title: 'Payment method :', value: invoice.supplier.paymentInfo),
        ],
      );

   static buildSimpleText({
     String title,
     String value,

  }) {
    final style = TextStyle(fontWeight: FontWeight.bold,fontSize: 5);
   
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: pw.CrossAxisAlignment.end,
      children: [
        Text(title, style: style,),
        SizedBox(width: 2 * PdfPageFormat.mm),
        Text(value,style: style),
      ],
    );
  }

  static buildPiceTotal({
     String title,
     
    double width = double.infinity,
    TextStyle titleStyle,
    bool unite = false, value,
  }) {
    
    return Container(
      width: width,
      child: Row(
        children: [
          Expanded(child: Text(title, style: TextStyle(fontWeight: FontWeight.bold))),
          Text(value, style: titleStyle)
        ],
      ),
    );
  }
}