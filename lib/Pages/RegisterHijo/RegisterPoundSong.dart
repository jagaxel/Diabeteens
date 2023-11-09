import 'package:diabeteens_v2/Elements/CustomButton.dart';
import 'package:diabeteens_v2/Elements/MyTextFormField.dart';
import 'package:diabeteens_v2/Pages/RegisterHijo/RegisterPhoneSong.dart';
import 'package:diabeteens_v2/Pages/RegisterHijo/RegisterSexSong.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class RegisterPoundSong extends StatefulWidget {
  final int idPersona;
  final int idTutor;
  final int idHijo;
  const RegisterPoundSong({super.key, required this.idPersona, required this.idTutor, required this.idHijo});

  @override
  State<RegisterPoundSong> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterPoundSong> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController poundController = TextEditingController();
  bool _obscureText = true;
  late int _idPersona;
  late int _idTutor;
  late int _idHijo;

  @override
  void initState() {
    super.initState();
    _idTutor = widget.idTutor;
    _idPersona = widget.idPersona;
    _idHijo = widget.idHijo;
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
    poundController.clear();
  }

  Future<void> sendData() async {
    final response = await http.post(
      Uri.parse('http://localhost/api_diabeteens/RegisterHijo/registerPound.php'),
      body: {
        "peso": poundController.text,
        "idHijo": _idHijo.toString()
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
              AppBar(
                backgroundColor: Color(0xFF4c709a),
                leading: GestureDetector(
                  onTap: () {
                    // Navigator.pushReplacement(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => RegisterSexSong(),
                    //   ) 
                    // );
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
                child: Text("Peso expresado en kg", style: TextStyle(color: Colors.white))
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
                        controller: poundController,
                        inputTypes: TextInputType.name,
                        myObscureText: false,
                        onChanged: (value) {},
                        suffixicon: null,
                        hintText: 'Peso',
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
                    await Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RegisterPhoneSong(idPersona: _idPersona, idTutor: _idTutor, idHijo: _idHijo)
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