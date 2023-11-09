import 'package:diabeteens_v2/Elements/CustomButton.dart';
import 'package:diabeteens_v2/Elements/MyTextFormField.dart';
import 'package:diabeteens_v2/Pages/RegisterHijo/SuccessfullRegisterSong.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class RegisterPasswordSong extends StatefulWidget {
  final int idPersona;
  final int idTutor;
  final int idHijo;
  final String telefono;
  const RegisterPasswordSong({super.key, required this.idPersona, required this.idTutor, required this.idHijo, required this.telefono});

  @override
  State<RegisterPasswordSong> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterPasswordSong> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController contrasenaController = TextEditingController();
  TextEditingController validContrasenaController = TextEditingController();
  bool _obscureText = true;
  late int _idPersona;
  late int _idTutor;
  late int _idHijo;
  late String _telefono;

  @override
  void initState() {
    super.initState();
    _idTutor = widget.idTutor;
    _idPersona = widget.idPersona;
    _idHijo = widget.idHijo;
    _telefono = widget.telefono;
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
      Uri.parse('http://localhost/api_diabeteens/RegisterHijo/registerPassword.php'),
      body: {
        "telefono": _telefono,
        "idHijo": _idHijo.toString(),
        "contrasena": contrasenaController.text
      }
    );
    var respuesta = jsonDecode(response.body);
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
              const SizedBox(
                width: 330,
                height: 50,
                child: Text("Datos del Hijo", 
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
                    await Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SuccessfullRegisterSong()
                      ) 
                    );
                  }
                },
                text: "Guardar",
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