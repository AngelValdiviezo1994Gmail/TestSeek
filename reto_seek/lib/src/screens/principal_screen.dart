
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
import 'package:reto_seek/src/services/services.dart';
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
    String numIdentIngresado = '';

    final objProvMarc = Provider.of<TareasServices>(context);

    final posicionInicial = BlocProvider.of<ColorBloc>(context);
    
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          extendBody: true,
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
                child: Form(
                  //key: objProvMarc.formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                              
                        Container(
                          color: Colors.transparent,
                          width: size.width * 0.7,
                          height: size.height * 0.01,
                        ),
                
                        Container(
                          color: Colors.transparent,
                          width: size.width * 0.7,
                          height: size.height * 0.02,
                        ),
                              
                        Container(
                          width: size.width * 0.96,
                          height: size.height * 0.25,
                          alignment: Alignment.center,
                          child: ListView(
                            
                            children: [
                              Slidable(
                                
                                // Specify a key if the Slidable is dismissible.
                                key: const ValueKey(0),
              
                                // The start action pane is the one at the left or the top side.
                                startActionPane: ActionPane(
                                  // A motion is a widget used to control how the pane animates.
                                  motion: const ScrollMotion(),
              
                                  // A pane can dismiss the Slidable.
                                  dismissible: DismissiblePane(onDismissed: () {}),
              
                                  // All actions are defined in the children parameter.
                                  children: const [
                                    // A SlidableAction can have an icon and/or a label.
                                    SlidableAction(
                                      onPressed: doNothing,
                                      backgroundColor: Color(0xFFFE4A49),
                                      foregroundColor: Colors.white,
                                      icon: Icons.delete,
                                      label: 'Delete',
                                    ),
                                    SlidableAction(
                                      onPressed: doNothing,
                                      backgroundColor: Color(0xFF21B7CA),
                                      foregroundColor: Colors.white,
                                      icon: Icons.share,
                                      label: 'Share',
                                    ),
                                  ],
                                ),
              
                                // The end action pane is the one at the right or the bottom side.
                                endActionPane:  ActionPane(
                                  motion: const ScrollMotion(),
                                  children: [
                                    SlidableAction(
                                      // An action can be bigger than the others.
                                      flex: 2,
                                      onPressed: (_) => controller.openEndActionPane(),
                                      backgroundColor: const Color(0xFF7BC043),
                                      foregroundColor: Colors.white,
                                      icon: Icons.archive,
                                      label: 'Archive',
                                    ),
                                    SlidableAction(
                                      onPressed: (_) => controller.close(),
                                      backgroundColor: const Color(0xFF0392CF),
                                      foregroundColor: Colors.white,
                                      icon: Icons.save,
                                      label: 'Save',
                                    ),
                                  ],
                                ),
              
                                // The child of the Slidable is what the user sees when the
                                // component is not dragged.
                                child: const ListTile(title: Text('Slide me')),
                              ),
                              Slidable(
                                controller: controller,
                                // Specify a key if the Slidable is dismissible.
                                key: const ValueKey(1),
              
                                // The start action pane is the one at the left or the top side.
                                startActionPane: const ActionPane(
                                  // A motion is a widget used to control how the pane animates.
                                  motion: ScrollMotion(),
              
                                  // All actions are defined in the children parameter.
                                  children: [
                                    // A SlidableAction can have an icon and/or a label.
                                    SlidableAction(
                                      onPressed: doNothing,
                                      backgroundColor: Color(0xFFFE4A49),
                                      foregroundColor: Colors.white,
                                      icon: Icons.delete,
                                      label: 'Delete',
                                    ),
                                    SlidableAction(
                                      onPressed: doNothing,
                                      backgroundColor: Color(0xFF21B7CA),
                                      foregroundColor: Colors.white,
                                      icon: Icons.share,
                                      label: 'Share',
                                    ),
                                  ],
                                ),
              
                                // The end action pane is the one at the right or the bottom side.
                                endActionPane: ActionPane(
                                  motion: const ScrollMotion(),
                                  dismissible: DismissiblePane(onDismissed: () {}),
                                  children: const [
                                    SlidableAction(
                                      // An action can be bigger than the others.
                                      flex: 2,
                                      onPressed: doNothing,
                                      backgroundColor: Color(0xFF7BC043),
                                      foregroundColor: Colors.white,
                                      icon: Icons.archive,
                                      label: 'Archive',
                                    ),
                                    SlidableAction(
                                      onPressed: doNothing,
                                      backgroundColor: Color(0xFF0392CF),
                                      foregroundColor: Colors.white,
                                      icon: Icons.save,
                                      label: 'Save',
                                    ),
                                  ],
                                ),
              
                                // The child of the Slidable is what the user sees when the
                                // component is not dragged.
                                child: const ListTile(title: Text('Slide me')),
                              ),
                            ],
                          ),
                        ),
                        
                      ],
                    ),
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

}


void doNothing(BuildContext context) {}