import 'package:diabeteens_v2/Elements/CustomButton.dart';
import 'package:diabeteens_v2/Elements/MyTextFormField.dart';
import 'package:diabeteens_v2/Pages/LoginPage.dart';
import 'package:diabeteens_v2/Pages/RegisterTutor/RegisterCorreoPage.dart';
import 'package:flutter/material.dart';

class RegisterSavePage extends StatefulWidget {
  static const routeName = '/registerTutor';
  const RegisterSavePage({super.key});

  @override
  State<RegisterSavePage> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterSavePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController phoneController = TextEditingController();
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
    phoneController.clear();
  }

  @override
  Widget build(BuildContext context) {
    double widgetHeight = MediaQuery.of(context).size.height;
    double widgetWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xFF4c709a),
        body: SafeArea(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20,
            ),
            const SizedBox(
              width: 302,
              height: 50,
              child: Text("Datos del Tutor", 
                style: TextStyle(
                  color: Color(0xFF90bbd0),
                  fontSize: 20
                )
              )
            ),
            const SizedBox(
              width: 302,
              height: 50,
              child: Text("¿Guardar información de inicio de sesión?", style: TextStyle(color: Colors.white))
            ),
            SizedBox(
                height: widgetHeight * .06,
                width: widgetWidth * .5,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFF795a9e)
                  ),
                  onPressed: () {
                    print("Guardar");
                  },
                  child: const Text("Guardar",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 15
                      )
                    ),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: widgetHeight * .06,
                width: widgetWidth * .5,
                child: OutlinedButton(
                  onPressed: () {
                    print("Ahora no");
                  },
                  child: Text("Ahora no"),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(
                      color: Color(0xFFd4b0a0),
                      // width: 4
                    ), //permite cambiar el color del border
                    primary: Colors.white, //Cambia el color del texto del boton
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(50))
                    ) //Para cambiar el border del botón
                  ),
                ),
              )
          ],
        ),
      ),
    ));
  }
}