import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tesis/domain/entities/departamentosEntity.dart';
import 'package:tesis/domain/entities/empresas/empresasEntity.dart';
import 'package:tesis/domain/providers/remplazo/remplazoProvider.dart';
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
  final key = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    var reemplazoP = Provider.of<RemplazoProvider>(context, listen: false);
    reemplazoP.getPersonas();
  }

  @override
  Widget build(BuildContext context) {
    final reemplazoP = Provider.of<RemplazoProvider>(context);
    return WhiteCard(
      title: "Reemplazo de productos",
      child: Form(
        key: key,
        child: Column(
          children: [
            Row(
              children: [
                Text("Fecha : "),
                Text("${fechaActual}"),
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
                Text("Motivo : "),
                Expanded(
                  child: TextFormField(),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {},
                  child: Text("Agregar"),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () async {
                    if (key.currentState!.validate()) {
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
                  onPressed: () {},
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
