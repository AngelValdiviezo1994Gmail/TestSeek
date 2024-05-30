
import 'package:audioplayers/audioplayers.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:reto_seek/environments/environments.dart';
import 'package:reto_seek/src/bloc/bloc.dart';
import 'package:reto_seek/src/services/services.dart';
import 'package:reto_seek/src/ui/ui.dart';
import 'package:slide_digital_clock/slide_digital_clock.dart';

const storagePrincipal = FlutterSecureStorage();
String localidadMarcacion = '';
String ultimoCaracterEscogido = '';
final _playerCorrect = AudioCache();
ColoresApp objColoresPrincipal = ColoresApp();

//ignore: must_be_immutable
class PrincipalScreen extends StatefulWidget {
  static const String routerName = 'principalScreen';

  PrincipalScreen({Key? key}) : super(key: key);

  @override
  PrincipalScreenState createState() => PrincipalScreenState();
}

class PrincipalScreenState extends State<PrincipalScreen> {

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
          body: Center(
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
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: objColoresPrincipal.bordesNegrosCajaTexto,
                          width: size.width * 0.004,
                          style: BorderStyle.solid
                        ),
                        borderRadius: BorderRadius.circular(size.width * 0.02),
                        color: objColoresPrincipal.bordesNegrosCajaTexto,
                      ),
                      width: size.width * 0.96,
                      height: size.height * 0.15,
                      child:  DigitalClock(
                        areaWidth: size.width * 0.95,
                        amPmDigitTextStyle: const TextStyle(fontSize: 110),
                        hourMinuteDigitTextStyle: const TextStyle(fontSize: 110, color: Colors.black),
                        secondDigitTextStyle: const TextStyle(fontSize: 53, color: Colors.black),//Theme.of(context).textTheme.caption!.copyWith(color: Colors.white),
                        areaDecoration: BoxDecoration(
                          border: Border.all(
                            color: objColoresPrincipal.bordesNegrosCajaTexto,
                            width: size.width * 0.004,
                            style: BorderStyle.solid
                          ),
                          borderRadius: BorderRadius.circular(size.width * 0.02)
                        ),
                        areaHeight: size.height * 0.15,
                        colon: Container(
                          color: Colors.transparent,
                          width: size.width * 0.02,
                          height: size.height * 0.06,
                          child: const Center(child: Text(':', style: TextStyle(fontSize: 55),)),
                        ),
                      ),
                    ),
                          
                    Container(
                      color: Colors.transparent,
                      width: size.width * 0.7,
                      height: size.height * 0.02,
                    ),
                          
                    Container(
                      width: size.width * 0.96,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: objColoresPrincipal.bordesNegrosCajaTexto,
                          width: size.width * 0.004,
                          style: BorderStyle.solid
                        ),
                        borderRadius: BorderRadius.circular(size.width * 0.02)
                      ),
                      alignment: Alignment.center,
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
                            width: size.width * 0.82,
                            height: size.height * 0.16,
                            alignment: Alignment.topCenter,
                            child: TextFormField(
                              textAlign: TextAlign.center,
                              readOnly: true,
                              controller: varControllerValidarPrinc,
                              //initialValue: numIdentIngresado,
                              style: const TextStyle(color: Colors.red, fontSize: 60, fontWeight: FontWeight.bold),
                              maxLength: 10,
                              autocorrect: false,
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                /*
                                tipoIdentificacion.varCedula = value;
                                numIdentAut = value;
                                */
                              },
                              validator: (value) {

                              },
                              decoration: InputDecorations.authInputDecoration(
                                esEdicion: false,
                                colorTexto: objColoresPrincipal.naranjaSeek,
                                varTamanioIcono: 20,
                                varEsContrasenia: false,
                                hintText: '',
                                colorBordes: objColoresPrincipal.bordesNegrosCajaTexto,
                                labelText: 'Identificación',
                                prefxIcon: null,
                                varOnPress: () {}
                              ),
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(10),
                                FilteringTextInputFormatter.digitsOnly
                              ],
                          
                            ),
                          ),
                          
                          Container(
                            color: Colors.transparent,
                            width: size.width * 0.7,
                            height: size.height * 0.04,
                          ),
                          
                          Container(
                            color: Colors.transparent,
                            width: size.width * 0.82,
                            height: size.height * 0.45,
                            child: Scaffold(
                              backgroundColor: Colors.white,
                              body: BlocBuilder<ColorBloc, ColorState>(
                                builder: (context,state) { 
                                  return Container(
                                    color: Colors.transparent,
                                    width: size.width * 0.82,
                                    height: size.height * 0.45,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          color: Colors.transparent,
                                          width: size.width * 0.25,
                                          height: size.height * 0.45,
                                          margin: const EdgeInsets.symmetric(horizontal: 1),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              
                                              Column(
                                                children: [
                                  
                                                  GestureDetector(
                                                    onTap: () async {
                                                      
                                                    },
                                                    child: Container(
                                                      width: double.infinity,
                                                      height: size.height * 0.1,//100,
                                                      decoration: BoxDecoration(
                                                        borderRadius: const BorderRadius.all(Radius.circular(15)),
                                                        shape: BoxShape.rectangle,
                                                        gradient: LinearGradient(
                                                          transform: const GradientRotation(-360),
                                                          colors: state.positionMenu == 1 ?
                                                            
                                                            <Color> [
                                                              const Color.fromRGBO(36,36,36,1),
                                                              const Color.fromRGBO(88, 89, 91, 1),
                                                            ]
                                                            :
                                                            <Color>[
                                                              const Color.fromRGBO(255,81,47,1),
                                                              const Color.fromRGBO(240, 152, 25, 1),
                                                            ]
                                                        ),
                                                          boxShadow: const [
                                                            BoxShadow(
                                                              color: Colors.white,
                                                              offset: Offset(-4,-4),
                                                              blurRadius: 5,
                                                              spreadRadius: 2
                                                            ),
                                                            BoxShadow(
                                                              color: Colors.grey,
                                                              offset: Offset(4,4),
                                                              blurRadius: 5,
                                                              spreadRadius: 2
                                                            ),
                                                          ],
                                                        
                                                        ),
                                                      child: Center(
                                                        child: Column(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            const SizedBox(height: 10,),
                                                            Text('1', style: TextStyle( fontSize: state.positionMenu == 1 ? 60 : 50, fontWeight: FontWeight.bold, color: Colors.white), textAlign: TextAlign.center),
                                                            const SizedBox(height: 10,),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                  
                                                  Container(
                                                    color: Colors.transparent,
                                                    height: size.height * 0.01,
                                                  ),
                                  
                                                  GestureDetector(
                                                    onTap: () async {
                                                      
                                                    },
                                                    child: Container(
                                                      width: double.infinity,
                                                      height: size.height * 0.1,//100,
                                                      decoration: BoxDecoration(
                                                        borderRadius: const BorderRadius.all(Radius.circular(15)),
                                                        shape: BoxShape.rectangle,
                                                        gradient: LinearGradient(
                                                          transform: const GradientRotation(-360),
                                                          colors: state.positionMenu == 4 ?
                                                            
                                                            <Color> [
                                                              const Color.fromRGBO(36,36,36,1),
                                                              const Color.fromRGBO(88, 89, 91, 1),
                                                            ]
                                                            :
                                                            <Color>[
                                                              const Color.fromRGBO(255,81,47,1),
                                                              const Color.fromRGBO(240, 152, 25, 1),
                                                            ]
                                                          
                                                        ),
                                                        boxShadow: const [
                                                          BoxShadow(
                                                            color: Colors.white,
                                                            offset: Offset(-4,-4),
                                                            blurRadius: 5,
                                                            spreadRadius: 2
                                                          ),
                                                          BoxShadow(
                                                            color: Colors.grey,
                                                            offset: Offset(4,4),
                                                            blurRadius: 5,
                                                            spreadRadius: 2
                                                          ),
                                                        ],
                                                      
                                                      ),
                                                      child: Center(
                                                        child: Column(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            const SizedBox(height: 10,),
                                                            Text('4', style: TextStyle( fontSize: state.positionMenu == 4 ? 60 : 50, fontWeight: FontWeight.bold, color: Colors.white), textAlign: TextAlign.center),
                                                            const SizedBox(height: 10,),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  
                                                  Container(
                                                    color: Colors.transparent,
                                                    height: size.height * 0.01,
                                                  ),
                                  
                                                  GestureDetector(
                                                    onTap: () async {
                                                      
                                                    },
                                                    child: Container(
                                                      width: double.infinity,
                                                      height: size.height * 0.1,//100,
                                                      decoration: BoxDecoration(
                                                        borderRadius: const BorderRadius.all(Radius.circular(15)),
                                                        shape: BoxShape.rectangle,
                                                        gradient: LinearGradient(
                                                          transform: const GradientRotation(-360),
                                                          colors: state.positionMenu == 7 ?
                          
                                                          <Color> [
                                                            const Color.fromRGBO(36,36,36,1),
                                                            const Color.fromRGBO(88, 89, 91, 1),
                                                          ]
                          
                                                          :
                                                            
                                                          <Color>[
                                                            const Color.fromRGBO(255,81,47,1),
                                                            const Color.fromRGBO(240, 152, 25, 1),
                                                          ]
                                                          
                                                        ),
                                                          boxShadow: const [
                                                            BoxShadow(
                                                              color: Colors.white,
                                                              offset: Offset(-4,-4),
                                                              blurRadius: 5,
                                                              spreadRadius: 2
                                                            ),
                                                            BoxShadow(
                                                              color: Colors.grey,
                                                              offset: Offset(4,4),
                                                              blurRadius: 5,
                                                              spreadRadius: 2
                                                            ),
                                                          ],
                                                        
                                                        ),
                                                      child: Center(
                                                        child: Column(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            const SizedBox(height: 10,),
                                                            Text('7', style: TextStyle( fontSize: state.positionMenu == 7 ? 60 : 50, fontWeight: FontWeight.bold, color: Colors.white), textAlign: TextAlign.center),
                                                            const SizedBox(height: 10,),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              
                                  
                                  
                                            ],
                                          ),
                                        ),
                          
                                        Container(
                                          color: Colors.transparent,
                                          width: size.width * 0.25,
                                          height: size.height * 0.45,
                                          margin: const EdgeInsets.symmetric(horizontal: 1),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              
                                              Column(
                                                children: [
                                  
                                                  GestureDetector(
                                                    onTap: () async {
                                                     
                                                    },
                                                    child: Container(
                                                      width: double.infinity,
                                                      height: size.height * 0.1,//100,
                                                      decoration: BoxDecoration(
                                                        borderRadius: const BorderRadius.all(Radius.circular(15)),
                                                        shape: BoxShape.rectangle,
                                                        gradient: LinearGradient(
                                                          transform: const GradientRotation(-360),
                                                          colors: state.positionMenu == 2 ?
                          
                                                          <Color> [
                                                            const Color.fromRGBO(36,36,36,1),
                                                            const Color.fromRGBO(88, 89, 91, 1),
                                                          ]
                          
                                                          :
                                                            
                                                          <Color>[
                                                            const Color.fromRGBO(255,81,47,1),
                                                            const Color.fromRGBO(240, 152, 25, 1),
                                                          ]
                                                          
                                                        ),
                                                          boxShadow: const [
                                                            BoxShadow(
                                                              color: Colors.white,
                                                              offset: Offset(-4,-4),
                                                              blurRadius: 5,
                                                              spreadRadius: 2
                                                            ),
                                                            BoxShadow(
                                                              color: Colors.grey,
                                                              offset: Offset(4,4),
                                                              blurRadius: 5,
                                                              spreadRadius: 2
                                                            ),
                                                          ],
                                                        
                                                        ),
                                                      child: Center(
                                                        child: Column(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            const SizedBox(height: 10,),
                                                            Text('2', style: TextStyle( fontSize: state.positionMenu == 2 ? 60 : 50, fontWeight: FontWeight.bold, color: Colors.white), textAlign: TextAlign.center),
                                                            const SizedBox(height: 10,),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                  
                                                  Container(
                                                    color: Colors.transparent,
                                                    height: size.height * 0.01,
                                                  ),
                                  
                                                  GestureDetector(
                                                    onTap: () async {
                                                      
                                                    },
                                                    child: Container(
                                                      width: double.infinity,
                                                      height: size.height * 0.1,//100,
                                                      decoration: BoxDecoration(
                                                        borderRadius: const BorderRadius.all(Radius.circular(15)),
                                                        shape: BoxShape.rectangle,
                                                        gradient: LinearGradient(
                                                          transform: const GradientRotation(-360),
                                                          colors: state.positionMenu == 5 ?
                          
                                                          <Color> [
                                                            const Color.fromRGBO(36,36,36,1),
                                                            const Color.fromRGBO(88, 89, 91, 1),
                                                          ]
                                                          :
                                                            
                                                          <Color>[
                                                            const Color.fromRGBO(255,81,47,1),
                                                            const Color.fromRGBO(240, 152, 25, 1),
                                                          ]
                                                          
                                                        ),
                                                          boxShadow: const [
                                                            BoxShadow(
                                                              color: Colors.white,
                                                              offset: Offset(-4,-4),
                                                              blurRadius: 5,
                                                              spreadRadius: 2
                                                            ),
                                                            BoxShadow(
                                                              color: Colors.grey,
                                                              offset: Offset(4,4),
                                                              blurRadius: 5,
                                                              spreadRadius: 2
                                                            ),
                                                          ],
                                                        
                                                        ),
                                                      child: Center(
                                                        child: Column(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            const SizedBox(height: 10,),
                                                            Text('5', style: TextStyle( fontSize: state.positionMenu == 5 ? 60 : 50, fontWeight: FontWeight.bold, color: Colors.white), textAlign: TextAlign.center),
                                                            const SizedBox(height: 10,),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  
                                                  Container(
                                                    color: Colors.transparent,
                                                    height: size.height * 0.01,
                                                  ),
                                  
                                                  GestureDetector(
                                                    onTap: () async {
                                                      
                                                    },
                                                    child: Container(
                                                      width: double.infinity,
                                                      height: size.height * 0.1,//100,
                                                      decoration: BoxDecoration(
                                                        borderRadius: const BorderRadius.all(Radius.circular(15)),
                                                        shape: BoxShape.rectangle,
                                                        gradient: LinearGradient(
                                                          transform: const GradientRotation(-360),
                                                          colors: state.positionMenu == 8 ?
                          
                                                            <Color> [
                                                              const Color.fromRGBO(36,36,36,1),
                                                              const Color.fromRGBO(88, 89, 91, 1),
                                                            ]
                                                            :
                                                             
                                                            <Color>[
                                                              const Color.fromRGBO(255,81,47,1),
                                                              const Color.fromRGBO(240, 152, 25, 1),
                                                            ]
                                                          
                                                        ),
                                                          boxShadow: const [
                                                            BoxShadow(
                                                              color: Colors.white,
                                                              offset: Offset(-4,-4),
                                                              blurRadius: 5,
                                                              spreadRadius: 2
                                                            ),
                                                            BoxShadow(
                                                              color: Colors.grey,
                                                              offset: Offset(4,4),
                                                              blurRadius: 5,
                                                              spreadRadius: 2
                                                            ),
                                                          ],
                                                        
                                                        ),
                                                      child: Center(
                                                        child: Column(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            const SizedBox(height: 10,),
                                                            Text('8', style: TextStyle( fontSize: state.positionMenu == 8 ? 60 : 50, fontWeight: FontWeight.bold, color: Colors.white), textAlign: TextAlign.center),
                                                            const SizedBox(height: 10,),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                
                                                  Container(
                                                    color: Colors.transparent,
                                                    height: size.height * 0.01,
                                                  ),
                                  
                                                  GestureDetector(
                                                    onTap: () async {
                                                      
                                                    },
                                                    child: Container(
                                                      width: double.infinity,
                                                      height: size.height * 0.1,//100,
                                                      decoration: BoxDecoration(
                                                        borderRadius: const BorderRadius.all(Radius.circular(15)),
                                                        shape: BoxShape.rectangle,
                                                        gradient: LinearGradient(
                                                          transform: const GradientRotation(-360),
                                                          colors: state.positionMenu == -1 ?
                          
                                                            <Color> [
                                                              const Color.fromRGBO(36,36,36,1),
                                                              const Color.fromRGBO(88, 89, 91, 1),
                                                            ]
                          
                                                            :
                                                             
                                                            <Color>[
                                                              const Color.fromRGBO(255,81,47,1),
                                                              const Color.fromRGBO(240, 152, 25, 1),
                                                            ]
                                                          
                                                        ),
                                                          boxShadow: const [
                                                            BoxShadow(
                                                              color: Colors.white,
                                                              offset: Offset(-4,-4),
                                                              blurRadius: 5,
                                                              spreadRadius: 2
                                                            ),
                                                            BoxShadow(
                                                              color: Colors.grey,
                                                              offset: Offset(4,4),
                                                              blurRadius: 5,
                                                              spreadRadius: 2
                                                            ),
                                                          ],
                                                        
                                                        ),
                                                      child: Center(
                                                        child: Column(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            const SizedBox(height: 10,),
                                                            Text('0', style: TextStyle( fontSize: state.positionMenu == -1 ? 60 : 50, fontWeight: FontWeight.bold, color: Colors.white), textAlign: TextAlign.center),
                                                            const SizedBox(height: 10,),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                
                                                ],
                                              ),
                                  
                                            ],
                                          ),
                                        ),
                          
                                        Container(
                                          color: Colors.transparent,
                                          width: size.width * 0.25,
                                          height: size.height * 0.45,
                                          margin: const EdgeInsets.symmetric(horizontal: 1),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              
                                              Column(
                                                children: [
                                  
                                                  GestureDetector(
                                                    onTap: () async {
                                                      
                                                    },
                                                    child: Container(
                                                      width: double.infinity,
                                                      height: size.height * 0.1,//100,
                                                      decoration: BoxDecoration(
                                                        borderRadius: const BorderRadius.all(Radius.circular(15)),
                                                        shape: BoxShape.rectangle,
                                                        gradient: LinearGradient(
                                                          transform: const GradientRotation(-360),
                                                          colors: state.positionMenu == 3 ?
                                                             
                                                            <Color> [
                                                              const Color.fromRGBO(36,36,36,1),
                                                              const Color.fromRGBO(88, 89, 91, 1),
                                                            ]
                                                            :
                                                            <Color>[
                                                              const Color.fromRGBO(255,81,47,1),
                                                              const Color.fromRGBO(240, 152, 25, 1),
                                                            ]
                                                          
                                                        ),
                                                          boxShadow: const [
                                                            BoxShadow(
                                                              color: Colors.white,
                                                              offset: Offset(-4,-4),
                                                              blurRadius: 5,
                                                              spreadRadius: 2
                                                            ),
                                                            BoxShadow(
                                                              color: Colors.grey,
                                                              offset: Offset(4,4),
                                                              blurRadius: 5,
                                                              spreadRadius: 2
                                                            ),
                                                          ],
                                                        
                                                        ),
                                                      child: Center(
                                                        child: Column(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            const SizedBox(height: 10,),
                                                            Text('3', style: TextStyle( fontSize: state.positionMenu == 3 ? 60 : 50, fontWeight: FontWeight.bold, color: Colors.white), textAlign: TextAlign.center),
                                                            const SizedBox(height: 10,),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                  
                                                  Container(
                                                    color: Colors.transparent,
                                                    height: size.height * 0.01,
                                                  ),
                                  
                                                  GestureDetector(
                                                    onTap: () async {
                                                      
                                                    },
                                                    child: Container(
                                                      width: double.infinity,
                                                      height: size.height * 0.1,//100,
                                                      decoration: BoxDecoration(
                                                        borderRadius: const BorderRadius.all(Radius.circular(15)),
                                                        shape: BoxShape.rectangle,
                                                        gradient: LinearGradient(
                                                          transform: const GradientRotation(-360),
                                                          colors: state.positionMenu == 6 ?
                          
                                                            <Color> [
                                                              const Color.fromRGBO(36,36,36,1),
                                                              const Color.fromRGBO(88, 89, 91, 1),
                                                            ]
                                                            :
                                                             
                                                            <Color>[
                                                              const Color.fromRGBO(255,81,47,1),
                                                              const Color.fromRGBO(240, 152, 25, 1),
                                                            ]
                          
                                                          
                                                        ),
                                                          boxShadow: const [
                                                            BoxShadow(
                                                              color: Colors.white,
                                                              offset: Offset(-4,-4),
                                                              blurRadius: 5,
                                                              spreadRadius: 2
                                                            ),
                                                            BoxShadow(
                                                              color: Colors.grey,
                                                              offset: Offset(4,4),
                                                              blurRadius: 5,
                                                              spreadRadius: 2
                                                            ),
                                                          ],
                                                        
                                                        ),
                                                      child: Center(
                                                        child: Column(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            const SizedBox(height: 10,),
                                                            Text('6', style: TextStyle( fontSize: state.positionMenu == 6 ? 60 : 50, fontWeight: FontWeight.bold, color: Colors.white), textAlign: TextAlign.center),
                                                            const SizedBox(height: 10,),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  
                                                  Container(
                                                    color: Colors.transparent,
                                                    height: size.height * 0.01,
                                                  ),
                                  
                                                  GestureDetector(
                                                    onTap: () async {
                          
                                                      
                                                      
                                                    },
                                                    child: Container(
                                                      width: double.infinity,
                                                      height: size.height * 0.1,//100,
                                                      decoration: BoxDecoration(
                                                        borderRadius: const BorderRadius.all(Radius.circular(15)),
                                                        shape: BoxShape.rectangle,
                                                        gradient: LinearGradient(
                                                          transform: const GradientRotation(-360),
                                                          colors: state.positionMenu == 9 ?
                          
                                                            <Color> [
                                                              const Color.fromRGBO(36,36,36,1),
                                                              const Color.fromRGBO(88, 89, 91, 1),
                                                            ]
                                                            :
                                                                   
                                                            <Color>[
                                                              const Color.fromRGBO(255,81,47,1),
                                                              const Color.fromRGBO(240, 152, 25, 1),
                                                            ]
                                                          
                                                        ),
                                                          boxShadow: const [
                                                            BoxShadow(
                                                              color: Colors.white,
                                                              offset: Offset(-4,-4),
                                                              blurRadius: 5,
                                                              spreadRadius: 2
                                                            ),
                                                            BoxShadow(
                                                              color: Colors.grey,
                                                              offset: Offset(4,4),
                                                              blurRadius: 5,
                                                              spreadRadius: 2
                                                            ),
                                                          ],
                                                        
                                                        ),
                                                      child: Center(
                                                        child: Column(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            const SizedBox(height: 10,),
                                                            Text('9', style: TextStyle( fontSize: state.positionMenu == 9 ? 60 : 50, fontWeight: FontWeight.bold, color: Colors.white), textAlign: TextAlign.center),
                                                            const SizedBox(height: 10,),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                          
                                                  Container(
                                                    color: Colors.transparent,
                                                    height: size.height * 0.01,
                                                  ),
                                  
                                                  GestureDetector(
                                                    onTap: () async {
                                                      
                                                      
                                                    },
                                                    child: Container(
                                                      width: double.infinity,
                                                      height: size.height * 0.1,//100,
                                                      decoration: BoxDecoration(
                                                        borderRadius: const BorderRadius.all(Radius.circular(15)),
                                                        shape: BoxShape.rectangle,
                                                        gradient: LinearGradient(
                                                          transform: const GradientRotation(-360),
                                                          colors: state.positionMenu == -2 ?
                          
                                                            <Color> [
                                                              const Color.fromRGBO(36,36,36,1),
                                                              const Color.fromRGBO(88, 89, 91, 1),
                                                            ]
                                                            :
                                                                   
                                                            <Color>[
                                                              const Color.fromRGBO(255,81,47,1),
                                                              const Color.fromRGBO(240, 152, 25, 1),
                                                            ]
                          
                                                        ),
                                                          boxShadow: const [
                                                            BoxShadow(
                                                              color: Colors.white,
                                                              offset: Offset(-4,-4),
                                                              blurRadius: 5,
                                                              spreadRadius: 2
                                                            ),
                                                            BoxShadow(
                                                              color: Colors.grey,
                                                              offset: Offset(4,4),
                                                              blurRadius: 5,
                                                              spreadRadius: 2
                                                            ),
                                                          ],
                                                        
                                                        ),
                                                      child: Center(
                                                        child: Column(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            const SizedBox(height: 10,),
                                                            //Icon(Icons.delete_forever_outlined, color: Colors.white, size: state.positionMenu == -2 ? 80 : 60,),
                                                            Container(
                                                              color: Colors.transparent,
                                                              width: size.width * 0.1,
                                                              child: Image.asset('assets/imgBorradorBlanco.png', )
                                                            ),
                                                            const SizedBox(height: 10,),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                
                          
                                                ],
                                              ),
                                              
                                  
                                  
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }
                              )
                            ),
                          ),
                          
                          Container(
                            color: Colors.transparent,
                            width: size.width * 0.7,
                            height: size.height * 0.02,
                          ),
                          
                        ],
                      ),
                    ),
                    
                  ],
                ),
              ),
            ),
          )
        )
      )
    );
  }

  void playInCorrect() {
    //ignore: no_leading_underscores_for_local_identifiers
    final _playerIncorrect = AudioCache();
    _playerIncorrect.play('marcacion_incorrecta.mp3');
  }
}