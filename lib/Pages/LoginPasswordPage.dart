import 'dart:math';

import 'package:diabeteens_v2/Common/Common.dart';
import 'package:diabeteens_v2/Elements/CustomButton.dart';
import 'package:diabeteens_v2/Elements/MyTextFormField.dart';
import 'package:diabeteens_v2/Pages/ForgetPassword.dart';
import 'package:diabeteens_v2/Pages/ForgotPassword/MethodToSendCode.dart';
import 'package:diabeteens_v2/Pages/RegisterTutor/RegisterUserTutor.dart';
import 'package:diabeteens_v2/Pages/Views/Hijo/EntryPointHijo.dart';
import 'package:diabeteens_v2/Pages/Views/Tutor/EntryPointTutor.dart';
import 'package:diabeteens_v2/Pages/Views/Tutor/HomeTutor.dart';
import 'package:diabeteens_v2/Utils/DirectionIp.dart';
import 'package:diabeteens_v2/Utils/FadeAnimationTest.dart';
import 'package:diabeteens_v2/VistaInicial.dart';
import 'package:diabeteens_v2/Widget/CustomWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:diabeteens_v2/Utils/AppColors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginPasswordPage extends StatefulWidget {
  static const routeName = '/loginScreen';
  final int idUsuario;
  final int idPersona;
  final bool isTutor;
  final String usuario;
  const LoginPasswordPage({super.key, required this.idUsuario, required this.idPersona, required this.isTutor, required this.usuario});

  @override
  State<LoginPasswordPage> createState() => _LoginPasswordScreenState();
}

