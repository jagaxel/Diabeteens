import 'package:diabeteens_v2/Utils/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:diabeteens_v2/Utils/DirectionIp.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class HomeHijo extends StatefulWidget {
  const HomeHijo({super.key});

  @override
  State<HomeHijo> createState() => _HomeHijoState();
}

class _HomeHijoState extends State<HomeHijo> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  DirectionIp ip = DirectionIp();

  List<String> items = [
    "Inicio",
    "Glucosa",
    "Insulina",
    "Comida",
    "Deportes",
    "Videojuego"
  ];

  /// List of body icon
  List<IconData> icons = [
    Icons.home_outlined,
    Icons.water_drop_outlined, //invert_colors_outlined
    Icons.vaccines_outlined,
    Icons.food_bank_outlined,
    Icons.sports_soccer_outlined,
    Icons.sports_esports_outlined
  ];

  List<String> src = [
    "assets/images/vista-glucosa.png",
    "assets/images/vista-glucosa.png",
    "assets/images/vista-insulina.png",
    "assets/images/vista-comida.png",
    "assets/images/vista-ejercicio.png",
  ];

  int current = 0;
  int value = 0;
  int selectComida = 0;

  PageController pageController = PageController();

  Widget CustomRadioButton(String text, int index) {
    return Container(
      margin: const EdgeInsets.only(left: 6, top: 4, bottom: 4, right: 6),
      child: OutlinedButton(
        onPressed: () {
          setState(() {
            value = index;
            // getComida();
          });
        },
        child: Text(
          text,
          style: TextStyle(
            color: (value == index) ? Colors.white : Colors.black38,
          ),
        ),
        style: ButtonStyle(
          side: MaterialStateProperty.all<BorderSide>(BorderSide(
              width: 1, color: (value == index) ? Colors.black : Colors.white)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          )),
          backgroundColor: (value == index)
              ? MaterialStateProperty.all<Color>(Colors.black)
              : MaterialStateProperty.all<Color>(Colors.white),
        ),
      ),
    );
  }

  List<List<String>> listComidas = [];
  void getComida() async {
    try {
      final response = await http.post(
        Uri.parse('http://${ip.ip}/api_diabeteens/Ingesta/getIngesta.php'),
        body: {
          "tipoGet": "1"
        }
      );
      var respuesta = jsonDecode(response.body);
      // print(respuesta);
      List<String> comidas = [];
      int tipoComida = 0;
      for (int i = 0; i < respuesta.length; i++) {
        if (tipoComida == 0) {
          tipoComida = int.parse(respuesta[i]["idTipoIngesta"]);
        } else if (int.parse(respuesta[i]["idTipoIngesta"]) != tipoComida) {
          listComidas.add(comidas);
          tipoComida = int.parse(respuesta[i]["idTipoIngesta"]);
          comidas = [];
        }
        comidas.add(respuesta[i]["src"]);
        if ((i + 1) >= respuesta.length) {
          listComidas.add(comidas);
        }
      }
    } catch (e) {
      print(e);
    }
  }

  List<String> listMedicamento = [];
  void getMedicamento() async {
    try {
      final response = await http.post(
        Uri.parse('http://${ip.ip}/api_diabeteens/Ingesta/getIngesta.php'),
        body: {
          "tipoGet": "2"
        }
      );
      var respuesta = jsonDecode(response.body);
      for (int i = 0; i < respuesta.length; i++) {
        listMedicamento.add(respuesta[i]["src"]);
      }
    } catch (e) {
      print(e);
    }
  }

  List<String> listDeportes = [];
  void getDeportes() async {
    try {
      final response = await http.post(
        Uri.parse('http://${ip.ip}/api_diabeteens/Ingesta/getIngesta.php'),
        body: {
          "tipoGet": "3"
        }
      );
      var respuesta = jsonDecode(response.body);
      for (int i = 0; i < respuesta.length; i++) {
        listDeportes.add(respuesta[i]["src"]);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> showDialogSelected(tipo) async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text(tipo == 1 ? "Comida seleccionada" : (tipo == 2 ? "Medicamento seleccionado" : (tipo == 3 ? "Deporte seleccionado" : ""))),
          content: Column(
            children: [
              SizedBox(
                height: 15,
              ),
              Image(image: AssetImage(tipo == 1 ? listComidas[value][selectComida] : (tipo == 2 ? listMedicamento[selectComida] : (tipo == 3 ? listDeportes[selectComida] : "")))),
              SizedBox(
                height: 15,
              ),
              Text(tipo == 1 ? "Ingresa la cantidad consumida" : (tipo == 2 ? "Ingresa la cantidad inyectada" : (tipo == 3 ? "Selecciona el tiempo jugado" : ""))),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancelar"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Registrar"),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    getComida();
    getMedicamento();
    getDeportes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF4c709a),
      body: Stack(
        children: [
          // Padding(
          //   padding: padding,
          // ),
          Container(
            width: double.infinity,
            height: double.infinity,
            margin: const EdgeInsets.only(top: 85,bottom: 5, left: 5, right: 5),
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 80,
                  child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: items.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (ctx, index) {
                        return Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  current = index;
                                });
                                pageController.animateToPage(
                                  current,
                                  duration: const Duration(milliseconds: 200),
                                  curve: Curves.ease,
                                );
                              },
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                margin: const EdgeInsets.all(5),
                                width: 100,
                                height: 55,
                                decoration: BoxDecoration(
                                  color: current == index
                                    ? Color.fromARGB(113, 0, 110, 255)
                                    : Color.fromARGB(111, 79, 151, 246),
                                  borderRadius: current == index
                                    ? BorderRadius.circular(12)
                                    : BorderRadius.circular(7),
                                  border: current == index
                                    ? Border.all(
                                        color: Color.fromARGB(113, 0, 110, 255),
                                        width: 2.5)
                                    : null,
                                ),
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        icons[index],
                                        size: current == index ? 23 : 20,
                                        color: current == index
                                          ? Colors.black
                                          : Colors.grey.shade400,
                                      ),
                                      Text(
                                        items[index],
                                        style: GoogleFonts.ubuntu(
                                          fontWeight: FontWeight.w500,
                                          color: current == index
                                            ? Colors.black
                                            : Colors.grey.shade400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Visibility(
                              visible: current == index,
                              child: Container(
                                width: 5,
                                height: 5,
                                decoration: const BoxDecoration(
                                  color: Color.fromARGB(113, 0, 110, 255),
                                  shape: BoxShape.circle),
                              ),
                            )
                          ],
                        );
                      }),
                ),

                /// MAIN BODY
                Container(
                  margin: const EdgeInsets.only(top: 30),
                  width: double.infinity,
                  height: 500,
                  child: PageView.builder(
                    itemCount: icons.length,
                    controller: pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          current == 0 ?
                          (Icon(
                            icons[current],
                            size: 200,
                            color: Colors.white,
                          ))
                          : 
                          current == 5 ?
                          Icon(
                            icons[current],
                            size: 200,
                            color: Colors.white,
                          )
                          :
                          current == 3 ?
                          Expanded(
                            child: Container(
                              child: Center(
                                child: Image(
                                image: AssetImage(src[current]),
                                width: 250,
                              ),
                              ),
                            ),
                          )
                          :
                          Image(
                            image: AssetImage(src[current]),
                            width: 250,
                          )
                          ,
                          current == 3 ?
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.only(left: 6, right: 6),
                              width: double.infinity,
                              height: 10,
                              child: ListView(
                                physics: const BouncingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                children: <Widget>[
                                  CustomRadioButton("Bebidas", 0),
                                  CustomRadioButton("Carnes", 1),
                                  CustomRadioButton("Dulces", 3),
                                  CustomRadioButton("Frutas", 4),
                                  CustomRadioButton("Postres", 5),
                                  CustomRadioButton("Verduras", 6),
                                  CustomRadioButton("Otros Alimentos", 2)
                                ],
                              ),
                            )
                          )
                          :const SizedBox(
                            height: 0,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            "${items[current]}",
                            style: GoogleFonts.ubuntu(
                              fontWeight: FontWeight.w500,
                              fontSize: 30,
                              color: Colors.white),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          current == 2 ?
                          Container(
                            margin: const EdgeInsets.only(left: 6, right: 6),
                            width: double.infinity,
                            height: 70,
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: listMedicamento.length,
                              physics: const BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                    onTap: () {
                                      print("Seleccionó una ingesta");
                                      setState(() {
                                        selectComida = index;
                                      });
                                      showDialogSelected(2);
                                    },
                                    child: Image(image: AssetImage(listMedicamento[index])),
                                  );
                              },
                            ),
                          )
                          :
                          current == 3 ?
                          Container(
                            margin: const EdgeInsets.only(left: 6, right: 6),
                            width: double.infinity,
                            height: 70,
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: listComidas[value].length,
                              physics: const BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                    onTap: () {
                                      print("Seleccionó una ingesta");
                                      setState(() {
                                        selectComida = index;
                                      });
                                      showDialogSelected(1);
                                    },
                                    child: Image(image: AssetImage(listComidas[value][index])),
                                  );
                              },
                            ),
                          )
                          :
                          current == 4 ?
                          Container(
                            margin: const EdgeInsets.only(left: 6, right: 6),
                            width: double.infinity,
                            height: 70,
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: listDeportes.length,
                              physics: const BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                    onTap: () {
                                      print("Seleccionó una ingesta");
                                      setState(() {
                                        selectComida = index;
                                      });
                                      showDialogSelected(3);
                                    },
                                    child: Image(image: AssetImage(listDeportes[index])),
                                  );
                              },
                            ),
                          )
                          :
                          const SizedBox(
                            height: 0,
                          )
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          )
        ]
      ),
    );
  }
}


