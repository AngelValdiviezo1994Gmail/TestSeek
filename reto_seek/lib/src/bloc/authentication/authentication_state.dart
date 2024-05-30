part of 'authentication_bloc.dart';

String tokenUserGeneral = '';
bool authLocal = false;

UsuarioType? objRspUsuario;
  
final LocalAuthentication auth = LocalAuthentication(); 

//ignore: must_be_immutable
class AuthenticationState extends Equatable {

  final int varObtieneToken;
  
  UsuarioType objUs = UsuarioType(
    cedula: '',
    codigo: '',
    celular: '',
    apellidos: 'Test',
    correo: 'Test',
    identificacion: 'Test',
    nombres: 'Test',
    id: '1',
  );

  AuthenticationState(
  {
    varObtieneToken = 0,
    objUs,
    lstBannerEnRolAppGen
  }) : varObtieneToken = varObtieneToken ?? 0 {
    initSignalR();
  }
  

  AuthenticationState copyWith({
    int? getToken,
    UsuarioType? objUsuario
  }) 
  => AuthenticationState(
    varObtieneToken: getToken ?? varObtieneToken,
    objUs: objUsuario ?? objUs
  );

  Future<String> readToken() async {
    try{
      
      var connectivityResult = await (Connectivity().checkConnectivity());
    
      if (connectivityResult != ConnectivityResult.mobile && connectivityResult != ConnectivityResult.wifi) {
        return 'NI';
      }
      
      return await storage.read(key: 'TokenAppSeek') ?? ''; 
    }
    catch(ex) {
      return '';
    }
    
  }

  Future<String> autenticacionLogin(String varNumIdVal, String passWord) async {

    try{
      /*
      final baseURL = 'https://rutafitcia/Authenticate'; 

      final response = await http.post(
        Uri.parse(baseURL),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>
        {
          "tipoCliente": tipoCliente,
          "identificacion": varNumIdVal,
          "password": passWord
        }
        ),
      ); 
      */

      //storage.write(key: 'TokenAppSeek', value: '123456789');

      await readToken();
    }
    catch(_){
      return '';
    }

    return '';
  }
  
  void initSignalR() {
    //final serverUrl = CadenaConexion().apiEndpoint;
    /*
    objHubConnection = HubConnectionBuilder().withUrl(serverUrl).build();
    objHubConnection!.onclose(({error}) {});
    */
  }

  @override
  List<Object> get props => [varObtieneToken,objUs];
}