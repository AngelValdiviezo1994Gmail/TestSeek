part of 'color_bloc.dart';

abstract class ColorEvent extends Equatable {
  const ColorEvent();

  @override
  List<Object> get props => [];
}


class CambioColorEvent extends ColorEvent { 
  final bool isColorEnabled;
  const CambioColorEvent({required this.isColorEnabled});
}

class OnNewPositionEvent extends ColorEvent {
  final int positionMenu;
  const OnNewPositionEvent(this.positionMenu);
}

class OnNewPositionFormaPagoEvent extends ColorEvent {
  final int positionFormaPago;
  const OnNewPositionFormaPagoEvent(this.positionFormaPago);
}

class OnNewCoordenadasPositionEvent extends ColorEvent {
  final double positionCoordenadasMenu;
  const OnNewCoordenadasPositionEvent(this.positionCoordenadasMenu);
}

class OnNewFormaPagoEvent extends ColorEvent {
  final String formaPago;
  const OnNewFormaPagoEvent(this.formaPago);
}

class OnNewRadioMarcacionEvent extends ColorEvent {
  final double radioMarcacion;
  const OnNewRadioMarcacionEvent(this.radioMarcacion);
}

class OnNewLocalidadMarcacionEvent extends ColorEvent {
  final String localidadId;
  const OnNewLocalidadMarcacionEvent(this.localidadId);
}

class OnNewIdFormaPagoEvent extends ColorEvent {
  final String idFormaPago;
  const OnNewIdFormaPagoEvent(this.idFormaPago);
}