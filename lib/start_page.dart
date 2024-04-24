import 'dart:async';
import 'package:flutter/material.dart';
import 'package:snake_game/game_page.dart';
import 'package:snake_game/info_page.dart';

class StartPage extends StatefulWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController);

    _animationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(112, 186, 166, 1),
      body: Stack(
        children: [
          AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return CustomPaint(
                painter: SnakePainter(_animation.value),
                size: Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height),
              );
            },
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/videogame/img_start.png',
                  width: 400,
                  height: 600,
                ),
                const SizedBox(height: 20),
                SnakeAnimatedButton(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => InfoPage()),
                    );
                  },
                  text: 'Iniciar juego',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SnakeAnimatedButton extends StatefulWidget {
  final VoidCallback onTap;
  final String text;

  const SnakeAnimatedButton({required this.onTap, required this.text, Key? key}) : super(key: key);

  @override
  _SnakeAnimatedButtonState createState() => _SnakeAnimatedButtonState();
}

class _SnakeAnimatedButtonState extends State<SnakeAnimatedButton> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
      reverseDuration: const Duration(milliseconds: 500),
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
        reverseCurve: Curves.easeInOut,
      ),
    );

    _animationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          decoration: BoxDecoration(
            color: Color.fromRGBO(235, 247, 255, 1),
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Text(
            widget.text,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color.fromRGBO(112, 186, 166, 1)),
          ),
        ),
      ),
    );
  }
}

class SnakePainter extends CustomPainter {
  final double animationValue;

  SnakePainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Color.fromRGBO(173, 216, 209, 1)
      ..strokeWidth = 5.0
      ..strokeCap = StrokeCap.round;

    final double width = size.width;
    final double height = size.height;
    final double offset = 20.0 * animationValue;

    final double startX = 0 + offset;
    final double startY = 0 + offset;
    final double endX = width - offset;
    final double endY = height - offset;

    canvas.drawLine(Offset(startX, startY), Offset(endX, startY), paint); // Top line
    canvas.drawLine(Offset(endX, startY), Offset(endX, endY), paint); // Right line
    canvas.drawLine(Offset(endX, endY), Offset(startX, endY), paint); // Bottom line
    canvas.drawLine(Offset(startX, endY), Offset(startX, startY), paint); // Left line
  }

  @override
  bool shouldRepaint(SnakePainter oldDelegate) => true;
}
