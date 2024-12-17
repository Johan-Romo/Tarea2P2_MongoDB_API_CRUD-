import 'package:flutter/material.dart';
import '../controllers/persona_controller.dart';
import '../models/persona.dart';
import '../utils/constants.dart';

class PersonaEditView extends StatefulWidget {
  final Persona persona;

  PersonaEditView({required this.persona});

  @override
  _PersonaEditViewState createState() => _PersonaEditViewState();
}

class _PersonaEditViewState extends State<PersonaEditView> {
  final _formKey = GlobalKey<FormState>();
  final PersonaController _controller = PersonaController(); // Instancia del controlador
  late String _nombre;
  late String _apellido;
  late String _telefono;

  @override
  void initState() {
    super.initState();
    _nombre = widget.persona.nombre;
    _apellido = widget.persona.apellido;
    _telefono = widget.persona.telefono;
  }

  void _actualizarPersona() async {
    if (_formKey.currentState!.validate()) {
      Persona persona = Persona(
        id: widget.persona.id,
        nombre: _nombre,
        apellido: _apellido,
        telefono: _telefono,
      );

      try {
        Persona personaActualizada = await _controller.actualizarPersona(persona.id, persona); // Usar el controlador
        Navigator.pop(context, personaActualizada);
      } catch (e) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Error'),
            content: Text('No se pudo actualizar la persona. Intenta nuevamente.'),
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
        title: Text('Editar Contacto'),
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
                        initialValue: _nombre,
                        decoration: InputDecoration(
                          labelText: 'Nombre',
                          labelStyle: TextStyle(color: colorSecundario),
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value) => _nombre = value,
                        validator: (value) => value!.isEmpty ? 'Por favor ingrese un nombre' : null,
                      ),
                      SizedBox(height: 15),
                      TextFormField(
                        initialValue: _apellido,
                        decoration: InputDecoration(
                          labelText: 'Apellido',
                          labelStyle: TextStyle(color: colorSecundario),
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value) => _apellido = value,
                        validator: (value) => value!.isEmpty ? 'Por favor ingrese un apellido' : null,
                      ),
                      SizedBox(height: 15),
                      TextFormField(
                        initialValue: _telefono,
                        decoration: InputDecoration(
                          labelText: 'Teléfono',
                          labelStyle: TextStyle(color: colorSecundario),
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value) => _telefono = value,
                        validator: (value) => value!.isEmpty ? 'Por favor ingrese un teléfono' : null,
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: colorSecundario,
                          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: _actualizarPersona,
                        child: Text(
                          'Actualizar Contacto',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              CircleAvatar(
                radius: 50,
                backgroundColor: colorSecundario,
                child: Icon(
                  Icons.person,
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
