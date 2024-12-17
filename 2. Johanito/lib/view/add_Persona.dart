import 'package:flutter/material.dart';
import '../controller/persona_controller.dart';
import '../model/persona_model.dart';

class PersonaAddView extends StatefulWidget {
@override
_PersonaAddViewState createState() => _PersonaAddViewState();
}

class _PersonaAddViewState extends State<PersonaAddView> {
  final PersonaController _personaController = PersonaController();
  final _formKey = GlobalKey<FormState>();
  String _nombre = '';
  String _apellido = '';
  String _telefono = '';

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Persona nuevaPersona = Persona(nombre: _nombre, apellido: _apellido, telefono: _telefono);
      await _personaController.addPersona(nuevaPersona);
      Navigator.pop(context);  // Volver a la pantalla anterior
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Agregar Persona')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Nombre'),
                validator: (value) => value!.isEmpty ? 'Por favor ingresa un nombre' : null,
                onSaved: (value) => _nombre = value!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Apellido'),
                validator: (value) => value!.isEmpty ? 'Por favor ingresa un apellido' : null,
                onSaved: (value) => _apellido = value!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Teléfono'),
                validator: (value) => value!.isEmpty ? 'Por favor ingresa un teléfono' : null,
                onSaved: (value) => _telefono = value!,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submit,
                child: Text('Agregar Persona'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}