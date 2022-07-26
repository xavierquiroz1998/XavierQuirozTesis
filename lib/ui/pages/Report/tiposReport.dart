import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:printing/printing.dart';
import 'package:provider/provider.dart';
import 'package:tesis/domain/providers/facturas/facturaProvider.dart';
import 'package:tesis/domain/providers/pedidos/pedidoProvider.dart';
import 'package:tesis/domain/providers/productos/productosProvider.dart';
import 'package:tesis/ui/pages/Report/createPdf.dart';
import 'package:tesis/ui/pages/Report/viewPdf.dart';
import 'package:tesis/ui/pages/widget/whiteCard.dart';

class TiposReport extends StatefulWidget {
  const TiposReport({Key? key}) : super(key: key);

  @override
  State<TiposReport> createState() => _TiposReportState();
}

class _TiposReportState extends State<TiposReport> {
  DateTime fechaInicio = new DateTime.now();
  DateTime fechafin = new DateTime.now();
  final DateFormat formatter = DateFormat('dd/MM/yyyy');
  final Uint8List data = Uint8List(0);

  bool incluirAnulas = false;

  Future<Null> _selectDateInicio(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: fechaInicio,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2015),
        lastDate: fechaInicio);
    if (picked != null) {
      setState(() {
        fechaInicio = picked;
      });
    }
  }

  Future<Null> _selectDateFin(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: fechafin,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: fechaInicio,
        lastDate: fechafin);
    if (picked != null) {
      setState(() {
        fechafin = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final pedidoP = Provider.of<PedidoProvider>(context);
    final facturasP = Provider.of<FacturaProvider>(context);
    final productosP = Provider.of<ProductosProvider>(context);
    return WhiteCard(
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(10),
              //color: Colors.green,
            ),
            height: 50,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Reporte de Pedidos"),
                  Row(
                    children: [
                      Text("Fecha Inicio : "),
                      GestureDetector(
                        onTap: () {
                          _selectDateInicio(context);
                        },
                        child: Container(
                          child: Text("${formatter.format(fechaInicio)}"),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text("Fecha Inicio : "),
                      GestureDetector(
                        onTap: () {
                          _selectDateFin(context);
                        },
                        child: Container(
                          child: Text("${formatter.format(fechafin)}"),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text("Incluir Anulados : "),
                      Checkbox(
                        value: incluirAnulas,
                        onChanged: (value) {
                          incluirAnulas = value!;
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                  TextButton.icon(
                    icon: Icon(Icons.picture_as_pdf),
                    onPressed: () async {
                      //  var temp = PdfInvoiceApi.generateReport1(await pedidoP.getReport1(
                      //       fechaInicio, fechafin, incluirAnulas));
                      var orde = await pedidoP.getReport1(
                          fechaInicio, fechafin, incluirAnulas);
                      var temp = await PdfInvoiceApi.generateReport1byte(orde);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ViewPdf(
                            data: temp,
                          ),
                        ),
                      );
                    },
                    label: Text(
                      "Generar PDF",
                      style: TextStyle(color: Colors.black, fontSize: 14),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(10),
              //color: Colors.green,
            ),
            height: 50,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Reporte de Productos"),
                  TextButton.icon(
                      icon: Icon(Icons.picture_as_pdf),
                      onPressed: () async {
                        if (productosP.listProducto.isEmpty) {
                          await productosP.getProductos();
                        }
                        var temp = await PdfInvoiceApi.generateListProductobyte(
                            productosP.listProducto);

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ViewPdf(
                              data: temp,
                            ),
                          ),
                        );
                      },
                      label: Text("Generar PDF",
                          style: TextStyle(color: Colors.black, fontSize: 14)))
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(10),
              //color: Colors.green,
            ),
            height: 50,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Reporte de Facturas"),
                  Row(
                    children: [
                      Text("Fecha Inicio : "),
                      GestureDetector(
                        onTap: () {
                          _selectDateInicio(context);
                        },
                        child: Container(
                          child: Text("${formatter.format(fechaInicio)}"),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text("Fecha Inicio : "),
                      GestureDetector(
                        onTap: () {
                          _selectDateFin(context);
                        },
                        child: Container(
                          child: Text("${formatter.format(fechafin)}"),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text("Incluir Anulados : "),
                      Checkbox(
                        value: incluirAnulas,
                        onChanged: (value) {
                          incluirAnulas = value!;
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                  TextButton.icon(
                    icon: Icon(Icons.picture_as_pdf),
                    onPressed: () async {
                      var temp = await PdfInvoiceApi.generateFacturasbyte(
                        await facturasP.getFacturasReport(
                            fechaInicio, fechafin, incluirAnulas),
                      );
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ViewPdf(
                            data: temp,
                          ),
                        ),
                      );
                    },
                    label: Text(
                      "Generar PDF",
                      style: TextStyle(color: Colors.black, fontSize: 14),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(10),
              //color: Colors.green,
            ),
            height: 50,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Costo vs Precio "),
                  TextButton.icon(
                      icon: Icon(Icons.picture_as_pdf),
                      onPressed: () async {
                        if (productosP.costoPrecio.isEmpty) {
                          await productosP.costovsPrecio();
                        }
                        var temp = await PdfInvoiceApi.generateListcostobyte(
                            productosP.costoPrecio);  
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ViewPdf(
                              data: temp,
                            ),
                          ),
                        );
                      },
                      label: Text("Generar PDF",
                          style: TextStyle(color: Colors.black, fontSize: 14)))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
