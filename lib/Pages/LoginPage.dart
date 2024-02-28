import 'package:diabeteens_v2/Common/Common.dart';
import 'package:diabeteens_v2/Elements/CustomButton.dart';
import 'package:diabeteens_v2/Elements/MyTextFormField.dart';
import 'package:diabeteens_v2/Pages/ForgetPassword.dart';
import 'package:diabeteens_v2/Pages/ForgotPassword/MethodToSendCode.dart';
import 'package:diabeteens_v2/Pages/RegisterTutor/RegisterNamePage.dart';
import 'package:diabeteens_v2/Pages/RegisterTutor/RegisterUserTutor.dart';
import 'package:diabeteens_v2/Pages/Views/Hijo/EntryPointHijo.dart';
import 'package:diabeteens_v2/Pages/Views/Tutor/EntryPointTutor.dart';
import 'package:diabeteens_v2/Pages/Views/Tutor/HomeTutor.dart';
import 'package:diabeteens_v2/Utils/DirectionIp.dart';
import 'package:diabeteens_v2/Utils/FadeAnimationTest.dart';
import 'package:diabeteens_v2/VistaInicial.dart';
import 'package:diabeteens_v2/Widget/CustomWidget.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:diabeteens_v2/Utils/AppColors.dart';
import 'package:flutter/cupertino.dart';
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
  bool flag = true;
  bool showPass = true;
  bool isIncorrectUser = false;
  bool isLoading = false;

  DirectionIp ip = DirectionIp();

