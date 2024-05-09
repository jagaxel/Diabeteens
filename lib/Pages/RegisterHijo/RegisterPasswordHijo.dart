import 'package:diabeteens_v2/Common/Common.dart';
import 'package:diabeteens_v2/Pages/PasswordChanged.dart';
import 'package:diabeteens_v2/Pages/RegisterHijo/CompleteRegister.dart';
import 'package:diabeteens_v2/Utils/DirectionIp.dart';
import 'package:diabeteens_v2/Utils/AppColors.dart';
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

class RegisterPasswordHijoPage extends StatefulWidget {
  final int idUsuario;
  final String nombre;
  final String primerAp;
  final String segundoAp;
  final String telefono;
  final String sexo;
  final String peso;
  final String altura;
  final String fechaNacimiento;
  const RegisterPasswordHijoPage({super.key, required this.idUsuario, required this.nombre, required this.primerAp, required this.segundoAp, required this.telefono, required this.sexo, required this.peso, required this.altura, required this.fechaNacimiento});

  @override
  State<RegisterPasswordHijoPage> createState() => _RegisterPasswordHijoPageState();
}

class _RegisterPasswordHijoPageState extends State<RegisterPasswordHijoPage> {
  final _formKey = GlobalKey<FormState>();

  bool flag = true;
  bool isIncorrectPassword = false;
  bool isLoading = false;
  bool showPass = true;
  bool showPassConfirm = true;
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  int selectImg = 0;

  late int _idUsuario;
  late String _nombre;
  late String _primerAP;
  late String _segundoAp;
  late String _telefono;
  late String _sexo;
  late String _peso;
  late String _altura;
  late String _fechaNacimiento;
  int _indexImg = 0;
  int lengthImg = 0;
  double delayFade = 1.6;

