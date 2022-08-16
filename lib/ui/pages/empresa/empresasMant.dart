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
  @override
  Widget build(BuildContext context) {
    final empProvider = Provider.of<EmpresasProvider>(context);
    return Container(
      child: ListView(
        children: [
          WhiteCard(
            title: 'Empresa',
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text("Nombre :"),
                    Expanded(
                        child: TextFormField(
                      controller: empProvider.ctrNombre,
                    )),
                  ],
                ),
                Row(
                  children: [
                    Text("Descripcion :"),
                    Expanded(
                        child: TextFormField(
                      controller: empProvider.ctrDescripcion,
                    )),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () async {
                        await empProvider.guardar();
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
      ),
    );
  }
}
