import 'package:diabeteens_v2/Common/Common.dart';
import 'package:diabeteens_v2/Pages/PasswordChanged.dart';
import 'package:diabeteens_v2/Utils/AppColors.dart';
import 'package:diabeteens_v2/Utils/FadeAnimationTest.dart';
import 'package:diabeteens_v2/Widget/CustomWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
// import 'package:go_router/go_router.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  bool flag = true;
  bool showPass = true;
  bool showPassConfirm = true;

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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FadeInAnimation(
                      delay: 1.3,
                      child: Text(
                        "Restablecer contraseña",
                        style: Common().titelTheme,
                      ),
                    ),
                    FadeInAnimation(
                      delay: 1.6,
                      child: Text(
                        "Ingrese una nueva contraseña: mínimo de 8 caratéres, al menos una myúcula, una minúscula, un número y un caracter especial.",
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
                          validator: MultiValidator([
                              RequiredValidator(errorText: 'La contraseña es requerida'), 
                              PatternValidator(r'^(?=.{8,})(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)(?!.*\s).*$', errorText: 'Contraseña no válida')
                          ]),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          obscureText: showPass,
                          decoration: InputDecoration (
                            filled: true,
                            fillColor: AppColors.blanco,
                            contentPadding: const EdgeInsets.all(13),
                            hintText: "Nueva contraseña",
                            hintStyle: Common().hinttext,
                            border: OutlineInputBorder (
                              borderSide: const BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.circular(12)
                            ),
                            suffixIcon: IconButton (
                              onPressed: () {
                                setState(() {
                                  showPass = !showPass;
                                });
                              },
                              icon: Icon(
                                showPass ? Icons.remove_red_eye_outlined : Icons.visibility_off
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
                          validator: MultiValidator([
                              RequiredValidator(errorText: 'La contraseña es requerida'), 
                              PatternValidator(r'^(?=.{8,})(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)(?!.*\s).*$', errorText: 'Contraseña no válida')
                          ]),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          obscureText: showPassConfirm,
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
                              onPressed: () {
                                setState(() {
                                  showPassConfirm = !showPassConfirm;
                                });
                              },
                              icon: Icon(
                                showPassConfirm ? Icons.remove_red_eye_outlined : Icons.visibility_off
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
                                builder: (context) => PasswordChangesPage()
                              )
                            );
                          },
                          style: Common().styleBtn,
                          child: !flag
                          ? const CupertinoActivityIndicator()
                          : FittedBox(
                              child: Text(
                                "Restablecer contraseña",
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
