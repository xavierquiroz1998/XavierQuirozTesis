import 'package:flutter/material.dart';
import 'home.dart';
import 'injection.dart' as di;
import 'data/datasource/reference/local_storage.dart';
import 'ui/Router/FluroRouter.dart';

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
