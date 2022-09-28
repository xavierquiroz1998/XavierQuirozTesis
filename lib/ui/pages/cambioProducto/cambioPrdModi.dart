import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tesis/domain/entities/departamentosEntity.dart';
import 'package:tesis/domain/entities/empresas/empresasEntity.dart';
import 'package:tesis/domain/entities/productos/productosEntity.dart';
import 'package:tesis/domain/providers/remplazo/remplazoProvider.dart';
import 'package:tesis/ui/pages/widget/helper/helPer.dart';
import 'package:tesis/ui/pages/widget/whiteCard.dart';
import 'package:tesis/ui/style/Custom_Inputs.dart';

import '../../../domain/entities/personas/personasEntity.dart';

class CambioProdMant extends StatefulWidget {
  CambioProdMant({Key? key}) : super(key: key);

  @override
  State<CambioProdMant> createState() => _CambioProdMantState();
}

class _CambioProdMantState extends State<CambioProdMant> {
  DateTime fechaActual = DateTime.now();
  final keyf = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    var reemplazoP = Provider.of<RemplazoProvider>(context, listen: false);
    reemplazoP.getPersonas();
    reemplazoP.getProductos();
  }

  @override
  Widget build(BuildContext context) {
    final reemplazoP = Provider.of<RemplazoProvider>(context);
    return WhiteCard(
      title: "Reemplazo de productos",
      child: Form(
        key: keyf,
        child: Column(
          children: [
            Row(
              children: [
                Text("Fecha : "),
                Text("${Ayuda.parseFecha(fechaActual)}"),
              ],
            ),
            Row(
              children: [
                Text("Empleado : "),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButtonFormField<PersonaEntity>(
                      onChanged: (value) async {
                        if (value != null) {
                          reemplazoP.personaSelect = value;
                          reemplazoP.cargarEmpresa_x_departamento();
                          setState(() {});
                        }
                      },
                      items: reemplazoP.listPersonas.map((item) {
                        return DropdownMenuItem<PersonaEntity>(
                          value: item,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              item.nombres,
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w400),
                            ),
                          ),
                        );
                      }).toList(),
                      validator: (value) {
                        if (value == null) {
                          return "Seleccione un Empleado";
                        }
                        return null;
                      },
                      decoration: CustomInputs.formInputDecoration(
                          hint: reemplazoP.personaSelect.id != 0
                              ? reemplazoP.personaSelect.nombres
                              : "Seleccione un Proveedor",
                          label: reemplazoP.personaSelect.id != 0
                              ? reemplazoP.personaSelect.nombres
                              : "Seleccione un Proveedor",
                          icon: Icons.assignment),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text("Empresa :"),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IgnorePointer(
                      ignoring: true,
                      child: DropdownButtonFormField<EmpresasEntity>(
                          onChanged: (value) async {},
                          items: reemplazoP.listEmpresas.map((item) {
                            return DropdownMenuItem<EmpresasEntity>(
                              value: item,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  item.descripcion,
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            );
                          }).toList(),
                          decoration: CustomInputs.formInputDecoration(
                              hint: reemplazoP.personaSelect.idempresa != 0
                                  ? reemplazoP.empresaSelect.descripcion
                                  : "Seleccione Empresa",
                              label: reemplazoP.personaSelect.idempresa != 0
                                  ? reemplazoP.empresaSelect.descripcion
                                  : "Seleccione Empresa",
                              icon: Icons.assignment)),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text("Departamento :"),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IgnorePointer(
                      ignoring: true,
                      child: DropdownButtonFormField<DepartamentosEntity>(
                          onChanged: (value) async {},
                          items: reemplazoP.listDepartamento
                              .where((element) =>
                                  element.idEmpresa ==
                                  reemplazoP.personaSelect.idempresa)
                              .map((item) {
                            return DropdownMenuItem<DepartamentosEntity>(
                              value: item,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  item.descripcion,
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            );
                          }).toList(),
                          decoration: CustomInputs.formInputDecoration(
                              hint: reemplazoP.personaSelect.idempresa != 0
                                  ? reemplazoP.departamentoSelect.descripcion
                                  : "Seleccione Departamento",
                              label: reemplazoP.personaSelect.idempresa != 0
                                  ? reemplazoP.departamentoSelect.descripcion
                                  : "Seleccione Departamento",
                              icon: Icons.assignment)),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text("Observacion : "),
                Expanded(
                  child: TextFormField(
                    controller: reemplazoP.ctobs,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    reemplazoP.agregar();
                  },
                  child: Text("Agregar"),
                ),
              ],
            ),
            Container(
              width: double.infinity,
              child: DataTable(
                columns: const [
                  DataColumn(
                    label: Center(child: Text("Producto")),
                  ),
                  DataColumn(
                    label: Center(child: Text("Cantidad")),
                  ),

                  DataColumn(
                    label: Center(child: Text("Remplazo")),
                  ),
                  DataColumn(
                    label: Center(child: Text("Cantidad")),
                  ),
                  DataColumn(
                    label: Center(child: Text("")),
                  )
                  // DataColumn(
                  //   label: Center(child: Text("Precio")),
                  // ),
                  // DataColumn(
                  //   label: Center(child: Text("Total")),
                  // ),
                ],
                rows: reemplazoP.listRemplazosDetalle
                    .map(
                      (e) => e.prd != null || reemplazoP.remplazoSelect.id == 0
                          ? DataRow(cells: [
                              DataCell(
                                DropdownButton<ProductosEntity>(
                                  onChanged: (value) async {
                                    e.idProducto1 = value!.id;
                                    e.prd = value;

                                    setState(() {});
                                  },
                                  items: reemplazoP.listProducto.map((item) {
                                    return DropdownMenuItem<ProductosEntity>(
                                      value: item,
                                      child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            item.nombre,
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w400),
                                          )),
                                    );
                                  }).toList(),
                                  hint: Text(e.idProducto1 != 0
                                      ? e.prd!.nombre
                                      : "Seleccione "),
                                ),
                              ),
                              DataCell(
                                TextFormField(
                                  initialValue: e.cantidad.toString(),
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'^(?:\+|-)?\d+$'))
                                  ],
                                  onChanged: (value) {
                                    e.cantidad = int.parse(value);
                                    //pedidoP.calculos();
                                  },
                                ),
                              ),
                              DataCell(
                                DropdownButton<ProductosEntity>(
                                  onChanged: (value) async {
                                    e.idProducto2 = value!.id;
                                    e.prd2 = value;

                                    setState(() {});
                                  },
                                  items: reemplazoP.listProducto.map((item) {
                                    return DropdownMenuItem<ProductosEntity>(
                                      value: item,
                                      child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            item.nombre,
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w400),
                                          )),
                                    );
                                  }).toList(),
                                  hint: Text(e.idProducto2 != 0
                                      ? e.prd2!.nombre
                                      : "Seleccione "),
                                ),
                              ),
                              DataCell(
                                TextFormField(
                                  initialValue: e.cantidad.toString(),
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'^(?:\+|-)?\d+$'))
                                  ],
                                  onChanged: (value) {
                                    e.cantidad2 = int.parse(value);
                                    //pedidoP.calculos();
                                  },
                                ),
                              ),
                              // DataCell(
                              //   Text("${e.precio}"),
                              // ),
                              // DataCell(
                              //   Text(NumberFormat.currency(
                              //           locale: 'en_US', symbol: r'$')
                              //       .format(e.total)),
                              // ),
                              DataCell(TextButton.icon(
                                  onPressed: () {
                                    reemplazoP.listRemplazosDetalle.remove(e);
                                  },
                                  icon: Icon(Icons.delete),
                                  label: Text("")))
                            ])
                          : DataRow(cells: [
                              DataCell(Text("")),
                              DataCell(Text("")),
                              DataCell(Text("")),
                              DataCell(Text("")),
                              DataCell(Text("")),
                            ]),
                    )
                    .toList(),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    "",
                    //"Total : ${NumberFormat.currency(locale: 'en_US', symbol: r'$').format(pedidoP.listdetalle.sum((p) => p.total))}",
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () async {
                    if (keyf.currentState!.validate()) {
                      if (await reemplazoP.guardar()) {
                        Navigator.of(context).pop();
                      } else {
                        // mensaje de error
                      }
                    }
                  },
                  child: Text("Guardar"),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("Cancelar"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
