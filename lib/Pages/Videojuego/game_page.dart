import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:diabeteens_v2/Pages/Videojuego/quiz.dart';


class SnakeGamePage extends StatefulWidget {
  const SnakeGamePage({Key? key}) : super(key: key);

  @override
  State<SnakeGamePage> createState() => _SnakeGamePageState();
}

enum Direction { up, down, left, right }

class _SnakeGamePageState extends State<SnakeGamePage> {
  int row = 20, column = 20;
  List<int> borderList = [];
  List<int> snakePosition = [];
  int snakeHead = 0;
  int score = 0;
  int candyPosition = -1; // Posición inicial fuera de la pantalla
  bool candyActive = false;
  bool gameActive = true;
  late Direction direction;
  late int foodPosition;
  late List<Question> questions;

  @override
  void initState() {
    startGame();
    questions = _generateQuestions();
    super.initState();
  }

  void startGame() {
    makeBorder();
    generateFood();
    direction = Direction.right;
    snakePosition = [45, 44, 43];
    snakeHead = snakePosition.first;
    score = 0;
    gameActive = true;
    Timer.periodic(const Duration(milliseconds: 300), (timer) {
      if (gameActive) {
        updateSnake();
        if (checkCollision()) {
          timer.cancel();
          showGameOverDialog();
        }
        checkCandyCollision();
        if (!candyActive) {
          generateCandy();
        }
      }
    });
  }

