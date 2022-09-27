import 'dart:typed_data';

import 'package:darq/darq.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:tesis/domain/entities/facturas/facturaEntity.dart';
import 'package:tesis/domain/entities/pedidos/pedidosEntity.dart';
import 'package:tesis/domain/entities/productos/productosEntity.dart';
import 'package:tesis/ui/pages/Report/pdfApi.dart';

class PdfInvoiceApi {
  static formatPrice(double price) => '\$ ${price.toStringAsFixed(2)}';
  static DateFormat formatter = DateFormat('dd/MM/yyyy');

  static Future generate(PedidoEntity invoice, String codRef) async {
    final pdf = Document();

    pdf.addPage(MultiPage(
      build: (context) => [
        buildHeader(invoice, codRef),
        SizedBox(height: 3 * PdfPageFormat.cm),
        buildTitle(invoice),
        buildInvoice(invoice),
        Divider(),
        buildTotal(invoice),
      ],
      //footer: (context) => buildFooter(invoice),
    ));

    PdfApi.saveDocument(
        name: 'nota${invoice.id}-${invoice.nomUsuario}.pdf', pdf: pdf);
  }

  static Future<Uint8List> generateBye(
      PedidoEntity invoice, String codRef) async {
    final pdf = Document();

    pdf.addPage(MultiPage(
      build: (context) => [
        buildHeader(invoice, codRef),
        SizedBox(height: 3 * PdfPageFormat.cm),
        buildTitle(invoice),
        buildInvoice(invoice),
        Divider(),
        buildTotal(invoice),
      ],
      //footer: (context) => buildFooter(invoice),
    ));

    return pdf.save();
  }

// #region orden de pedido
  static Future<Uint8List> generateReport1byte(
      List<PedidoEntity> invoice) async {
    final pdf = Document();

    pdf.addPage(MultiPage(
      build: (context) => [
        //buildHeader(invoice, codRef),
        SizedBox(height: 3 * PdfPageFormat.cm),
        //buildTitle(invoice),
        buildInvoiceReport(invoice),
        Divider(),
        buildTotalReport(invoice),
      ],
      //footer: (context) => buildFooter(invoice),
    ));

    return pdf.save();
  }

  static Widget buildInvoiceReport(List<PedidoEntity> invoice) {
    final headers = ['Fecha', 'Proveedor', 'Cantidad', 'Total'];
    final data = invoice.map((item) {
      //final total = item.unitPrice * item.quantity * (1 + item.vat);

      return [
        formatter.format(item.fecha!),
        //'${item.lote}',
        ' ${item.nomUsuario}',
        ' ${item.cantidad} ',
        '\$ ${item.total.toStringAsFixed(2)}',
      ];
    }).toList();

    return Table.fromTextArray(
      headers: headers,
      data: data,
      border: null,
      headerStyle: TextStyle(fontWeight: FontWeight.bold),
      headerDecoration: BoxDecoration(color: PdfColors.grey300),
      cellHeight: 30,
      cellAlignments: {
        0: Alignment.centerLeft,
        //1: Alignment.centerRight,
        1: Alignment.centerRight,
        2: Alignment.centerRight,
        3: Alignment.centerRight,
      },
    );
  }

  static Widget buildTotalReport(List<PedidoEntity> invoice) {
    final netTotal = invoice.sum((p) => p.total);
    // final vatPercent = invoice.items.first.vat;
    // final vat = netTotal * vatPercent;
    // final total = netTotal + vat;

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
                buildText(
                  title: 'total',
                  //value: Utils.formatPrice(netTotal),
                  value: formatPrice(netTotal),
                  unite: true,
                ),
                // buildText(
                //   title: 'Vat ${vatPercent * 100} %',
                //   value: Utils.formatPrice(vat),
                //   unite: true,
                // ),
                // Divider(),
                // buildText(
                //   title: 'Total amount due',
                //   titleStyle: TextStyle(
                //     fontSize: 14,
                //     fontWeight: FontWeight.bold,
                //   ),
                //   value: Utils.formatPrice(total),
                //   unite: true,
                // ),
                SizedBox(height: 2 * PdfPageFormat.mm),
                Container(height: 1, color: PdfColors.grey400),
                SizedBox(height: 0.5 * PdfPageFormat.mm),
                Container(height: 1, color: PdfColors.grey400),
              ],
            ),
          ),
        ],
      ),
    );
  }

// #endregion

