import 'package:diabeteens_v2/Elements/CustomButton.dart';
import 'package:diabeteens_v2/Pages/RegisterHijo/RegisterNameSong.dart';
import 'package:diabeteens_v2/Pages/RegisterHijo/RegisterSexSong.dart';
import 'package:flutter/material.dart';

class RegisterBirthDateSong extends StatefulWidget {
  static const routeName = '/registerTutor';
  const RegisterBirthDateSong({super.key});

  @override
  State<RegisterBirthDateSong> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterBirthDateSong> {
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
      });
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
                        builder: (context) => RegisterNamSong(),
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
                child: Text("¿Cuándo nació?", style: TextStyle(color: Colors.white))
              ),
              Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Padding(
                  padding: const EdgeInsets.only(left: 40, right: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Ingrese la fecha de nacimiento",
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
                        child: TextFormField (
                          onTap: () => _selectDate(context),
                          cursorColor: Colors.black,
                          // keyboardType: inputTypes,
                          textAlign: TextAlign.left,
                          // obscureText: myObscureText,
                          controller: TextEditingController(text: selectedDate.toString()),
                          // onChanged: onChanged,
                          decoration: InputDecoration(
                            hintText: "Fecha de Nacimiento",
                            hintStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              // fontFamily: 'Nexa Light',
                              // fontWeight: FontWeight.w700,
                            ),
                            // border: BorderRadius.circular(5.r)
                            // suffixIcon: suffixicon,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,

                            //  border: OutlineInputBorder(
                            //         borderRadius: BorderRadius.circular(10.r),
                            //         borderSide: BorderSide.none, // This sets the border color to none.
                            //       ),

                            contentPadding: EdgeInsets.all(20),
                          ),
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
                        builder: (context) => RegisterSexSong()
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