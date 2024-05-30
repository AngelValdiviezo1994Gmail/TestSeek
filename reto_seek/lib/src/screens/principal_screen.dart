
import 'package:auto_size_text/auto_size_text.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:reto_seek/environments/environments.dart';
import 'package:reto_seek/src/bloc/bloc.dart';
import 'package:reto_seek/src/models/models.dart';
import 'package:reto_seek/src/screens/screens.dart';
import 'package:reto_seek/src/services/services.dart';
import 'package:reto_seek/src/styles/styles.dart';
import 'package:reto_seek/src/ui/ui.dart';
import 'package:slide_digital_clock/slide_digital_clock.dart';

const storagePrincipal = FlutterSecureStorage();
String localidadMarcacion = '';
String ultimoCaracterEscogido = '';
ColoresApp objColoresPrincipal = ColoresApp();

//ignore: must_be_immutable
class PrincipalScreen extends StatefulWidget {
  static const String routerName = 'principalScreen';

  PrincipalScreen({Key? key}) : super(key: key);

  @override
  PrincipalScreenState createState() => PrincipalScreenState();
}

class PrincipalScreenState extends State<PrincipalScreen> with SingleTickerProviderStateMixin {
  late final controller = SlidableController(this);

  TextEditingController varControllerValidarPrinc = TextEditingController();

  @override
  void initState() {
    super.initState();
    varControllerValidarPrinc = TextEditingController();
    final posicionInicial = BlocProvider.of<ColorBloc>(context);
    posicionInicial.setPosicion(0);
    
    varControllerValidarPrinc.text = '';
    varControllerValidarPrinc = TextEditingController();
  }
  
  @override
  void dispose() {
    super.dispose();
    varControllerValidarPrinc.text = '';
    varControllerValidarPrinc = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          //extendBody: true,
          body: FutureBuilder(
            future: TareasServices().getTareas(),
              builder: (context, snapshot) {

                if (snapshot.hasError) {
                  return const Center(
                    child: AutoSizeText(
                      '!UPS¡, intenta acceder después de unos minutos.',
                      style: TextStyle(fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                  );
                }

                if(snapshot.hasData){

                  List<TareasModel> lstTareas = snapshot.data as List<TareasModel>;

                  return Center(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                    
                          Container(
                            color: Colors.transparent,
                            width: size.width * 0.7,
                            height: size.height * 0.02,
                          ),
                    
                          Container(
                            color: Colors.transparent,
                            width: size.width * 0.7,
                            height: size.height * 0.045,
                            child: Text('Tareas', style: TextStyle(color: objColoresPrincipal.naranjaSeek, fontSize: 25),),
                          ),
                    
                          Container(
                            color: Colors.transparent,
                            width: size.width * 0.7,
                            height: size.height * 0.02,
                          ),
                                
                          Container(
                            color: Colors.transparent,
                            width: size.width * 0.55,
                            height: size.height * 0.06,
                            child:   ElevatedButton(
                          onPressed: onPressedAgregar,
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                            ),
                            padding:
                                MaterialStateProperty.all(const EdgeInsets.symmetric(vertical: 8)),
                            backgroundColor: MaterialStateProperty.all(Style.buttonColor),
                          ),
                          child: const Text(
                                  'Agregar',
                                  style: TextStyle(
                                    fontFamily: 'Nunito',
                                    color: Colors.white,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        ),
                      
                          ),
                                      
                          Container(
                            color: Colors.transparent,
                            width: size.width * 0.7,
                            height: size.height * 0.02,
                          ),
                                      
                          if(lstTareas.isEmpty)
                          Container(
                            color: Colors.transparent,
                            width: size.width * 0.7,
                            height: size.height * 0.03,
                            child: const Text('No existen tareas registradas'),
                          ),
                                
                          if(lstTareas.isNotEmpty)
                          Container(
                            width: size.width * 0.96,
                            height: size.height * 0.85,
                            alignment: Alignment.center,
                            color: Colors.transparent,
                            child: Center(
                              child: ListView.builder(
                                itemCount: lstTareas.length,
                                itemBuilder: (context, index) {
                                  return Slidable(                                    
                                    key: const ValueKey(0), 
                                    // The end action pane is the one at the right or the bottom side.
                                    endActionPane: const ActionPane(
                                      motion: ScrollMotion(),
                                      children: [
                                        SlidableAction(
                                          onPressed: doNothing,
                                          backgroundColor: Color(0xFFFE4A49),
                                          foregroundColor: Colors.white,
                                          icon: Icons.delete,
                                          label: 'Eliminar',
                                        ),
                                        SlidableAction(
                                          onPressed: doNothing,
                                          backgroundColor: Color(0xFF21B7CA),
                                          foregroundColor: Colors.white,
                                          icon:  Icons.archive,
                                          label: 'Editar',
                                        ),
                                      ],
                                    ),
                                  
                                    child: ListTile(
                                      title: Container(
                                        width: size.width * 0.8,
                                          height: size.height * 0.065,
                                        decoration: BoxDecoration(
                                              color: Colors.transparent,
                                              border: Border.all(
                                                  color: const Color.fromARGB(255, 217, 217, 217)),
                                              borderRadius: const BorderRadius.all(Radius.circular(10))
                                            ),
                                        child: Center(child: Text(lstTareas[index].descripcion))
                                      )
                                    ),
                                  );
                                }
                              ),
                            ),
                          ),
                          
                        ],
                      ),
                    ),
                  );
            
                } 
              
            
               return Center(
                  child: Container(
                    width: size.width * 0.4,
                    height: size.height * 0.3,
                    color: Colors.transparent,
                    child: Image.asset('assets/loading.gif'),
                  ),
                );
            }
          )
        )
      )
    );
  }

  void onPressed() async {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => PrincipalScreen(),
      ),
    );
  }

  void onPressedAgregar() async {
    Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => AgregarTareaScreen(),
          ),
        );
  }



}


  


void doNothing(BuildContext context) {}