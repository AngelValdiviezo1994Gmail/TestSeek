
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reto_seek/src/bloc/bloc.dart';
import 'package:reto_seek/src/screens/Errores/conexion_internet_screen.dart';
import 'package:reto_seek/src/screens/screens.dart';

class CheckAuthScreen extends StatelessWidget {
  static const String routerName = 'checkAuthScreen';

  const CheckAuthScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context,state) {
          return Center(
            child: FutureBuilder(
              future: state.readToken(), 
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {

                if(!snapshot.hasData) {
                  return Image.asset(
                    "assets/loading.gif",
                    height: 150.0,
                    width: 150.0,
                  );
                } else {
                  if(snapshot.data != '') {

                    if(snapshot.data == 'NV') {
                    } else {
                      if(snapshot.data == 'NI') {
                        Future.microtask(() => 
                          Navigator.of(context, rootNavigator: true).pushReplacement(
                            CupertinoPageRoute<bool>(
                              fullscreenDialog: true,
                              builder: (BuildContext context) => const ConexionInternetScreen(),
                            ),
                          )
                        );
                      } else {
                        Future.microtask(() => 
                          Navigator.of(context, rootNavigator: true).pushReplacement(
                            CupertinoPageRoute<bool>(
                              fullscreenDialog: true,
                              builder: (BuildContext context) => PrincipalScreen(),
                            ),
                          )
                        );
                        
                      }
                    }
                    
                  } else {
                    Future.microtask(() => 
                      Navigator.of(context, rootNavigator: true).pushReplacement(
                        CupertinoPageRoute<bool>(
                          fullscreenDialog: true,
                          builder: (BuildContext context) => const AuthScreen(),
                        ),
                      )
                    );
                  }
                }

                return Container();
              },
            )
          
          );
        }
      )
      
   );
    
  }
}