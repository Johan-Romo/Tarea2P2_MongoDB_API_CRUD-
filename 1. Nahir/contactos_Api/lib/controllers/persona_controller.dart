import '../models/persona.dart';
import '../service/persona_service.dart';

class PersonaController {
  final PersonaService _personaService = PersonaService();

  // Método para crear una persona
  Future<Persona> crearPersona(Persona persona) async {
    try {
      return await _personaService.crearPersona(persona);
    } catch (e) {
      throw Exception('Error al crear la persona: $e');
    }
  }

  // Método para actualizar una persona
  Future<Persona> actualizarPersona(String id, Persona persona) async {
    try {
      return await _personaService.actualizarPersona(id, persona);
    } catch (e) {
      throw Exception('Error al actualizar la persona: $e');
    }
  }

  // Método para obtener todas las personas
  Future<List<Persona>> obtenerPersonas() async {
    try {
      return await _personaService.obtenerPersonas();
    } catch (e) {
      throw Exception('Error al obtener personas: $e');
    }
  }

  // Método para eliminar una persona
  Future<void> eliminarPersona(String id) async {
    try {
      await _personaService.eliminarPersona(id);
    } catch (e) {
      throw Exception('Error al eliminar persona: $e');
    }
  }
}
