import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tesis/domain/providers/empresas/empresasProvider.dart';
import 'package:tesis/ui/pages/widget/whiteCard.dart';

class EmpresasMantenimiento extends StatefulWidget {
  const EmpresasMantenimiento({Key? key}) : super(key: key);

  @override
  State<EmpresasMantenimiento> createState() => _EmpresasMantenimientoState();
}

class _EmpresasMantenimientoState extends State<EmpresasMantenimiento> {
  final key = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    var empProviderTemp = Provider.of<EmpresasProvider>(context, listen: false);
    if (empProviderTemp.entidad.id != 0) {
      empProviderTemp.setEmpresa();
    }
  }

  @override
  Widget build(BuildContext context) {
    final empProvider = Provider.of<EmpresasProvider>(context);
    return Container(
      child: ListView(
        children: [
          WhiteCard(
            title: 'Empresa',
            child: Form(
              key: key,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20, right: 5),
                        child: Text("Nombre :"),
                      ),
                      Expanded(
                        child: TextFormField(
                          controller: empProvider.ctrNombre,
                          maxLength: 20,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Ingrese Nombre de la empresa";
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
                          maxLength: 50,
                          controller: empProvider.ctrDescripcion,
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
                            await empProvider.guardar();
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
      ),
    );
  }
}
