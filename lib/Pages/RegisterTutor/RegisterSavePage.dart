import 'package:diabeteens_v2/Pages/RegisterTutor/RegisterPasswordPage.dart';
import 'package:diabeteens_v2/Pages/RegisterTutor/SuccessfullRegisterTutorPage.dart';
import 'package:diabeteens_v2/VistaInicial.dart';
import 'package:flutter/material.dart';

class RegisterSavePage extends StatefulWidget {
  final int idPersona;
  final int idTutor;
  final String correo;
  const RegisterSavePage({super.key, required this.idPersona, required this.idTutor, required this.correo});

  @override
  State<RegisterSavePage> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterSavePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController phoneController = TextEditingController();
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
    phoneController.clear();
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
                        builder: (context) => RegisterPasswordPage(idPersona: _idPersona, idTutor: _idTutor, correo: _correo),
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
                height: 50,
                width: 200,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF795a9e)
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SuccessfullRegisterTutorPage(idTutor: _idTutor),
                      ) 
                    );
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
                height: 50,
                width: 200,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => VistaInicial(),
                      ) 
                    );
                  },
                  child: Text("Ahora no"),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white, side: BorderSide(
                      color: Color(0xFFd4b0a0),
                      // width: 4
                    ), //Cambia el color del texto del boton
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(50))
                    ) //Para cambiar el border del botón
                  ),
                ),
              )
            ],
          ),
        ),
      )
    );
  }
}