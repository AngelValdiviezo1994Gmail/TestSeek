
import 'dart:convert';

class TareasModel {
    TareasModel({
      required this.id,
      required this.codigo,
      required this.nombre,
      required this.descripcion,
    });

    String id;
    String codigo;
    String nombre;
    String descripcion;

    //factory TareasModel.fromJson(String str) => TareasModel.fromMap(json.decode(str));

     factory TareasModel.fromJson(Map<String, dynamic> json) {
    return TareasModel(
      id: json['id'],
      codigo: json['codigo'],
      nombre: json['nombre'],
      descripcion: json['descripcion'],
    );
  }

    String toJson() => json.encode(toMap());

    Map<String, dynamic> toJsonList() {
      return {
        'id': id,
        'codigo': codigo,
        'nombre': nombre,
        'descripcion': descripcion
      };
    }

    factory TareasModel.fromMap(Map<String, dynamic> json) => TareasModel(
        id: json["id"] ?? '',
        codigo: json["codigo"] ?? '',
        nombre: json["nombre"] ?? '',
        descripcion: json["descripcion"] ?? ''
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "codigo": codigo,
        "nombre": nombre,
        "descripcion": descripcion,
    };
}
