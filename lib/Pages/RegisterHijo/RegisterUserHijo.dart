import 'package:diabeteens_v2/Common/Common.dart';
import 'package:diabeteens_v2/Pages/RegisterHijo/RegisterDateSexHijo.dart';
import 'package:diabeteens_v2/Pages/RegisterTutor/RegisterDateSexTutor.dart';
import 'package:diabeteens_v2/Utils/AppColors.dart';
import 'package:diabeteens_v2/Utils/FadeAnimationTest.dart';
import 'package:diabeteens_v2/Widget/CustomWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class RegisterUserHijoPage extends StatefulWidget {
  const RegisterUserHijoPage({super.key});

  @override
  State<RegisterUserHijoPage> createState() => _RegisterUserHijoPageState();
}

class _RegisterUserHijoPageState extends State<RegisterUserHijoPage> {
  bool flag = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.fondoColorAzul,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            AppBar(
              backgroundColor: AppColors.fondoColorAzul,
              leading: FadeInAnimation(
                delay: 1,
                child: IconButton(
                  onPressed: () {
                    // GoRouter.of(context).pop();
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    CupertinoIcons.back,
                    size: 35,
                  )
                ),
              )
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 80,
                ),
                FadeInAnimation(
                  delay: 1.3,
                  child: Text(
                    "Registro",
                    style: Common().titelTheme,
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25, right: 25),
                  child: Form(
                    child: Column(
                      children: [
                        FadeInAnimation (
                          delay: 1.6,
                          child: TextFormField (
                            obscureText: flag ? true : false,
                            decoration: InputDecoration (
                              filled: true,
                              fillColor: AppColors.blanco,
                              contentPadding: const EdgeInsets.all(13),
                              hintText: "Ingrese número de teléfono",
                              hintStyle: Common().hinttext,
                              border: OutlineInputBorder (
                                borderSide: const BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(12)
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        FadeInAnimation (
                          delay: 1.9,
                          child: TextFormField (
                            obscureText: flag ? true : false,
                            decoration: InputDecoration (
                              filled: true,
                              fillColor: AppColors.blanco,
                              contentPadding: const EdgeInsets.all(13),
                              hintText: "Nombre(s)",
                              hintStyle: Common().hinttext,
                              border: OutlineInputBorder (
                                borderSide: const BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(12)
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        FadeInAnimation (
                          delay: 2.2,
                          child: TextFormField (
                            obscureText: flag ? true : false,
                            decoration: InputDecoration (
                              filled: true,
                              fillColor: AppColors.blanco,
                              contentPadding: const EdgeInsets.all(13),
                              hintText: "Primer Apellido",
                              hintStyle: Common().hinttext,
                              border: OutlineInputBorder (
                                borderSide: const BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(12)
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        FadeInAnimation (
                          delay: 2.5,
                          child: TextFormField (
                            obscureText: flag ? true : false,
                            decoration: InputDecoration (
                              filled: true,
                              fillColor: AppColors.blanco,
                              contentPadding: const EdgeInsets.all(13),
                              hintText: "Segundo Apellido",
                              hintStyle: Common().hinttext,
                              border: OutlineInputBorder (
                                borderSide: const BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(12)
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 55,
                        ),
                        FadeInAnimation(
                          delay: 2.8,
                          child: ElevatedButton(
                            onPressed: () async {
                              Navigator.push(
                                  context, 
                                  MaterialPageRoute(
                                    builder: (context) => RegisterDateSexHijoPage()
                                  )
                                );
                            },
                            style: Common().styleBtnLite,
                            child: !flag
                                ? const CupertinoActivityIndicator()
                                : FittedBox(
                                    child: Text(
                                    "Siguiente",
                                    style: Common().semiboldwhite,
                                  )),
                          ),
                        ),
                        SizedBox(
                          height: 130,
                        ),
                        FadeInAnimation(
                          delay: 3.1,
                          child: ElevatedButton (
                            onPressed: () async {
                              // Navigator.push(
                              //   context, 
                              //   MaterialPageRoute(
                              //     builder: (context) => PasswordChangesPage()
                              //   )
                              // );
                            },
                            style: Common().styleBtn,
                            child: !flag
                            ? const CupertinoActivityIndicator()
                            : FittedBox(
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
                ),
              ],
            ),
          ],
        )
      )
    );
  }
}
