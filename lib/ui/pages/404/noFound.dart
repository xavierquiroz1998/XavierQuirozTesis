import 'package:flutter/material.dart';
import 'package:tesis/ui/pages/widget/whiteCard.dart';

class NoPageFoundView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const WhiteCard(
      child: Center(
        child: Text(
          '404 - Página no encontrada',
          style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
