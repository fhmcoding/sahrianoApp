import 'dart:io';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';
import 'package:sahariano_travel/ataycom_app/model/customer.dart';
import 'package:sahariano_travel/ataycom_app/model/invoice.dart';
import 'package:sahariano_travel/ataycom_app/model/supplier.dart';
import 'package:sahariano_travel/ataycom_app/pages/pdfApi.dart';
import 'package:sahariano_travel/shared/components/constants.dart';

class PdfInvoiceApi {
  
  static Future<File> generate(Invoice invoice) async {
    final type = invoice.supplier.type;
    final pdf = Document();
    final logo = (await rootBundle.load(type==ataycom?'assets/atay.png':'assets/parfum.png')).buffer.asUint8List();
    // if () {
      
    // }
    pdf.addPage(MultiPage(
      build: (context) => [
        buildHeader(invoice,logo),
        SizedBox(height: 0.5 * PdfPageFormat.cm),
        buildTotalcomule(invoice),
        SizedBox(height: 0.9 * PdfPageFormat.cm),
        buildInvoice(invoice),
        SizedBox(height: 0.3 * PdfPageFormat.cm),
        Divider(),
         SizedBox(height: 0.9 * PdfPageFormat.cm),
        buildTotal(invoice),
        
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

  static Widget buildCustomerAddress(Customer customer) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Delivery To :', style: TextStyle(fontWeight: FontWeight.bold,color: PdfColors.grey,fontSize: 9)),
          SizedBox(height: 1.2 * PdfPageFormat.mm),
          Text(customer.firstname, style: TextStyle(fontWeight: FontWeight.bold,color: PdfColors.grey400,fontSize: 8)),
           SizedBox(height: 1 * PdfPageFormat.mm),
          Text(customer.lastname, style: TextStyle(fontWeight: FontWeight.bold,color: PdfColors.grey400,fontSize: 8)),
             SizedBox(height: 1 * PdfPageFormat.mm),
          Text(customer.phone, style: TextStyle(fontWeight: FontWeight.bold,color: PdfColors.grey400,fontSize: 8)),
            SizedBox(height: 1 * PdfPageFormat.mm),
          Text(customer.address,style: TextStyle(fontWeight: FontWeight.bold,color: PdfColors.grey400,fontSize: 8)),
        ],
      );
    
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
      'Product Name',
      'Brand',
      'Size',
      'Quantity',
      'Price',
    ];
    final data = invoice.items.map((item) {
      return [
        item.ProductName,
        item.Brand,
        '${item.Size} ml',
        '${item.quantity}',
        '${item.Price} MAD',
      ];
    }).toList();
  final type = invoice.supplier.type;
    return Table.fromTextArray(
      headers: headers,
      data: data,
      border: null,
      
      headerStyle: TextStyle(fontWeight: FontWeight.bold,color: PdfColors.white),
      headerDecoration: BoxDecoration(color: type==ataycom ?PdfColors.green:PdfColors.pink),
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
   static Widget buildTotal(Invoice invoice) {
    final netTotal = invoice.items
        .map((item) => item.Price * item.quantity)
        .reduce((item1, item2) => item1 + item2);
   

    final total = netTotal;
    final paymentPrice = invoice.supplier.paymentPrice;
    final type = invoice.supplier.type;
    return Container(
      alignment: Alignment.centerRight,
      child: Row(
        children: [
          Spacer(flex: 6),
          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildPiceTotal(
                  title: 'SubTotal',
                  value: '${total} MAD',
                   titleStyle:TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: type==ataycom ?PdfColors.green:PdfColors.pink 
                  ),
                  unite: true,
                ),
                pw.SizedBox(height: 8,),
                  buildPiceTotal(
                  title: '${invoice.supplier.paymentInfo}',
                  titleStyle:TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: type==ataycom ?PdfColors.green:PdfColors.pink 
                  ),
                  value: '${paymentPrice} MAD',
                  unite: true,
                ),
                Divider(),
                buildPiceTotal(
                  title: 'Total',
                  titleStyle:TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: type==ataycom ?PdfColors.green:PdfColors.pink 
                  ),
                  value: '${(total + paymentPrice).toStringAsFixed(2)} MAD',
                  unite: true,
                ),
                SizedBox(height: 2 * PdfPageFormat.mm),
               
            
              ],
            ),
          ),
        ],
      ),
    );
  }
  static Widget buildTotalcomule(Invoice invoice) {
    final netTotal = invoice.items
        .map((item) => item.Price * item.quantity)
        .reduce((item1, item2) => item1 + item2);
   

    final total = netTotal;
    final paymentPrice = invoice.supplier.paymentPrice;
    final type = invoice.supplier.type;
    return Row(
           crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildCustomerAddress(invoice.customer),
              
              Container(
                width: 150,
                height: 60,
                
                child: Padding(
                padding: pw.EdgeInsets.all(10),
                child: pw.Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
               children: [
                pw.SizedBox(height: 3),
                pw.Row(
                   crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                        Text('Total comule:',style: TextStyle(fontWeight: FontWeight.bold,color:PdfColors.black,fontSize: 9)),
                        Text('${(total + paymentPrice).toStringAsFixed(2)}',style: TextStyle(fontWeight: FontWeight.bold,color:type==ataycom ?PdfColors.green:PdfColors.pink,fontSize: 10)),
                    ]),
                     pw.SizedBox(height: 3),
                    pw.Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                      Text('Devise',style: TextStyle(fontWeight: FontWeight.bold,color:PdfColors.black ,fontSize: 9)),
                      Text('MAD',style: TextStyle(fontWeight: FontWeight.bold,color:type==ataycom ?PdfColors.green:PdfColors.pink,fontSize: 10)),
                    ])
                
                ])),
                decoration: BoxDecoration(  
                color: PdfColors.white,
                borderRadius: BorderRadius.circular(5),
                border:Border.all(color:type==ataycom ?PdfColors.green:PdfColors.pink,width: 1.5))),
                
            ],
          );
  }
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