import 'dart:ffi';
import 'dart:math';
import 'package:diabeteens_v2/Models/MenuBtn.dart';
import 'package:diabeteens_v2/Pages/Views/Hijo/HomeHijo.dart';
import 'package:diabeteens_v2/Pages/Views/Hijo/MenuHijo.dart';
import 'package:diabeteens_v2/Utils/RiveUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
// import 'package:rive/rive.dart';

class EntryPointHijo extends StatefulWidget {
  final int idHijo;
  final String usuario;
  final String nombreCompleto;
  const EntryPointHijo({super.key, required this.idHijo, required this.usuario, required this.nombreCompleto});

  @override
  State<EntryPointHijo> createState() => _EntryPointHijoState();
}

class _EntryPointHijoState extends State<EntryPointHijo> with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late AnimationController _animationController;
  late Animation<double> animation;
  late Animation<double> scaleAnimation;

  late SMIBool isSideBarClosed;
  
  bool isSideMenuClosed = true;

  late int _idHijo;
  late String _usuario;
  late String _nombreCompleto;

  @override
  void initState() {
    _idHijo = widget.idHijo;
    _usuario = widget.usuario;
    _nombreCompleto = widget.nombreCompleto;

    _animationController = AnimationController(
      vsync: this, 
      duration: const Duration(milliseconds: 200)
    )..addListener(() {
      setState(() {
        
      });
    });

    animation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _animationController, curve: Curves.fastOutSlowIn));
    scaleAnimation = Tween<double>(begin: 1, end: 0.8).animate(CurvedAnimation(parent: _animationController, curve: Curves.fastOutSlowIn));
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF17203A),
      resizeToAvoidBottomInset: false,
      extendBody: true,
      body: Stack(
        children: [
          AnimatedPositioned(
            duration: const Duration(milliseconds: 200),
            curve: Curves.fastOutSlowIn,
            width: 288,
            left: isSideMenuClosed ? -288 : 0,
            height: MediaQuery.of(context).size.height,
            child:  MenuHijo(nombreHijo: _nombreCompleto, idHijo: _idHijo)
          ),
          SizedBox(
            height: 80,
          ),
          Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()..setEntry(3, 2, 0.001)..rotateY(animation.value - 30 * animation.value * pi / 180),
            child: Transform.translate(
              offset: Offset(animation.value * 265, 0),
              child: Transform.scale(
                scale: scaleAnimation.value,
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(24)),
                  child: HomeHijo(idUsuario: _idHijo)
                )
              ),
          
            ),
          ),
          AnimatedPositioned(
            duration: Duration(milliseconds: 200),
            curve: Curves.fastOutSlowIn,
            left: isSideMenuClosed ? 0 : 220,
            top: 16,
            child: MenuBtn(
              riveOnInit: (Artboard artboard) {
                StateMachineController controller = RiveUtils.getRiveController(artboard, stateMachineName: "SM1");
                isSideBarClosed = controller.findSMI("open") as SMIBool;
                isSideBarClosed.value = false;
              }, 
              press: () {
                isSideBarClosed.value = !isSideBarClosed.value;
                if (isSideMenuClosed) {
                  _animationController.forward();
                } else {
                  _animationController.reverse();
                }
                setState(() {
                  isSideMenuClosed = !isSideBarClosed.value;
                });
              },
            ),
          )
        ],
      ),
    );
  }
}


