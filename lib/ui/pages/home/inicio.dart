import 'package:flutter/material.dart';
import 'package:tesis/ui/pages/Dashboard/dashboardPrd.dart';
import 'package:tesis/ui/pages/widget/whiteCard.dart';

class Inicio extends StatelessWidget {
  const Inicio({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WhiteCard(
      title: "Inicio",
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DashboardProducto(),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DashboardMensual(),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DashboardAnulados(),
          )
        ],
      ),
    );
  }
}
