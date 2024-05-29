
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:reto_seek/scale_text_widget.dart';

class Seek extends StatefulWidget {

  Seek({Key? key}) : super (key: key);

  @override
  State<Seek> createState() => SeekState();
}

class SeekState extends State<Seek> {

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  final GlobalKey<ScaffoldMessengerState> messengerKey = GlobalKey<ScaffoldMessengerState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => MarcacionesService(),//ColorBloc
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => AutenticacionService(),
          lazy: false,
        ),
      ],
      child: MaterialApp(
        builder: (varContext, varChild) {
          return MaxScaleTextWidget(
            max: 1.0,
            child: varChild,
          );
        },
        debugShowCheckedModeBanner: false,
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          //Locale('en', ''), // English, no country code
          Locale('es', ''), // Spanish, no country code
        ],
        title: '',
        initialRoute: CheckAuthScreen.routerName,
        navigatorKey: navigatorKey,
        scaffoldMessengerKey: messengerKey,
        routes: {
          CheckAuthScreen.routerName: (_) => const CheckAuthScreen(),
          PrincipalScreen.routerName:(_) => PrincipalScreen(),
        },
        home: PrincipalScreen(objUserEntrada: null ),
        theme: ThemeData(
          primaryColor: Colors.black,
          appBarTheme: const AppBarTheme(
            color: Colors.black,
          ),
        ),
      )
    );
  }
}