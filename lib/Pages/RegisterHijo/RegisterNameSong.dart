import 'package:diabeteens_v2/Elements/CustomButton.dart';
import 'package:diabeteens_v2/Elements/MyTextFormField.dart';
import 'package:diabeteens_v2/Pages/RegisterHijo/RegisterBirthDateSong.dart';
import 'package:diabeteens_v2/VistaInicial.dart';
import 'package:flutter/material.dart';

class RegisterNamSong extends StatefulWidget {
  static const routeName = '/registerTutor';
  const RegisterNamSong({super.key});

  @override
  State<RegisterNamSong> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterNamSong> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController nombreController = TextEditingController();
  TextEditingController primerApellidoController = TextEditingController();
  TextEditingController segundoApellidoController = TextEditingController();
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
    nombreController.clear();
    primerApellidoController.clear();
    segundoApellidoController.clear();
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
                        builder: (context) => VistaInicial(),
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
                // child: Image(
                //   image: AssetImage("assets/images/logo-diabeteens-letras.png"),
                // ),
                child: Text("¿Cómo se llama?", style: TextStyle(color: Colors.white))
              ),
              Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Padding(
                  padding: const EdgeInsets.only(left: 40, right: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Nombre:",
                          style: TextStyle(
                            color: Color(0xFFd4b0a0),
                            fontSize: 15,
                            // fontFamily: 'Nexa Bold',
                            // fontWeight: FontWeight.w700,
                          )),
                      const SizedBox(
                        height: 10,
                      ),
                      MyTextFormField(
                        controller: nombreController,
                        inputTypes: TextInputType.name,
                        myObscureText: false,
                        onChanged: (value) {},
                        suffixicon: null,
                        hintText: 'Nombre',
                        // validator: (value) {
                        //   if (value == null || value.isEmpty) {
                        //     return 'Ingrese su nombre';
                        //   }
                        //   return null;
                        // },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text("Primer Apellido:",
                        style: TextStyle(
                          color: Color(0xFFd4b0a0),
                          fontSize: 15,
                          // fontFamily: 'Nexa Bold',
                          // fontWeight: FontWeight.w700,
                        )
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      MyTextFormField(
                        controller: primerApellidoController,
                        inputTypes: TextInputType.emailAddress,
                        myObscureText: false,
                        onChanged: (value) {},
                        suffixicon: null,
                        hintText: 'Primer Apellido',
                        // validator: (value) {
                        //   if (value == null || value.isEmpty) {
                        //     return 'Please enter your email';
                        //   } else if (!EmailValidator.validate(value)) {
                        //     return 'Invalid email address';
                        //   }
                        //   return null;
                        // },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text("Segundo Apellido:",
                        style: TextStyle(
                          color: Color(0xFFd4b0a0),
                          fontSize: 15,
                          // fontFamily: 'Nexa Bold',
                          // fontWeight: FontWeight.w700,
                        )
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      MyTextFormField(
                        controller: segundoApellidoController,
                        inputTypes: TextInputType.emailAddress,
                        myObscureText: false,
                        onChanged: (value) {},
                        suffixicon: null,
                        hintText: 'Segundo Apellido',
                        // validator: (value) {
                        //   if (value == null || value.isEmpty) {
                        //     return 'Please enter your email';
                        //   } else if (!EmailValidator.validate(value)) {
                        //     return 'Invalid email address';
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
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RegisterBirthDateSong()
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