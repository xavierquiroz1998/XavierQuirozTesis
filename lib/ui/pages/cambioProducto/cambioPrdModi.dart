import 'package:flutter/material.dart';
import 'package:tesis/ui/pages/widget/whiteCard.dart';

class CambioProdMant extends StatefulWidget {
  CambioProdMant({Key? key}) : super(key: key);

  @override
  State<CambioProdMant> createState() => _CambioProdMantState();
}

class _CambioProdMantState extends State<CambioProdMant> {
  DateTime fechaActual = DateTime.now();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WhiteCard(
      title: "Reemplazo de productos",
      child: Column(
        children: [
          Row(
            children: [
              Text("Fecha : "),
              Text("$fechaActual"),
            ],
          ),
          Row(
            children: [
              Text("Empleado : "),
              Expanded(
                child: TextFormField(),
              ),
            ],
          ),
          Row(
            children: [
              Text("Empresa : "),
              Expanded(
                child: TextFormField(),
              ),
            ],
          ),
          Row(
            children: [
              Text("Departamento : "),
              Expanded(
                child: TextFormField(),
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
                onPressed: () {},
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
    );
  }
}
