import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/persona_model.dart';

class PersonaService {
  static const String baseUrl = 'http://localhost:5000/api'; // URL de tu API

  // Obtener lista de personas
  Future<List<Persona>> getPersonas() async {
    final response = await http.get(Uri.parse('$baseUrl/personas'));

    if (response.statusCode == 200) {
      final List<dynamic> personasJson = json.decode(response.body);
      return personasJson.map((json) => Persona.fromJson(json)).toList();
    } else {
      throw Exception('Error al cargar las personas');
    }
  }

  // Agregar una nueva persona
  Future<void> addPersona(Persona persona) async {
    final response = await http.post(
      Uri.parse('$baseUrl/personas'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(persona.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception('Error al agregar la persona');
    }
  }

  // Editar una persona
  Future<void> updatePersona(String id, Persona persona) async {
    final response = await http.put(
      Uri.parse('$baseUrl/personas/$id'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(persona.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Error al editar la persona');
    }
  }

  // Eliminar una persona
  Future<void> deletePersona(String id) async {
    final response = await http.delete(Uri.parse('$baseUrl/personas/$id'));

    if (response.statusCode != 200) {
      throw Exception('Error al eliminar la persona');
    }
  }
}