  void showGameOverDialog() async {
    gameActive = false;

    Question selectedQuestion = questions[Random().nextInt(questions.length)];

    bool answerCorrect = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => QuizScreen(selectedQuestion)),
    );

    if (answerCorrect != null) {
      if (answerCorrect) {
        // Respuesta correcta, reiniciar juego con los mismos puntos
        startGame();
      } else {
        // Respuesta incorrecta, mostrar pantalla de respuesta correcta
        await showAnswerDialog(selectedQuestion);
      }
    } else {
      // Si el usuario cierra el quiz sin responder, finaliza la aplicación
      exitGame();
    }
  }

  void exitGame() {
    Navigator.pop(context);
  }

  Future<void> showAnswerDialog(Question question) async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text("Respuesta Incorrecta"),
          content: Column(
            children: [
              const Text("La respuesta correcta es:"),
              Text(question.correctAnswer),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                // Pregunta si desea volver a jugar
                showReplayDialog();
              },
              child: const Text("Volver a Jugar"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                exitGame();
              },
              child: const Text("Salir"),
            ),
          ],
        );
      },
    );
  }

  Future<void> showReplayDialog() async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text("¿Desea Volver a Jugar?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                // Vuelve a jugar
                score = 0;
                startGame();
              },
              child: const Text("Sí"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                exitGame();
              },
              child: const Text("No"),
            ),
          ],
        );
      },
    );
  }

  bool checkCollision() {
    if (borderList.contains(snakeHead)) return true;
    if (snakePosition.sublist(1).contains(snakeHead)) return true;
    return false;
  }

  void generateFood() {
    foodPosition = Random().nextInt(row * column);
    if (borderList.contains(foodPosition) ||
        snakePosition.contains(foodPosition) ||
        (candyActive && candyPosition == foodPosition)) {
      generateFood();
    }
  }

  void generateCandy() {
    candyPosition = Random().nextInt(row * column);
    if (borderList.contains(candyPosition) ||
        snakePosition.contains(candyPosition) ||
        candyPosition == foodPosition) {
      generateCandy();
    }
    candyActive = true;
    Timer(const Duration(seconds: 5), () {
      candyActive = false;
      generateCandy();
    });
  }

  void updateSnake() {
    setState(() {
      switch (direction) {
        case Direction.up:
          snakePosition.insert(0, snakeHead - column);
          break;
        case Direction.down:
          snakePosition.insert(0, snakeHead + column);
          break;
        case Direction.right:
          snakePosition.insert(0, snakeHead + 1);
          break;
        case Direction.left:
          snakePosition.insert(0, snakeHead - 1);
          break;
      }
    });

    if (snakeHead == foodPosition) {
      score++;
      generateFood();
    } else if (candyActive && snakeHead == candyPosition) {
      // Colisión con el caramelo
      showGameOverDialog();
    } else {
      snakePosition.removeLast();
    }

    snakeHead = snakePosition.first;
  }

  void checkCandyCollision() {
    if (candyActive && snakeHead == candyPosition) {
      // Colisión con el caramelo
      showGameOverDialog();
    }
  }

  List<Question> _generateQuestions() {
    return [
      Question(
        "¿Cuál es una actividad física segura para las personas con diabetes tipo 1?",
        ["a) Ver televisión todo el día", "b) Hacer ejercicio regularmente, como caminar o nadar", "c) Nunca hacer ejercicio", "d) Solo jugar videojuegos"],
        "b) Hacer ejercicio regularmente, como caminar o nadar",
      ),
      Question(
        "¿Cuándo es necesario administrar insulina?",
        ["a) Solo los fines de semana", "b) Solo en la escuela", "c) Regularmente, según las indicaciones del médico", "d) Nunca es necesario"],
        "c) Regularmente, según las indicaciones del médico",
      ),
      Question(
        "¿Por qué es importante medir los niveles de glucosa en la sangre?",
        ["a) Para jugar", "b) Para controlar el azúcar en la sangre", "c) Para perder peso", "d) No es importante"],
        "b) Para controlar el azúcar en la sangre",
      ),
      Question(
        "¿Qué alimentos deben consumirse con moderación en una dieta para la diabetes tipo 1?",
        ["a) Frutas y verduras", "b) Dulces y alimentos ricos en azúcar", "c) Carnes magras y pescado", "d) Todos los alimentos son seguros"],
        "b) Dulces y alimentos ricos en azúcar",
      ),
      Question(
        "¿Qué se debe hacer si los niveles de azúcar en la sangre son demasiado altos?",
        ["a) Comer más dulces", "b) Beber más agua", "c) Administrar insulina según las indicaciones del médico", "d) Ignorar los niveles altos"],
        "c) Administrar insulina según las indicaciones del médico",
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [Expanded(child: _buildGameView()), _buildGameControls()],
      ),
    );
  }

  Widget _buildGameView() {
    return GridView.builder(
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: column),
      itemBuilder: (context, index) {
        return _buildGridItem(index);
      },
      itemCount: row * column,
    );
  }

  Widget _buildGameControls() {
    return Container(
      padding: const EdgeInsets.all(20),
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Puntaje : $score"),
          IconButton(
            onPressed: () {
              if (direction != Direction.down) direction = Direction.up;
            },
            icon: const Icon(Icons.arrow_circle_up),
            iconSize: 80,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  if (direction != Direction.right) direction = Direction.left;
                },
                icon: const Icon(Icons.arrow_circle_left_outlined),
                iconSize: 80,
              ),
              const SizedBox(width: 80),
              IconButton(
                onPressed: () {
                  if (direction != Direction.left) direction = Direction.right;
                },
                icon: const Icon(Icons.arrow_circle_right_outlined),
                iconSize: 80,
              ),
            ],
          ),
          IconButton(
            onPressed: () {
              if (direction != Direction.up) direction = Direction.down;
            },
            icon: const Icon(Icons.arrow_circle_down_outlined),
            iconSize: 80,
          ),
        ],
      ),
    );
  }

  Widget _buildGridItem(int index) {
    if (borderList.contains(index)) {
      return _buildBorderBox();
    } else if (snakePosition.contains(index)) {
      if (index == snakeHead) {
        return _buildSnakeBox("assets/images/videogame/head.png");
      } else {
        return _buildSnakeBox("assets/images/videogame/body.png");
      }
    } else if (index == foodPosition) {
      return _buildFoodBox();
    } else if (candyActive && index == candyPosition) {
      return _buildCandyBox();
    } else {
      return _buildEmptyBox();
    }
  }

  Widget _buildBorderBox() {
    return Container(
      margin: const EdgeInsets.all(1),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.blueAccent,
      ),
    );
  }

  Widget _buildSnakeBox(String imagePath) {
    return Image.asset(
      imagePath,
      width: double.infinity,
      height: double.infinity,
      fit: BoxFit.cover,
    );
  }

  Widget _buildFoodBox() {
    return Image.asset(
      "assets/images/videogame/fruit.png",
      width: double.infinity,
      height: double.infinity,
      fit: BoxFit.cover,
    );
  }

  Widget _buildCandyBox() {
    return Image.asset(
      "assets/images/videogame/candy.png",
      width: double.infinity,
      height: double.infinity,
      fit: BoxFit.cover,
    );
  }

  Widget _buildEmptyBox() {
    return Container(
      margin: const EdgeInsets.all(1),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.grey.withOpacity(0.05),
      ),
    );
  }

  void makeBorder() {
    for (int i = 0; i < column; i++) {
      if (!borderList.contains(i)) borderList.add(i);
    }
    for (int i = 0; i < row * column; i = i + column) {
      if (!borderList.contains(i)) borderList.add(i);
    }
    for (int i = column - 1; i < row * column; i = i + column) {
      if (!borderList.contains(i)) borderList.add(i);
    }
    for (int i = (row * column) - column; i < row * column; i = i + 1) {
      if (!borderList.contains(i)) borderList.add(i);
    }
  }
}

class Question {
  final String questionText;
  final List<String> options;
  final String correctAnswer;

  Question(this.questionText, this.options, this.correctAnswer);
}

class QuizScreen extends StatelessWidget {
  final Question question;

  QuizScreen(this.question);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              '¡Contesta correctamente y obtén una segunda oportunidad!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  const Text(
                    'Pregunta:',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Image.asset(
                    'assets/images/videogame/quiz.png', // Ajusta la ruta según la ubicación de tu imagen
                    height: 100, // Ajusta la altura de la imagen según tus necesidades
                  ),
                  const SizedBox(height: 10),
                  Text(
                    question.questionText,
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Opciones:',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  const SizedBox(height: 10),
                  ...question.options.map((option) => ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context, option == question.correctAnswer);
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                        ),
                        child: Text(
                          option,
                          style: TextStyle(fontSize: 16),
                        ),
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: QuizScreen(quizQuestions[0] as Question), // Muestra la primera pregunta del quiz
    );
  }
}
