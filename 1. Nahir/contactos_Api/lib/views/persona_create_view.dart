import 'package:flutter/material.dart';
import '../controllers/persona_controller.dart';
import '../models/persona.dart';
import '../utils/constants.dart';

class PersonaCreateView extends StatefulWidget {
  @override
  _PersonaCreateViewState createState() => _PersonaCreateViewState();
}

class _PersonaCreateViewState extends State<PersonaCreateView> {
  final _formKey = GlobalKey<FormState>();
  final PersonaController _controller = PersonaController(); // Instancia del controlador
  String _nombre = '';
  String _apellido = '';
  String _telefono = '';

  void _crearPersona() async {
    if (_formKey.currentState!.validate()) {
      Persona persona = Persona(id: '', nombre: _nombre, apellido: _apellido, telefono: _telefono);

      try {
        Persona nuevaPersona = await _controller.crearPersona(persona); // Llama al controlador

        // Mostrar Snackbar de éxito
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Contacto creado con éxito'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 2),
          ),
        );

        Navigator.pop(context, nuevaPersona);
      } catch (e) {
        // Mostrar cuadro de diálogo de error
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Error'),
            content: Text('No se pudo crear la persona. Intenta nuevamente.'),
            actions: [
              TextButton(onPressed: () => Navigator.pop(context), child: Text('OK')),
            ],
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorPrimario,
      appBar: AppBar(
        title: Text('Crear Contacto'),
        backgroundColor: colorPrimario,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Container(
                margin: EdgeInsets.only(top: 50),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                width: MediaQuery.of(context).size.width * 0.9,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(height: 60),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Nombre',
                          labelStyle: TextStyle(color: colorCuaternario),
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value) => _nombre = value,
                        validator: (value) => value!.isEmpty ? 'Por favor ingrese un nombre' : null,
                      ),
                      SizedBox(height: 15),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Apellido',
                          labelStyle: TextStyle(color: colorCuaternario),
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value) => _apellido = value,
                        validator: (value) => value!.isEmpty ? 'Por favor ingrese un apellido' : null,
                      ),
                      SizedBox(height: 15),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Teléfono',
                          labelStyle: TextStyle(color: colorCuaternario),
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value) => _telefono = value,
                        validator: (value) => value!.isEmpty ? 'Por favor ingrese un teléfono' : null,
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: colorCuaternario,
                          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: _crearPersona,
                        child: Text(
                          'Crear Contacto',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              CircleAvatar(
                radius: 50,
                backgroundColor: colorCuaternario,
                child: Icon(
                  Icons.person_add,
                  color: Colors.white,
                  size: 50,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