// #region Facturas
  static Future<Uint8List> generateFacturasbyte(
      List<FacturaEntity> invoice) async {
    final pdf = Document();

    pdf.addPage(MultiPage(
      build: (context) => [
        //buildHeader(invoice, codRef),
        SizedBox(height: 3 * PdfPageFormat.cm),
        //buildTitle(invoice),
        buildInvoiceFacturas(invoice),
        Divider(),
        buildTotalFacturas(invoice),
      ],
      //footer: (context) => buildFooter(invoice),
    ));

    return pdf.save();
  }

  static Widget buildInvoiceFacturas(List<FacturaEntity> invoice) {
    final headers = ['Fecha', 'Cliente', 'Cantidad', 'Total'];
    // final data = invoice.map((item) {
    //   //final total = item.unitPrice * item.quantity * (1 + item.vat);

    //   return [
    //     formatter.format(item.fecha!),

    //     //'${item.lote}',
    //     ' ${item.nomPersona}',
    //     ' ${item.cantidad} ',
    //     '\$ ${item.total.toStringAsFixed(2)}',
    //   ];
    // }).toList();

    final data = invoice.map((item) {
      //final total = item.unitPrice * item.quantity * (1 + item.vat);

      return [
        formatter.format(item.fecha!),

        //'${item.lote}',
        ' ${item.nomPersona}',
        ' ${item.cantidad} ',
        '\$ ${item.total.toStringAsFixed(2)}',
      ];
    }).toList();

    return Table.fromTextArray(
      headers: headers,
      data: data,
      border: null,
      headerStyle: TextStyle(fontWeight: FontWeight.bold),
      headerDecoration: BoxDecoration(color: PdfColors.grey300),
      cellHeight: 30,
      cellAlignments: {
        0: Alignment.centerLeft,
        //1: Alignment.centerRight,
        1: Alignment.centerRight,
        2: Alignment.centerRight,
        3: Alignment.centerRight,
      },
    );
  }

  static Widget buildTotalFacturas(List<FacturaEntity> invoice) {
    final netTotal = invoice.sum((p) => p.total);
    // final vatPercent = invoice.items.first.vat;
    // final vat = netTotal * vatPercent;
    // final total = netTotal + vat;

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
                buildText(
                  title: 'total',
                  //value: Utils.formatPrice(netTotal),
                  value: formatPrice(netTotal),
                  unite: true,
                ),
                // buildText(
                //   title: 'Vat ${vatPercent * 100} %',
                //   value: Utils.formatPrice(vat),
                //   unite: true,
                // ),
                // Divider(),
                // buildText(
                //   title: 'Total amount due',
                //   titleStyle: TextStyle(
                //     fontSize: 14,
                //     fontWeight: FontWeight.bold,
                //   ),
                //   value: Utils.formatPrice(total),
                //   unite: true,
                // ),
                SizedBox(height: 2 * PdfPageFormat.mm),
                Container(height: 1, color: PdfColors.grey400),
                SizedBox(height: 0.5 * PdfPageFormat.mm),
                Container(height: 1, color: PdfColors.grey400),
              ],
            ),
          ),
        ],
      ),
    );
  }

// #endregion

// #region lista de productos
  static Future<Uint8List> generateListProductobyte(
      List<ProductosEntity> products) async {
    final pdf = Document();

    pdf.addPage(MultiPage(
      build: (context) => [
        buildHeaderProductos("Listado de Productos"),
        SizedBox(height: 3 * PdfPageFormat.cm),
        //buildTitle(invoice),
        buildInvoiceProductos(products),
        Divider(),
      ],
      //footer: (context) => buildFooter(invoice),
    ));

    return pdf.save();
    // PdfApi.saveDocument(name: 'Report002.pdf', pdf: pdf);
  }

  static Widget buildHeaderProductos(String invoice) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 1 * PdfPageFormat.cm),
          Row(
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //Text(invoice, style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(invoice),
                  SizedBox(height: 1 * PdfPageFormat.mm),
                  //Text("adreess"),
                ],
              )
            ],
          ),
          SizedBox(height: 1 * PdfPageFormat.cm),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // buildCustomerAddress(invoice.customer),
              // buildInvoiceInfo(invoice.info),
            ],
          ),
        ],
      );

  static Widget buildInvoiceProductos(List<ProductosEntity> invoice) {
    final headers = ['Id', 'Nombres', 'Stock', 'Precio', 'Costo', 'Estado'];
    final data = invoice.map((item) {
      //final total = item.unitPrice * item.quantity * (1 + item.vat);

      return [
        item.id,
        '${item.nombre}',
        ' ${item.stock}',
        '\$  ${item.precio.toStringAsFixed(2)} ',
        '\$ ${item.costo.toStringAsFixed(2)}',
        ' ${item.estado}',
      ];
    }).toList();

    return Table.fromTextArray(
      headers: headers,
      data: data,
      border: null,
      // headerStyle: TextStyle(fontWeight: FontWeight.bold),
      headerDecoration: BoxDecoration(color: PdfColors.grey300),
      cellHeight: 30,
      cellAlignments: {
        0: Alignment.centerLeft,
        1: Alignment.centerRight,
        2: Alignment.centerRight,
        3: Alignment.centerRight,
        4: Alignment.centerRight,
        5: Alignment.centerRight,
      },
    );
  }

