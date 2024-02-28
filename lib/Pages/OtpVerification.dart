import 'package:diabeteens_v2/Common/Common.dart';
import 'package:diabeteens_v2/Pages/ResetPassword.dart';
import 'package:diabeteens_v2/Utils/AppColors.dart';
import 'package:diabeteens_v2/Utils/FadeAnimationTest.dart';
import 'package:diabeteens_v2/Widget/CustomWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class OtpVerificationPage extends StatefulWidget {
  const OtpVerificationPage({super.key});

  @override
  State<OtpVerificationPage> createState() => _OtpVerificationPageState();
}

class _OtpVerificationPageState extends State<OtpVerificationPage> {
  bool flag = true;
  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
          fontSize: 20, color: Colors.grey, fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade800),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: Colors.grey),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: const Color.fromRGBO(234, 239, 243, 1),
      ),
    );

    return Scaffold(
      backgroundColor: AppColors.fondoColorAzul,
      body: SafeArea(
        child: SingleChildScrollView (
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
                  const Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FadeInAnimation(
                          delay: 1.3,
                          child: Image(
                            image: AssetImage("assets/images/logo-diabeteens.png"),
                          ),
                        ),
                      ],
                    ),
                  ),
                  FadeInAnimation(
                    delay: 1.6,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Código de verificación",
                        style: Common().titelTheme,
                      )
                    ),
                  ),
                  FadeInAnimation(
                    delay: 1.9,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Ingrese el código enviado a correo@gmail.com",
                        style: Common().shortTheme,
                      )
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Form(
                      child: Column(
                        children: [
                          FadeInAnimation(
                            delay: 1.9,
                            child: Pinput(
                              defaultPinTheme: defaultPinTheme,
                              focusedPinTheme: focusedPinTheme,
                              submittedPinTheme: submittedPinTheme,
                              validator: (s) {
                                return s == '2222' ? null : 'Código incorrecto';
                              },
                              pinputAutovalidateMode:
                                  PinputAutovalidateMode.onSubmit,
                              showCursor: true,
                              onCompleted: (pin) {
                                print(pin);
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          FadeInAnimation(
                            delay: 2.1,
                            child: ElevatedButton (
                              onPressed: () async {
                                Navigator.push(
                                  context, 
                                  MaterialPageRoute(
                                    builder: (context) => ResetPasswordPage()
                                  )
                                );
                              },
                              style: Common().styleBtnLite,
                              child: !flag
                              ? const CupertinoActivityIndicator()
                              : FittedBox(
                                  child: Text(
                                    "Verificar código",
                                    style: Common().semiboldwhite,
                                  )
                                ),
                            ),
                          ),
                          SizedBox(
                            height: 95,
                          ),
                          FadeInAnimation(
                            delay: 3.1,
                            child: Align(
                              alignment: Alignment.center,
                              child: GestureDetector(
                                onTap: () {
                                  // GoRouter.of(context).pushNamed(Routers.forgetpassword.name);
                                },
                                child: const Text(
                                  "¿Tienes cuenta?",
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: "GFSNeohellenic",
                                  ),
                                )
                              )
                            ),
                          ),
                          FadeInAnimation(
                            delay: 3.4,
                            child: Align(
                              alignment: Alignment.center,
                              child: GestureDetector(
                                onTap: () {
                                  // GoRouter.of(context).pushNamed(Routers.forgetpassword.name);
                                },
                                child: const Text(
                                  "Inicia sesión",
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: "GFSNeohellenic",
                                    decoration: TextDecoration.underline,
                                  ),
                                )
                              )
                            ),
                          ),
                          SizedBox(
                            height: 53,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              const Positioned(
                left: -20,
                bottom: 0,
                child: FadeInAnimation(
                  delay: 3.1,
                  child: Image(
                    image: AssetImage('assets/images/las-olas-del-mar-l.png'),
                    width: 130,
                    // height: 100,
                  )
                ),
              ),
              const Positioned(
                right: -20,
                bottom: 0,
                child: FadeInAnimation(
                  delay: 3.1,
                  child: Image(
                    image: AssetImage('assets/images/las-olas-del-mar.png'),
                    width: 130,
                    // height: 100,
                  )
                ),
              )
            ],
          )
        )
        // Padding(
        //   padding: const EdgeInsets.all(10.0),
        //   child: Column(
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: [
        //       FadeInAnimation(
        //         delay: 1,
        //         child: IconButton(
        //             onPressed: () {
        //               // GoRouter.of(context).pop();
        //             },
        //             icon: const Icon(
        //               CupertinoIcons.back,
        //               size: 35,
        //             )),
        //       ),
        //       Padding(
        //         padding: const EdgeInsets.all(12.0),
        //         child: Column(
        //           crossAxisAlignment: CrossAxisAlignment.start,
        //           children: [
        //             FadeInAnimation(
        //               delay: 1.3,
        //               child: Text(
        //                 "OTP Verification",
        //                 style: Common().titelTheme,
        //               ),
        //             ),
        //             FadeInAnimation(
        //               delay: 1.6,
        //               child: Text(
        //                 "Enter the verification code we just sent on your email address.",
        //                 style: Common().mediumThemeblack,
        //               ),
        //             )
        //           ],
        //         ),
        //       ),
        //       Padding(
        //         padding: const EdgeInsets.all(12.0),
        //         child: Form(
        //           child: Column(
        //             children: [
        //               FadeInAnimation(
        //                 delay: 1.9,
        //                 child: Pinput(
        //                   defaultPinTheme: defaultPinTheme,
        //                   focusedPinTheme: focusedPinTheme,
        //                   submittedPinTheme: submittedPinTheme,
        //                   validator: (s) {
        //                     return s == '2222' ? null : 'Pin is incorrect';
        //                   },
        //                   pinputAutovalidateMode:
        //                       PinputAutovalidateMode.onSubmit,
        //                   showCursor: true,
        //                   onCompleted: (pin) {
        //                     print(pin);
        //                   },
        //                 ),
        //               ),
        //               const SizedBox(
        //                 height: 30,
        //               ),
        //               FadeInAnimation(
        //                 delay: 2.1,
        //                 child: CustomElevatedButton(
        //                   message: "Verify",
        //                   function: () {
        //                     // GoRouter.of(context).pushNamed(Routers.newpassword.name);
        //                   },
        //                   color: Colors.black,
        //                 ),
        //               ),
        //             ],
        //           ),
        //         ),
        //       ),
        //       const Spacer(),
        //       FadeInAnimation(
        //         delay: 2.4,
        //         child: Padding(
        //           padding: const EdgeInsets.only(left: 50),
        //           child: Row(
        //             crossAxisAlignment: CrossAxisAlignment.center,
        //             children: [
        //               Text(
        //                 "Don’t have an account?",
        //                 style: Common().hinttext,
        //               ),
        //               TextButton(
        //                   onPressed: () {
        //                     // GoRouter.of(context).pushNamed(Routers.signuppage.name);
        //                   },
        //                   child: Text(
        //                     "Register Now",
        //                     style: Common().mediumTheme,
        //                   )),
        //             ],
        //           ),
        //         ),
        //       )
        //     ],
        //   ),
        // ),
      
      ),
    );
  }
}