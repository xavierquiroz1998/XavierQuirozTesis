import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tesis/domain/entities/departamentosEntity.dart';
import 'package:tesis/domain/entities/empresas/empresasEntity.dart';
import 'package:tesis/domain/entities/tipoPersona/tipoPersonaEntity.dart';
import 'package:tesis/domain/providers/personas/personasProvider.dart';
import 'package:tesis/ui/pages/widget/whiteCard.dart';
import 'package:tesis/ui/style/Custom_Inputs.dart';

class PersonaMantenimiento extends StatefulWidget {
  const PersonaMantenimiento({Key? key}) : super(key: key);

  @override
  State<PersonaMantenimiento> createState() => _PersonaMantenimientoState();
}

class _PersonaMantenimientoState extends State<PersonaMantenimiento> {
  final keyProducto = GlobalKey<FormState>();

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

  int limite = 10;

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<PersonasProvider>(context);
    return Container(
      child: ListView(
        children: [
          WhiteCard(
            title: 'Persona',
            child: Form(
              key: keyProducto,
              child: Column(
                children: [
                  Row(
                    children: [
                      Text("Identificación :"),
                      Expanded(
                        child: TextFormField(
                          maxLength: limite,
                          controller: prov.ctrIdentificacion,
                          validator: ((value) {
                            if (value!.isEmpty) {
                              return "Ingrese # de Identificación";
                            }
                            if (value.length != limite) {
                              if (limite == 13) {
                                return "Ingrese # de Identificación RUC";
                              } else if (limite == 10) {
                                return "Ingrese # de Identificación Correcto 10 Caracteres";
                              }
                            }
                            return null;
                          }),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text("Tipo Persona :"),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DropdownButtonFormField<TipoPersonaEntity>(
                              onChanged: (value) async {
                                prov.tipoPersona = value!.id;
                                prov.personaSelect = value;
                                if (prov.tipoPersona == 3) {
                                  limite = 13;
                                }
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
                              validator: (value) {
                                if (value == null) {
                                  return "Seleccione una Tipo de Persona";
                                }

                                return null;
                              },
                              decoration: CustomInputs.formInputDecoration(
                                  hint: prov.tipoPersona != 0
                                      ? prov.personaSelect.descripcion
                                      : "Seleccione Tipo de Persona",
                                  label: prov.tipoPersona != 0
                                      ? prov.personaSelect.descripcion
                                      : "Seleccione Tipo de Persona",
                                  icon: Icons.assignment)),
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
                            child: DropdownButtonFormField<EmpresasEntity>(
                                onChanged: (value) async {
                                  prov.idempresa = value!.id;
                                  prov.empresaSelect = value;

                                  prov.idDepartamento = 0;
                                  prov.departamentoSelect =
                                      DepartamentosEntity();

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
                                validator: (value) {
                                  if (prov.tipoPersona == 1) {
                                    if (value == null) {
                                      return "Seleccione una Empresa";
                                    }
                                  }

                                  return null;
                                },
                                decoration: CustomInputs.formInputDecoration(
                                    hint: prov.idempresa != 0
                                        ? prov.empresaSelect.descripcion
                                        : "Seleccione Empresa",
                                    label: prov.idempresa != 0
                                        ? prov.empresaSelect.descripcion
                                        : "Seleccione Empresa",
                                    icon: Icons.assignment)),
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
                            child: DropdownButtonFormField<DepartamentosEntity>(
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
                                validator: (value) {
                                  if (prov.tipoPersona == 1) {
                                    if (value == null) {
                                      return "Seleccione un Departamento";
                                    }
                                  }

                                  return null;
                                },
                                decoration: CustomInputs.formInputDecoration(
                                    hint: prov.idDepartamento != 0
                                        ? prov.departamentoSelect.descripcion
                                        : "Seleccione Departamento",
                                    label: prov.idDepartamento != 0
                                        ? prov.departamentoSelect.descripcion
                                        : "Seleccione Departamento",
                                    icon: Icons.assignment)),
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
                              validator: (value) {
                                if (prov.tipoPersona == 3) {
                                  if (value!.isEmpty) {
                                    return "Ingrese # de Identificación";
                                  }
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
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
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Ingrese Nombres de la Persona";
                            }
                            return null;
                          },
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
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Ingrese Direccion de la Persona";
                            }
                            return null;
                          },
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
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Ingrese correo de la Persona";
                            }
                            return null;
                          },
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
                            if (keyProducto.currentState!.validate()) {
                              if (await prov.guardar()) {
                                Navigator.of(context).pop();
                              }
                            }
                          },
                          child: Text(
                            "Guardar",
                            style: TextStyle(color: Colors.white),
                          ),
                          style: TextButton.styleFrom(
                              backgroundColor: Colors.blue),
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
                          style: TextButton.styleFrom(
                              backgroundColor: Colors.blue),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
