import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tesis/domain/providers/motivos/motivosProvider.dart';
import 'package:tesis/ui/pages/widget/whiteCard.dart';

class MotivoMantenimiento extends StatefulWidget {
  const MotivoMantenimiento({Key? key}) : super(key: key);

  @override
  State<MotivoMantenimiento> createState() => _MotivoMantenimientoState();
}

class _MotivoMantenimientoState extends State<MotivoMantenimiento> {
  @override
  void initState() {
    super.initState();
    var temp = Provider.of<MotivosProvider>(context, listen: false);
    if (temp.entidad.id != 0) {
      temp.setMotivos();
    }
  }

  @override
  Widget build(BuildContext context) {
    final motivoProv = Provider.of<MotivosProvider>(context);
    return ListView(
      children: [
        WhiteCard(
          title: 'Motivo',
          child: Column(
            children: [
              Row(
                children: [
                  Text("Nombre :"),
                  Expanded(
                      child: TextFormField(
                    controller: motivoProv.ctrNombre,
                  )),
                ],
              ),
              Row(
                children: [
                  Text("Descripcion :"),
                  Expanded(
                      child: TextFormField(
                    controller: motivoProv.ctrDescripcion,
                  )),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () async {
                      await motivoProv.guardar();
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
              )
            ],
          ),
        ),
      ],
    );
  }
}