/*
  _launch(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'No se envió $url';
    }
  }

  launchEMAI() async {
    // final Uri _emailLaunchUri = Uri(
    //   scheme: 'mailto',
    //   path: 'pp103634@gmail.com',
    //   queryParameters: {
    //     'subject': 'Codigo de Validación',
    //     'body': 'Prueba'
    //   }
    // );
    // _launch(_emailLaunchUri.toString());
    final Email email = await Email(
      body: 'Prueba',
      subject: 'Codigo',
      recipients: ['pp103634@gmail.com'],
      isHTML: false,
    );

    await FlutterEmailSender.send(email);
  }
*/

  Future<void> sendData() async {
    try {
      setState(() {
        isLoading = true;
      });
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
          // ignore: use_build_context_synchronously
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
          // ignore: use_build_context_synchronously
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
        setState(() {
          isIncorrectUser = true;
        });
        Fluttertoast.showToast(
          msg: "Usuario o contraseña incorrecta",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 2,
          backgroundColor: Color.fromARGB(130, 169, 0, 0),
          textColor: Colors.white,
          fontSize: 16.0
        );
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Ocurrió un error inesperado, intenté de nuevo",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 3,
        backgroundColor: const Color.fromARGB(255, 158, 118, 38),
        textColor: Color.fromARGB(255, 255, 255, 255),
        fontSize: 16.0
      );
      print(e);
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      backgroundColor: AppColors.fondoColorAzul,
      body: SingleChildScrollView (
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                /*
                AppBar(
                  backgroundColor: AppColors.fondoColorAzul,
                  leading: FadeInAnimation(
                    delay: 1,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => VistaInicial(),
                          ) 
                        );
                      },
                      child: const Icon(
                        Icons.arrow_back,
                        color: Color(0xFFd4b0a0),
                        size: 30,
                      )
                    ),
                  )
                ),
                */
                SizedBox(
                  height: 50,
                ),
                const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FadeInAnimation(
                        delay: 1.3,
                        child: Image(
                          image: AssetImage("assets/images/logo-diabeteens.png"),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25, right: 25),
                  child: Form(
                    child: Column(
                      children: [
                        FadeInAnimation (
                          delay: 1.9,
                          child: TextFormField (
                            controller: emailController,
                            // obscureText: flag ? true : false,
                            decoration: InputDecoration (
                              filled: true,
                              fillColor: AppColors.blanco,
                              contentPadding: const EdgeInsets.all(13),
                              hintText: "Usuario",
                              hintStyle: Common().hinttext,
                              border: OutlineInputBorder (
                                borderSide: BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(12)
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: isIncorrectUser ? BorderSide(color: Colors.red, width: 3) : BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(12)
                              ),
                            ),
                            // validator: (s) {
                            //   return isIncorrectUser ? "Usuario incorrecto" : null;
                            // },
                          ),
                        ),
                        const SizedBox (
                          height: 20,
                        ),
                        FadeInAnimation (
                          delay: 2.2,
                          child: TextFormField (
                            controller: passwordController,
                            obscureText: showPass,
                            decoration: InputDecoration (
                              filled: true,
                              fillColor: AppColors.blanco,
                              contentPadding: const EdgeInsets.all(13),
                              hintText: "Contraseña",
                              hintStyle: Common().hinttext,
                              border: OutlineInputBorder (
                                borderSide: BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(12)
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: isIncorrectUser ? BorderSide(color: Colors.red, width: 3) : BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(12)
                              ),
                              suffixIcon: IconButton (
                                onPressed: () {
                                  setState(() {
                                    showPass = !showPass;
                                  });
                                },
                                icon: const Icon(
                                  Icons.remove_red_eye_outlined
                                )
                              )
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        FadeInAnimation(
                          delay: 2.5,
                          child: Align(
                            alignment: Alignment.center,
                            child: GestureDetector(
                              onTap: () {
                                // GoRouter.of(context).pushNamed(Routers.forgetpassword.name);
                                Navigator.push(
                                  context, 
                                  MaterialPageRoute(
                                    builder: (context) => ForgetPasswordPage()
                                  )
                                );
                              },
                              child: const Text(
                                "¿Olvidaste tu contraseña?",
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: "GFSNeohellenic",
                                  decoration: TextDecoration.underline,
                                ),
                              )
                            )
                          ),
                        ),
                        SizedBox(
                          height: 100,
                        ),
                        FadeInAnimation(
                          delay: 2.8,
                          child: ElevatedButton(
                            onPressed: () async {
                              sendData();
                            },
                            style: Common().styleBtnLite,
                            child: isLoading
                                ? const CupertinoActivityIndicator()
                                : FittedBox(
                                    child: Text(
                                    "Iniciar Sesión",
                                    style: Common().semiboldwhite,
                                  )),
                          ),
                        ),
                        SizedBox(
                          height: 80,
                        ),
                        FadeInAnimation(
                          delay: 3.1,
                          child: Align(
                            alignment: Alignment.center,
                            child: GestureDetector(
                              onTap: () {
                                // GoRouter.of(context).pushNamed(Routers.forgetpassword.name);
                              },
                              child: const Text(
                                "¿No tienes cuenta?",
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: "GFSNeohellenic",
                                ),
                              )
                            )
                          ),
                        ),
                        FadeInAnimation(
                          delay: 3.4,
                          child: Align(
                            alignment: Alignment.center,
                            child: GestureDetector(
                              onTap: () {
                                // GoRouter.of(context).pushNamed(Routers.forgetpassword.name);
                                Navigator.push(
                                  context, 
                                  MaterialPageRoute(
                                    builder: (context) => const RegisterUserTutorPage()
                                  )
                                );
                              },
                              child: const Text(
                                "Registrate",
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: "GFSNeohellenic",
                                  decoration: TextDecoration.underline,
                                ),
                              )
                            )
                          ),
                        ),
                        SizedBox(
                          height: 60,
                        ),
                      ],
                    ),
                  ),
                ),
                
    /*      
                Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 40, right: 40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 20,
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
    */   
              ],
            ),
            
            const Positioned(
              left: -20,
              bottom: 0,
              child: FadeInAnimation(
                delay: 3.1,
                child: Image(
                  image: AssetImage('assets/images/las-olas-del-mar-l.png'),
                  width: 130,
                  // height: 100,
                )
              ),
            ),
            const Positioned(
              right: -20,
              bottom: 0,
              child: FadeInAnimation(
                delay: 3.1,
                child: Image(
                  image: AssetImage('assets/images/las-olas-del-mar.png'),
                  width: 130,
                  // height: 100,
                )
              ),
            )
          ],
        )
      )
    );
  }
}