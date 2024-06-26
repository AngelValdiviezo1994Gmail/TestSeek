part of 'color_bloc.dart';

class ColorState extends Equatable {

  final int positionMenu;
  final int positionFormaPago;
  final double coordenadasMapa;
  final double radioMarcacion;
  final String formaPago;
  final String localidadId;
  final String idFormaPago; 
  final bool tareasTotal;
  final bool tareasPendientes;
  final bool tareasCompletas;

  const ColorState(
    {
      positionMenu = 0,
      positionFormaPago = 0,
      coordenadasMapa = 0,
      radioMarcacion = 0,
      formaPago = 'C',
      localidadId = '',
      idFormaPago = '',
      tareasTotal = true,
      tareasPendientes = false,
      tareasCompletas = false
    } 
  ) : positionMenu = positionMenu ?? 0,
      positionFormaPago = positionFormaPago ?? 0,
      coordenadasMapa = coordenadasMapa ?? 0,
      radioMarcacion = radioMarcacion ?? 0,
      formaPago = formaPago ?? 'C',
      localidadId = localidadId ?? '',
      idFormaPago = idFormaPago ?? '',
      tareasTotal = tareasTotal ?? true,
      tareasPendientes = tareasPendientes ?? false,
      tareasCompletas = tareasCompletas ?? false;
  

  ColorState copyWith({
    int? positionMenu,
    int? positionFormaPago,
    double? coordenadasMapa,
    double? radioMarcacion,
    String? formaPago,
    String? localidadId,
    String? idFormaPago,
    bool? tareasTotal,
    bool? tareasPendientes,
    bool? tareasCompletas
  }) 
  => ColorState(
    positionMenu: positionMenu ?? this.positionMenu,
    positionFormaPago: positionFormaPago ?? this.positionFormaPago,
    coordenadasMapa: coordenadasMapa ?? this.coordenadasMapa,
    radioMarcacion: radioMarcacion ?? this.radioMarcacion,
    formaPago: formaPago ?? this.formaPago,
    localidadId: localidadId ?? this.localidadId,
    idFormaPago: idFormaPago ?? this.idFormaPago,
    tareasTotal: tareasTotal ?? this.tareasTotal,
    tareasPendientes: tareasPendientes ?? this.tareasPendientes,
    tareasCompletas: tareasCompletas ?? this.tareasCompletas
  );


  @override
  List<Object> get props => [positionMenu,positionFormaPago,coordenadasMapa,radioMarcacion,formaPago,localidadId,idFormaPago, tareasTotal, tareasPendientes, tareasCompletas];


  Future<String> waitCarga() async {
    
    return await Future.delayed(
      const Duration(milliseconds: 2500), 
        () => 'ok'
      ); 
  }
}

