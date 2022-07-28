import 'package:flutter/material.dart';
import 'package:tesis/data/datasource/reference/local_storage.dart';
import 'package:tesis/ui/Router/FluroRouter.dart';
import 'home.dart';
import 'injection.dart' as di;

void main() {
  ErrorWidget.builder = (details) => ErrorFailWidget(
        detail: details,
      );
  LocalStorage.configurePrefs();
  di.init();
  Flurorouter.configureRoutes();
  runApp(MyApp());
}

class ErrorFailWidget extends StatelessWidget {
  FlutterErrorDetails? detail;
  ErrorFailWidget({this.detail});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Text(detail!.exception.toString())],
      ),
    );
  }
}
