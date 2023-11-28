import 'package:diabeteens_v2/Models/RiveAsset.dart';
import 'package:diabeteens_v2/Pages/Views/Tutor/InfoMenuCardTutor.dart';
import 'package:diabeteens_v2/Pages/Views/Tutor/SideMenuTileTutor.dart';
import 'package:diabeteens_v2/Utils/DirectionIp.dart';
import 'package:diabeteens_v2/Utils/RiveUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
// import 'package:rive/rive.dart';

class MenuTutor extends StatefulWidget {
  final String nombreTutor;
  final String idHijos;
  final int cantHijos;
  const MenuTutor({super.key, required this.idHijos, required this.cantHijos, required this.nombreTutor});

  @override
  State<MenuTutor> createState() => _MenuTutorState();
}

class _MenuTutorState extends State<MenuTutor> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  RiveAsset selectedMenu = sideMenusTutor.first;
  DirectionIp ip = DirectionIp();
  late String _nombreTutor;
  late String _idHijos;
  late int _cantHijos;
  // List<String> nombres = ["Miguel Angel Ramirez Mejía", "Litzy Guliane Camacho Ramirez"];

  List<RiveAsset> sideMenuHijos = [];

  void addSideHijos() async {
    try {
      final response = await http.post(
        Uri.parse('http://${ip.ip}/api_diabeteens/getHijos.php'),
        body: {
          "idHijos": _idHijos,
        }
      );
      var respuesta = jsonDecode(response.body);
      print(respuesta);
      for(int i = 0; i < _cantHijos; i++) {
        sideMenuHijos.add(
          RiveAsset(
            "assets/riveAssets/iconosAnimados.riv",
            artboard: "USER",
            stateMachineName: "USER_Interactivity",
            title: respuesta[i]["nombreCompleto"]
          )
        );
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    _nombreTutor = widget.nombreTutor;
    _idHijos = widget.idHijos;
    _cantHijos = widget.cantHijos;
    addSideHijos();
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
              InfoMenuCardTutor(
                nombre: _nombreTutor, 
                tipoUsuario: "Tutor"
              ),
              Padding(
                padding: const EdgeInsets.only(left: 24, top: 32, bottom: 16),
                child: Text(
                  "Navegar".toUpperCase(),
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.white70),
                ),
              ),
              ...sideMenusTutor.map(
                (menu) => SideMenuTileTutor(
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
                  },
                  isActive: selectedMenu == menu,
                )
              ),
              Padding(
                padding: const EdgeInsets.only(left: 24, top: 32, bottom: 16),
                child: Text(
                  "Hijo(s)".toUpperCase(),
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.white70),
                ),
              ),
              ...sideMenuHijos.map(
                (menu) => SideMenuTileTutor(
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
