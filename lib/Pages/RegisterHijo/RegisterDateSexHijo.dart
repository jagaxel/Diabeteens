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

class RegisterDateSexHijoPage extends StatefulWidget {
  final String telefono;
  final String nombre;
  final String primerAp;
  final String segundoAp;
  const RegisterDateSexHijoPage({super.key, required this.telefono, required this.nombre, required this.primerAp, required this.segundoAp});

  @override
  State<RegisterDateSexHijoPage> createState() => _RegisterDateSexHijoPageState();
}

class _RegisterDateSexHijoPageState extends State<RegisterDateSexHijoPage> {
  bool flag = true;
  TextEditingController dateController = TextEditingController();
  late String _telefono;
  late String _nombre;
  late String _primerAP;
  late String _segundoAp;
  int _edad = 0;
  String sexo = "";

  @override
  void initState() {
    _correo = widget.correo;
    _nombre = widget.nombre;
    _primerAP = widget.primerAp;
    _segundoAp = widget.segundoAp;

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

  String? selectedValue;

  List<String> items = [
    'Masculino',
    'Femenino',
    // '31 tipos de gays',
  ];

  Future<void> validateInfo() async {
    List<String> fechaC = DateTime(selectedDate.year, selectedDate.month, selectedDate.day).toString().split(" ");
    /*
    final response = await http.post(
      Uri.parse('http://${ip.ip}/api_diabeteens/RegisterHijo/registerBirthDate.php'),
      body: {
        "fechaNacimiento": fechaC[0].toString(),
        "edad": _edadHijo.toString(),
        "idPersona": _idPersona.toString()
      }
    );
    var respuesta = jsonDecode(response.body);
    */ 
    sexo = selectedValue == "Masculino" ? "M" : "F";
    Navigator.push(
      context, 
      MaterialPageRoute(
        builder: (context) => RegisterPasswordHijoPage(
          telefono: _telefono, 
          nombre: _nombre, 
          primerAp: _primerAP, 
          segundoAp: _segundoAp,
          fechaNacimiento: fechaC[0].toString(),
          edad: _edad,
          sexo: sexo,
        )
      )
    );
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
                          child: DropdownButton<String>(
                            padding: EdgeInsets.only(left: 5, right: 5),
                            value: selectedValue,
                            onChanged: (String? value) {
                              setState(() {
                                selectedValue = value;
                              });
                            },
                            items: items.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            isExpanded: true,
                            // style: const TextStyle(
                            //   // decorationColor: AppColors.blanco
                            // ),
                          )
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        FadeInAnimation (
                          delay: 1.9,
                          child: TextFormField (
                            obscureText: flag ? true : false,
                            decoration: InputDecoration (
                              filled: true,
                              fillColor: AppColors.blanco,
                              contentPadding: const EdgeInsets.all(13),
                              hintText: "Peso (kg)",
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
                          height: 130,
                        ),
                        FadeInAnimation(
                          delay: 2.2,
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
