import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tesis/domain/entities/empresas/empresasEntity.dart';
import 'package:tesis/domain/providers/departamento/departamentoProvider.dart';
import 'package:tesis/ui/pages/widget/whiteCard.dart';
import 'package:tesis/ui/style/Custom_Inputs.dart';

class DepartamentoMantenimiento extends StatefulWidget {
  const DepartamentoMantenimiento({Key? key}) : super(key: key);

  @override
  State<DepartamentoMantenimiento> createState() =>
      _DepartamentoMantenimientoState();
}

class _DepartamentoMantenimientoState extends State<DepartamentoMantenimiento> {
  final key = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var depTemp = Provider.of<DepartamentoProvider>(context, listen: false);
    depTemp.getEmpresas();
    if (depTemp.entity.id != 0) {
      depTemp.setDEpartamento();
    }
  }

  @override
  Widget build(BuildContext context) {
    final depProvider = Provider.of<DepartamentoProvider>(context);
    return ListView(
      children: [
        WhiteCard(
          title: 'Departamento',
          child: Form(
            key: key,
            child: Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15, right: 5),
                      child: Text("Empresa :"),
                    ),
                    Expanded(
                      child: IgnorePointer(
                        ignoring: depProvider.entity.id == 0 ? false : true,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DropdownButtonFormField<EmpresasEntity>(
                            onChanged: (value) async {
                              depProvider.idempresa = value!.id;
                              depProvider.empEntity = value;
                              setState(() {});
                            },
                            items: depProvider.listEmpresas.map((item) {
                              return DropdownMenuItem<EmpresasEntity>(
                                value: item,
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      item.descripcion,
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400),
                                    )),
                              );
                            }).toList(),
                            validator: (value) {
                              if (depProvider.entity.id == 0) {
                                if (value == null) {
                                  return "Seleccione una Empresa";
                                }
                              }

                              return null;
                            },
                            decoration: CustomInputs.formInputDecoration(
                                hint: depProvider.idempresa != 0
                                    ? depProvider.empEntity.descripcion
                                    : "Seleccione Empresa",
                                label: depProvider.idempresa != 0
                                    ? depProvider.empEntity.descripcion
                                    : "Seleccione Empresa",
                                icon: Icons.assignment),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20, right: 5),
                      child: Text("Nombre :"),
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: depProvider.ctrNombre,
                        maxLength: 20,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Ingrese Nombre";
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20, right: 5),
                      child: Text("Descripcion :"),
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: depProvider.ctrDescripcion,
                        maxLength: 50,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Ingrese Descripción";
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () async {
                        if (key.currentState!.validate()) {
                          await depProvider.guardar();
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
        ),
      ],
    );
  }
}
