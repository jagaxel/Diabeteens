import 'package:diabeteens_v2/Elements/CustomButton.dart';
import 'package:diabeteens_v2/Pages/RegisterHijo/RegisterBirthDateSong.dart';
import 'package:diabeteens_v2/Pages/RegisterHijo/RegisterPoundSong.dart';
import 'package:flutter/material.dart';

class RegisterSexSong extends StatefulWidget {
  static const routeName = '/registerTutor';
  const RegisterSexSong({super.key});

  @override
  State<RegisterSexSong> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterSexSong> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController dateController = TextEditingController();
  bool _obscureText = true;

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
    dateController.clear();
  }

  String? selectedValue;

  List<String> items = [
    'Mujer',
    'Hombre',
    '31 tipos de gays',
  ];

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
                        builder: (context) => RegisterBirthDateSong(),
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
                child: Text("¿Cuál es el sexo?", style: TextStyle(color: Colors.white))
              ),
              Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Padding(
                  padding: const EdgeInsets.only(left: 40, right: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Seleccione un sexo",
                        style: TextStyle(
                          color: Color(0xFFd4b0a0),
                          fontSize: 15,
                        )
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 46, width: 377,
                        decoration: BoxDecoration (
                          borderRadius: BorderRadius.circular(5),
                          color: Color(0xFF9f77df),
                          border: Border.all(
                            color: Color(0xFFdbb3a0),
                            width: 1
                          )
                        ),
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
                        ),
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
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RegisterPoundSong()
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