import 'package:diabeteens_v2/Common/Common.dart';
import 'package:diabeteens_v2/Pages/PasswordChanged.dart';
import 'package:diabeteens_v2/Pages/RegisterTutor/RegiSterCompleteTutor.dart';
import 'package:diabeteens_v2/Utils/AppColors.dart';
import 'package:diabeteens_v2/Utils/DirectionIp.dart';
import 'package:diabeteens_v2/Utils/FadeAnimationTest.dart';
import 'package:diabeteens_v2/Widget/CustomWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:form_field_validator/form_field_validator.dart';

class RegisterPasswordTutorPage extends StatefulWidget {
  final String correo;
  final String nombre;
  final String primerAp;
  final String segundoAp;
  final String fechaNacimiento;
  final String sexo;
  const RegisterPasswordTutorPage({super.key, required this.correo, required this.nombre, required this.primerAp, required this.segundoAp, required this.fechaNacimiento, required this.sexo});

  @override
  State<RegisterPasswordTutorPage> createState() => _RegisterPasswordTutorPageState();
}

class _RegisterPasswordTutorPageState extends State<RegisterPasswordTutorPage> {
  final _formKey = GlobalKey<FormState>();

  bool flag = true;
  bool showPass = true;
  bool showPassConfirm= true;
  bool isIncorrectPassword = false;
  bool isLoading = false;
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  late String _correo;
  late String _nombre;
  late String _primerAP;
  late String _segundoAp;
  late String _fechaNacimiento;
  late String _sexo;

  DirectionIp ip = DirectionIp();

  @override
  void initState() {
    _correo = widget.correo;
    _nombre = widget.nombre;
    _primerAP = widget.primerAp;
    _segundoAp = widget.segundoAp;
    _fechaNacimiento = widget.fechaNacimiento;
    _sexo = widget.sexo;

    super.initState();
  }

  bool isEqualsPasswoords() {
    if (passwordController.text == confirmPasswordController.text) {
      setState(() {
        isIncorrectPassword = false;
      });
      return true;
    }
    setState(() {
      isIncorrectPassword = true;
    });
    return false;
  }

  Future<void> registerData() async {
    try {
      setState(() {
        isLoading = true;
      });
      if (isEqualsPasswoords()) {
        final response = await http.post(
          Uri.parse('http://${ip.ip}/api_diabeteens2/RegisterTutor/registerData.php'),
          body: {
            "correo": _correo,
            "nombre": _nombre,
            "primerAP": _primerAP,
            "segundoAp": _segundoAp,
            "contrasena": passwordController.text,
            "sexo": _sexo,
            "fechaNacimiento": _fechaNacimiento,
          }
        );
        var respuesta = jsonDecode(response.body);
        print(respuesta);
        if (respuesta["isSuccess"]) {
          // ignore: use_build_context_synchronously
          Navigator.push(
            context, 
            MaterialPageRoute(
              builder: (context) => RegiSterCompleteTutorPage(idUsuario: respuesta["idUsuario"])
            )
          );
        } else {
          Fluttertoast.showToast(
            // ignore: prefer_interpolation_to_compose_strings
            msg: "${"Error al " + respuesta["msgError"]} intente de nuevo.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 2,
            backgroundColor: Color.fromARGB(130, 169, 0, 0),
            textColor: Colors.white,
            fontSize: 16.0
          );
        }
      } else {
        Fluttertoast.showToast(
          msg: "La contraseña no coincide, intente de nuevo.",
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
    return Scaffold(
      backgroundColor: AppColors.fondoColorAzul,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FadeInAnimation(
                delay: 1,
                child: IconButton(
                    onPressed: () {
                      // GoRouter.of(context).pop();
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      CupertinoIcons.back,
                      size: 35,
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    FadeInAnimation(
                      delay: 1.3,
                      child: Text(
                        "Registrar",
                        style: Common().titelTheme,
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    FadeInAnimation(
                      delay: 1.6,
                      child: Text(
                        "Ingrese una contraseña: mínimo de 8 caratéres, al menos una mayúcula, una minúscula, un número y un caracter especial.",
                        style: Common().shortTheme,
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      FadeInAnimation(
                        delay: 1.9,
                        child: TextFormField (
                          validator: MultiValidator([
                              RequiredValidator(errorText: 'La contraseña es requerida'), 
                              PatternValidator(r'^(?=.{8,})(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)(?!.*\s).*$', errorText: 'Contraseña no válida')
                          ]),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: passwordController,
                          obscureText: showPass,
                          decoration: InputDecoration (
                            filled: true,
                            fillColor: AppColors.blanco,
                            contentPadding: const EdgeInsets.all(13),
                            hintText: "Ingresar contraseña",
                            hintStyle: Common().hinttext,
                            border: OutlineInputBorder (
                              borderSide: const BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.circular(12)
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: isIncorrectPassword ? BorderSide(color: Colors.red, width: 3) : BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.circular(12)
                            ),
                            suffixIcon: IconButton (
                              onPressed: () {
                                setState(() {
                                  showPass = !showPass;
                                });
                              },
                              icon: Icon(
                                showPass ? Icons.remove_red_eye_outlined : Icons.visibility_off
                              )
                            )
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      FadeInAnimation(
                        delay: 2.1,
                        child: TextFormField (
                          validator: MultiValidator([
                              RequiredValidator(errorText: 'La contraseña es requerida'), 
                              PatternValidator(r'^(?=.{8,})(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)(?!.*\s).*$', errorText: 'Contraseña no válida')
                          ]),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: confirmPasswordController,
                          obscureText: showPassConfirm,
                          decoration: InputDecoration (
                            filled: true,
                            fillColor: AppColors.blanco,
                            contentPadding: const EdgeInsets.all(13),
                            hintText: "Confirmar contraseña",
                            hintStyle: Common().hinttext,
                            border: OutlineInputBorder (
                              borderSide: const BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.circular(12)
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: isIncorrectPassword ? BorderSide(color: Colors.red, width: 3) : BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.circular(12)
                            ),
                            suffixIcon: IconButton (
                              onPressed: () {
                                setState(() {
                                  showPassConfirm = !showPassConfirm;
                                });
                              },
                              icon: Icon(
                                showPassConfirm ? Icons.remove_red_eye_outlined : Icons.visibility_off
                              )
                            )
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      FadeInAnimation(
                        delay: 2.4,
                        child: ElevatedButton (
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              registerData();
                            }
                          },
                          style: Common().styleBtnLite,
                          child: isLoading
                              ? const CupertinoActivityIndicator()
                              : FittedBox(
                                  child: Text(
                                    "Finalizar",
                                    style: Common().semiboldwhite,
                                  )
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Spacer(),
              // FadeInAnimation(
              //   delay: 2.5,
              //   child: Padding(
              //     padding: const EdgeInsets.only(left: 50),
              //     child: Row(
              //       crossAxisAlignment: CrossAxisAlignment.center,
              //       children: [
              //         Text(
              //           "Don’t have an account?",
              //           style: Common().hinttext,
              //         ),
              //         TextButton(
              //             onPressed: () {
              //               // GoRouter.of(context).pushNamed(Routers.signuppage.name);
              //             },
              //             child: Text(
              //               "Register Now",
              //               style: Common().mediumTheme,
              //             )),
              //       ],
              //     ),
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