class _LoginPasswordScreenState extends State<LoginPasswordPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  late int _idUsuario;
  late int _idPersona;
  late bool _isTutor;
  late String _usuario;

  bool _obscureText = true;
  bool flag = true;
  bool showPass = true;
  bool isIncorrectUser = false;
  bool isLoading = false;
  int selectImg = 0;
  double delayFade = 1.9;
  int _indexImg = 0;
  int lengthImg = 0;

  DirectionIp ip = DirectionIp();

  List<String> listSrcImgLogin = [];
  List<String> listNameImg = [];
  List<int> listIdImg = [];
  void getImgLogin() async {
    try {
      final response = await http.post(
        Uri.parse('http://${ip.ip}/api_diabeteens2/RegisterHijo/getImagesPassword.php'),
      );
      var respuesta = jsonDecode(response.body);
      // print(respuesta);
      for (int i = 0; i < respuesta.length; i++) {
        listIdImg.add(int.parse(respuesta[i]["id"]));
        listSrcImgLogin.add(respuesta[i]["src"]);
        listNameImg.add(respuesta[i]["nombre"]);
      }
      // print(listIdImg);
      setState(() {
        listIdImg = listIdImg;
        listSrcImgLogin = listSrcImgLogin;
        listNameImg = listNameImg;
      });
      shuffle(listIdImg);
      // print(listSrcImgLogin);
    } catch (e) {
      print(e);
    }
  }

  void shuffle(List<int> list) {
    var random = new Random();
    for (var i = list.length - 1; i > 0; i--) {
      var n = random.nextInt(i + 1);
      var temp = list[i];
      list[i] = list[n];
      list[n] = temp;
    }
    setState(() {
      listIdImg = list;
    });
    // print(listIdImg);
  }

  void showImgSelected() async {
    print(selectImg);
    await showDialog (
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        void showConfirmRegistro() async {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("Confirmación"),
                content: const Text(
                  "La imagen se asociará al usuario del hijo, ¿Continuar con el registro?",
                  style: TextStyle(
                    fontSize: 17,
                    // fontWeight: FontWeight.bold
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Cancelar"),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      // saveUserHijo();
                    },
                    child: const Text("Confirmar"),
                  ),
                ],
                // backgroundColor: Colors.amber,
              );
            },
          );
        }

        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: const Text(
                "Imagen Seleccionada",
                style: TextStyle(
                  color: AppColors.menuBackground
                ),
              ),
              content: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 15,
                    ),
                    Image(
                      image: AssetImage(listSrcImgLogin[selectImg - 1])
                    )
                    ,SizedBox(
                      height: 10,
                    ),
                    Text(
                     listNameImg[selectImg - 1],
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ],
                ),
                
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Cancelar",
                    style: TextStyle(
                      color: AppColors.azul
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    validateUser();
                  },
                  child: const Text(
                    "Iniciar Sesión",
                    style: TextStyle(
                      color: AppColors.azul
                    ),
                  ),
                ),
              ],
              backgroundColor: AppColors.fondoColorAzul,
            );
          }
        );
      },
    );
  }

  Future<void> validateUser() async {
    try {
      String contrasena = "";
      if (_isTutor) {
        contrasena = passwordController.text;
      } else {
        contrasena = selectImg.toString();
      }
      setState(() {
        isLoading = true;
      });
      final response = await http.post(
        Uri.parse('http://${ip.ip}/api_diabeteens2/loginPassword.php'),
        body: {
          "usuario": _usuario,
          "contrasena": contrasena,
          "isTutor": _isTutor.toString()
        }
      );
      print(response.body);
      var respuesta = jsonDecode(response.body);
      print(respuesta);
      if (respuesta["existe"]) {
        if (_isTutor) {
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
                idHijo: int.parse(respuesta["idPersona"]), 
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
          msg: _isTutor ? "La contraseña es incorrecta" : "La imagen es incorrecta",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 2,
          backgroundColor: Color.fromARGB(130, 169, 0, 0),
          textColor: Colors.white,
          fontSize: 16.0
        );
        Navigator.pop(context);
        if (!_isTutor) {
          shuffle(listIdImg); 
        }
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
  void initState() {
    _idUsuario = widget.idUsuario;
    _idPersona = widget.idPersona;
    _isTutor = widget.isTutor;
    _usuario = widget.usuario;
    if (!_isTutor) {
      getImgLogin();
    }

    super.initState();
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
                SizedBox(
                  height: 20,
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
                        // FadeInAnimation (
                        //   delay: 1.9,
                        //   child: TextFormField (
                        //     controller: emailController,
                        //     // obscureText: flag ? true : false,
                        //     decoration: InputDecoration (
                        //       filled: true,
                        //       fillColor: AppColors.blanco,
                        //       contentPadding: const EdgeInsets.all(13),
                        //       hintText: "Usuario",
                        //       hintStyle: Common().hinttext,
                        //       border: OutlineInputBorder (
                        //         borderSide: BorderSide(color: Colors.black),
                        //         borderRadius: BorderRadius.circular(12)
                        //       ),
                        //       enabledBorder: OutlineInputBorder(
                        //         borderSide: isIncorrectUser ? BorderSide(color: Colors.red, width: 3) : BorderSide(color: Colors.black),
                        //         borderRadius: BorderRadius.circular(12)
                        //       ),
                        //     ),
                        //     // validator: (s) {
                        //     //   return isIncorrectUser ? "Usuario incorrecto" : null;
                        //     // },
                        //   ),
                        // ),
                        // const SizedBox (
                        //   height: 20,
                        // ),
                        _isTutor ?
                        FadeInAnimation (
                          delay: 1.6,
                          child: TextFormField (
                            controller: passwordController,
                            obscureText: showPass,
                            decoration: InputDecoration (
                              filled: true,
                              fillColor: AppColors.blanco,
                              contentPadding: const EdgeInsets.all(13),
                              hintText: "Contraseña",
                              labelText: "Contraseña:",
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
                                icon: Icon(
                                  showPass ? Icons.remove_red_eye_outlined : Icons.visibility_off
                                )
                              )
                            ),
                          ),
                        )
                        :
                        SizedBox(
                          height: 0,
                        )
                        ,
                        SizedBox(
                          height: _isTutor ? 10 : 0,
                        ),
                        _isTutor ?
                        FadeInAnimation(
                          delay: 1.9,
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
                        )
                        :
                        SizedBox(
                          height: 0,
                        )
                        ,
                        SizedBox(
                          height: _isTutor ? 100 : 0,
                        ),
                        _isTutor ?
                        FadeInAnimation(
                          delay: 2.2,
                          child: ElevatedButton(
                            onPressed: () async {
                              validateUser();
                              // launchEMAI();
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
                        )
                        :
                        SizedBox(
                          height: _isTutor ? 80 : 0,
                        )
                        ,
                        !_isTutor ?
                        FadeInAnimation(
                          delay: 1.6,
                          child: Text(
                            "Selecciona la imagen asociada a tu usuario:",
                            style: Common().shortTheme,
                          ),
                        )
                        :
                        SizedBox(
                          height: 0,
                        )
                        ,
                        !_isTutor ?
                        ListView.builder (
                          shrinkWrap: true,
                          itemCount: ((listSrcImgLogin.length ~/ 2) * 2 ) + 1 == listSrcImgLogin.length ? (listSrcImgLogin.length ~/ 2) + 1 : listSrcImgLogin.length ~/ 2,
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) {
                            _indexImg = index * 2;
                            delayFade += 0.3;
                            // return Text("primero: ${_indexImg} .. segundo: ${_indexImg + 1}");
                            return FadeInAnimation(
                              delay: delayFade,
                              child: Row (
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Tooltip(
                                    message: listNameImg[listIdImg[_indexImg] - 1],
                                    child: GestureDetector (
                                      onTap: () {
                                        setState(() {
                                          selectImg = listIdImg[index * 2];
                                        });
                                        showImgSelected();
                                      },
                                      child: Container (
                                        child: Image (
                                          image: AssetImage(listSrcImgLogin[listIdImg[_indexImg] - 1]),
                                        ),
                                        width: 115,
                                      ),
                                    ),
                                  ),
                                  (_indexImg + 1) < listSrcImgLogin.length ?
                                  Tooltip(
                                    message: listNameImg[listIdImg[_indexImg + 1] - 1],
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          selectImg = listIdImg[(index * 2) + 1];
                                        });
                                        showImgSelected();
                                      },
                                      child: Container (
                                        child: Image (
                                          image: AssetImage(listSrcImgLogin[listIdImg[_indexImg + 1] - 1])
                                        ),
                                        width: 115,
                                      ),
                                    ),
                                  )
                                  :
                                  Container(
                                    width: 115,
                                  ),
                                ],
                              ),
                            );
                          },
                        )
                        :
                        SizedBox(
                          height: 0,
                        )
                        ,
                        SizedBox(
                          height: _isTutor ? 210 : 40,
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