import 'package:diabeteens_v2/Elements/CustomButton.dart';
import 'package:diabeteens_v2/Elements/MyTextFormField.dart';
import 'package:diabeteens_v2/Pages/RegisterHijo/RegisterPasswordSong.dart';
import 'package:diabeteens_v2/Pages/RegisterHijo/RegisterPoundSong.dart';
import 'package:diabeteens_v2/Pages/RegisterHijo/RegisterSendCodeSong.dart';
import 'package:diabeteens_v2/Utils/DirectionIp.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class RegisterPhoneSong extends StatefulWidget {
  final int idPersona;
  final int idTutor;
  final int idHijo;
  const RegisterPhoneSong({super.key, required this.idPersona, required this.idTutor, required this.idHijo});

  @override
  State<RegisterPhoneSong> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterPhoneSong> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController phoneController = TextEditingController();
  bool _obscureText = true;
  late int _idPersona;
  late int _idTutor;
  late int _idHijo;

  DirectionIp ip = DirectionIp();

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
    phoneController.clear();
  }

  Future<void> sendData() async {
    final response = await http.post(
      Uri.parse('http://${ip.ip}/api_diabeteens/RegisterHijo/registerPhone.php'),
      body: {
        "telefono": phoneController.text,
        "id": _idPersona.toString()
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
                child: Text("Número de celular", style: TextStyle(color: Colors.white))
              ),
              Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Padding(
                  padding: const EdgeInsets.only(left: 40, right: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Ingrese su número de celular",
                        style: TextStyle(
                          color: Color(0xFFd4b0a0),
                          fontSize: 15,
                        )
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      MyTextFormField(
                        controller: phoneController,
                        inputTypes: TextInputType.name,
                        myObscureText: false,
                        onChanged: (value) {},
                        suffixicon: null,
                        hintText: 'Núemero de celular',
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
                        builder: (context) => RegisterPasswordSong(idPersona: _idPersona, idTutor: _idTutor, idHijo: _idHijo, telefono: phoneController.text,)
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