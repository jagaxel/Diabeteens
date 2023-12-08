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
  int candyPosition = -1;
  bool candyActive = false;
  bool gameActive = true;
  late Direction direction;
  late int foodPosition;
  late List<Question> questions;
  int currentScore = 0;
  static const int snakeSpeed = 300;
  
  @override
  void initState() {
    foodPosition = _generateRandomPosition();
    _showStartScreen();
    questions = _generateQuestions();
    super.initState();
  }

  void _showStartScreen() async {
    await Future.delayed(Duration.zero);
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text("¡Ayuda a Snake a comer sanamente!"),
          content: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/videogame/snake.png',
                height: 100,
              ),
              const SizedBox(height: 20),
              const Text("Su comida favorita son las frutas y lo ayudan a crecer."),
              Image.asset(
                'assets/images/fruits/apple.png',
                height: 80,
              ),
              const Text("Evita los dulces, son dañinos para la salud."),
              Image.asset(
                'assets/images/kandies/candy.png',
                height: 80,
              ),
              const SizedBox(height: 20),
              const Text(
                "Nota: Si comes algún dulce, reiniciaras el juego con más velocidad por el azúcar, ¡ten cuidado!",
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Text(
                "¿Cuántos puntos podrás conseguir?",
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                startGame();
              },
              child: const Text("Continuar"),
            ),
          ],
        );
      },
    );
  }

  void startGame() {
    makeBorder();
    generateFood();
    direction = Direction.right;
    snakePosition = [45, 44, 43];
    snakeHead = snakePosition.first;
    score = 0;
    gameActive = true;
    candyActive = false;
    Timer.periodic(const Duration(milliseconds: snakeSpeed), (timer) {
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
        await showSuccessScreen(score);
      } else {
        await showAnswerDialog(selectedQuestion);
      }
    } else {
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
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/videogame/wrong.png',
                height: 100,
              ),
              const SizedBox(height: 20),
              const Text(
                "La respuesta correcta es:",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                question.correctAnswer,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                exitGame();
              },
              child: const Text("Salir", style: TextStyle(color: Colors.red)),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                showReplayDialog();
              },
              child: const Text("Volver a Jugar", style: TextStyle(color: Colors.blue)),
            ),
          ],
        );
      },
    );
  }

  Future<void> showSuccessScreen(int score) async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          content: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/videogame/success.png',
                height: 100,
              ),
              const SizedBox(height: 20),
              Text(
                '¡Bien hecho, ahora tienes otra oportunidad!',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Aún conservas tus puntos',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Puntuación actual: $score',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                // Reinicia la posición de la serpiente y continúa el juego
                setState(() {
                  snakePosition = [45, 44, 43];
                  snakeHead = snakePosition.first;
                  direction = Direction.right;
                });
                gameActive = true;
                Timer.periodic(const Duration(milliseconds: snakeSpeed), (timer) {
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
              },
              child: const Text(
                'Continuar',
                style: TextStyle(color: Colors.blue),
              ),
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
    foodPosition = _generateRandomPosition();
  }

  void generateCandy() {
    candyPosition = _generateRandomPosition();
    candyActive = true;
    Timer(const Duration(seconds: 8), () {
      candyActive = false;
      generateCandy();
    });
  }

  int _generateRandomPosition() {
    int position;
    do {
      position = Random().nextInt(row * column);
    } while (snakePosition.contains(position) || borderList.contains(position));
    return position;
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
      showGameOverDialog();
    } else {
      snakePosition.removeLast();
    }

    snakeHead = snakePosition.first;
  }

  void checkCandyCollision() {
    if (candyActive && snakeHead == candyPosition) {
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
      Question(
        "¿Qué parte del cuerpo produce insulina?",
        ["a) Riñones", "b) Páncreas", "c) Corazón", "d) Estómago"],
        "b) Páncreas",
      ),
      Question(
        "¿Qué hace la insulina en el cuerpo?",
        ["a) Regula el azúcar en la sangre", "b) Produce energía", "c) Hace crecer el cabello", "d) Da color a la piel"],
        "a) Regula el azúcar en la sangre",
      ),
      Question(
        "¿Cómo se llama la herramienta que se usa para medir el nivel de azúcar en la sangre?",
        ["a) Termómetro", "b) Glucómetro", "c) Regla", "d) Binocular"],
        "b) Glucómetro",
      ),
      Question(
        "¿Cuándo es importante tomar insulina?",
        ["a) Solo en la noche", "b) Cuando los niveles de azúcar son altos", "c) Solo en días de fiesta", "d) Nunca es importante"],
        "b) Cuando los niveles de azúcar son altos",
      ),
      Question(
        "¿Por qué es importante llevar un registro de los niveles de azúcar?",
        ["a) Para jugar", "b) Para mostrar a los amigos", "c) Para compartir en redes sociales", "d) Para ayudar al médico a entender y manejar la diabetes"],
        "d) Para ayudar al médico a entender y manejar la diabetes",
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
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: column),
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
        Text(
          "Puntaje : $score",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blueAccent),
        ),
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
    List<String> fruitImages = [
      "assets/images/fruits/apple.png",
      "assets/images/fruits/avocado.png",
      "assets/images/fruits/banana.png",
      "assets/images/fruits/blackberry.png",
      "assets/images/fruits/cucumber.png",
      "assets/images/fruits/guava.png",
      "assets/images/fruits/lemon.png",
      "assets/images/fruits/mango.png",
      "assets/images/fruits/melon.png",
      "assets/images/fruits/orange.png",
      "assets/images/fruits/papaya.png",
      "assets/images/fruits/peach.png",
      "assets/images/fruits/pear.png",
      "assets/images/fruits/strawberry.png",
      "assets/images/fruits/watermelon.png",
      "assets/images/fruits/yam.png",
    ];

    String currentFruitImage = fruitImages[foodPosition % fruitImages.length];

    return Image.asset(
      currentFruitImage,
      width: double.infinity,
      height: double.infinity,
      fit: BoxFit.cover,
    );
  }

  Widget _buildCandyBox() {
    List<String> candyImages = [
      "assets/images/dessert/cake.png",
      "assets/images/dessert/cookie.png",
      "assets/images/dessert/donut.png",
      "assets/images/dessert/ice-cream.png",
      "assets/images/dessert/muffin.png",
      "assets/images/dessert/popsicle.png",
      "assets/images/kandies/candy.png",
      "assets/images/kandies/chewing-gum.png",
      "assets/images/kandies/lollipop.png",
      "assets/images/kandies/popcorn.png",
    ];

    String currentCandyImage = candyImages[candyPosition % candyImages.length];

    return Image.asset(
      currentCandyImage,
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
                color: Colors.white,
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
                    'assets/images/videogame/quiz.png',
                    height: 100,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    question.questionText,
                    style: TextStyle(fontSize: 18, color: Colors.blue),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Opciones:',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  ...question.options.map((option) => ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context, option == question.correctAnswer);
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                      minimumSize: Size(double.infinity, 50),
                      alignment: Alignment.center,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(color: Colors.white, width: 2),
                      ),
                    ),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Text(
                        option,
                        style: TextStyle(fontSize: 16),
                      ),
                    )
                  ),),
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
      home: QuizScreen(quizQuestions[0] as Question),
    );
  }
}
