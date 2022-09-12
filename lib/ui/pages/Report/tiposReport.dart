import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tesis/domain/providers/pedidos/pedidoProvider.dart';
import 'package:tesis/ui/pages/Report/createPdf.dart';
import 'package:tesis/ui/pages/widget/whiteCard.dart';

class TiposReport extends StatefulWidget {
  const TiposReport({Key? key}) : super(key: key);

  @override
  State<TiposReport> createState() => _TiposReportState();
}

class _TiposReportState extends State<TiposReport> {
  DateTime fechaInicio = new DateTime.now();
  DateTime fechafin = new DateTime.now();
  final DateFormat formatter = DateFormat('yyyy-MM-dd');

  Future<Null> _selectDateInicio(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: fechaInicio,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2015),
        lastDate: DateTime(2101));
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
        firstDate: DateTime(2015),
        lastDate: DateTime(2101));
    if (picked != null) {
      setState(() {
        fechafin = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
       final pedidoP = Provider.of<PedidoProvider>(context);
    return WhiteCard(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Reporte 1"),
              GestureDetector(
                onTap: () {
                  _selectDateInicio(context);
                },
                child: Container(
                  child: Text("${formatter.format(fechaInicio)}"),
                ),
              ),
              GestureDetector(
                onTap: () {
                  _selectDateFin(context);
                },
                child: Container(
                  child: Text("${formatter.format(fechaInicio)}"),
                ),
              ),
              TextButton(
                  onPressed: () async {
                    PdfInvoiceApi.generateReport1(await pedidoP.getReport1(fechaInicio, fechafin));
                  },
                  child: Text("Generar"))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Reporte 2"),
              GestureDetector(
                onTap: () {
                  _selectDateInicio(context);
                },
                child: Container(
                  child: Text("${formatter.format(fechaInicio)}"),
                ),
              ),
              GestureDetector(
                onTap: () {
                  _selectDateFin(context);
                },
                child: Container(
                  child: Text("${formatter.format(fechaInicio)}"),
                ),
              ),
              TextButton(onPressed: () {}, child: Text("Generar"))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Reporte 3"),
              GestureDetector(
                onTap: () {
                  _selectDateInicio(context);
                },
                child: Container(
                  child: Text("${formatter.format(fechaInicio)}"),
                ),
              ),
              GestureDetector(
                onTap: () {
                  _selectDateFin(context);
                },
                child: Container(
                  child: Text("${formatter.format(fechaInicio)}"),
                ),
              ),
              TextButton(onPressed: () {}, child: Text("Generar"))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Reporte 4"),
              GestureDetector(
                onTap: () {
                  _selectDateInicio(context);
                },
                child: Container(
                  child: Text("${formatter.format(fechaInicio)}"),
                ),
              ),
              GestureDetector(
                onTap: () {
                  _selectDateFin(context);
                },
                child: Container(
                  child: Text("${formatter.format(fechaInicio)}"),
                ),
              ),
              TextButton(onPressed: () {}, child: Text("Generar"))
            ],
          ),
        ],
      ),
    );
  }
}
