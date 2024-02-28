import 'package:diabeteens_v2/Common/Common.dart';
import 'package:diabeteens_v2/Elements/CustomButton.dart';
import 'package:diabeteens_v2/Elements/MyTextFormField.dart';
import 'package:diabeteens_v2/Pages/ForgetPassword.dart';
import 'package:diabeteens_v2/Pages/ForgotPassword/MethodToSendCode.dart';
import 'package:diabeteens_v2/Pages/RegisterHijo/RegisterUserHijo.dart';
import 'package:diabeteens_v2/Pages/RegisterTutor/RegisterNamePage.dart';
import 'package:diabeteens_v2/Pages/RegisterTutor/RegisterUserTutor.dart';
import 'package:diabeteens_v2/Pages/Views/Hijo/EntryPointHijo.dart';
import 'package:diabeteens_v2/Pages/Views/Tutor/EntryPointTutor.dart';
import 'package:diabeteens_v2/Pages/Views/Tutor/HomeTutor.dart';
import 'package:diabeteens_v2/Utils/DirectionIp.dart';
import 'package:diabeteens_v2/Utils/FadeAnimationTest.dart';
import 'package:diabeteens_v2/VistaInicial.dart';
import 'package:diabeteens_v2/Widget/CustomWidget.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:diabeteens_v2/Utils/AppColors.dart';
// import 'package:flutter_email_sender/flutter_email_sender.dart';
// import 'package:url_launcher/url_launcher.dart';

class RegiSterCompleteTutorPage extends StatefulWidget {
  // static const routeName = '/RegiSterCompleteTutorScreen';
  const RegiSterCompleteTutorPage({super.key});

  @override
  State<RegiSterCompleteTutorPage> createState() => _RegiSterCompleteTutorScreenState();
}

class _RegiSterCompleteTutorScreenState extends State<RegiSterCompleteTutorPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool _obscureText = true;
  bool flag = true;

  DirectionIp ip = DirectionIp();

/*
  _launch(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'No se envió $url';
    }
  }

  launchEMAI() async {
    // final Uri _emailLaunchUri = Uri(
    //   scheme: 'mailto',
    //   path: 'pp103634@gmail.com',
    //   queryParameters: {
    //     'subject': 'Codigo de Validación',
    //     'body': 'Prueba'
    //   }
    // );
    // _launch(_emailLaunchUri.toString());
    final Email email = await Email(
      body: 'Prueba',
      subject: 'Codigo',
      recipients: ['pp103634@gmail.com'],
      isHTML: false,
    );

    await FlutterEmailSender.send(email);
  }
*/

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      backgroundColor: AppColors.fondoColorAzul,
      body: SingleChildScrollView (
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: FadeInAnimation(
                    delay: 1.3,
                    child: Text(
                      "¡MOMENTO DE REGISTRAR HIJO!",
                      style: Common().titelTheme,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                SizedBox(
                  height: 200,
                ),
                FadeInAnimation(
                  delay: 1.3,
                  child: ElevatedButton (
                    onPressed: () async {
                      Navigator.push(
                        context, 
                        MaterialPageRoute(
                          builder: (context) => RegisterUserHijoPage()
                        )
                      );
                    },
                    style: Common().styleBtnWhite,
                    
                    child: FittedBox(
                        child: Text(
                          "Iniciar",
                          style: Common().titelTheme,
                        )
                      ),
                  ),
                ),
                SizedBox(
                  height: 18,
                )
              ],
            ),
            const Positioned(
              left: 230,
              bottom: 0,
              child: FadeInAnimation(
                delay: 3.1,
                child: Image(
                  image: AssetImage('assets/images/delfin.png'),
                  width: 130,
                  // height: 100,
                )
              ),
            ),
          ],
        )
      )
    );
  }
}