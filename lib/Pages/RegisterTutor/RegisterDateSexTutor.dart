import 'package:diabeteens_v2/Common/Common.dart';
import 'package:diabeteens_v2/Pages/RegisterTutor/RegisterPasswordTutor.dart';
import 'package:diabeteens_v2/Utils/AppColors.dart';
import 'package:diabeteens_v2/Utils/FadeAnimationTest.dart';
import 'package:diabeteens_v2/Widget/CustomWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:diabeteens_v2/Utils/DirectionIp.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class RegisterDateSexTutorPage extends StatefulWidget {
  final String correo;
  final String nombre;
  final String primerAp;
  final String segundoAp;
  const RegisterDateSexTutorPage({super.key, required this.correo, required this.nombre, required this.primerAp, required this.segundoAp});

  @override
  State<RegisterDateSexTutorPage> createState() => _RegisterDateSexTutorPageState();
}

class _RegisterDateSexTutorPageState extends State<RegisterDateSexTutorPage> {
  bool flag = true;
  TextEditingController dateController = TextEditingController();
  late String _correo;
  late String _nombre;
  late String _primerAP;
  late String _segundoAp;
  int _edad = 0;
  int? sexo = 0;
  bool showComponent = false;

  DirectionIp ip = DirectionIp();

  @override
  void initState() {
    _correo = widget.correo;
    _nombre = widget.nombre;
    _primerAP = widget.primerAp;
    _segundoAp = widget.segundoAp;
    getGarden();

    super.initState();
  }

  DateTime selectedDate = DateTime.now();
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        _calculateAge();
      });
  }

  int? selectedValue;

  List<String> items = [
    'Masculino',
    'Femenino',
    // '33 tipos de gays',
  ];

  List<int> listIdGender = [];
  List<String> listNameGender = [];
  void getGarden() async {
    print("entraaaaaaaaaaaa");
    try {
      final response = await http.post(
        Uri.parse('http://${ip.ip}/api_diabeteens2/Catalogs/getGender.php'),
      );
      var respuesta = jsonDecode(response.body);
      // print(respuesta);
      for (int i = 0; i < respuesta.length; i++) {
        listIdGender.add(int.parse(respuesta[i]["id"]));
        listNameGender.add(respuesta[i]["descripcion"]);
      }
      setState(() {
        listIdGender = listIdGender;
        listNameGender = listNameGender;
        showComponent = true;
      });
      // print(listSrcImgLogin);
    } catch (e) {
      print(e);
    }
  }


  Future<void> validateInfo() async {
    List<String> fechaC = DateTime(selectedDate.year, selectedDate.month, selectedDate.day).toString().split(" ");
    if (_edad < 18) {
      Fluttertoast.showToast(
        msg: "El tutor debe de ser mayor de edad.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 4,
        backgroundColor: const Color.fromARGB(255, 158, 118, 38),
        textColor: Color.fromARGB(255, 255, 255, 255),
        fontSize: 16.0
      );
    } else if (selectedValue == null) {
      Fluttertoast.showToast(
        msg: "Debe de seleccionar un sexo.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 4,
        backgroundColor: const Color.fromARGB(255, 158, 118, 38),
        textColor: Color.fromARGB(255, 255, 255, 255),
        fontSize: 16.0
      );
    } else {
      sexo = selectedValue;
      Navigator.push(
        context, 
        MaterialPageRoute(
          builder: (context) => RegisterPasswordTutorPage(
            correo: _correo, 
            nombre: _nombre, 
            primerAp: _primerAP, 
            segundoAp: _segundoAp,
            sexo: sexo.toString(),
            fechaNacimiento: fechaC[0].toString(),
          )
        )
      );
    }
  }

  Future<void> _calculateAge() async {
    DateTime fechaNacimiento = DateTime(selectedDate.year, selectedDate.month, selectedDate.day);
    DateTime fechaActual = DateTime.now();
    int edad = fechaActual.year - fechaNacimiento.year;
    if (fechaActual.month < fechaNacimiento.month ||
        (fechaActual.month == fechaNacimiento.month && fechaActual.day < fechaNacimiento.day)) {
      edad--;
    }
    _edad = edad;
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
                  height: 100,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25, right: 25),
                  child: Form(
                    child: Column(
                      children: [
                        FadeInAnimation (
                          delay: 1.6,
                          child: TextFormField (
                            onTap: () => _selectDate(context),
                            cursorColor: Colors.black,
                            textAlign: TextAlign.left,
                            // obscureText: flag ? true : false,
                            controller: TextEditingController(text: selectedDate.toString()),
                            decoration: InputDecoration(
                              hintText: "Fecha de Nacimiento",
                              filled: true,
                              fillColor: AppColors.blanco,
                              contentPadding: const EdgeInsets.all(13),
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
                          delay: 1.6,
                          child: 
                          showComponent
                          ?
                          DropdownButton<int>(
                            padding: EdgeInsets.only(left: 5, right: 5),
                            value: selectedValue,
                            onChanged: (int? value) {
                              setState(() {
                                selectedValue = value;
                              });
                            },
                            items: listIdGender.map((int value) {
                              return DropdownMenuItem<int>(
                                value: value,
                                child: Text(listNameGender[value - 1]),
                              );
                            }).toList(),
                            isExpanded: true,
                            // style: const TextStyle(
                            //   // decorationColor: AppColors.blanco
                            // ),
                          )
                          :
                          const CircularProgressIndicator()
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        FadeInAnimation(
                          delay: 1.9,
                          child: ElevatedButton(
                            onPressed: () async {
                              validateInfo();
                            },
                            style: Common().styleBtnLite,
                            child: !flag
                                ? const CupertinoActivityIndicator()
                                : FittedBox(
                                    child: Text(
                                    "Siguiente",
                                    style: Common().semiboldwhite,
                                  )),
                          ),
                        ),
                        SizedBox(
                          height: 140,
                        ),
                        // FadeInAnimation(
                        //   delay: 2.2,
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
                        SizedBox(
                          height: 300,
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
                  image: AssetImage('assets/images/concha.png'),
                  width: 300,
                  // height: 100,
                )
              ),
            ),
          ],
        )
      )
    );
  }
}
