import 'package:diabeteens_v2/Elements/CustomButton.dart';
import 'package:diabeteens_v2/Elements/MyTextFormField.dart';
import 'package:diabeteens_v2/Pages/RegisterTutor/RegisterPasswordPage.dart';
import 'package:diabeteens_v2/Pages/RegisterTutor/RegisterPhonePage.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class RegisterCorreoPage extends StatefulWidget {
  final int idPersona;
  const RegisterCorreoPage({super.key, required this.idPersona});

  @override
  State<RegisterCorreoPage> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterCorreoPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController correoController = TextEditingController();
  bool _obscureText = true;
  late int _idPersona;
  int _idTutor = 0;

  @override
  void initState() {
    super.initState();
    _idPersona = widget.idPersona;
    print(_idPersona);
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
    correoController.clear();
  }

  Future<void> sendData() async {
    final response = await http.post(
      Uri.parse('http://localhost/api_diabeteens/RegisterTutor/registerCorreo.php'),
      body: {
        "correo": this.correoController.text,
        "id": this._idPersona.toString()
      }
    );
    var respuesta = jsonDecode(response.body);
    print(respuesta);
    _idTutor = respuesta["idTutor"];
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
                    Navigator.pop(context);
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
                child: Text("¿Cúal es su correo electrónico?", style: TextStyle(color: Colors.white))
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
                        controller: correoController,
                        inputTypes: TextInputType.name,
                        myObscureText: false,
                        onChanged: (value) {},
                        suffixicon: null,
                        hintText: 'Correo electrónico',
                        // validator: (value) {
                        //   if (value == null || value.isEmpty) {
                        //     return 'Ingrese su nombre';
                        //   }
                        //   return null;
                        // },
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
                    await Navigator.push(
                      context, 
                      MaterialPageRoute(
                        builder: (context) => RegisterPasswordPage(idPersona: _idPersona, idTutor: _idTutor, correo: correoController.text)
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