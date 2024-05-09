import 'package:diabeteens_v2/Common/Common.dart';
import 'package:diabeteens_v2/Pages/OtpVerification.dart';
import 'package:diabeteens_v2/Utils/AppColors.dart';
import 'package:diabeteens_v2/Utils/FadeAnimationTest.dart';
import 'package:diabeteens_v2/Widget/CustomWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:diabeteens_v2/Utils/DirectionIp.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:go_router/go_router.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({super.key});

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  bool flag = true;
  final _formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  bool isLoading = false;
  bool existEmail = false;
  DirectionIp ip = DirectionIp();

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
        // ignore: use_build_context_synchronously
        // Navigator.push(
        //   context, 
        //   MaterialPageRoute(
        //     builder: (context) => RegisterDateSexTutorPage(
        //       correo: emailController.text, 
        //     )
        //   )
        // );
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
                FadeInAnimation(
                  delay: 1.6,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Ingresa tu correo",
                      style: Common().titelTheme,
                    )
                  ),
                ),
                FadeInAnimation(
                  delay: 1.9,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Se enviará un correo de verificación",
                      style: Common().shortTheme,
                    )
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25, right: 25),
                  child: Form(
                    child: Column(
                      children: [
                        FadeInAnimation (
                          delay: 1.9,
                          child: TextFormField (
                            
                            decoration: InputDecoration (
                              filled: true,
                              fillColor: AppColors.blanco,
                              contentPadding: const EdgeInsets.all(13),
                              hintText: "Correo",
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
                          delay: 2.2,
                          child: ElevatedButton(
                            onPressed: () async {
                              Navigator.push(
                                  context, 
                                  MaterialPageRoute(
                                    builder: (context) => OtpVerificationPage()
                                  )
                                );
                            },
                            style: Common().styleBtnLite,
                            child: !flag
                                ? const CupertinoActivityIndicator()
                                : FittedBox(
                                    child: Text(
                                    "Enviar correo",
                                    style: Common().semiboldwhite,
                                  )),
                          ),
                          // CustomElevatedButton(
                          //   message: "Enviar correo",
                            
                          //   function: () {
                              
                          //     if (flag) {
                          //       setState(() {
                          //         flag = false;
                          //       });
                          //     } else {
                          //       setState(() {
                          //         flag = true;
                          //       });
                          //     }
                          //   },
                          //   color: AppColors.azulLite,
                          // ),
                        ),
                        SizedBox(
                          height: 110,
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
                                "¿Tienes cuenta?",
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
                              },
                              child: const Text(
                                "Inicia sesión",
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