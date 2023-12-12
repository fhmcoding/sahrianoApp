
import 'package:sahariano_travel/ataycom_app/model/customer.dart';
import 'package:sahariano_travel/ataycom_app/model/supplier.dart';

class Invoice {
  final InvoiceInfo info;
  final Supplier supplier;
  final Customer customer;
  final List<InvoiceItem> items;

  const Invoice({
     this.info,
     this.supplier,
     this.customer,
     this.items,
  });
}

class InvoiceInfo {
  final String description;
  final String number;
  final DateTime date;
  final DateTime dueDate;

  const InvoiceInfo({
     this.description,
     this.number,
     this.date,
     this.dueDate,
  });
}

class InvoiceItem {
  final String ProductName;
  final String Brand;
  final String Size;
  final int quantity;
  final int Price;

  const InvoiceItem({
    this.ProductName,
    this.Brand,
     this.quantity,
     this.Size,
     this.Price,
  });
}
