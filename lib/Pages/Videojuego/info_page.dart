import 'dart:math';
import 'package:diabeteens_v2/Pages/Videojuego/game_page.dart';
import 'package:flutter/material.dart';

class InfoPage extends StatelessWidget {
  final List<String> diabetesInfo = [
    "¡Hola, soy Aletín! ¿Sabías que la diabetes tipo 1 es una enfermedad que afecta la forma en que el cuerpo usa el azúcar?",
    "¡Hola, soy Aletín! ¿Sabías que el ejercicio y una buena alimentación son importantes para mantenerse saludable?",
    "¡Hola, soy Aletín! ¿Sabías que el páncreas es un órgano en nuestro cuerpo que ayuda a mantener nuestros niveles de azúcar bajo control?",
    "¡Hola, soy Aletín! ¿Sabías que tomar la insulina adecuada es fundamental para las personas con diabetes tipo 1?",
    "¡Hola, soy Aletín! ¿Sabías que a veces las personas con diabetes tipo 1 necesitan controlar sus niveles de azúcar varias veces al día?",
    "¡Hola, soy Aletín! ¿Sabías que los dulces y las golosinas son deliciosos, pero para las personas con diabetes tipo 1 es mejor comer frutas y verduras?",
    "¡Hola, soy Aletín! ¿Sabías que es importante seguir las recomendaciones del médico para mantenerse sano y fuerte?",
    "¡Hola, soy Aletín! ¿Sabías que las personas con diabetes tipo 1 pueden hacer muchas cosas divertidas, como jugar, siempre cuidando su salud?",
    "¡Hola, soy Aletín! ¿Sabías que la diabetes tipo 1 no impide que las personas lleven una vida activa y feliz?",
    "¡Hola, soy Aletín! ¿Sabías que la diabetes tipo 1 no se contagia y se puede aprender a vivir bien con ella?",
    "¡Hola, soy Aletín! ¿Sabías que es importante mantenerse positivo y animado, incluso si tienes diabetes tipo 1?",
    "¡Hola, soy Aletín! ¿Sabías que contar con el apoyo de la familia y los amigos puede hacer más fácil vivir con diabetes tipo 1?",
    "¡Hola, soy Aletín! ¿Sabías que llevar un registro de los niveles de azúcar en la sangre puede ayudar a controlar la diabetes tipo 1?",
    "¡Hola, soy Aletín! ¿Sabías que aprender sobre la diabetes tipo 1 puede ayudarte a cuidarte mejor?",
    "¡Hola, soy Aletín! ¿Sabías que puedes preguntarle al médico cualquier duda que tengas sobre la diabetes tipo 1?",
    "¡Hola, soy Aletín! ¿Sabías que hacer ejercicio te hace sentir fuerte y feliz? ¡Es genial para mantener tu diabetes tipo 1 bajo control!",
    "¡Hola, soy Aletín! ¿Sabías que comer frutas y verduras te da energía y te hace sentir genial? ¡Son deliciosas y saludables para tu diabetes tipo 1!",
    "¡Hola, soy Aletín! ¿Sabías que contarle a tus amigos sobre tu diabetes tipo 1 los hace comprender mejor y pueden ayudarte cuando lo necesites?",
    "¡Hola, soy Aletín! ¿Sabías que llevar tu kit de diabetes contigo te ayuda a estar preparado para cualquier situación? ¡Es como tu superpoder contra la diabetes tipo 1!",
    "¡Hola, soy Aletín! ¿Sabías que los controles regulares con tu médico son importantes para asegurarte de que estás cuidando bien tu diabetes tipo 1?",
    "¡Hola, soy Aletín! ¿Sabías que tomar agua es vital para mantenerte hidratado y para ayudar a tu cuerpo a controlar tu diabetes tipo 1?",
    "¡Hola, soy Aletín! ¿Sabías que el apoyo de tu familia y amigos es como un abrazo que te ayuda a sentirte seguro y amado mientras manejas tu diabetes tipo 1?",
    "¡Hola, soy Aletín! ¿Sabías que llevar un estilo de vida activo y feliz es posible con diabetes tipo 1? ¡Tú puedes hacerlo, solo mantén una actitud positiva!",
    "¡Hola, soy Aletín! ¿Sabías que aprender sobre tu diabetes tipo 1 te da el poder de tomar decisiones saludables y cuidar mejor de ti mismo?",
    "¡Hola, soy Aletín! ¿Sabías que tu sonrisa es tu mejor accesorio? ¡Sigue siendo tú mismo y vive la vida al máximo, incluso con diabetes tipo 1!",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color.fromRGBO(112, 186, 166, 1),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Color.fromRGBO(173, 216, 209, 1),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    '¡MENSAJE DE ALETÍN!',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.red),
                  ),
                  const SizedBox(height: 20),
                  Image.asset(
                    'assets/images/videogame/delfin.png',
                    height: 200,
                    width: 200,
                  ),
                  const SizedBox(height: 40),
                  Text(
                    _getRandomInfo(),
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                  const SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SnakeGamePage()),
                    );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      minimumSize: Size(150, 50),
                      padding: EdgeInsets.symmetric(vertical: 10),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    child: Text(
                      'Entendido',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String _getRandomInfo() {
    final Random random = Random();
    final int index = random.nextInt(diabetesInfo.length);
    return diabetesInfo[index];
  }
}