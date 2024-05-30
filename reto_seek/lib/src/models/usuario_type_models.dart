import 'dart:convert';

class UsuarioType {
    UsuarioType({
      required this.id,
      required this.identificacion,
      required this.nombres,
      required this.apellidos,
      required this.correo,
      required this.celular,
      required this.cedula,
      required this.codigo
    }
  );

    String id;
    String? cedula;
    String? codigo;
    String celular;
    String identificacion;
    String nombres;
    String apellidos;
    String correo;

    factory UsuarioType.fromJson(String str) => UsuarioType.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory UsuarioType.fromMap(Map<String, dynamic> json) => UsuarioType(
      id: json["id"] ?? '',
      celular: json["celular"] ?? '',
      identificacion: json["identificacion"] ??'',
      nombres: json["nombres"] ?? '',
      apellidos: json["apellidos"] ?? '',
      correo: json["correo"] ?? json["Correo"] ?? '',
      cedula: json["cedula"] ?? '',
      codigo: json["codigo"] ?? '',
    );

    Map<String, dynamic> toMap() => {
      "id": id,
      "identificacion": identificacion,
      "nombres": nombres,
      "apellidos": apellidos,
      "correo": correo
    };
}
