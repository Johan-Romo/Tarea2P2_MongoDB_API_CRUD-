class Persona {
  String id;
  String nombre;
  String apellido;
  String telefono;

  Persona({required this.id, required this.nombre, required this.apellido, required this.telefono});

  // Deserialización: convierte el JSON recibido en una instancia de Persona
  factory Persona.fromJson(Map<String, dynamic> json) {
    return Persona(
      id: json['_id'],  // Asegúrate de que el campo _id venga del backend
      nombre: json['nombre'],
      apellido: json['apellido'],
      telefono: json['telefono'],
    );
  }

  // Serialización: convierte la instancia de Persona en un JSON
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {
      'nombre': nombre,
      'apellido': apellido,
      'telefono': telefono,
    };

    if (id.isNotEmpty) {  // Solo incluir _id si no está vacío
      data['_id'] = id;
    }

    return data;
  }
}
