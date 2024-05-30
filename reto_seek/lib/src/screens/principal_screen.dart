
import 'package:auto_size_text/auto_size_text.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:grouped_checkbox/grouped_checkbox.dart';
import 'package:msh_checkbox/msh_checkbox.dart';
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

//const CheckboxOrientation orientation = CheckboxOrientation();

bool lstCompleta = true;
bool lstTareasIncompletas = false;
bool lstTareasCompletas = false;

List<TareasModel> lstTotal = [];
List<TareasModel> lstTarIncom = [];
List<TareasModel> lstTarCom = [];

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
  List<FiltroModel> selectedHorizontalItems = [];
  List<FiltroModel> selectedItems = [];

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
      child: BlocBuilder<ColorBloc, ColorState>(
        builder: (context,state) { 
          return WillPopScope(
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
                          child: state.tareasTotal ?
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
          
                              Container(
                                color: Colors.transparent,
                                width: size.width * 0.95,
                                height: size.height * 0.08,
                                alignment: Alignment.centerLeft,
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.output,
                                    color: Colors.red,
                                    size: 30.0,
                                  ),
                                  onPressed: () async {
                                
                                    await  storagePrincipal.write(key: 'TokenAppSeek', value: '');
                                    await storagePrincipal.delete(key: 'TokenAppSeek');
                                
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const AuthScreen(),
                                      ),
                                    );
                                  },
                                ),
                              ),
                        
                              Container(
                                color: Colors.transparent,
                                width: size.width * 0.7,
                                height: size.height * 0.02,
                              ),
                        
                              Container(
                                color: Colors.transparent,
                                width: size.width * 0.9,
                                height: size.height * 0.045,
                                child: AutoSizeText('Arrastre hacia izquierda o derecha cada elemento de la lista para realizar una acción', style: TextStyle(color: objColoresPrincipal.naranjaSeek, fontSize: 25),),
                              ),
                        
                              Container(
                                color: Colors.transparent,
                                width: size.width * 0.7,
                                height: size.height * 0.02,
                              ),        

                              Container(
                                color: Colors.transparent,
                                width: size.width * 0.92,
                                height: size.height * 0.12,
                                alignment: Alignment.topCenter,
                                child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              color: Colors.transparent,
                                              //height: sizeScreen.height * 0.08,//90,
                                              width: size.width * 0.65,//- 110, //360,
                                              child: const Text('Lista completa')
                                            ),
                                            Container(
                                              width: size.width * 0.15,
                                              height: size.height * 0.07,
                                              color: Colors.transparent,
                                              alignment: Alignment.centerLeft,
                                              child: Center(
                                                child: MSHCheckbox(
                                                  size: size.width * 0.08,
                                                  value: state.tareasTotal,
                                                  colorConfig: MSHColorConfig.fromCheckedUncheckedDisabled(
                                                    checkedColor: Colors.green,
                                                  ),
                                                  //style: style,
                                                  onChanged: (selected) {
                                                    
                                                    final posicionInicial = BlocProvider.of<ColorBloc>(context);
                                                    posicionInicial.setTareasCompletas(false);
                                                    posicionInicial.setTareasPend(false);
                                                    posicionInicial.setTareasTotales(true);
                                                  },
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                              ),
          
                              Container(
                                color: Colors.transparent,
                                width: size.width * 0.7,
                                height: size.height * 0.02,
                              ),
          

                              Container(
                                color: Colors.transparent,
                                width: size.width * 0.92,
                                height: size.height * 0.12,
                                alignment: Alignment.topCenter,
                                child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              color: Colors.transparent,
                                              //height: sizeScreen.height * 0.08,//90,
                                              width: size.width * 0.65,//- 110, //360,
                                              child: const Text('Lista tareas pendientes')
                                            ),
                                            Container(
                                              width: size.width * 0.15,
                                              height: size.height * 0.07,
                                              color: Colors.transparent,
                                              alignment: Alignment.centerLeft,
                                              child: Center(
                                                child: MSHCheckbox(
                                                  size: size.width * 0.08,
                                                  value: state.tareasPendientes,
                                                  colorConfig: MSHColorConfig.fromCheckedUncheckedDisabled(
                                                    checkedColor: Colors.green,
                                                  ),
                                                  //style: style,
                                                  onChanged: (selected) {
                                                    
                                                    final posicionInicial = BlocProvider.of<ColorBloc>(context);
                                                    posicionInicial.setTareasCompletas(false);
                                                    posicionInicial.setTareasPend(true);
                                                    posicionInicial.setTareasTotales(false);

                                                    lstTarIncom = [];

                                                    for(int i = 0; i < lstTareas.length; i ++) {
                                                      if(!lstTareas[i].tareaCompleta)
                                                      {
                                                        lstTarIncom.add(lstTareas[i]);
                                                        }
                                                    }



                                                  },
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                              ),
          
                              Container(
                                color: Colors.transparent,
                                width: size.width * 0.7,
                                height: size.height * 0.02,
                              ),
          

                              Container(
                                color: Colors.transparent,
                                width: size.width * 0.92,
                                height: size.height * 0.12,
                                alignment: Alignment.topCenter,
                                child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              color: Colors.transparent,
                                              //height: sizeScreen.height * 0.08,//90,
                                              width: size.width * 0.65,//- 110, //360,
                                              child: const Text('Lista tareas completas')
                                            ),
                                            Container(
                                              width: size.width * 0.15,
                                              height: size.height * 0.07,
                                              color: Colors.transparent,
                                              alignment: Alignment.centerLeft,
                                              child: Center(
                                                child: MSHCheckbox(
                                                  size: size.width * 0.08,
                                                  value: state.tareasCompletas,
                                                  colorConfig: MSHColorConfig.fromCheckedUncheckedDisabled(
                                                    checkedColor: Colors.green,
                                                  ),
                                                  //style: style,
                                                  onChanged: (selected) {
                                                    
                                                    final posicionInicial = BlocProvider.of<ColorBloc>(context);
                                                    posicionInicial.setTareasCompletas(true);
                                                    posicionInicial.setTareasPend(false);
                                                    posicionInicial.setTareasTotales(false);
      
                                                      lstTarCom = [];

                                                    for(int i = 0; i < lstTareas.length; i ++) {
                                                      if(lstTareas[i].tareaCompleta)
                                                      {
                                                        lstTarCom.add(lstTareas[i]);
                                                        }
                                                    }

                                                  },
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
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
                                        startActionPane: ActionPane(
                                          motion: const ScrollMotion(),
                                          //dismissible: DismissiblePane(onDismissed: () {}),
                                      
                                          // All actions are defined in the children parameter.
                                          children: [
                                            // A SlidableAction can have an icon and/or a label.
                                            /*
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
                                              icon: Icons.share,
                                              label: 'Editar',
                                            ),
                                            */
                                            SlidableAction(
                                              //onPressed: (_) => controller.close(),
                                              onPressed: (context) async {
                                                TareasModel objTareasModel  = TareasModel(
                                                  codigo: lstTareas[index].codigo,
                                                  descripcion: lstTareas[index].descripcion,
                                                  nombre: lstTareas[index].nombre,
                                                  id: lstTareas[index].id,
                                                  tareaCompleta: true
                                                );
                                                await TareasServices().actualizaTarea(objTareasModel);
                                                Fluttertoast.showToast(
                                                  msg: 'Tarea completada exitosamente',
                                                  toastLength: Toast.LENGTH_LONG,
                                                  gravity: ToastGravity.TOP,
                                                  timeInSecForIosWeb: 5,
                                                  backgroundColor: Colors.green,
                                                  textColor: Colors.white,
                                                  fontSize: 45.0
                                                );
                                                Future.microtask(() => 
                                                  Navigator.of(context, rootNavigator: true).pushReplacement(
                                                    CupertinoPageRoute<bool>(
                                                      fullscreenDialog: true,
                                                      builder: (BuildContext context) => PrincipalScreen(),
                                                    ),
                                                  )
                                                );
                                              },
                                              backgroundColor: const Color(0xFF0392CF),
                                              foregroundColor: Colors.white,
                                              icon: Icons.save,
                                              label: 'Tarea Completada',
                                            ),
                                            
                                            SlidableAction(
                                              onPressed: (context) async {
                                                TareasModel objTareasModel  = TareasModel(
                                                  codigo: lstTareas[index].codigo,
                                                  descripcion: lstTareas[index].descripcion,
                                                  nombre: lstTareas[index].nombre,
                                                  id: lstTareas[index].id,
                                                  tareaCompleta: lstTareas[index].tareaCompleta
                                                );
                                                Future.microtask(() => 
                                                  Navigator.of(context, rootNavigator: true).pushReplacement(
                                                    CupertinoPageRoute<bool>(
                                                      fullscreenDialog: true,
                                                      builder: (BuildContext context) => EditaTareaScreen(objTareasEditModelInp: objTareasModel,),
                                                    ),
                                                  )
                                                );
                                                //await TareasServices().actualizaTarea(objTareasModel);
                                                          
                                              },
                                              backgroundColor: const Color(0xFF21B7CA),
                                              foregroundColor: Colors.white,
                                              icon:  Icons.archive,
                                              label: 'Editar',
                                            ),
                                          
                                          ],
                                        ),
          
                                        
                                      
                                        // The end action pane is the one at the right or the bottom side.
                                        endActionPane:  ActionPane(
                                          dismissible: DismissiblePane(
                                            onDismissed: () async {
                                              await TareasServices().eliminaTarea(lstTareas[index].id);
          
                                                Fluttertoast.showToast(
                                                  msg: 'Tarea eliminada exitosamente',
                                                  toastLength: Toast.LENGTH_LONG,
                                                  gravity: ToastGravity.TOP,
                                                  timeInSecForIosWeb: 5,
                                                  backgroundColor: Colors.green,
                                                  textColor: Colors.white,
                                                  fontSize: 45.0
                                                );
          
                                                Future.microtask(() => 
                                                  Navigator.of(context, rootNavigator: true).pushReplacement(
                                                    CupertinoPageRoute<bool>(
                                                      fullscreenDialog: true,
                                                      builder: (BuildContext context) => PrincipalScreen(),
                                                    ),
                                                  )
                                                );
                                            }
                                          ),
                                          motion: const ScrollMotion(),
                                          children: [
                                            SlidableAction(
                                              onPressed: (context) async {
                                                
                                              },
                                              backgroundColor: const Color(0xFFFE4A49),
                                              foregroundColor: Colors.white,
                                              icon: Icons.delete,
                                              label: 'Eliminar',
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
                                            child: Center(child: Text(lstTareas[index].nombre))
                                          )
                                        ),
                                      );
                                    }
                                  ),
                                ),
                              ),
                              
                            ],
                          )
                          :
                          state.tareasPendientes ?
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
          
                              Container(
                                color: Colors.transparent,
                                width: size.width * 0.95,
                                height: size.height * 0.08,
                                alignment: Alignment.centerLeft,
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.output,
                                    color: Colors.red,
                                    size: 30.0,
                                  ),
                                  onPressed: () {
                                
                                    storagePrincipal.write(key: 'TokenAppSeek', value: '');
                                
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const AuthScreen(),
                                      ),
                                    );
                                  },
                                ),
                              ),
                        
                              Container(
                                color: Colors.transparent,
                                width: size.width * 0.7,
                                height: size.height * 0.02,
                              ),
                        
                              Container(
                                color: Colors.transparent,
                                width: size.width * 0.9,
                                height: size.height * 0.045,
                                child: AutoSizeText('Arrastre hacia izquierda o derecha cada elemento de la lista para realizar una acción', style: TextStyle(color: objColoresPrincipal.naranjaSeek, fontSize: 25),),
                              ),
                        
                              
                              Container(
                                color: Colors.transparent,
                                width: size.width * 0.7,
                                height: size.height * 0.02,
                              ),        

                              Container(
                                color: Colors.transparent,
                                width: size.width * 0.92,
                                height: size.height * 0.12,
                                alignment: Alignment.topCenter,
                                child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              color: Colors.transparent,
                                              //height: sizeScreen.height * 0.08,//90,
                                              width: size.width * 0.65,//- 110, //360,
                                              child: const Text('Lista completa')
                                            ),
                                            Container(
                                              width: size.width * 0.15,
                                              height: size.height * 0.07,
                                              color: Colors.transparent,
                                              alignment: Alignment.centerLeft,
                                              child: Center(
                                                child: MSHCheckbox(
                                                  size: size.width * 0.08,
                                                  value: state.tareasTotal,
                                                  colorConfig: MSHColorConfig.fromCheckedUncheckedDisabled(
                                                    checkedColor: Colors.green,
                                                  ),
                                                  //style: style,
                                                  onChanged: (selected) {
                                                    
                                                    final posicionInicial = BlocProvider.of<ColorBloc>(context);
                                                    posicionInicial.setTareasCompletas(false);
                                                    posicionInicial.setTareasPend(false);
                                                    posicionInicial.setTareasTotales(true);
                                                  },
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                              ),
          
                              Container(
                                color: Colors.transparent,
                                width: size.width * 0.7,
                                height: size.height * 0.02,
                              ),
          

                              Container(
                                color: Colors.transparent,
                                width: size.width * 0.92,
                                height: size.height * 0.12,
                                alignment: Alignment.topCenter,
                                child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              color: Colors.transparent,
                                              //height: sizeScreen.height * 0.08,//90,
                                              width: size.width * 0.65,//- 110, //360,
                                              child: const Text('Lista tareas pendientes')
                                            ),
                                            Container(
                                              width: size.width * 0.15,
                                              height: size.height * 0.07,
                                              color: Colors.transparent,
                                              alignment: Alignment.centerLeft,
                                              child: Center(
                                                child: MSHCheckbox(
                                                  size: size.width * 0.08,
                                                  value: state.tareasPendientes,
                                                  colorConfig: MSHColorConfig.fromCheckedUncheckedDisabled(
                                                    checkedColor: Colors.green,
                                                  ),
                                                  //style: style,
                                                  onChanged: (selected) {
                                                    
                                                    final posicionInicial = BlocProvider.of<ColorBloc>(context);
                                                    posicionInicial.setTareasCompletas(false);
                                                    posicionInicial.setTareasPend(true);
                                                    posicionInicial.setTareasTotales(false);

                                                    lstTarIncom = [];

                                                    for(int i = 0; i < lstTareas.length; i ++) {
                                                      if(!lstTareas[i].tareaCompleta)
                                                      {
                                                        lstTarIncom.add(lstTareas[i]);
                                                        }
                                                    }



                                                  },
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                              ),
          
                              Container(
                                color: Colors.transparent,
                                width: size.width * 0.7,
                                height: size.height * 0.02,
                              ),
          

                              Container(
                                color: Colors.transparent,
                                width: size.width * 0.92,
                                height: size.height * 0.12,
                                alignment: Alignment.topCenter,
                                child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              color: Colors.transparent,
                                              //height: sizeScreen.height * 0.08,//90,
                                              width: size.width * 0.65,//- 110, //360,
                                              child: const Text('Lista tareas completas')
                                            ),
                                            Container(
                                              width: size.width * 0.15,
                                              height: size.height * 0.07,
                                              color: Colors.transparent,
                                              alignment: Alignment.centerLeft,
                                              child: Center(
                                                child: MSHCheckbox(
                                                  size: size.width * 0.08,
                                                  value: state.tareasCompletas,
                                                  colorConfig: MSHColorConfig.fromCheckedUncheckedDisabled(
                                                    checkedColor: Colors.green,
                                                  ),
                                                  //style: style,
                                                  onChanged: (selected) {
                                                    
                                                    final posicionInicial = BlocProvider.of<ColorBloc>(context);
                                                    posicionInicial.setTareasCompletas(true);
                                                    posicionInicial.setTareasPend(false);
                                                    posicionInicial.setTareasTotales(false);
      
                                                      lstTarCom = [];

                                                    for(int i = 0; i < lstTareas.length; i ++) {
                                                      if(lstTareas[i].tareaCompleta)
                                                      {
                                                        lstTarCom.add(lstTareas[i]);
                                                        }
                                                    }

                                                  },
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
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

                              /*
                              
                              
List<TareasModel> lstTotal = [];
List<TareasModel> lstTarIncom = [];
List<TareasModel> lstTarCom = [];
                               */
                                          
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
                                    itemCount: lstTarIncom.length,
                                    itemBuilder: (context, index) {
                                      return Slidable(                                    
                                        key: const ValueKey(0),                                  
                                        startActionPane: ActionPane(
                                          motion: const ScrollMotion(),
                                          //dismissible: DismissiblePane(onDismissed: () {}),
                                      
                                          // All actions are defined in the children parameter.
                                          children: [
                                            // A SlidableAction can have an icon and/or a label.
                                            /*
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
                                              icon: Icons.share,
                                              label: 'Editar',
                                            ),
                                            */
                                            SlidableAction(
                                              //onPressed: (_) => controller.close(),
                                              onPressed: (context) async {
                                                TareasModel objTareasModel  = TareasModel(
                                                  codigo: lstTarIncom[index].codigo,
                                                  descripcion: lstTarIncom[index].descripcion,
                                                  nombre: lstTarIncom[index].nombre,
                                                  id: lstTarIncom[index].id,
                                                  tareaCompleta: true
                                                );
                                                await TareasServices().actualizaTarea(objTareasModel);
                                                Fluttertoast.showToast(
                                                  msg: 'Tarea completada exitosamente',
                                                  toastLength: Toast.LENGTH_LONG,
                                                  gravity: ToastGravity.TOP,
                                                  timeInSecForIosWeb: 5,
                                                  backgroundColor: Colors.green,
                                                  textColor: Colors.white,
                                                  fontSize: 45.0
                                                );
                                                Future.microtask(() => 
                                                  Navigator.of(context, rootNavigator: true).pushReplacement(
                                                    CupertinoPageRoute<bool>(
                                                      fullscreenDialog: true,
                                                      builder: (BuildContext context) => PrincipalScreen(),
                                                    ),
                                                  )
                                                );
                                              },
                                              backgroundColor: const Color(0xFF0392CF),
                                              foregroundColor: Colors.white,
                                              icon: Icons.save,
                                              label: 'Tarea Completada',
                                            ),
                                            
                                            SlidableAction(
                                              onPressed: (context) async {
                                                TareasModel objTareasModel  = TareasModel(
                                                  codigo: lstTarIncom[index].codigo,
                                                  descripcion: lstTarIncom[index].descripcion,
                                                  nombre: lstTarIncom[index].nombre,
                                                  id: lstTarIncom[index].id,
                                                  tareaCompleta: lstTarIncom[index].tareaCompleta
                                                );
                                                Future.microtask(() => 
                                                  Navigator.of(context, rootNavigator: true).pushReplacement(
                                                    CupertinoPageRoute<bool>(
                                                      fullscreenDialog: true,
                                                      builder: (BuildContext context) => EditaTareaScreen(objTareasEditModelInp: objTareasModel,),
                                                    ),
                                                  )
                                                );
                                                //await TareasServices().actualizaTarea(objTareasModel);
                                                          
                                              },
                                              backgroundColor: const Color(0xFF21B7CA),
                                              foregroundColor: Colors.white,
                                              icon:  Icons.archive,
                                              label: 'Editar',
                                            ),
                                          
                                          ],
                                        ),
          
                                        
                                      
                                        // The end action pane is the one at the right or the bottom side.
                                        endActionPane:  ActionPane(
                                          dismissible: DismissiblePane(
                                            onDismissed: () async {
                                              await TareasServices().eliminaTarea(lstTareas[index].id);
          
                                                Fluttertoast.showToast(
                                                  msg: 'Tarea eliminada exitosamente',
                                                  toastLength: Toast.LENGTH_LONG,
                                                  gravity: ToastGravity.TOP,
                                                  timeInSecForIosWeb: 5,
                                                  backgroundColor: Colors.green,
                                                  textColor: Colors.white,
                                                  fontSize: 45.0
                                                );
          
                                                Future.microtask(() => 
                                                  Navigator.of(context, rootNavigator: true).pushReplacement(
                                                    CupertinoPageRoute<bool>(
                                                      fullscreenDialog: true,
                                                      builder: (BuildContext context) => PrincipalScreen(),
                                                    ),
                                                  )
                                                );
                                            }
                                          ),
                                          motion: const ScrollMotion(),
                                          children: [
                                            SlidableAction(
                                              onPressed: (context) async {
                                                
                                              },
                                              backgroundColor: const Color(0xFFFE4A49),
                                              foregroundColor: Colors.white,
                                              icon: Icons.delete,
                                              label: 'Eliminar',
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
                                            child: Center(child: Text(lstTarIncom[index].nombre))
                                          )
                                        ),
                                      );
                                    }
                                  ),
                                ),
                              ),
                              
                            ],
                          )
                          :
                          state.tareasCompletas ?
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
          
                              Container(
                                color: Colors.transparent,
                                width: size.width * 0.95,
                                height: size.height * 0.08,
                                alignment: Alignment.centerLeft,
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.output,
                                    color: Colors.red,
                                    size: 30.0,
                                  ),
                                  onPressed: () {
                                
                                    storagePrincipal.write(key: 'TokenAppSeek', value: '');
                                
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const AuthScreen(),
                                      ),
                                    );
                                  },
                                ),
                              ),
                        
                              Container(
                                color: Colors.transparent,
                                width: size.width * 0.7,
                                height: size.height * 0.02,
                              ),
                        
                              Container(
                                color: Colors.transparent,
                                width: size.width * 0.9,
                                height: size.height * 0.045,
                                child: AutoSizeText('Arrastre hacia izquierda o derecha cada elemento de la lista para realizar una acción', style: TextStyle(color: objColoresPrincipal.naranjaSeek, fontSize: 25),),
                              ),
                        
                              
                              Container(
                                color: Colors.transparent,
                                width: size.width * 0.7,
                                height: size.height * 0.02,
                              ),        

                              Container(
                                color: Colors.transparent,
                                width: size.width * 0.92,
                                height: size.height * 0.12,
                                alignment: Alignment.topCenter,
                                child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              color: Colors.transparent,
                                              //height: sizeScreen.height * 0.08,//90,
                                              width: size.width * 0.65,//- 110, //360,
                                              child: const Text('Lista completa')
                                            ),
                                            Container(
                                              width: size.width * 0.15,
                                              height: size.height * 0.07,
                                              color: Colors.transparent,
                                              alignment: Alignment.centerLeft,
                                              child: Center(
                                                child: MSHCheckbox(
                                                  size: size.width * 0.08,
                                                  value: state.tareasTotal,
                                                  colorConfig: MSHColorConfig.fromCheckedUncheckedDisabled(
                                                    checkedColor: Colors.green,
                                                  ),
                                                  //style: style,
                                                  onChanged: (selected) {
                                                    
                                                    final posicionInicial = BlocProvider.of<ColorBloc>(context);
                                                    posicionInicial.setTareasCompletas(false);
                                                    posicionInicial.setTareasPend(false);
                                                    posicionInicial.setTareasTotales(true);
                                                  },
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                              ),
          
                              Container(
                                color: Colors.transparent,
                                width: size.width * 0.7,
                                height: size.height * 0.02,
                              ),
          

                              Container(
                                color: Colors.transparent,
                                width: size.width * 0.92,
                                height: size.height * 0.12,
                                alignment: Alignment.topCenter,
                                child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              color: Colors.transparent,
                                              //height: sizeScreen.height * 0.08,//90,
                                              width: size.width * 0.65,//- 110, //360,
                                              child: const Text('Lista tareas pendientes')
                                            ),
                                            Container(
                                              width: size.width * 0.15,
                                              height: size.height * 0.07,
                                              color: Colors.transparent,
                                              alignment: Alignment.centerLeft,
                                              child: Center(
                                                child: MSHCheckbox(
                                                  size: size.width * 0.08,
                                                  value: state.tareasPendientes,
                                                  colorConfig: MSHColorConfig.fromCheckedUncheckedDisabled(
                                                    checkedColor: Colors.green,
                                                  ),
                                                  //style: style,
                                                  onChanged: (selected) {
                                                    
                                                    final posicionInicial = BlocProvider.of<ColorBloc>(context);
                                                    posicionInicial.setTareasCompletas(false);
                                                    posicionInicial.setTareasPend(true);
                                                    posicionInicial.setTareasTotales(false);

                                                    lstTarIncom = [];

                                                    for(int i = 0; i < lstTareas.length; i ++) {
                                                      if(!lstTareas[i].tareaCompleta)
                                                      {
                                                        lstTarIncom.add(lstTareas[i]);
                                                        }
                                                    }



                                                  },
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                              ),
          
                              Container(
                                color: Colors.transparent,
                                width: size.width * 0.7,
                                height: size.height * 0.02,
                              ),
          

                              Container(
                                color: Colors.transparent,
                                width: size.width * 0.92,
                                height: size.height * 0.12,
                                alignment: Alignment.topCenter,
                                child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              color: Colors.transparent,
                                              //height: sizeScreen.height * 0.08,//90,
                                              width: size.width * 0.65,//- 110, //360,
                                              child: const Text('Lista tareas completas')
                                            ),
                                            Container(
                                              width: size.width * 0.15,
                                              height: size.height * 0.07,
                                              color: Colors.transparent,
                                              alignment: Alignment.centerLeft,
                                              child: Center(
                                                child: MSHCheckbox(
                                                  size: size.width * 0.08,
                                                  value: state.tareasCompletas,
                                                  colorConfig: MSHColorConfig.fromCheckedUncheckedDisabled(
                                                    checkedColor: Colors.green,
                                                  ),
                                                  //style: style,
                                                  onChanged: (selected) {
                                                    
                                                    final posicionInicial = BlocProvider.of<ColorBloc>(context);
                                                    posicionInicial.setTareasCompletas(true);
                                                    posicionInicial.setTareasPend(false);
                                                    posicionInicial.setTareasTotales(false);
      
                                                      lstTarCom = [];

                                                    for(int i = 0; i < lstTareas.length; i ++) {
                                                      if(lstTareas[i].tareaCompleta)
                                                      {
                                                        lstTarCom.add(lstTareas[i]);
                                                        }
                                                    }

                                                  },
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
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
                                          
                              if(lstTarCom.isEmpty)
                              Container(
                                color: Colors.transparent,
                                width: size.width * 0.7,
                                height: size.height * 0.03,
                                child: const Text('No existen tareas completadas'),
                              ),
                                    
                              if(lstTarCom.isNotEmpty)
                              Container(
                                width: size.width * 0.96,
                                height: size.height * 0.85,
                                alignment: Alignment.center,
                                color: Colors.transparent,
                                child: Center(
                                  child: ListView.builder(
                                    itemCount: lstTarCom.length,
                                    itemBuilder: (context, index) {
                                      return Slidable(                                    
                                        key: const ValueKey(0),                                  
                                        startActionPane: ActionPane(
                                          motion: const ScrollMotion(),
                                          children: [
                                            SlidableAction(
                                              onPressed: (context) async {
                                                TareasModel objTareasModel  = TareasModel(
                                                  codigo: lstTarCom[index].codigo,
                                                  descripcion: lstTarCom[index].descripcion,
                                                  nombre: lstTarCom[index].nombre,
                                                  id: lstTarCom[index].id,
                                                  tareaCompleta: true
                                                );
                                                await TareasServices().actualizaTarea(objTareasModel);
                                                Fluttertoast.showToast(
                                                  msg: 'Tarea completada exitosamente',
                                                  toastLength: Toast.LENGTH_LONG,
                                                  gravity: ToastGravity.TOP,
                                                  timeInSecForIosWeb: 5,
                                                  backgroundColor: Colors.green,
                                                  textColor: Colors.white,
                                                  fontSize: 45.0
                                                );
                                                Future.microtask(() => 
                                                  Navigator.of(context, rootNavigator: true).pushReplacement(
                                                    CupertinoPageRoute<bool>(
                                                      fullscreenDialog: true,
                                                      builder: (BuildContext context) => PrincipalScreen(),
                                                    ),
                                                  )
                                                );
                                              },
                                              backgroundColor: const Color(0xFF0392CF),
                                              foregroundColor: Colors.white,
                                              icon: Icons.save,
                                              label: 'Tarea Completada',
                                            ),
                                            
                                            SlidableAction(
                                              onPressed: (context) async {
                                                TareasModel objTareasModel  = TareasModel(
                                                  codigo: lstTarCom[index].codigo,
                                                  descripcion: lstTarCom[index].descripcion,
                                                  nombre: lstTarCom[index].nombre,
                                                  id: lstTarCom[index].id,
                                                  tareaCompleta: lstTarCom[index].tareaCompleta
                                                );
                                                Future.microtask(() => 
                                                  Navigator.of(context, rootNavigator: true).pushReplacement(
                                                    CupertinoPageRoute<bool>(
                                                      fullscreenDialog: true,
                                                      builder: (BuildContext context) => EditaTareaScreen(objTareasEditModelInp: objTareasModel,),
                                                    ),
                                                  )
                                                );
                                                //await TareasServices().actualizaTarea(objTareasModel);
                                                          
                                              },
                                              backgroundColor: const Color(0xFF21B7CA),
                                              foregroundColor: Colors.white,
                                              icon:  Icons.archive,
                                              label: 'Editar',
                                            ),
                                          
                                          ],
                                        ),
          
                                        
                                      
                                        // The end action pane is the one at the right or the bottom side.
                                        endActionPane:  ActionPane(
                                          dismissible: DismissiblePane(
                                            onDismissed: () async {
                                              await TareasServices().eliminaTarea(lstTarCom[index].id);
          
                                                Fluttertoast.showToast(
                                                  msg: 'Tarea eliminada exitosamente',
                                                  toastLength: Toast.LENGTH_LONG,
                                                  gravity: ToastGravity.TOP,
                                                  timeInSecForIosWeb: 5,
                                                  backgroundColor: Colors.green,
                                                  textColor: Colors.white,
                                                  fontSize: 45.0
                                                );
          
                                                Future.microtask(() => 
                                                  Navigator.of(context, rootNavigator: true).pushReplacement(
                                                    CupertinoPageRoute<bool>(
                                                      fullscreenDialog: true,
                                                      builder: (BuildContext context) => PrincipalScreen(),
                                                    ),
                                                  )
                                                );
                                            }
                                          ),
                                          motion: const ScrollMotion(),
                                          children: [
                                            SlidableAction(
                                              onPressed: (context) async {
                                                
                                              },
                                              backgroundColor: const Color(0xFFFE4A49),
                                              foregroundColor: Colors.white,
                                              icon: Icons.delete,
                                              label: 'Eliminar',
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
                                            child: Center(child: Text(lstTarCom[index].nombre))
                                          )
                                        ),
                                      );
                                    }
                                  ),
                                ),
                              ),
                              
                            ],
                          )
                          : Container()
                          
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
          );
        }
      )
    );
  }

  void updateHorizontalItems(List<FiltroModel> newItems) {
    setState(() {
      selectedHorizontalItems = [];
      selectedHorizontalItems = newItems;
    });
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