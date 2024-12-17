// lib/service/persona_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/persona.dart';

class PersonaService {
  static const String _baseUrl = 'http://localhost:5000/api/personas';

  // Obtener todas las personas
  Future<List<Persona>> obtenerPersonas() async {
    final response = await http.get(Uri.parse(_baseUrl));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Persona.fromJson(json)).toList();
    } else {
      throw Exception('Error al cargar personas');
    }
  }

  // Crear una persona
  Future<Persona> crearPersona(Persona persona) async {
    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(persona.toJson()),
    );

    if (response.statusCode == 201) {
      return Persona.fromJson(json.decode(response.body));
    } else {
      throw Exception('Error al crear persona');
    }
  }

  // Actualizar una persona
  Future<Persona> actualizarPersona(String id, Persona persona) async {
    final response = await http.put(
      Uri.parse('$_baseUrl/$id'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(persona.toJson()),
    );

    if (response.statusCode == 200) {
      return Persona.fromJson(json.decode(response.body));
    } else {
      throw Exception('Error al actualizar persona');
    }
  }

  // Eliminar una persona
  Future<void> eliminarPersona(String id) async {
    final response = await http.delete(Uri.parse('$_baseUrl/$id'));

    if (response.statusCode != 200) {
      throw Exception('Error al eliminar persona');
    }
  }
}
