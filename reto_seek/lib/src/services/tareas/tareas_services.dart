import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:reto_seek/src/models/models.dart';

class TareasServices extends ChangeNotifier {
 
  final storage = const FlutterSecureStorage();

  List<TareasModel> _lstTareasModel = [];
  List<TareasModel> get lstTareasModel => _lstTareasModel;
  set lstTareasModel(List<TareasModel> valor) {
    _lstTareasModel = valor;
    notifyListeners();
  }

  Future<List<TareasModel>> getTareas() async {
    try {
      String? lstTareasTmp = await storage.read(key: 'lstTareas');
      
      if(lstTareasTmp != null) {

        List<dynamic> jsonList = jsonDecode(lstTareasTmp);
        List<TareasModel> lstTmp = jsonList.map((json) => TareasModel.fromJson(json)).toList();
        _lstTareasModel = lstTmp;
      }
      
      return _lstTareasModel;
    } on Exception catch (ex) {
      return [];
    }
  }

  Future<String> guardarTarea(TareasModel objTareasModel) async {
    try {
      String rsp = '';
      
      String? lstTareasTmp = await storage.read(key: 'lstTareas');
      
      if(lstTareasTmp != null) {

        List<dynamic> jsonList = jsonDecode(lstTareasTmp);

        List<TareasModel> lstTmp = jsonList.map((json) => TareasModel.fromJson(json)).toList();
        _lstTareasModel = [];
        _lstTareasModel = lstTmp;
        
        int contLst = _lstTareasModel.length + 1;
        objTareasModel.id = contLst.toString();

        _lstTareasModel.add(objTareasModel);

        // Convertir la lista de objetos Persona a una lista de mapas (maps)
        List<Map<String, dynamic>> tareasMap = _lstTareasModel.map((item) => item.toJsonList()).toList();

        // Convertir la lista de mapas a JSON
        String tareasJson = jsonEncode(tareasMap);
        await storage.write(key: 'lstTareas', value: tareasJson);
      } else {
        List<TareasModel> lstTmp = [];
        objTareasModel.id = '1';
        lstTmp.add(objTareasModel);

        _lstTareasModel = [];
        _lstTareasModel = lstTmp;

        List<Map<String, dynamic>> tareasMap = _lstTareasModel.map((item) => item.toJsonList()).toList();

        // Convertir la lista de mapas a JSON
        String tareasJson = jsonEncode(tareasMap);
        await storage.write(key: 'lstTareas', value: tareasJson);
      }
      
      notifyListeners();
      return rsp;
    } on Exception catch (_) {
      return '';
    }
  }

  Future<void> actualizaTarea(TareasModel objTareasModel) async {
    try {
      
      String? lstTareasTmp = await storage.read(key: 'lstTareas');
      
      if(lstTareasTmp != null) {

        List<dynamic> jsonList = jsonDecode(lstTareasTmp);

        List<TareasModel> lstTmp = jsonList.map((json) => TareasModel.fromJson(json)).toList();

        _lstTareasModel = lstTmp;
        
        for(int i = 0; i < _lstTareasModel.length; i++){
          if(_lstTareasModel[i].id == objTareasModel.id) {
            _lstTareasModel[i].descripcion = objTareasModel.descripcion;
            _lstTareasModel[i].codigo = objTareasModel.codigo;
            _lstTareasModel[i].nombre = objTareasModel.nombre;
          }
        }

        // Convertir la lista de objetos Persona a una lista de mapas (maps)
        List<Map<String, dynamic>> tareasMap = _lstTareasModel.map((item) => item.toJsonList()).toList();

        // Convertir la lista de mapas a JSON
        String tareasJson = jsonEncode(tareasMap);
        await storage.write(key: 'lstTareas', value: tareasJson);
      }
      
      notifyListeners();
    } on Exception catch (_) {

    }
  }

  Future<void> eliminaTarea(String id) async {
    try {
      
      String? lstTareasTmp = await storage.read(key: 'lstTareas');
      
      if(lstTareasTmp != null) {

        List<dynamic> jsonList = jsonDecode(lstTareasTmp);

        List<TareasModel> lstTmp = jsonList.map((json) => TareasModel.fromJson(json)).toList();

        _lstTareasModel = lstTmp;

        List<TareasModel> lstTmpDelete = [];
        
        for(int i = 0; i < _lstTareasModel.length; i++){
          if(_lstTareasModel[i].id != id) {
            lstTmpDelete.add(_lstTareasModel[i]);
          }
        }

        _lstTareasModel = [];
        _lstTareasModel = lstTmpDelete;

        // Convertir la lista de objetos Persona a una lista de mapas (maps)
        List<Map<String, dynamic>> tareasMap = _lstTareasModel.map((item) => item.toJsonList()).toList();

        // Convertir la lista de mapas a JSON
        String tareasJson = jsonEncode(tareasMap);
        await storage.write(key: 'lstTareas', value: tareasJson);
      }
      
      notifyListeners();
    } on Exception catch (_) {

    }
  }

}
