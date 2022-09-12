import 'dart:typed_data';

import 'package:darq/darq.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:tesis/domain/entities/pedidos/pedidosEntity.dart';
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

  static Future generateReport1(List<PedidoEntity> invoice) async {
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

    PdfApi.saveDocument(name: 'Report001.pdf', pdf: pdf);
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
          Text("Nv-$cod", style: TextStyle(fontWeight: FontWeight.bold)),
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

  static Widget buildInvoiceReport(List<PedidoEntity> invoice) {
    final headers = ['Fecha', 'cliente', 'Cantidad', 'Total'];
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
