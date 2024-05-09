import 'package:diabeteens_v2/Common/Common.dart';
import 'package:diabeteens_v2/Pages/RegisterTutor/RegisterDateSexTutor.dart';
import 'package:diabeteens_v2/Utils/AppColors.dart';
import 'package:diabeteens_v2/Utils/DirectionIp.dart';
import 'package:diabeteens_v2/Utils/FadeAnimationTest.dart';
import 'package:diabeteens_v2/Widget/CustomWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:go_router/go_router.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class RegisterUserTutorPage extends StatefulWidget {
  const RegisterUserTutorPage({super.key});

  @override
  State<RegisterUserTutorPage> createState() => _RegisterUserTutorPageState();
}

class _RegisterUserTutorPageState extends State<RegisterUserTutorPage> {
  final _formKey = GlobalKey<FormState>();

  bool flag = true;
  TextEditingController emailController = TextEditingController();
  TextEditingController nombreController = TextEditingController();
  TextEditingController primerApController = TextEditingController();
  TextEditingController segundoApController = TextEditingController();
  String correo = "";
  bool isLoading = false;
  bool existEmail = false;

  DirectionIp ip = DirectionIp();

  final emailValidation = EmailValidator(errorText: 'Ingrese un correo válido');

  Future<void> searchEmail() async {
    try {
      setState(() {
        isLoading = true;
      });
      final response = await http.post(
        Uri.parse('http://${ip.ip}/api_diabeteens2/RegisterTutor/validateCorreo.php'),
        body: {
          "correo": emailController.text,
        }
      );
      var respuesta = jsonDecode(response.body);
      print(respuesta);
      if (respuesta["existe"]) {
        setState(() {
          existEmail = true;
        });
        Fluttertoast.showToast(
          msg: "El correo ya se encuentra registrado",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 2,
          backgroundColor: AppColors.azul,
          textColor: Colors.white,
          fontSize: 16.0
        );
      } else {
        setState(() {
          existEmail = false;
        });
        print(primerApController.text);
        // ignore: use_build_context_synchronously
        Navigator.push(
          context, 
          MaterialPageRoute(
            builder: (context) => RegisterDateSexTutorPage(
              correo: emailController.text, 
              nombre: nombreController.text, 
              primerAp: primerApController.text, 
              segundoAp: segundoApController.text,
            )
          )
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

  String? validateCorreo(String? correo) {
    RegExp correoRegex = RegExp(r'^[\w\.-]+@[\w-]+\.\w{2,3}(\.\w{2,3})?$');
    final isCorreoValid = correoRegex.hasMatch(correo ?? '');
    if (!isCorreoValid) {
      return 'Ingrese un correo válido';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.fondoColorAzul,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            AppBar(
              backgroundColor: AppColors.fondoColorAzul,
              leading: FadeInAnimation(
                delay: 1,
                child: IconButton(
                  onPressed: () {
                    // GoRouter.of(context).pop();
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    CupertinoIcons.back,
                    size: 35,
                  )
                ),
              )
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 80,
                ),
                FadeInAnimation(
                  delay: 1.3,
                  child: Text(
                    "Registro",
                    style: Common().titelTheme,
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25, right: 25),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        FadeInAnimation (
                          delay: 1.6,
                          child: TextFormField (
                            keyboardType: TextInputType.emailAddress,
                            validator: MultiValidator([
                              RequiredValidator(errorText: "El correo es requerido"),
                              EmailValidator(errorText: 'Ingrese un correo válido'),
                            ]),
                            autovalidateMode: AutovalidateMode.onUserInteraction, //Para que el fomulario se valide en automático
                            controller: emailController,
                            decoration: InputDecoration (
                              filled: true,
                              fillColor: AppColors.blanco,
                              contentPadding: const EdgeInsets.all(13),
                              hintText: "Ingrese el correo electrónico",
                              hintStyle: Common().hinttext,
                              border: OutlineInputBorder (
                                borderSide: const BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(12)
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        FadeInAnimation (
                          delay: 1.9,
                          child: TextFormField (
                            validator: MultiValidator([
                              RequiredValidator(errorText: "El nombre es requerido"),
                              PatternValidator(r'', errorText: 'Formato incorrecto')
                            ]),
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            controller: nombreController,
                            decoration: InputDecoration (
                              filled: true,
                              fillColor: AppColors.blanco,
                              contentPadding: const EdgeInsets.all(13),
                              hintText: "Nombre(s)",
                              hintStyle: Common().hinttext,
                              border: OutlineInputBorder (
                                borderSide: const BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(12)
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        FadeInAnimation (
                          delay: 2.2,
                          child: TextFormField (
                            validator: MultiValidator([
                              RequiredValidator(errorText: "El primer apellido es requerido"),
                              PatternValidator(r'^[A-Za-z\.\-\s]+$', errorText: 'Formato incorrecto')
                            ]),
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            controller: primerApController,
                            decoration: InputDecoration (
                              filled: true,
                              fillColor: AppColors.blanco,
                              contentPadding: const EdgeInsets.all(13),
                              hintText: "Primer Apellido",
                              hintStyle: Common().hinttext,
                              border: OutlineInputBorder (
                                borderSide: const BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(12)
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        FadeInAnimation (
                          delay: 2.5,
                          child: TextFormField (
                            controller: segundoApController,
                            validator: PatternValidator(r'^[A-Za-z\.\-\s]+$', errorText: 'Formato incorrecto'),
                            decoration: InputDecoration (
                              filled: true,
                              fillColor: AppColors.blanco,
                              contentPadding: const EdgeInsets.all(13),
                              hintText: "Segundo Apellido",
                              hintStyle: Common().hinttext,
                              border: OutlineInputBorder (
                                borderSide: const BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(12)
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 55,
                        ),
                        FadeInAnimation(
                          delay: 2.8,
                          child: ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                searchEmail();
                              }
                            },
                            style: Common().styleBtnLite,
                            child: isLoading
                                ? const CupertinoActivityIndicator()
                                : FittedBox(
                                    child: Text(
                                    "Siguiente",
                                    style: Common().semiboldwhite,
                                  )),
                          ),
                        ),
                        SizedBox(
                          height: 130,
                        ),
                        // FadeInAnimation(
                        //   delay: 3.1,
                        //   child: ElevatedButton (
                        //     onPressed: () async {
                        //       // Navigator.push(
                        //       //   context, 
                        //       //   MaterialPageRoute(
                        //       //     builder: (context) => PasswordChangesPage()
                        //       //   )
                        //       // );
                        //     },
                        //     style: Common().styleBtn,
                        //     child: !flag
                        //     ? const CupertinoActivityIndicator()
                        //     : FittedBox(
                        //         child: Text(
                        //           "Iniciar sesión",
                        //           style: Common().semiboldwhite,
                        //         )
                        //       ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        )
      )
    );
  }
}
