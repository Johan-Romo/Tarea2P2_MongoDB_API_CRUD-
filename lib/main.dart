import 'package:flutter/material.dart';
import 'view/persona_view.dart';
import 'view/detail_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contactos',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PersonaListView(),
      routes: {
        '/persona-form': (context) => PersonaFormView(),
      },
    );
  }
}
