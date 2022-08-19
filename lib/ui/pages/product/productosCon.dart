import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tesis/domain/Navigation/NavigationService.dart';
import 'package:tesis/domain/providers/productos/productosProvider.dart';
import 'package:tesis/ui/Router/FluroRouter.dart';
import 'package:tesis/ui/pages/widget/whiteCard.dart';

class ProductosConsulta extends StatefulWidget {
  const ProductosConsulta({Key? key}) : super(key: key);

  @override
  State<ProductosConsulta> createState() => _ProductosConsultaState();
}

class _ProductosConsultaState extends State<ProductosConsulta> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    var temp = Provider.of<ProductosProvider>(context, listen: false);
    temp.getProductos();
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductosProvider>(context);
    return ListView(
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
                    DataColumn(
                      label: Center(child: Text("Acciones")),
                    ),
                  ],
                  rows: productProvider.listProducto.map((e) {
                    return DataRow(cells: [
                      DataCell(
                        Text("${e.codigo}"),
                      ),
                      DataCell(
                        Text("${e.nombre}"),
                      ),
                      DataCell(
                        Text("${e.stock}"),
                      ),
                      DataCell(
                        Text("${e.estado}"),
                      ),
                      DataCell(
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 5, right: 5),
                              child: TextButton.icon(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.edit,
                                  color: Colors.blue,
                                ),
                                label: Text(""),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 5, right: 5),
                              child: TextButton.icon(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                label: Text(""),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ]);
                  }).toList(),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
