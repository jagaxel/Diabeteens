import 'package:diabeteens_v2/Pages/LoginPage.dart';
import 'package:diabeteens_v2/Pages/RegisterHijo/RegisterNameSong.dart';
import 'package:flutter/material.dart';

class SuccessfullRegisterTutorPage extends StatefulWidget {
  static const routeName = '/registerTutor';
  const SuccessfullRegisterTutorPage({super.key});

  @override
  State<SuccessfullRegisterTutorPage> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<SuccessfullRegisterTutorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF4c709a),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                height: 100,
                child: Image(
                  image: AssetImage("assets/images/avatar.png"),
                  fit: BoxFit.cover,
                )
              ),
              const Text("Tutor Creado",
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: "NanumMyeongjo",
                  fontWeight: FontWeight.bold,
                  fontSize: 25
                )
              ),
              const SizedBox(height: 5),
              const SizedBox(height: 5),
              SizedBox(
                height: 50,
                width: 200,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFF795a9e)
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RegisterNamSong()
                      ) 
                    );
                  },
                  child: const Text("Registrar Hijo",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 15
                    )
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