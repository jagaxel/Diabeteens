import 'package:diabeteens_v2/Common/Common.dart';
import 'package:diabeteens_v2/Pages/RegisterHijo/RegisterDateSexHijo.dart';
import 'package:diabeteens_v2/Pages/RegisterTutor/RegisterDateSexTutor.dart';
import 'package:diabeteens_v2/Utils/AppColors.dart';
import 'package:diabeteens_v2/Utils/FadeAnimationTest.dart';
import 'package:diabeteens_v2/Widget/CustomWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:diabeteens_v2/Utils/DirectionIp.dart';

class RegisterUserHijoPage extends StatefulWidget {
  final int idTutor;
  const RegisterUserHijoPage({super.key, required this.idTutor});

  @override
  State<RegisterUserHijoPage> createState() => _RegisterUserHijoPageState();
}

class _RegisterUserHijoPageState extends State<RegisterUserHijoPage> {
  final _formKey = GlobalKey<FormState>();

  bool flag = true;
  bool isLoading = false;
  bool existPhone = false;
  TextEditingController telefonoController = TextEditingController();
  TextEditingController nombreController = TextEditingController();
  TextEditingController primerApController = TextEditingController();
  TextEditingController segundoApController = TextEditingController();
  late int _idTutor;
  DirectionIp ip = DirectionIp();

  @override
  void initState() {
    _idTutor = widget.idTutor;

    super.initState();
  }

  Future<void> searchPhone() async {
    try {
      setState(() {
        isLoading = true;
      });
      print("entra");
      final response = await http.post(
        Uri.parse('http://${ip.ip}/api_diabeteens/RegisterHijo/validatePhone.php'),
        body: {
          "telefono": telefonoController.text,
        }
      );
      var respuesta = jsonDecode(response.body);
      print(respuesta);
      if (respuesta["existe"]) {
        setState(() {
          existPhone = true;
        });
        Fluttertoast.showToast(
          msg: "El teléfono ya se encuentra registrado.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 2,
          backgroundColor: AppColors.azul,
          textColor: Colors.white,
          fontSize: 16.0
        );
      } else {
        setState(() {
          existPhone = false;
        });
        // ignore: use_build_context_synchronously
        Navigator.push(
          context, 
          MaterialPageRoute(
            builder: (context) => RegisterDateSexHijoPage(
              idTutor: _idTutor, 
              telefono: telefonoController.text, 
              nombre: nombreController.text, 
              primerAp: primerApController.text, 
              segundoAp: segundoApController.text,
            )
          )
        );
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Ocurrió un error inesperado, intenté de nuevo.",
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
                            controller: telefonoController,
                            validator: MultiValidator([
                              RequiredValidator(errorText: "El teléfono es requerido."),
                              MinLengthValidator(10, errorText: 'Formato de teléfono incorrecto.'),
                              MaxLengthValidator(10, errorText: 'Formato de teléfono incorrecto.'),
                              PatternValidator(r'[0-9]', errorText: 'Formato de teléfono incorrecto.')
                            ]),
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            decoration: InputDecoration (
                              filled: true,
                              fillColor: AppColors.blanco,
                              contentPadding: const EdgeInsets.all(13),
                              hintText: "Ingrese número de teléfono",
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
                            controller: nombreController,
                            validator: MultiValidator([
                              RequiredValidator(errorText: "El nombre es requerido"),
                              PatternValidator(r'^[A-Za-z\.\-\s]+$', errorText: 'Formato incorrecto')
                            ]),
                            autovalidateMode: AutovalidateMode.onUserInteraction,
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
                            controller: primerApController,
                            validator: MultiValidator([
                              RequiredValidator(errorText: "El primer apellido es requerido"),
                              PatternValidator(r'^[A-Za-z\.\-\s]+$', errorText: 'Formato incorrecto')
                            ]),
                            autovalidateMode: AutovalidateMode.onUserInteraction,
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
                                searchPhone();
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
                        FadeInAnimation(
                          delay: 3.1,
                          child: ElevatedButton (
                            onPressed: () async {
                              // Navigator.push(
                              //   context, 
                              //   MaterialPageRoute(
                              //     builder: (context) => PasswordChangesPage()
                              //   )
                              // );
                            },
                            style: Common().styleBtn,
                            child: !flag
                            ? const CupertinoActivityIndicator()
                            : FittedBox(
                                child: Text(
                                  "Iniciar sesión",
                                  style: Common().semiboldwhite,
                                )
                              ),
                          ),
                        ),
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
