import 'package:flutter/material.dart';
import 'package:tesis/domain/Navigation/NavigationService.dart';
import 'package:tesis/ui/Router/FluroRouter.dart';
import 'package:tesis/ui/pages/widget/whiteCard.dart';

class ProductosConsulta extends StatefulWidget {
  const ProductosConsulta({Key? key}) : super(key: key);

  @override
  State<ProductosConsulta> createState() => _ProductosConsultaState();
}

class _ProductosConsultaState extends State<ProductosConsulta> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: [
          WhiteCard(
            title: 'Productos',
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      //style: ButtonStyle(),
                      onPressed: () {
                        NavigationService.navigateTo(
                            Flurorouter.productoMantenimiento);
                      },
                      child: Text("Nuevo"),
                    ),
                  ],
                ),
                Container(
                  width: double.infinity,
                  child: DataTable(
                    columns: const [
                      DataColumn(
                        label: Center(child: Text("Código")),
                      ),
                      DataColumn(
                        label: Center(child: Text("Nombre")),
                      ),
                      DataColumn(
                        label: Center(child: Text("Stock")),
                      ),
                      DataColumn(
                        label: Center(child: Text("Estado")),
                      ),
                    ],
                    rows: const [
                      DataRow(
                        cells: [
                          DataCell(
                            Text(""),
                          ),
                          DataCell(
                            Text(""),
                          ),
                          DataCell(
                            Text(""),
                          ),
                          DataCell(
                            Text(""),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
