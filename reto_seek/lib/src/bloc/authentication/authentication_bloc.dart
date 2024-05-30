
//ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'dart:convert'; 
import 'package:http/http.dart' as http;
import 'package:equatable/equatable.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:local_auth/local_auth.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:reto_seek/src/models/models.dart';
/*
import 'package:signalr_netcore/hub_connection.dart';
import 'package:signalr_netcore/hub_connection_builder.dart';
*/

part 'authentication_event.dart';
part 'authentication_state.dart';

const storage = FlutterSecureStorage();

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  int obtieneToken = 0;
  UsuarioType objUsBloc = UsuarioType(
    cedula: '',
    codigo: '',
    celular: '',
    apellidos: 'Test',
    correo: 'Test',
    identificacion: 'Test',
    nombres: 'Test',
    id: '1',
  );

  AuthenticationBloc() : super(AuthenticationState(varObtieneToken: 0)) {
    on<OnNewAutenticacionEvent>(_onReInitPosition);
    on<GetNewAutenticacionEvent>(_onNewUser);
  }

  Future<void> init() async {
    add( OnNewAutenticacionEvent(obtieneToken),);
    add( GetNewAutenticacionEvent(objUsBloc),);
  }

  void _onReInitPosition( OnNewAutenticacionEvent event, Emitter<AuthenticationState> emit ) {
    emit( state.copyWith( getToken: obtieneToken ) );
  }

  void _onNewUser( GetNewAutenticacionEvent event, Emitter<AuthenticationState> emit ) {
    emit( state.copyWith( getToken: obtieneToken, objUsuario: objUsBloc ) );
  }

  void getPosicion() {
    //PosicionInicial 
    add(OnNewAutenticacionEvent(obtieneToken));
  }

  void setInicicaSesion(int obtuvoToken) {
    obtieneToken = obtuvoToken;
    add(OnNewAutenticacionEvent(obtuvoToken));
  }

  void setUsuarioLog(UsuarioType objUser) {
    objUsBloc = objUser;
    add(GetNewAutenticacionEvent(objUser));
  }


  @override
  //ignore: unnecessary_overrides
  Future<void> close() {
    return super.close();
  }

}
