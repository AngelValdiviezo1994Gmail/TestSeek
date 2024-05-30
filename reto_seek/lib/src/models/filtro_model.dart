import 'dart:convert';

class FiltroModel {

  FiltroModel({
      required this.id,
      required this.estado,
      required this.descripcion
    }
  );

  int id;
  bool estado;
  String? descripcion;

  //factory FiltroModel.fromJson(String str) => FiltroModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
    "id": id,
    "estado": estado,
    "descripcion": descripcion      
  };
}
