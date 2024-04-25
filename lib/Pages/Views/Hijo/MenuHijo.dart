import 'package:diabeteens_v2/Models/RiveAsset.dart';
import 'package:diabeteens_v2/Pages/LoginPage.dart';
import 'package:diabeteens_v2/Pages/Videojuego/start_page.dart';
import 'package:diabeteens_v2/Pages/Views/Hijo/HistoryHijo.dart';
import 'package:diabeteens_v2/Pages/Views/Hijo/InfoMenuCardHijo.dart';
import 'package:diabeteens_v2/Pages/Views/Hijo/SideMenuTileHijo.dart';
import 'package:diabeteens_v2/Utils/DirectionIp.dart';
import 'package:diabeteens_v2/Utils/RiveUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
// import 'package:rive/rive.dart';

class MenuHijo extends StatefulWidget {
  final String nombreHijo;
  final int idHijo;
  const MenuHijo({super.key, required this.nombreHijo, required this.idHijo});

  @override
  State<MenuHijo> createState() => _MenuHijoState();
}

class _MenuHijoState extends State<MenuHijo> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  RiveAsset selectedMenu = sideMenusHijo.first;
  DirectionIp ip = DirectionIp();
  late String _nombreHijo;
  late int _idHijo;

  @override
  void initState() {
    _nombreHijo = widget.nombreHijo;
    _idHijo = widget.idHijo;
    // addSideHijos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 288,
        height: double.infinity,
        color: Color(0xFF17203A),
        child: SafeArea(
          child:  Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InfoMenuCardHijo(
                nombre: _nombreHijo, 
                tipoUsuario: "Hijo"
              ),
              Padding(
                padding: const EdgeInsets.only(left: 24, top: 32, bottom: 16),
                child: Text(
                  "Navegar".toUpperCase(),
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.white70),
                ),
              ),
              ...sideMenusHijo.map(
                (menu) => SideMenuTileHijo(
                  menu: menu,
                  riveOnInit: (artboard) {
                    StateMachineController controller = RiveUtils.getRiveController(artboard, stateMachineName: menu.stateMachineName);
                    menu.input = controller.findSMI("active") as SMIBool;
                  },
                  press: () {
                    menu.input?.change(true);
                    Future.delayed(const Duration(seconds: 1), () {
                      menu.input!.change(false);
                    });
                    setState(() {
                      selectedMenu = menu;
                    });

                    if (menu.title == "Juego") {
                      Navigator.push(
                        context, 
                        MaterialPageRoute(
                          builder: (context) => StartSnakePage()
                        )
                      );
                    }

                    if (menu.title == "Historial de registros") {
                      Navigator.push(
                        context, 
                        MaterialPageRoute(
                          builder: (context) => HistoryHijo(idHijo: _idHijo.toString())
                        )
                      );
                    }

                    if (menu.title == "Salir") {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginPage()
                        ) 
                      );
                    }
                  },
                  isActive: selectedMenu == menu,
                )
              ),
            ],
          ),
        )
      ),
    );
  }
}
