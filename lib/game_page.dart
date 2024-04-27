import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:snake_game/quiz.dart';
import 'package:snake_game/start_page.dart';

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
  int snakeSpeed = 250;
  
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
        return WillPopScope(
          onWillPop: () async {
            //showReplayDialog();
            return false;
          },
          child: AlertDialog(
            backgroundColor: Color.fromRGBO(173, 216, 209, 1),
            title: const Text(
              "¡Ayuda a Snake a comer sanamente!",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            content: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/videogame/serpiente.png',
                  height: 100,
                ),
                const SizedBox(height: 20),
                const Text(
                  "Su comida favorita son las frutas y verduras que lo ayudan a crecer.",
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Image.asset(
                  'assets/images/videogame/manzana.png',
                  height: 80,
                ),
                const SizedBox(height: 20),
                const Text(
                  "Evita los dulces, son dañinos para la salud.",
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Image.asset(
                  'assets/images/videogame/caramelo.png',
                  height: 80,
                ),
                const SizedBox(height: 20),
                const Text(
                  "Consigue la máxima cantidad de puntos que puedas. ¿Qué tan grande podrás hacer crecer a Snake?",
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Text(
                  "Elige la dificultad",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  snakeSpeed += 150;
                  startGame();
                },
                child: const Text(
                  "Fácil",
                  style: TextStyle(
                    color: Colors.yellow,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  startGame();
                },
                child: const Text(
                  "Intermedio",
                  style: TextStyle(
                    color: Colors.orange,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  snakeSpeed -= 150;
                  Navigator.pop(context);
                  startGame();
                },
                child: const Text(
                  "Difícil",
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
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
    Timer.periodic(Duration(milliseconds: snakeSpeed), (timer) {
      if (gameActive) {
        updateSnake();
        if (checkCollision()) {
          timer.cancel();
          showGameOverDialog();
        }
        if (checkCandyCollision()) {
          timer.cancel();
          showGameOverDialog();
        }
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

    // ignore: unnecessary_null_comparison
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
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => StartPage()),
    );
  }

  Future<void> showAnswerDialog(Question question) async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: AlertDialog(
            backgroundColor: Color.fromRGBO(235, 247, 255, 1),
            title: const Text(
              "Respuesta Incorrecta",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            content: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Puntos acumulados:  $score",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 30),
                Image.asset(
                  'assets/images/videogame/wrong.png',
                  height: 200,
                  width: 200,
                ),
                const SizedBox(height: 20),
                const Text(
                  "No te preocupes, aprendamos un poco más jugando...",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 40),
                const Text(
                  "La respuesta correcta es:",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 30),
                Text(
                  question.correctAnswer,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(112, 186, 166, 1),
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  showReplayDialog();
                },
                child: const Text(
                  "Salir",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  startGame();
                },
                child: const Text(
                  "Volver a Jugar",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> showSuccessScreen(int score) async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: AlertDialog(
            backgroundColor: Color.fromRGBO(235, 247, 255, 1),
            title: const Text(
              "Respuesta Correcta",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            content: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/videogame/success.png',
                  height: 200,
                ),
                const SizedBox(height: 20),
                Text(
                  '¡Bien hecho, ahora tienes otra oportunidad!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Aún conservas tus puntos',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Puntuación actual: $score',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(112, 186, 166, 1),
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  setState(() {
                    snakePosition = [45, 44, 43];
                    snakeHead = snakePosition.first;
                    direction = Direction.right;
                  });
                  gameActive = true;
                  Timer.periodic(Duration(milliseconds: snakeSpeed), (timer) {
                    if (gameActive) {
                      updateSnake();
                      if (checkCollision()) {
                        timer.cancel();
                        showGameOverDialog();
                      }
                      if (checkCandyCollision()) {
                        timer.cancel();
                        showGameOverDialog();
                      }
                      //checkCandyCollision();
                      if (!candyActive) {
                        generateCandy();
                      }
                    }
                  });
                },
                child: const Text(
                  'Continuar',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showDifficultyDialog() {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
        backgroundColor: Color.fromRGBO(235, 247, 255, 1),
        title: const Text("Elige la dificultad",
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.bold,),),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  snakeSpeed = 400;
                  gameActive = true;
                });
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(backgroundColor: Color.fromRGBO(112, 186, 166, 1),),
              child: const Text("Fácil",
              style: TextStyle(color: Colors.yellow),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  snakeSpeed = 250;
                  gameActive = true;
                });
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(backgroundColor: Color.fromRGBO(112, 186, 166, 1),),
              child: const Text("Intermedio",
              style: TextStyle(color: Colors.orange),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  snakeSpeed = 100;
                  gameActive = true;
                });
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(backgroundColor: Color.fromRGBO(112, 186, 166, 1),),
              child: const Text("Difícil",
              style: TextStyle(color: Colors.red),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "La dificlutad se aplicará al iniciar una nueva partida",
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    },
  );
}

  Future<void> showReplayDialog() async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: AlertDialog(
            backgroundColor: Color.fromRGBO(235, 247, 255, 1),
            title: const Text("¿Desea salir del juego?"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  startGame();
                },
                child: const Text("No",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  score = 0;
                  exitGame();
                },
                child: const Text("Sí",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ],
          ),
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

  bool checkCandyCollision() {
    if (candyActive && snakeHead == candyPosition) {
      return true;
    }
    return false;
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
      Question(
      "¿Cuál es un síntoma común de hipoglucemia en personas con diabetes?",
      ["a) Sed excesiva", "b) Niveles altos de azúcar en la sangre", "c) Mareos y sudoración", "d) Aumento de energía"],
      "c) Mareos y sudoración",
      ),
      Question(
        "¿Cuál es la importancia de llevar una identificación que indique la condición de diabetes?",
        ["a) Solo por precaución", "b) Para mostrar a los amigos", "c) En caso de emergencia médica", "d) No es importante"],
        "c) En caso de emergencia médica",
      ),
      Question(
        "¿Cuáles son algunos factores que pueden afectar los niveles de azúcar en la sangre?",
        ["a) La fase lunar", "b) El estrés y la enfermedad", "c) El color de la ropa", "d) Solo la dieta"],
        "b) El estrés y la enfermedad",
      ),
      Question(
        "¿Cuál es una recomendación para prevenir complicaciones a largo plazo de la diabetes?",
        ["a) No visitar al médico regularmente", "b) Ignorar los niveles de azúcar", "c) Mantener un control constante de los niveles de azúcar", "d) Consumir grandes cantidades de azúcar"],
        "c) Mantener un control constante de los niveles de azúcar",
      ),
      Question(
        "¿Qué tipo de ejercicio se recomienda para mejorar la sensibilidad a la insulina?",
        ["a) Ejercicio intenso y esporádico", "b) Ejercicio aeróbico regular", "c) Solo levantamiento de pesas", "d) Ningún tipo de ejercicio"],
        "b) Ejercicio aeróbico regular",
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: Color.fromRGBO(112, 186, 166, 1),
        body: Column(
          children: [
            Expanded(child: _buildGameView()),
            _buildGameControls(),
          ],
        ),
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

  void _showPauseDialog() {
  gameActive = false;
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
        title: const Text("El juego está en pausa...",
        textAlign: TextAlign.center,),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              gameActive = true;
            },
            child: const Text("Reanudar",
            style: TextStyle(color: Colors.grey),),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _showDifficultyDialog();
            },
            child: const Text("Dificultad",
            style: TextStyle(color: Colors.grey),),
          ),
          TextButton(
            onPressed: () {
              exitGame();
            },
            child: const Text("Salir",
            style: TextStyle(color: Colors.grey),),
          ),
        ],
      );
    },
  );
}

  Widget _buildGameControls() {
    return Container(
    padding: const EdgeInsets.all(30),
    width: double.infinity,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () {
            _showPauseDialog();
          },
          color: Color.fromRGBO(235, 247, 255, 1),
          icon: const Icon(Icons.pause_circle_filled),
          iconSize: 30,
        ),
        Text(
          "Puntaje : $score",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color.fromRGBO(173, 216, 209, 1)),
        ),
        //const SizedBox(height: 20),
        IconButton(
          onPressed: () {
            if (direction != Direction.down) direction = Direction.up;
          },
          color: Color.fromRGBO(235, 247, 255, 1),
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
                color: Color.fromRGBO(235, 247, 255, 1),
                icon: const Icon(Icons.arrow_circle_left_outlined),
                iconSize: 80,
              ),
              const SizedBox(width: 80),
              IconButton(
                onPressed: () {
                  if (direction != Direction.left) direction = Direction.right;
                },
                color: Color.fromRGBO(235, 247, 255, 1),
                icon: const Icon(Icons.arrow_circle_right_outlined),
                iconSize: 80,
              ),
            ],
          ),
          IconButton(
            onPressed: () {
              if (direction != Direction.up) direction = Direction.down;
            },
            color: Color.fromRGBO(235, 247, 255, 1),
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
        borderRadius: BorderRadius.zero,
        color: Color.fromRGBO(235, 247, 255, 1),
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
      "assets/images/Kandies/candy.png",
      "assets/images/Kandies/chewing-gum.png",
      "assets/images/Kandies/lollipop.png",
      "assets/images/Kandies/popcorn.png",
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
        color: Color.fromRGBO(173, 216, 209, 1).withOpacity(0.05),
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
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: Color.fromRGBO(173, 216, 209, 1),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                '¡Contesta correctamente y obtén otra oportunidad!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(235, 247, 255, 1),
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
                      textAlign: TextAlign.center, 
                      style: TextStyle(fontSize: 18, color: Colors.black),
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
                        backgroundColor: Color.fromRGBO(112, 186, 166, 1),
                        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                        minimumSize: Size(double.infinity, 50),
                        alignment: Alignment.center,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(color: Color.fromRGBO(235, 247, 255, 1), width: 2),
                        ),
                      ),
                      child: Text(
                        option,
                        style: TextStyle(fontSize: 16, color: Color.fromRGBO(235, 247, 255, 1)), 
                      ),
                    ),),
                  ],
                ),
              ),
            ],
          ),
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