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
  int value = 1;

  PageController pageController = PageController();

  Widget CustomRadioButton(String text, int index) {
    return Container(
      margin: const EdgeInsets.only(left: 6, top: 4, bottom: 4, right: 6),
      child: OutlinedButton(
        onPressed: () {
          setState(() {
            value = index;
            getComida();
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

  List<Image> listComida = [];
  void getComida() async {
    try {
      listComida = [];
      final response = await http.post(
        Uri.parse('http://${ip.ip}/api_diabeteens/Ingesta/getComida.php'),
        body: {
          "tipoComida": value.toString(),
        }
      );
      var respuesta = jsonDecode(response.body);
      // print(respuesta);
      for (int i = 0; i < respuesta.length; i++) {
        listComida.add(
          Image(
            image: AssetImage(respuesta[i]["src"]),
          )
        );
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getComida();
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
                                  CustomRadioButton("Bebidas", 1),
                                  CustomRadioButton("Carnes", 2),
                                  CustomRadioButton("Dulces", 4),
                                  CustomRadioButton("Frutas", 6),
                                  CustomRadioButton("Postres", 8),
                                  CustomRadioButton("Verduras", 9),
                                  CustomRadioButton("Otros Alimentos", 3)
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
                          current == 3 ?
                          Container(
                            margin: const EdgeInsets.only(left: 6, right: 6),
                            width: double.infinity,
                            height: 70,
                            child: ListView(
                              physics: const BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              children: listComida,
                              
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


