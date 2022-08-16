import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tesis/domain/providers/departamento/departamentoProvider.dart';
import 'package:tesis/ui/pages/widget/whiteCard.dart';

class DepartamentoMantenimiento extends StatefulWidget {
  const DepartamentoMantenimiento({Key? key}) : super(key: key);

  @override
  State<DepartamentoMantenimiento> createState() =>
      _DepartamentoMantenimientoState();
}

class _DepartamentoMantenimientoState extends State<DepartamentoMantenimiento> {
  @override
  Widget build(BuildContext context) {
    final depProvider = Provider.of<DepartamentoProvider>(context);
    return ListView(
      children: [
        WhiteCard(
          title: 'Departamento',
          child: Column(
            children: [
              Row(
                children: [
                  Text("Nombre :"),
                  Expanded(
                      child: TextFormField(
                    controller: depProvider.ctrNombre,
                  )),
                ],
              ),
              Row(
                children: [
                  Text("Descripcion :"),
                  Expanded(
                      child: TextFormField(
                    controller: depProvider.ctrDescripcion,
                  )),
                ],
              ),
              Row(
                children: [
                  Text("Empresa :"),
                  Expanded(
                      child: TextFormField(
                    controller: depProvider.ctrEmpresa,
                  )),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () async {
                      await depProvider.guardar();
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
      ],
    );
  }
}
