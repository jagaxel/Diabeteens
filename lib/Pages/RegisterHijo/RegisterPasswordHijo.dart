import 'package:diabeteens_v2/Common/Common.dart';
import 'package:diabeteens_v2/Pages/PasswordChanged.dart';
import 'package:diabeteens_v2/Pages/RegisterHijo/CompleteRegister.dart';
import 'package:diabeteens_v2/Pages/RegisterTutor/RegiSterCompleteTutor.dart';
import 'package:diabeteens_v2/Utils/AppColors.dart';
import 'package:diabeteens_v2/Utils/FadeAnimationTest.dart';
import 'package:diabeteens_v2/Widget/CustomWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';

class RegisterPasswordHijoPage extends StatefulWidget {
  const RegisterPasswordHijoPage({super.key});

  @override
  State<RegisterPasswordHijoPage> createState() => _RegisterPasswordHijoPageState();
}

class _RegisterPasswordHijoPageState extends State<RegisterPasswordHijoPage> {
  bool flag = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.fondoColorAzul,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FadeInAnimation(
                delay: 1,
                child: IconButton(
                    onPressed: () {
                      // GoRouter.of(context).pop();
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      CupertinoIcons.back,
                      size: 35,
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    FadeInAnimation(
                      delay: 1.3,
                      child: Text(
                        "Registrar",
                        style: Common().titelTheme,
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    FadeInAnimation(
                      delay: 1.6,
                      child: Text(
                        "Ingrese una nueva contraseña: mínimo de 8 caratéres, al menos una myúcula, una minúscula, un número y un carácter especial.",
                        style: Common().shortTheme,
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Form(
                  child: Column(
                    children: [
                      FadeInAnimation(
                        delay: 1.9,
                        child: TextFormField (
                          obscureText: flag ? true : false,
                          decoration: InputDecoration (
                            filled: true,
                            fillColor: AppColors.blanco,
                            contentPadding: const EdgeInsets.all(13),
                            hintText: "Ingresar contraseña",
                            hintStyle: Common().hinttext,
                            border: OutlineInputBorder (
                              borderSide: const BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.circular(12)
                            ),
                            suffixIcon: IconButton (
                              onPressed: () {},
                              icon: const Icon(
                                Icons.remove_red_eye_outlined
                              )
                            )
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      FadeInAnimation(
                        delay: 2.1,
                        child: TextFormField (
                          obscureText: flag ? true : false,
                          decoration: InputDecoration (
                            filled: true,
                            fillColor: AppColors.blanco,
                            contentPadding: const EdgeInsets.all(13),
                            hintText: "Confirmar contraseña",
                            hintStyle: Common().hinttext,
                            border: OutlineInputBorder (
                              borderSide: const BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.circular(12)
                            ),
                            suffixIcon: IconButton (
                              onPressed: () {},
                              icon: const Icon(
                                Icons.remove_red_eye_outlined
                              )
                            )
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      FadeInAnimation(
                        delay: 2.4,
                        child: ElevatedButton (
                          onPressed: () async {
                            Navigator.push(
                              context, 
                              MaterialPageRoute(
                                builder: (context) => CompleteRegisterPage()
                              )
                            );
                          },
                          style: Common().styleBtnLite,
                          child: !flag
                          ? const CupertinoActivityIndicator()
                          : FittedBox(
                              child: Text(
                                "Finalizar",
                                style: Common().semiboldwhite,
                              )
                            ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Spacer(),
              // FadeInAnimation(
              //   delay: 2.5,
              //   child: Padding(
              //     padding: const EdgeInsets.only(left: 50),
              //     child: Row(
              //       crossAxisAlignment: CrossAxisAlignment.center,
              //       children: [
              //         Text(
              //           "Don’t have an account?",
              //           style: Common().hinttext,
              //         ),
              //         TextButton(
              //             onPressed: () {
              //               // GoRouter.of(context).pushNamed(Routers.signuppage.name);
              //             },
              //             child: Text(
              //               "Register Now",
              //               style: Common().mediumTheme,
              //             )),
              //       ],
              //     ),
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
