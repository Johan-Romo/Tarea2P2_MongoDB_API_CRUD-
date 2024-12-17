import 'package:flutter/material.dart';
import '../model/persona_model.dart';
import '../controller/persona_controller.dart';

class PersonaFormView extends StatefulWidget {
  final Persona? persona;

  PersonaFormView({this.persona});

  @override
  _PersonaFormViewState createState() => _PersonaFormViewState();
}

class _PersonaFormViewState extends State<PersonaFormView> {
  final _formKey = GlobalKey<FormState>();
  final PersonaController _personaController = PersonaController();
  late String _nombre, _apellido, _telefono;

  @override
  void initState() {
    super.initState();
    if (widget.persona != null) {
      _nombre = widget.persona!.nombre;
      _apellido = widget.persona!.apellido;
      _telefono = widget.persona!.telefono;
    } else {
      _nombre = '';
      _apellido = '';
      _telefono = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.persona == null ? Text('Agregar Persona') : Text('Editar Persona'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: _nombre,
                decoration: InputDecoration(labelText: 'Nombre'),
                onSaved: (value) => _nombre = value!,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'El nombre es obligatorio';
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: _apellido,
                decoration: InputDecoration(labelText: 'Apellido'),
                onSaved: (value) => _apellido = value!,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'El apellido es obligatorio';
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: _telefono,
                decoration: InputDecoration(labelText: 'Teléfono'),
                onSaved: (value) => _telefono = value!,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'El teléfono es obligatorio';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    final persona = Persona(
                      nombre: _nombre,
                      apellido: _apellido,
                      telefono: _telefono,
                    );
                    if (widget.persona == null) {
                      _personaController.addPersona(persona);
                    } else {
                      _personaController.updatePersona(widget.persona!.id, persona);
                    }
                    Navigator.pop(context);
                  }
                },
                child: Text(widget.persona == null ? 'Agregar Persona' : 'Actualizar Persona'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
