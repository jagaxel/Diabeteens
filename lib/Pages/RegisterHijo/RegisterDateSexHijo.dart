import 'package:diabeteens_v2/Common/Common.dart';
import 'package:diabeteens_v2/Pages/RegisterHijo/RegisterPasswordHijo.dart';
import 'package:diabeteens_v2/Utils/AppColors.dart';
import 'package:diabeteens_v2/Utils/FadeAnimationTest.dart';
import 'package:diabeteens_v2/Widget/CustomWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'dart:async';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:diabeteens_v2/Utils/DirectionIp.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class RegisterDateSexHijoPage extends StatefulWidget {
  final int idUsuario;
  final String telefono;
  final String nombre;
  final String primerAp;
  final String segundoAp;
  const RegisterDateSexHijoPage({super.key, required this.telefono, required this.nombre, required this.primerAp, required this.segundoAp, required this.idUsuario});

  @override
  State<RegisterDateSexHijoPage> createState() => _RegisterDateSexHijoPageState();
}

class _RegisterDateSexHijoPageState extends State<RegisterDateSexHijoPage> {
  bool flag = true;
  TextEditingController dateController = TextEditingController();
  TextEditingController pesoController = TextEditingController();
  TextEditingController alturaController = TextEditingController();
  late int _idUsuario;
  late String _telefono;
  late String _nombre;
  late String _primerAP;
  late String _segundoAp;
  int _edad = 0;
  int? sexo;
  bool showComponent = false;
  double delayFade = 2.2;
  bool isIncorrectPeso = false;
  bool isIncorrectAltura = false;

  DirectionIp ip = DirectionIp();

  @override
  void initState() {
    _idUsuario = widget.idUsuario;
    _telefono = widget.telefono;
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
      locale: const Locale('es', 'ES'),
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
    // '39 tipos de gays',
  ];

  List<int> listIdGender = [];
  List<String> listNameGender = [];
  void getGarden() async {
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
    double? peso = double.tryParse(pesoController.text);
    double? altura = double.tryParse(alturaController.text);

    if (peso == null) {
      msgAlert("Formato de peso incorrecto.");
      setState(() {
        isIncorrectPeso = true;
      });
    } else if (peso <= 0) {
      msgAlert("El peso debe de ser mayor a 0.");
    } else if (altura == null) {
      setState(() {
        isIncorrectPeso = false;
      });
      msgAlert("Formato de altura incorrecto.");
      setState(() {
        isIncorrectAltura = false;
      });
    } else if (altura <= 0) {
      msgAlert("La altura debe de ser mayor a 0.");
    } else if (selectedValue == null) {
      setState(() {
        isIncorrectAltura = false;
      });
      msgAlert("Debe de seleccionar un sexo.");
    } else {
      sexo = selectedValue;
      Navigator.push(
        context, 
        MaterialPageRoute(
          builder: (context) => RegisterPasswordHijoPage(
            idUsuario: _idUsuario, 
            telefono: _telefono, 
            nombre: _nombre, 
            primerAp: _primerAP, 
            segundoAp: _segundoAp,
            altura: alturaController.text,
            sexo: sexo.toString(),
            peso: pesoController.text,
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

  void msgAlert(msgText) {
    Fluttertoast.showToast(
      msg: msgText,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 4,
      backgroundColor: const Color.fromARGB(255, 158, 118, 38),
      textColor: Color.fromARGB(255, 255, 255, 255),
      fontSize: 16.0
    );
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
                  height: 50,
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
                            controller: TextEditingController(text: selectedDate.toString().split(" ")[0]),
                            decoration: InputDecoration(
                              hintText: "Fecha de Nacimiento",
                              labelText: "Fecha de Nacimiento",
                              filled: true,
                              prefixIcon: const Icon(Icons.calendar_today),
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
                          delay: 1.9,
                          child: TextFormField (
                            controller: pesoController,
                            decoration: InputDecoration (
                              filled: true,
                              fillColor: AppColors.blanco,
                              contentPadding: const EdgeInsets.all(13),
                              hintText: "Peso (kg)",
                              labelText: "Peso (kg):",
                              hintStyle: Common().hinttext,
                              border: OutlineInputBorder (
                                borderSide: const BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(12)
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: isIncorrectPeso ? BorderSide(color: Colors.red, width: 3) : BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(12)
                              )
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        FadeInAnimation (
                          delay: 2.2,
                          child: TextFormField (
                            controller: alturaController,
                            decoration: InputDecoration (
                              filled: true,
                              fillColor: AppColors.blanco,
                              contentPadding: const EdgeInsets.all(13),
                              hintText: "Altura (cm)",
                              labelText: "Altura (cm):",
                              hintStyle: Common().hinttext,
                              border: OutlineInputBorder (
                                borderSide: const BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(12)
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: isIncorrectAltura ? BorderSide(color: Colors.red, width: 3) : BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(12)
                              )
                            ),
                          ),
                        ),
                        FadeInAnimation (
                          delay: 2.2,
                          child: 
                          showComponent
                          ?
                          ListView.builder (
                            shrinkWrap: true,
                            itemCount: listIdGender.length,
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index) {
                              delayFade += 0.3;
                              return FadeInAnimation(
                                delay: delayFade,
                                child: RadioListTile(
                                  title: Text(listNameGender[index]),
                                  value: listIdGender[index],
                                  groupValue: selectedValue,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedValue = value;
                                    });
                                  },
                                ),
                              );
                            },
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
