import 'package:flutter/material.dart';
import 'package:tesis/ui/pages/widget/whiteCard.dart';

class EmpresasMantenimiento extends StatefulWidget {
  const EmpresasMantenimiento({Key? key}) : super(key: key);

  @override
  State<EmpresasMantenimiento> createState() => _EmpresasMantenimientoState();
}

class _EmpresasMantenimientoState extends State<EmpresasMantenimiento> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: [
          WhiteCard(
            title: 'Empresa',
            child: Column(
              children: [],
            ),
          ),
        ],
      ),
    );
  }
}