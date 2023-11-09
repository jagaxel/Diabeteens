import 'package:diabeteens_v2/Elements/CustomButton.dart';
import 'package:diabeteens_v2/Elements/MyTextFormField.dart';
import 'package:diabeteens_v2/Pages/RegisterTutor/RegisterCorreoPage.dart';
import 'package:diabeteens_v2/Pages/RegisterTutor/RegisterSavePage.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class RegisterPasswordPage extends StatefulWidget {
  final int idPersona;
  final int idTutor;
  final String correo;
  const RegisterPasswordPage({super.key, required this.idPersona, required this.idTutor, required this.correo});

  @override
  State<RegisterPasswordPage> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterPasswordPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController contrasenaController = TextEditingController();
  TextEditingController validContrasenaController = TextEditingController();
  bool _obscureText = true;
  late int _idPersona;
  late int _idTutor;
  late String _correo;

  @override
  void initState() {
    super.initState();
    _idPersona = widget.idPersona;
    _idTutor = widget.idTutor;
    _correo = widget.correo;
    print(_idTutor);
  }

  // @override
  // void dispose() {
  //   // Dispose the text editing controllers
  //   emailController.dispose();
  //   passwordController.dispose();
  //   nameController.dispose();
  //   phoneController.dispose();
  //   super.dispose();
  // }

  void clearControllers() {
    contrasenaController.clear();
  }

  Future<void> sendData() async {
    final response = await http.post(
      Uri.parse('http://localhost/api_diabeteens/RegisterTutor/registerPassword.php'),
      body: {
        "idTutor": this._idTutor.toString(),
        "correo": _correo,
        "contrasena": this.contrasenaController.text,
      }
    );
    var respuesta = jsonDecode(response.body);
    print(respuesta);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF4c709a),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppBar(
                backgroundColor: Color(0xFF4c709a),
                leading: GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RegisterCorreoPage(idPersona: _idPersona),
                      ) 
                    );
                  },
                  child: Icon(
                    Icons.arrow_back,
                    color: Color(0xFFd4b0a0),
                    size: 30,
                  )
                ),
              ),
              const SizedBox(
                width: 330,
                height: 50,
                child: Text("Datos del Tutor", 
                  style: TextStyle(
                    color: Color(0xFF90bbd0),
                    fontSize: 20
                  )
                )
              ),
              const SizedBox(
                width: 330,
                height: 50,
                child: Text("Crea una contraseña", style: TextStyle(color: Colors.white))
              ),
              Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Padding(
                  padding: const EdgeInsets.only(left: 40, right: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyTextFormField(
                        myObscureText: _obscureText,
                        controller: contrasenaController,
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
                        onChanged: (value) {}
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              CustomButton(
                buttonWidth: 260,
                buttonHeight: 46,
                onPressed: () async {
                  await sendData();
                  if (_formKey.currentState!.validate()) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RegisterSavePage(idPersona: _idPersona, idTutor: _idTutor, correo: _correo)
                      ) 
                    );
                  }
                },
                text: "Siguiente",
                buttonBackgroundColor: Color(0xFF795a9e),
                style: TextStyle(
                  color: Colors.white,
                    fontSize: 12,
                    // fontFamily: 'Nexa Light',
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.01,
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}