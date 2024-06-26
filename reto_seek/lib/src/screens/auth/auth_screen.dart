import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:reto_seek/src/controllers/controllers.dart';
import 'package:reto_seek/src/screens/principal_screen.dart';
import 'package:reto_seek/src/styles/styles.dart';
import 'package:reto_seek/src/ui/ui.dart';

/*
final FocusNode _userNode = FocusNode();
final FocusNode _passwordNode = FocusNode();
*/

const storageAuth = FlutterSecureStorage();

class AuthScreen extends StatefulWidget {

  static const String routerName = 'authScreen';

  const AuthScreen({Key? key}) : super(key: key);
  @override
  AuthScreenState createState() => AuthScreenState();
}

class AuthScreenState extends State<AuthScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  late TeddyController _teddyController;
  String _email = '';
  String _password = '';
  bool _isLoading = false;
  bool _isObscured = true;

  @override
  void initState() {
    _teddyController = TeddyController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        height: height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Style.upperGradientColor,
              Style.lowerGradientColor,
            ],
          ),
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.only(top: height * 0.05),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              
              SizedBox(
                height: height * 0.25,
                child: FlareActor(
                  "assets/Teddy.flr",
                  shouldClip: false,
                  alignment: Alignment.bottomCenter,
                  fit: BoxFit.contain,
                  controller: _teddyController,
                ),
              ),
              Container(
                height: height * 0.45,
                margin: const EdgeInsets.symmetric(horizontal: 15.0),
                padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 5.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: Form(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      TrackingTextInput(
                        onTextChanged: (String email) {
                          _email = email;
                        },
                        label: "Email",
                        onCaretMoved: (Offset caret) {
                          _teddyController.coverEyes(false);
                          _teddyController.lookAt(caret);
                        },
                        icon: Icons.email,
                        enable: !_isLoading,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Expanded(
                            child: TrackingTextInput(
                              label: "Password",
                              isObscured: _isObscured,
                              onCaretMoved: (Offset caret) {
                                _teddyController.coverEyes(true);
                                _teddyController.lookAt(null);
                              },
                              onTextChanged: (String password) {
                                _password = password;
                              },
                              icon: Icons.lock,
                              enable: !_isLoading,
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              _isObscured ? Icons.visibility : Icons.visibility_off,
                                color: Colors.black45),
                            onPressed: () {
                              setState(() {
                                _isObscured = !_isObscured;
                              });
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 10.0),
                      ElevatedButton(
                        onPressed: onPressed,
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                          ),
                          padding:
                              MaterialStateProperty.all(const EdgeInsets.symmetric(vertical: 8)),
                          backgroundColor: MaterialStateProperty.all(Style.buttonColor),
                        ),
                        child: _isLoading
                            ? const SpinKitThreeBounce(
                                color: Colors.white,
                                size: 25.0,
                              )
                            : const Text(
                                'Sign In',
                                style: TextStyle(
                                  fontFamily: 'Nunito',
                                  color: Colors.white,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onPressed() async {
    if (_email.isEmpty && _password.isEmpty) {
      _showSnackBar('Ingrese las credenciales');
      _teddyController.play('fail');
    } else {
      if (_isEmailValid(_email)) {
        _isLoading = true;
        setState(() {});
        bool signInSuccess = await _teddyController.checkEmailPassword(
          email: _email,
          password: _password,
        );
        _teddyController.coverEyes(false);
        if (signInSuccess) {
          
          storageAuth.write(key: 'TokenAppSeek', value: '123456789');
          _signInSuccess();
        } else {
          _signInFailed();
        }
      } else {
        _teddyController.play('fail');
        _showSnackBar('Please Enter Valid Email Address');
      }
    }
  }
  
  bool _isEmailValid(String email) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern);
    if (regex.hasMatch(email)) {
      return true;
    } else {
      return false;
    }
  }

  void _signInSuccess() {
    Future.delayed(const Duration(seconds: 1)).then(
      (_) {
        
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => PrincipalScreen(),
          ),
        );
        
      },
    );
  }

  void _signInFailed() {
    _showSnackBar('Credenciales incorrectas');
    _isLoading = false;
    setState(() {});
  }

  void _showSnackBar(String title) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(title, textAlign: TextAlign.center),
      ),
    );
  }
}
