import 'dart:math';
import 'package:diabeteens_v2/Pages/Videojuego/game_page.dart';
import 'package:flutter/material.dart';

class InfoPage extends StatelessWidget {
  final List<String> diabetesInfo = [
    "Hola, soy Aletín, ¿sabías que la diabetes tipo 1 es una enfermedad que afecta la forma en que el cuerpo usa el azúcar?",
    "Hola, soy Aletín, ¿sabías que el ejercicio y una buena alimentación son importantes para mantenerse saludable?",
    "Hola, soy Aletín, ¿sabías que el páncreas es un órgano en nuestro cuerpo que ayuda a mantener nuestros niveles de azúcar bajo control?",
    "Hola, soy Aletín, ¿sabías que tomar la insulina adecuada es fundamental para las personas con diabetes tipo 1?",
    "Hola, soy Aletín, ¿sabías que a veces las personas con diabetes tipo 1 necesitan controlar sus niveles de azúcar varias veces al día?",
    "Hola, soy Aletín, ¿sabías que los dulces y las golosinas son deliciosos, pero para las personas con diabetes tipo 1 es mejor comer frutas y verduras?",
    "Hola, soy Aletín, ¿sabías que es importante seguir las recomendaciones del médico para mantenerse sano y fuerte?",
    "Hola, soy Aletín, ¿sabías que las personas con diabetes tipo 1 pueden hacer muchas cosas divertidas, como jugar, siempre cuidando su salud?",
    "Hola, soy Aletín, ¿sabías que la diabetes tipo 1 no impide que las personas lleven una vida activa y feliz?",
    "Hola, soy Aletín, ¿sabías que la diabetes tipo 1 no se contagia, pero se puede aprender a vivir bien con ella?",
    "Hola, soy Aletín, ¿sabías que es importante mantenerse positivo y animado, incluso si tienes diabetes tipo 1?",
    "Hola, soy Aletín, ¿sabías que contar con el apoyo de la familia y los amigos puede hacer más fácil vivir con diabetes tipo 1?",
    "Hola, soy Aletín, ¿sabías que llevar un registro de los niveles de azúcar en la sangre puede ayudar a controlar la diabetes tipo 1?",
    "Hola, soy Aletín, ¿sabías que aprender sobre la diabetes tipo 1 puede ayudarte a cuidarte mejor?",
    "Hola, soy Aletín, ¿sabías que puedes preguntarle al médico cualquier duda que tengas sobre la diabetes tipo 1?",
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

  // Método para obtener un dato aleatorio de la lista
  String _getRandomInfo() {
    final Random random = Random();
    final int index = random.nextInt(diabetesInfo.length);
    return diabetesInfo[index];
  }
}