// #endregion

  static Future<Uint8List> generateListcostobyte(
      List<CostovsPrecioEntity> products) async {
    final pdf = Document();

    pdf.addPage(MultiPage(
      build: (context) => [
        buildHeaderProductos("Listado de Costo vs Precio"),
        SizedBox(height: 3 * PdfPageFormat.cm),
        //buildTitle(invoice),
        buildInvoicecostos(products),
        Divider(),
        buildTotalCosto(products)
      ],
      //footer: (context) => buildFooter(invoice),
    ));

    return pdf.save();
    // PdfApi.saveDocument(name: 'Report002.pdf', pdf: pdf);
  }

  static Widget buildInvoicecostos(List<CostovsPrecioEntity> invoice) {
    final headers = [
      'Codigo',
      'Nombres',
      'Pendiente Facturar',
      'costo',
      'Precio',
      'Costo Total',
      'Precio Total'
    ];
    final data = invoice.map((item) {
      //final total = item.unitPrice * item.quantity * (1 + item.vat);

      return [
        item.codigo,
        item.nombre,
        item.canpendfact,
        '\$  ${item.costo.toStringAsFixed(2)} ',
        '\$ ${item.precio.toStringAsFixed(2)}',
        '\$  ${item.costototal.toStringAsFixed(2)} ',
        '\$ ${item.preciototal.toStringAsFixed(2)}',
      ];
    }).toList();

    return Table.fromTextArray(
      headers: headers,
      data: data,
      border: null,
      headerStyle: TextStyle(fontWeight: FontWeight.bold),
      headerDecoration: BoxDecoration(color: PdfColors.grey300),
      cellHeight: 30,
      headerPadding: EdgeInsets.all(5),
      cellAlignments: {
        0: Alignment.centerLeft,
        1: Alignment.centerLeft,
        2: Alignment.centerLeft,
        3: Alignment.center,
        4: Alignment.center,
        5: Alignment.center,
        6: Alignment.center,
      },
    );
  }

  static Widget buildTotalCosto(List<CostovsPrecioEntity> invoice) {
    final netTotal = invoice.sum((p) => p.costototal);
    final totalPrecio = invoice.sum((p) => p.preciototal);
    // final vatPercent = invoice.items.first.vat;
    // final vat = netTotal * vatPercent;
    // final total = netTotal + vat;

    return Container(
      //alignment: Alignment.centerRight,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // Spacer(flex: 6),
              // Expanded(
              //   flex: 4,
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       buildText(
              //         title: 'totales ',
              //         //value: Utils.formatPrice(netTotal),
              //         value: formatPrice(netTotal),
              //         unite: true,
              //       ),
              //       buildText(
              //         title: 'totales ',
              //         //value: Utils.formatPrice(netTotal),
              //         value: formatPrice(totalPrecio),
              //         unite: true,
              //       ),
              //       // buildText(
              //       //   title: 'Vat ${vatPercent * 100} %',
              //       //   value: Utils.formatPrice(vat),
              //       //   unite: true,
              //       // ),
              //       // Divider(),
              //       // buildText(
              //       //   title: 'Total amount due',
              //       //   titleStyle: TextStyle(
              //       //     fontSize: 14,
              //       //     fontWeight: FontWeight.bold,
              //       //   ),
              //       //   value: Utils.formatPrice(total),
              //       //   unite: true,
              //       // ),
              //       SizedBox(height: 2 * PdfPageFormat.mm),
              //       Container(height: 1, color: PdfColors.grey400),
              //       SizedBox(height: 0.5 * PdfPageFormat.mm),
              //       Container(height: 1, color: PdfColors.grey400),
              //     ],
              //   ),
              // ),

              Text(formatPrice(netTotal).toString()),
              SizedBox(width: 20),
              Text(formatPrice(totalPrecio).toString()),
              SizedBox(width: 10),
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "Ganancia",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 20),
              Text(
                formatPrice(netTotal - totalPrecio).toString(),
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 10),
            ],
          ),
        ],
      ),
    );
  }

  static Widget buildHeader(PedidoEntity invoice, String cod) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 1 * PdfPageFormat.cm),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildSupplierAddress(cod),
            ],
          ),
          SizedBox(height: 1 * PdfPageFormat.cm),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // buildCustomerAddress(invoice.customer),
              // buildInvoiceInfo(invoice.info),
            ],
          ),
        ],
      );

  static Widget buildSupplierAddress(String cod) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Text("Nv-$cod", style: TextStyle(fontWeight: FontWeight.bold)),
          Text(
            "Nv-$cod",
          ),
          SizedBox(height: 1 * PdfPageFormat.mm),
          //Text("adreess"),
        ],
      );

  static Widget buildTitle(PedidoEntity registro) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Text(
          //   "NV-" + codRef,
          //   style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          // ),
          SizedBox(height: 0.8 * PdfPageFormat.cm),
          Text("Fecha : ${registro.fecha}"),
          SizedBox(height: 0.8 * PdfPageFormat.cm),
          Text("Cliente : ${registro.nomUsuario}"),
          SizedBox(height: 0.8 * PdfPageFormat.cm),
          Text("Observaciones : ${registro.observacion}"),
          SizedBox(height: 0.8 * PdfPageFormat.cm),
        ],
      );

  static Widget buildInvoice(PedidoEntity invoice) {
    final headers = ['Producto', 'Cantidad', 'Precio', 'Total'];
    final data = invoice.listdetalle.map((item) {
      //final total = item.unitPrice * item.quantity * (1 + item.vat);

      return [
        item.prd!.nombre,
        //'${item.lote}',
        ' ${item.cantidad}',
        '\$ ${item.precio.toStringAsFixed(2)} ',
        '\$ ${item.total.toStringAsFixed(2)}',
      ];
    }).toList();

    return Table.fromTextArray(
      headers: headers,
      data: data,
      border: null,
      // headerStyle: TextStyle(fontWeight: FontWeight.bold),
      headerDecoration: BoxDecoration(color: PdfColors.grey300),
      cellHeight: 30,
      cellAlignments: {
        0: Alignment.centerLeft,
        //1: Alignment.centerRight,
        1: Alignment.centerRight,
        2: Alignment.centerRight,
        3: Alignment.centerRight,
      },
    );
  }

  static Widget buildTotal(PedidoEntity invoice) {
    final netTotal = invoice.listdetalle
        .map((item) =>
            double.parse(item.precio.toStringAsFixed(2)) * item.cantidad)
        .reduce((item1, item2) => item1 + item2);
    // final vatPercent = invoice.items.first.vat;
    // final vat = netTotal * vatPercent;
    // final total = netTotal + vat;

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
                buildText(
                  title: 'total',
                  //value: Utils.formatPrice(netTotal),
                  value: formatPrice(netTotal),
                  unite: true,
                ),
                // buildText(
                //   title: 'Vat ${vatPercent * 100} %',
                //   value: Utils.formatPrice(vat),
                //   unite: true,
                // ),
                // Divider(),
                // buildText(
                //   title: 'Total amount due',
                //   titleStyle: TextStyle(
                //     fontSize: 14,
                //     fontWeight: FontWeight.bold,
                //   ),
                //   value: Utils.formatPrice(total),
                //   unite: true,
                // ),
                SizedBox(height: 2 * PdfPageFormat.mm),
                Container(height: 1, color: PdfColors.grey400),
                SizedBox(height: 0.5 * PdfPageFormat.mm),
                Container(height: 1, color: PdfColors.grey400),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static buildText({
    required String title,
    required String value,
    double width = double.infinity,
    //TextStyle? titleStyle,
    bool unite = false,
  }) {
    //final style = titleStyle ?? TextStyle(fontWeight: FontWeight.bold);

    return Container(
      width: width,
      child: Row(
        children: [
          Expanded(
              child: Text(
            title,
          )),
          Text(value),
        ],
      ),
    );
  }
}
