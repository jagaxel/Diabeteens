import 'package:diabeteens_v2/Common/Common.dart';
import 'package:diabeteens_v2/Pages/LoginPage.dart';
import 'package:diabeteens_v2/Utils/AppColors.dart';
import 'package:diabeteens_v2/Utils/FadeAnimationTest.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

class CompleteRegisterPage extends StatefulWidget {
  const CompleteRegisterPage({super.key});

  @override
  State<CompleteRegisterPage> createState() => _CompleteRegisterPageState();
}

class _CompleteRegisterPageState extends State<CompleteRegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.fondoColorAzul,
      body: SafeArea(
        child: Column(
          children: [
            LottieBuilder.asset("assets/images/ticker.json"),
            FadeInAnimation(
              delay: 1,
              child: Text(
                "¡Reigstro Completado!",
                style: Common().titelTheme,
              ),
            ),
            FadeInAnimation(
              delay: 1.5,
              child: Text(
                "Has completado el registro exitosamente",
                style: Common().shortTheme,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            FadeInAnimation(
              delay: 2,
              child: ElevatedButton (
                onPressed: () async {
                  Navigator.pushAndRemoveUntil(
                    context, 
                    MaterialPageRoute(
                      builder: (context) => LoginPage()
                    ),
                    (Route<dynamic> route) => false,
                  );
                },
                style: Common().styleBtn,
                child: FittedBox(
                  child: Text(
                    "Iniciar sesión",
                    style: Common().semiboldwhite,
                  )
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
