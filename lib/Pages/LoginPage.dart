import 'package:diabeteens_v2/Elements/CustomButton.dart';
import 'package:diabeteens_v2/Elements/MyTextFormField.dart';
import 'package:diabeteens_v2/Pages/RegisterTutor/RegisterNamePage.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  static const routeName = '/loginScreen';
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold (
      backgroundColor: Color(0xFF4c709a),
      body: SingleChildScrollView (
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 320,
              child: Image(
                image: AssetImage("assets/images/logo-diabeteens-letras.png"),
              ),
            ),
            Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Padding(
                padding: const EdgeInsets.only(left: 40, right: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Correo electrónico",
                        style: TextStyle(
                          color: Color(0xFFd4b0a0),
                          fontSize: 12,
                          // fontFamily: 'Nexa Bold',
                          // fontWeight: FontWeight.w700,
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    MyTextFormField(
                      controller: emailController,
                      inputTypes: TextInputType.emailAddress,
                      myObscureText: false,
                      suffixicon: null,
                      hintText: 'Correo elctrónico',
                      // validator: (value) {
                      //   if (value == null || value.isEmpty) {
                      //     return 'Please enter your email';
                      //   } else if (!EmailValidator.validate(value)) {
                      //     return 'Invalid email address';
                      //   }

                      //   return null;
                      // },
                      onChanged: (value) {},
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text("Contraseña",
                        style: TextStyle(
                          color: Color(0xFFd4b0a0),
                          fontSize: 12,
                          // fontFamily: 'Nexa Bold',
                          // fontWeight: FontWeight.w700,
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    MyTextFormField(
                        myObscureText: _obscureText,
                        controller: passwordController,
                        suffixicon: IconButton(
                          color: Colors.white,
                          icon: Icon(
                            _obscureText
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          },
                        ),
                        inputTypes: TextInputType.visiblePassword,
                        hintText: 'Contraseña',
                        // validator: (value) {
                        //   if (value == null || value.isEmpty) {
                        //     return 'Introduzca su contraseña';
                        //   }

                        //   return null;
                        // },
                        onChanged: (value) {}),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                      GestureDetector(
                          onTap: () {},
                          child: const Text("Olvidé mi contraseña...",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                // fontFamily: 'Nexa Light',
                                fontWeight: FontWeight.w400,
                              ))),
                    ]),
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
            ),
            CustomButton(
                buttonWidth: 260,
                buttonHeight: 46,
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    print("Iniciar Sesión");
                  }
                },
                text: "Iniciar Sesión",
                buttonBackgroundColor: Color(0xFF795a9e),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  // fontFamily: 'Nexa Light',
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0.01,
                )),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("¿No tienes cuenta?",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 10,
                      // fontFamily: 'Nexa',
                      fontWeight: FontWeight.w500,
                    )),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => RegisterNamePage()));
                  },
                  child: Text("-Crear cuenta",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 10,
                      // fontFamily: 'Nexa Light',
                      fontWeight: FontWeight.w700,
                    )
                  )
                )
              ],
            ),
          ],
        ),
      )
    );
  }
}