  // List<String> srcImgLogin = [
  //   "assets/images/login/ave.png",
  //   "assets/images/login/caballo.png",
  //   "assets/images/login/calamar.png",
  //   "assets/images/login/cangrejo.png",
  //   "assets/images/login/foca.png",
  //   "assets/images/login/nutria.png",
  //   "assets/images/login/pez_gato.png",
  //   "assets/images/login/pez_globo.png",
  //   "assets/images/login/pez.png",
  //   "assets/images/login/tortuga.png",
  // ];


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
      print(listIdImg);
      setState(() {
        listIdImg = listIdImg;
        listSrcImgLogin = listSrcImgLogin;
        listNameImg = listNameImg;
      });
      // print(listSrcImgLogin);
    } catch (e) {
      print(e);
    }
  }

  void showImgSelected() async {
    print(selectImg);
    await showDialog (
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        void saveUserHijo() async {
          try {
            final response = await http.post(
              Uri.parse('http://${ip.ip}/api_diabeteens2/RegisterHijo/registerData.php'),
              body: {
                "idUsuario": _idUsuario.toString(),
                "nombre": _nombre,
                "primerAp": _primerAP,
                "segundoAp": _segundoAp,
                "telefono": _telefono,
                "idImgContrasena": selectImg.toString(),
                "idTipoGenero": _sexo,
                "peso": _peso,
                "altura": _altura,
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
                  builder: (context) => CompleteRegisterPage()
                )
              );
            } else {
              Fluttertoast.showToast(
                // ignore: prefer_interpolation_to_compose_strings
                msg: "${"Error al " + respuesta["msgError"]}, intente de nuevo.",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.TOP,
                timeInSecForIosWeb: 2,
                backgroundColor: Color.fromARGB(130, 169, 0, 0),
                textColor: Colors.white,
                fontSize: 16.0
              );
            }
          } catch (e) {
            print(e);
          }
        }
        
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
                      saveUserHijo();
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
                    showConfirmRegistro();
                  },
                  child: const Text(
                    "Confirmar",
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

  DirectionIp ip = DirectionIp();

  @override
  void initState() {
    _idUsuario = widget.idUsuario;
    _nombre = widget.nombre;
    _primerAP = widget.primerAp;
    _segundoAp = widget.segundoAp;
    _telefono = widget.telefono;
    _sexo = widget.sexo;
    _peso = widget.peso;
    _altura = widget.altura;
    _fechaNacimiento = widget.fechaNacimiento;
    getImgLogin();

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
                          "Seleccione una imagen:",
                          style: Common().shortTheme,
                        ),
                      )
                    ],
                  ),
                ),
                // Row (
                //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                //   children: [
                //     Container(
                //       child: Image (
                //         image: AssetImage(srcImgLogin[8])
                //       ),
                //       width: 150,
                //     ),
                //   ],
                // ),
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
                              message: listNameImg[_indexImg],
                              child: GestureDetector (
                                onTap: () {
                                  setState(() {
                                    selectImg = listIdImg[index * 2];
                                  });
                                  showImgSelected();
                                },
                                child: Container (
                                  child: Image (
                                    image: AssetImage(listSrcImgLogin[_indexImg]),
                                  ),
                                  width: 115,
                                ),
                              ),
                            ),
                            (_indexImg + 1) < listSrcImgLogin.length ?
                            Tooltip(
                              message: listNameImg[_indexImg + 1],
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectImg = listIdImg[(index * 2) + 1];
                                  });
                                  showImgSelected();
                                },
                                child: Container (
                                  child: Image (
                                    image: AssetImage(listSrcImgLogin[_indexImg + 1])
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
                  ),
                // Padding(
                //   padding: const EdgeInsets.all(12.0),
                //   child: Form(
                //     key: _formKey,
                //     child: Column(
                //       children: [
                //         FadeInAnimation(
                //           delay: 1.9,
                //           child: TextFormField (
                //             validator: MultiValidator([
                //                 RequiredValidator(errorText: 'La contraseña es requerida'), 
                //                 PatternValidator(r'^(?=.{8,})(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)(?!.*\s).*$', errorText: 'Contraseña no válida')
                //             ]),
                //             autovalidateMode: AutovalidateMode.onUserInteraction,
                //             controller: passwordController,
                //             obscureText: showPass,
                //             decoration: InputDecoration (
                //               filled: true,
                //               fillColor: AppColors.blanco,
                //               contentPadding: const EdgeInsets.all(13),
                //               hintText: "Ingresar contraseña",
                //               hintStyle: Common().hinttext,
                //               border: OutlineInputBorder (
                //                 borderSide: const BorderSide(color: Colors.black),
                //                 borderRadius: BorderRadius.circular(12)
                //               ),
                //               enabledBorder: OutlineInputBorder(
                //                 borderSide: isIncorrectPassword ? BorderSide(color: Colors.red, width: 3) : BorderSide(color: Colors.black),
                //                 borderRadius: BorderRadius.circular(12)
                //               ),
                //               suffixIcon: IconButton (
                //                 onPressed: () {
                //                   setState(() {
                //                     showPass = !showPass;
                //                   });
                //                 },
                //                 icon: Icon(
                //                   showPass ? Icons.remove_red_eye_outlined : Icons.visibility_off
                //                 )
                //               )
                //             ),
                //           ),
                //         ),
                //         const SizedBox(
                //           height: 15,
                //         ),
                //         FadeInAnimation(
                //           delay: 2.1,
                //           child: TextFormField (
                //             validator: MultiValidator([
                //                 RequiredValidator(errorText: 'La contraseña es requerida'), 
                //                 PatternValidator(r'^(?=.{8,})(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)(?!.*\s).*$', errorText: 'Contraseña no válida')
                //             ]),
                //             autovalidateMode: AutovalidateMode.onUserInteraction,
                //             controller: confirmPasswordController,
                //             obscureText: showPassConfirm,
                //             decoration: InputDecoration (
                //               filled: true,
                //               fillColor: AppColors.blanco,
                //               contentPadding: const EdgeInsets.all(13),
                //               hintText: "Confirmar contraseña",
                //               hintStyle: Common().hinttext,
                //               border: OutlineInputBorder (
                //                 borderSide: const BorderSide(color: Colors.black),
                //                 borderRadius: BorderRadius.circular(12)
                //               ),
                //               enabledBorder: OutlineInputBorder(
                //                 borderSide: isIncorrectPassword ? BorderSide(color: Colors.red, width: 3) : BorderSide(color: Colors.black),
                //                 borderRadius: BorderRadius.circular(12)
                //               ),
                //               suffixIcon: IconButton (
                //                 onPressed: () {
                //                   setState(() {
                //                     showPassConfirm = !showPassConfirm;
                //                   });
                //                 },
                //                 icon: Icon(
                //                   showPassConfirm ? Icons.remove_red_eye_outlined : Icons.visibility_off
                //                 )
                //               )
                //             ),
                //           ),
                //         ),
                //         SizedBox(
                //           height: 30,
                //         ),
                //         FadeInAnimation(
                //           delay: 2.4,
                //           child: ElevatedButton (
                //             onPressed: () async {
                //               registerData();
                //             },
                //             style: Common().styleBtnLite,
                //             child: isLoading
                //             ? const CupertinoActivityIndicator()
                //             : FittedBox(
                //                 child: Text(
                //                   "Finalizar",
                //                   style: Common().semiboldwhite,
                //                 )
                //               ),
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
                
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
