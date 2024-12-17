import 'package:flutter/material.dart';
import 'views/pantalla_bienvenida.dart'; // Importa tu PantallaBienvenida
import 'views/persona_list_view.dart'; // Importa tu pantalla principal

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gestión de Contactos',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PantallaBienvenida(nextScreen: PersonaListView()), 
    );
  }
}
