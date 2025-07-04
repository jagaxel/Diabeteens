import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class MenuBtn extends StatelessWidget {
  const MenuBtn({
    super.key, required this.press, required this.riveOnInit,
  });

  final VoidCallback press;
  final ValueChanged<Artboard> riveOnInit;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: press,
        child: Container(
          margin: const EdgeInsets.only(left: 16),
          height: 40,
          width: 40,
          decoration: const BoxDecoration(
            color: Color.fromARGB(0, 74, 74, 116),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                offset: Offset(0, 3),
                blurRadius: 8
              )
            ],
          ),
          child: RiveAnimation.asset(
            "assets/riveAssets/menuIcon.riv",
            onInit: riveOnInit,
          ),
        ),
      ),
    );
  }
}