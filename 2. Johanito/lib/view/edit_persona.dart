import 'package:flutter/material.dart';
import '../controller/persona_controller.dart';
import '../model/persona_model.dart';

class PersonaEditView extends StatefulWidget {
  final Persona persona;

  PersonaEditView({required this.persona});

  @override
  _PersonaEditViewState createState() => _PersonaEditViewState();
}

class _PersonaEditViewState extends State<PersonaEditView> {
  final PersonaController _personaController = PersonaController();
  final _formKey = GlobalKey<FormState>();
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

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Persona updatedPersona = Persona(
        id: widget.persona.id,
        nombre: _nombre,
        apellido: _apellido,
        telefono: _telefono,
      );
      await _personaController.updatePersona(widget.persona.id, updatedPersona);
      Navigator.pop(context);  // Volver a la pantalla anterior
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Editar Persona')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: _nombre,
                decoration: InputDecoration(labelText: 'Nombre'),
                validator: (value) => value!.isEmpty ? 'Por favor ingresa un nombre' : null,
                onSaved: (value) => _nombre = value!,
              ),
              TextFormField(
                initialValue: _apellido,
                decoration: InputDecoration(labelText: 'Apellido'),
                validator: (value) => value!.isEmpty ? 'Por favor ingresa un apellido' : null,
                onSaved: (value) => _apellido = value!,
              ),
              TextFormField(
                initialValue: _telefono,
                decoration: InputDecoration(labelText: 'Teléfono'),
                validator: (value) => value!.isEmpty ? 'Por favor ingresa un teléfono' : null,
                onSaved: (value) => _telefono = value!,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submit,
                child: Text('Actualizar Persona'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
