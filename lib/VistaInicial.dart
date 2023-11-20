import 'package:diabeteens_v2/Models/MenuBtn.dart';
import 'package:diabeteens_v2/Pages/LoginPage.dart';
import 'package:diabeteens_v2/Pages/RegisterTutor/RegisterNamePage.dart';
import 'package:diabeteens_v2/Pages/Views/Tutor/EntryPointTutor.dart';
import 'package:diabeteens_v2/Pages/Views/Tutor/MenuTutor.dart';
import 'package:flutter/material.dart';

// import '../utils/constants.dart';

class VistaInicial extends StatefulWidget {
  const VistaInicial({super.key});

  @override
  State<VistaInicial> createState() => _GetStartedScreenState();
}

class _GetStartedScreenState extends State<VistaInicial> {
  @override
  Widget build(BuildContext context) {
    double widgetHeight = MediaQuery.of(context).size.height;
    double widgetWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xFF4c709a),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: widgetWidth * 1.1,
              child: Image(
                image: AssetImage("assets/images/logo-diabeteens-letras.png"),
                fit: BoxFit.cover,
              )
            ),
            // const Text("DIABETEENS",
            //     style: TextStyle(
            //         color: Color(0xFFe88559),
            //         fontFamily: "NanumMyeongjo",
            //         fontWeight: FontWeight.bold,
            //         fontSize: 25)),
            const SizedBox(height: 5),
            // const Text(
            //   "Coffee Boosts energy levels, Coffee house is one of the best coffee shops in Mardan.",
            //   style: TextStyle(
            //       color: Colors.white,
            //       fontWeight: FontWeight.w400,
            //       fontSize: 15),
            //   textAlign: TextAlign.center,
            // ),
            const SizedBox(height: 5),
            SizedBox(
              height: widgetHeight * .06,
              width: widgetWidth * .5,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFF795a9e)
                ),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginPage()
                      // builder: (context) => LineChartSample3()
                      // builder: (context) => const MenuBtn()
                      // builder: (context) => const EntryPointTutor()
                      // builder: (context) => const MenuTutor(idHijos: "5,6", cantHijos: 2,)
                    ) 
                  );
                },
                child: const Text("Iniciar Sesión",
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
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RegisterNamePage()
                    ) 
                  );
                },
                child: Text("¿Crear cuenta?"),
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
      )
    );
  }
}