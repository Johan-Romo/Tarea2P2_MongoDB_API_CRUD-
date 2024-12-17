import 'package:flutter/material.dart';
import '../controllers/persona_controller.dart';
import '../models/persona.dart';
import 'persona_edit_view.dart';
import 'persona_create_view.dart';
import '../utils/constants.dart';

class PersonaListView extends StatefulWidget {
  @override
  _PersonaListViewState createState() => _PersonaListViewState();
}

class _PersonaListViewState extends State<PersonaListView> {
  final PersonaController _controller = PersonaController(); // Instancia del controlador
  late Future<List<Persona>> _personas;

  @override
  void initState() {
    super.initState();
    _recargarPersonas();
  }

  // Método para recargar la lista de personas
  void _recargarPersonas() {
    setState(() {
      _personas = _controller.obtenerPersonas();
    });
  }

  // Método para confirmar eliminación
  void _confirmarEliminacion(String id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmar Eliminación'),
          content: Text('¿Estás seguro de que deseas eliminar esta contacto?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(), // Cancelar acción
              child: Text('Cancelar', style: TextStyle(color: colorTerciario)),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop(); // Cierra el diálogo
                try {
                  await _controller.eliminarPersona(id);
                  _recargarPersonas(); // Refresca la lista después de eliminar
                } catch (e) {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Error'),
                      content: Text('No se pudo eliminar la persona.'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text('OK'),
                        ),
                      ],
                    ),
                  );
                }
              },
              child: Text('Eliminar', style: TextStyle(color: colorPrimario)),
            ),
          ],
        );
      },
    );
  }

  // Método para agregar una nueva persona
  void _agregarPersona() async {
    var nuevaPersona = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PersonaCreateView()),
    );
    if (nuevaPersona != null) {
      _recargarPersonas(); // Refresca la lista después de agregar
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Contactos'),
        backgroundColor: colorPrimario,
        foregroundColor: Colors.white,
      ),
      body: FutureBuilder<List<Persona>>(
        future: _personas,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No hay personas registradas.'));
          } else {
            List<Persona> personas = snapshot.data!;
            personas.sort((a, b) => a.nombre.compareTo(b.nombre)); // Ordena alfabéticamente

            return ListView.builder(
              itemCount: personas.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  color: colorCuaternario,
                  elevation: 10,
                  child: ListTile(
                    contentPadding: EdgeInsets.all(15),
                    leading: CircleAvatar(
                      backgroundColor: colorSecundario,
                      radius: 30,
                      child: Text(
                        personas[index].nombre[0],
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                    ),
                    title: Text(
                      '${personas[index].nombre} ${personas[index].apellido}',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: colorPrimario,
                      ),
                    ),
                    subtitle: Text(
                      personas[index].telefono,
                      style: TextStyle(color: colorPrimario),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit, color: colorPrimario),
                          onPressed: () async {
                            var personaEditada = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    PersonaEditView(persona: personas[index]),
                              ),
                            );
                            if (personaEditada != null) {
                              _recargarPersonas();
                            }
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: colorPrimario),
                          onPressed: () => _confirmarEliminacion(personas[index].id),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _agregarPersona,
        backgroundColor: colorSecundario,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
