import 'package:flutter/material.dart';
import '../model/persona_model.dart';
import '../controller/persona_controller.dart';
import 'add_Persona.dart';
import 'edit_persona.dart';

class PersonaListView extends StatefulWidget {
  @override
  _PersonaListViewState createState() => _PersonaListViewState();
}

class _PersonaListViewState extends State<PersonaListView> {
  final PersonaController _personaController = PersonaController();
  late Future<List<Persona>> _personasFuture;

  @override
  void initState() {
    super.initState();
    _personasFuture = _personaController.getPersonas();
  }


  void _reloadPersonas() {
    setState(() {
      _personasFuture = _personaController.getPersonas();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Lista de Personas')),
      body: FutureBuilder<List<Persona>>(
        future: _personasFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No hay personas disponibles'));
          }

          final personas = snapshot.data!;

          return ListView.builder(
            itemCount: personas.length,
            itemBuilder: (context, index) {
              final persona = personas[index];
              return ListTile(
                title: Text('${persona.nombre} ${persona.apellido}'),
                subtitle: Text(persona.telefono),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        // Navegar a la pantalla de edición
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PersonaEditView(persona: persona),
                          ),
                        ).then((_) {
                          _reloadPersonas(); // Recargar la lista después de editar
                        });
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () async {
                        await _personaController.deletePersona(persona.id);
                        _reloadPersonas();  // Recargar la lista después de eliminar
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PersonaAddView()),
          ).then((_) {
            _reloadPersonas();
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
