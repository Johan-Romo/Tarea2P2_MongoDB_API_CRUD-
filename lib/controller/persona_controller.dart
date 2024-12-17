import '../model/persona_model.dart';
import '../services/persona_Service.dart';

class PersonaController {
  final PersonaService _personaService = PersonaService();

  // Obtener todas las personas
  Future<List<Persona>> getPersonas() async {
    try {
      return await _personaService.getPersonas();
    } catch (e) {
      rethrow;
    }
  }

  // Agregar una persona
  Future<void> addPersona(Persona persona) async {
    try {
      await _personaService.addPersona(persona);
    } catch (e) {
      rethrow;
    }
  }

  // Actualizar una persona
  Future<void> updatePersona(String id, Persona persona) async {
    try {
      await _personaService.updatePersona(id, persona);
    } catch (e) {
      rethrow;
    }
  }

  // Eliminar una persona
  Future<void> deletePersona(String id) async {
    try {
      await _personaService.deletePersona(id);
    } catch (e) {
      rethrow;
    }
  }
}
