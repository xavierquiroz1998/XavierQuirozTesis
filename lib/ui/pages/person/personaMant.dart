import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tesis/domain/entities/departamentosEntity.dart';
import 'package:tesis/domain/entities/empresas/empresasEntity.dart';
import 'package:tesis/domain/entities/tipoPersona/tipoPersonaEntity.dart';
import 'package:tesis/domain/providers/personas/personasProvider.dart';
import 'package:tesis/ui/pages/widget/whiteCard.dart';

class PersonaMantenimiento extends StatefulWidget {
  const PersonaMantenimiento({Key? key}) : super(key: key);

  @override
  State<PersonaMantenimiento> createState() => _PersonaMantenimientoState();
}

class _PersonaMantenimientoState extends State<PersonaMantenimiento> {
  @override
  void initState() {
    super.initState();

    var prov = Provider.of<PersonasProvider>(context, listen: false);
    if (prov.listEmpresas.length == 0) {
      prov.getEmpresas();
    }
    if (prov.listDepartamento.length == 0) {
      prov.getDepartamentos();
    }
  }

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<PersonasProvider>(context);
    return Container(
      child: ListView(
        children: [
          WhiteCard(
            title: 'Persona',
            child: Column(
              children: [
                Row(
                  children: [
                    Text("Identificación :"),
                    Expanded(
                        child: TextFormField(
                      controller: prov.ctrIdentificacion,
                    )),
                  ],
                ),
                Row(
                  children: [
                    Text("Tipo Persona :"),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownButton<TipoPersonaEntity>(
                          onChanged: (value) async {
                            prov.tipoPersona = value!.id;
                            prov.personaSelect = value;
                            setState(() {});
                          },
                          items: prov.listTipoPersonas.map((item) {
                            return DropdownMenuItem<TipoPersonaEntity>(
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
                          hint: Text(prov.tipoPersona != 0
                              ? prov.personaSelect.descripcion
                              : "Seleccione Tipo de Persona"),
                        ),
                      ),
                    ),
                  ],
                ),
                if (prov.tipoPersona == 1) ...{
                  Row(
                    children: [
                      Text("Empresa :"),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DropdownButton<EmpresasEntity>(
                            onChanged: (value) async {
                              prov.idempresa = value!.id;
                              prov.empresaSelect = value;

                              prov.idDepartamento = 0;
                              prov.departamentoSelect = DepartamentosEntity();

                              setState(() {});
                            },
                            items: prov.listEmpresas.map((item) {
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
                            hint: Text(prov.idempresa != 0
                                ? prov.empresaSelect.descripcion
                                : "Seleccione Empresa"),
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
                          child: DropdownButton<DepartamentosEntity>(
                            onChanged: (value) async {
                              prov.idDepartamento = value!.id;
                              prov.departamentoSelect = value;
                              setState(() {});
                            },
                            items: prov.listDepartamento
                                .where((element) =>
                                    element.idEmpresa == prov.idempresa)
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
                            hint: Text(prov.idDepartamento != 0
                                ? prov.departamentoSelect.descripcion
                                : "Seleccione Departamento"),
                          ),
                        ),
                      ),
                    ],
                  ),
                } else if (prov.tipoPersona == 3) ...{
                  Row(
                    children: [
                      Text("empresa del Proveedor:"),
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: prov.ctrEmpresaProveedor,
                        ),
                      )),
                    ],
                  ),
                },
                Row(
                  children: [
                    Text("Nombres :"),
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: prov.ctrNombres,
                      ),
                    )),
                  ],
                ),
                Row(
                  children: [
                    Text("Direccion :"),
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: prov.ctrDireccion,
                      ),
                    )),
                  ],
                ),
                Row(
                  children: [
                    Text("Correo :"),
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: prov.ctrCorreo,
                      ),
                    )),
                  ],
                ),
                Row(
                  children: [
                    Text("Celular :"),
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: prov.ctrCelular,
                      ),
                    )),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextButton(
                        onPressed: () async {
                          await prov.guardar();
                        },
                        child: Text(
                          "Guardar",
                          style: TextStyle(color: Colors.white),
                        ),
                        style:
                            TextButton.styleFrom(backgroundColor: Colors.blue),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          "Cancelar",
                          style: TextStyle(color: Colors.white),
                        ),
                        style:
                            TextButton.styleFrom(backgroundColor: Colors.blue),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
