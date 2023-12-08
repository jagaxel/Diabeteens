import 'package:diabeteens_v2/Elements/CustomButton.dart';
import 'package:diabeteens_v2/Elements/MyTextFormField.dart';
import 'package:diabeteens_v2/Pages/ForgotPassword/MethodToSendCode.dart';
import 'package:diabeteens_v2/Pages/RegisterTutor/RegisterNamePage.dart';
import 'package:diabeteens_v2/Pages/Views/Hijo/EntryPointHijo.dart';
import 'package:diabeteens_v2/Pages/Views/Tutor/EntryPointTutor.dart';
import 'package:diabeteens_v2/Pages/Views/Tutor/HomeTutor.dart';
import 'package:diabeteens_v2/Utils/DirectionIp.dart';
import 'package:diabeteens_v2/VistaInicial.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
// import 'package:flutter_email_sender/flutter_email_sender.dart';
// import 'package:url_launcher/url_launcher.dart';

class LoginPage extends StatefulWidget {
  static const routeName = '/loginScreen';
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool _obscureText = true;

  DirectionIp ip = DirectionIp();

  // _launch(url) async {
  //   if (await canLaunch(url)) {
  //     await launch(url);
  //   } else {
  //     throw 'No se envió $url';
  //   }
  // }

  // launchEMAI() async {
  //   // final Uri _emailLaunchUri = Uri(
  //   //   scheme: 'mailto',
  //   //   path: 'pp103634@gmail.com',
  //   //   queryParameters: {
  //   //     'subject': 'Codigo de Validación',
  //   //     'body': 'Prueba'
  //   //   }
  //   // );
  //   // _launch(_emailLaunchUri.toString());
  //   final Email email = await Email(
  //     body: 'Prueba',
  //     subject: 'Codigo',
  //     recipients: ['pp103634@gmail.com'],
  //     isHTML: false,
  //   );

  //   await FlutterEmailSender.send(email);
  // }

  Future<void> sendData() async {
    try {
      final response = await http.post(
        Uri.parse('http://${ip.ip}/api_diabeteens/login.php'),
        body: {
          "usuario": emailController.text,
          "contrasena": passwordController.text
        }
      );
      var respuesta = jsonDecode(response.body);
      print(respuesta);
      if (respuesta["existe"]) {
        if (respuesta["isTutor"]) {
          await Navigator.push(
            context, 
            MaterialPageRoute(
              builder: (context) => EntryPointTutor(
                idUsuario: int.parse(respuesta["idUsuario"]), 
                idTutor: int.parse(respuesta["idTutor"]), 
                idPersona: int.parse(respuesta["idPersona"]),
                usuario: respuesta["usuario"],
                nombreCompleto: respuesta["nombreCompleto"],
                idHijos: respuesta["idHijos"],
                cantHijos: int.parse(respuesta["cantHijos"]),
              )
            )
          );
        } else {
          await Navigator.push(
            context, 
            MaterialPageRoute(
              builder: (context) => EntryPointHijo(
                idUsuario: int.parse(respuesta["idUsuario"]), 
                idHijo: int.parse(respuesta["idHijo"]), 
                idPersona: int.parse(respuesta["idPersona"]),
                usuario: respuesta["usuario"],
                nombreCompleto: respuesta["nombreCompleto"],
              )
            )
          );
        }
      } else {
        Fluttertoast.showToast(
          msg: "Usuario o contraseña incorrecta",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 2,
          backgroundColor: Color.fromARGB(44, 255, 0, 0),
          textColor: Colors.white,
          fontSize: 16.0
        );
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Ocurrió un error inesperado, intenté de nuevo",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 2,
        backgroundColor: Color.fromARGB(44, 0, 170, 255),
        textColor: Colors.white,
        fontSize: 16.0
      );
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      backgroundColor: Color(0xFF4c709a),
      body: SingleChildScrollView (
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppBar(
              backgroundColor: Color(0xFF4c709a),
              leading: GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => VistaInicial(),
                    ) 
                  );
                },
                child: Icon(
                  Icons.arrow_back,
                  color: Color(0xFFd4b0a0),
                  size: 30,
                )
              ),
            ),
            const SizedBox(
              width: 290,
              child: Image(
                image: AssetImage("assets/images/logo-diabeteens-letras.png"),
              ),
            ),
            Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Padding(
                padding: const EdgeInsets.only(left: 40, right: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Usuario",
                        style: TextStyle(
                          color: Color(0xFFd4b0a0),
                          fontSize: 12,
                          // fontFamily: 'Nexa Bold',
                          // fontWeight: FontWeight.w700,
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    MyTextFormField(
                      controller: emailController,
                      inputTypes: TextInputType.emailAddress,
                      myObscureText: false,
                      suffixicon: null,
                      hintText: 'Correo (tutor); Telefono (hijo)',
                      // validator: (value) {
                      //   if (value == null || value.isEmpty) {
                      //     return 'Please enter your email';
                      //   } else if (!EmailValidator.validate(value)) {
                      //     return 'Invalid email address';
                      //   }

                      //   return null;
                      // },
                      onChanged: (value) {},
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text("Contraseña",
                        style: TextStyle(
                          color: Color(0xFFd4b0a0),
                          fontSize: 12,
                          // fontFamily: 'Nexa Bold',
                          // fontWeight: FontWeight.w700,
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    MyTextFormField(
                        myObscureText: _obscureText,
                        controller: passwordController,
                        suffixicon: IconButton(
                          color: Colors.white,
                          icon: Icon(
                            _obscureText
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          },
                        ),
                        inputTypes: TextInputType.visiblePassword,
                        hintText: 'Contraseña',
                        // validator: (value) {
                        //   if (value == null || value.isEmpty) {
                        //     return 'Introduzca su contraseña';
                        //   }

                        //   return null;
                        // },
                        onChanged: (value) {}),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                      GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MethodToSendCode()
                            ) 
                          );
                          },
                          child: const Text("Olvidé mi contraseña...",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                // fontFamily: 'Nexa Light',
                                fontWeight: FontWeight.w400,
                              ))),
                    ]),
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
            ),
            CustomButton(
                buttonWidth: 260,
                buttonHeight: 46,
                onPressed: () async {
                  await sendData();
                },
                text: "Iniciar Sesión",
                buttonBackgroundColor: Color(0xFF795a9e),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  // fontFamily: 'Nexa Light',
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0.01,
                )),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("¿No tienes cuenta?",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 10,
                      // fontFamily: 'Nexa',
                      fontWeight: FontWeight.w500,
                    )),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => RegisterNamePage()));
                  },
                  child: Text("-Crear cuenta",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 10,
                      // fontFamily: 'Nexa Light',
                      fontWeight: FontWeight.w700,
                    )
                  )
                )
              ],
            ),
          ],
        ),
      )
    );
  }
}