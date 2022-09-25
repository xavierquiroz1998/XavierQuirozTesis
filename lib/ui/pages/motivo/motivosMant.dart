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
  final key = GlobalKey<FormState>();
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
          child: Form(
            key: key,
            child: Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20, right: 5),
                      child: Text("Nombre :"),
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: motivoProv.ctrNombre,
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
                        controller: motivoProv.ctrDescripcion,
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
                          await motivoProv.guardar();
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
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
