import 'package:diabeteens_v2/Pages/Videojuego/start_page.dart';
import 'package:diabeteens_v2/Utils/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:diabeteens_v2/Utils/DirectionIp.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:diabeteens_v2/Utils/AppColors.dart';
import 'package:diabeteens_v2/Utils/FadeAnimationTest.dart';
import 'package:flutter/cupertino.dart';
import 'package:diabeteens_v2/Common/Common.dart';
import 'package:form_field_validator/form_field_validator.dart';

class HomeHijo extends StatefulWidget {
  final int idUsuario;
  const HomeHijo({super.key, required this.idUsuario});

  @override
  State<HomeHijo> createState() => _HomeHijoState();
}

class _HomeHijoState extends State<HomeHijo> {
  DirectionIp ip = DirectionIp();
  late int _idUsuario;
  final _formKey = GlobalKey<FormState>();

  List<String> items = [
    "Inicio",
    "Glucosa",
    "Insulina",
    "Comida",
    "Deportes",
    "Videojuego"
  ];

  List<Color> colors = [
    AppColors.azulLite,
    AppColors.naranja,
    AppColors.amarillo,
    AppColors.naranjaLite,
    AppColors.morado,
    AppColors.azul,
  ];

  List<String> tiposComida = [
    "Bebida",
    "Carne",
    "Comida",
    "Dulce",
    "Fruta",
    "Postre",
    "Verdura",
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
          });
        },
        child: Text(
          text,
          style: TextStyle(
            color: (value == index) ? Colors.white : Colors.black,
          ),
        ),
        style: ButtonStyle(
          side: MaterialStateProperty.all<BorderSide>(BorderSide(
              width: 1, color: (value == index) ? AppColors.naranjaLite : Color.fromARGB(255, 248, 192, 167))),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          )),
          backgroundColor: (value == index)
              ? MaterialStateProperty.all<Color>(AppColors.naranjaLite)
              : MaterialStateProperty.all<Color>(Color.fromARGB(255, 248, 192, 167)),
        ),
      ),
    );
  }

  List<List<String>> listSrcComidas = [];
  List<List<String>> listNameComidas = [];
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
      List<String> nombreComidas = [];
      int tipoComida = 0;
      for (int i = 0; i < respuesta.length; i++) {
        if (tipoComida == 0) {
          tipoComida = int.parse(respuesta[i]["idTipoIngesta"]);
        } else if (int.parse(respuesta[i]["idTipoIngesta"]) != tipoComida) {
          listSrcComidas.add(comidas);
          listNameComidas.add(nombreComidas);
          tipoComida = int.parse(respuesta[i]["idTipoIngesta"]);
          comidas = [];
          nombreComidas = [];
        }
        comidas.add(respuesta[i]["src"]);
        nombreComidas.add(respuesta[i]["nombre"]);
        if ((i + 1) >= respuesta.length) {
          listSrcComidas.add(comidas);
          listNameComidas.add(nombreComidas);
        }
      }
    } catch (e) {
      print(e);
    }
  }

  List<String> listSrcMedicamento = [];
  List<String> listNameMedicamento = [];
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
        listSrcMedicamento.add(respuesta[i]["src"]);
        listNameMedicamento.add(respuesta[i]["nombre"]);
      }
    } catch (e) {
      print(e);
    }
  }

  List<String> listSrcDeportes = [];
  List<String> listNameDeportes = [];
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
        listSrcDeportes.add(respuesta[i]["src"]);
        listNameDeportes.add(respuesta[i]["nombre"]);
      }
    } catch (e) {
      print(e);
    }
  }

  void showDialogSelected(tipo) async {
    await showDialog (
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        int cantidad = 1;
        double cantSliderGlucosa = 20;
        double cantSliderInsu = 1;
        final cantidadLibre = TextEditingController();
        bool inInput = false;

        void addIngesta() async {
          try {
            String tipoIngesta = (tipo == 0 ? 76 : (value + 1)).toString();
            if (tipo != 1) {
              cantidad = tipo == 0 ? cantSliderGlucosa.toInt() : cantSliderInsu.toInt();
            }
            final response = await http.post(
              Uri.parse('http://${ip.ip}/api_diabeteens/Ingesta/addIngesta.php'),
              body: {
                "idUsuario": _idUsuario.toString(),
                "tipoIngesta": tipoIngesta,
                "cantidad": cantidad.toString(),
              }
            );
            var respuesta = jsonDecode(response.body);
            // print(respuesta);
            if (respuesta["accion"]) {
              Fluttertoast.showToast(
                msg: tipo == 0 ? "Glucosa guardada con éxito :)" : tipo == 1 ? "${tiposComida[value]} guardada con éxito :)" : (tipo == 2 ? "Medicamento guarado con éxito :)" : (tipo == 3 ? "Deporte guardado con éxito :)" : "")),
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.TOP,
                timeInSecForIosWeb: 2,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16.0
              );
              Navigator.pop(context);
            } else {
              Fluttertoast.showToast(
                msg: "Intente de nuevo más tarde",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.TOP,
                timeInSecForIosWeb: 2,
                backgroundColor: Color.fromARGB(44, 255, 0, 0),
                textColor: Colors.white,
                fontSize: 16.0
              );
            }
            
          } catch (e) {
            print(e);
          }
        }
        
        void showConfirmRegistro() async {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("Confirmación"),
                content: const Text(
                  "¿Realizar registro?",
                  style: TextStyle(
                    fontSize: 17,
                    // fontWeight: FontWeight.bold
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Cancelar"),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      addIngesta();
                    },
                    child: const Text("Confirmar"),
                  ),
                ],
                // backgroundColor: Colors.amber,
              );
            },
          );
        }

        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: Text(
                tipo == 0 ? "Registro de glucosa" : tipo == 1 ? "${tiposComida[value]} seleccionada" : (tipo == 2 ? "Medicamento seleccionado" : (tipo == 3 ? "Deporte seleccionado" : "")),
                style: TextStyle(
                  color: AppColors.blanco
                ),
              ),
              content: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 15,
                    ),
                    inInput ?
                    // ignore: dead_code
                    Image(
                      height: 150,
                      image: AssetImage(tipo == 0 ? 'assets/images/glucose/medidor-de-glucosa.png' : tipo == 1 ? listSrcComidas[value][selectComida] : (tipo == 2 ? listSrcMedicamento[selectComida] : (tipo == 3 ? listSrcDeportes[selectComida] : "")))
                    )
                    :
                    Image(
                      image: AssetImage(tipo == 0 ? 'assets/images/glucose/medidor-de-glucosa.png' : tipo == 1 ? listSrcComidas[value][selectComida] : (tipo == 2 ? listSrcMedicamento[selectComida] : (tipo == 3 ? listSrcDeportes[selectComida] : "")))
                    )
                    ,SizedBox(
                      height: 10,
                    ),
                    Text(
                      tipo == 1 ? listNameComidas[value][selectComida] : (tipo == 2 ? listNameMedicamento[selectComida] : (tipo == 3 ? listNameDeportes[selectComida] : "")),
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      tipo == 0 ? "Ingresa la cantidad medida" : tipo == 1 ? "Ingresa la cantidad consumida" : (tipo == 2 ? "Ingresa la cantidad suministrada" : (tipo == 3 ? "Ingresa el tiempo jugado" : "")),
                      style: TextStyle(
                        color: AppColors.blanco
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    tipo == 1 ?
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        OutlinedButton(
                          onPressed: () {
                            // decrementCounter();
                            if (cantidad > 1) {
                              setState(() {
                                cantidad -= 1;
                              });
                            }
                          }, 
                          child: Center(
                            child: Icon(
                              Icons.remove,
                              size: 15,
                            )
                          ),
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(
                              color: Colors.grey,
                              width: 2,
                            ), //permite cambiar el color del border
                            primary: Colors.black, //Cambia el color del texto del boton
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(40))
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text('${cantidad}', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                        SizedBox(
                          width: 10,
                        ),
                        OutlinedButton(
                          onPressed: () {
                            // incrementCounter();
                            setState(() {
                              cantidad += 1;
                            });
                          }, 
                          child: Center(
                            child: Icon(
                              Icons.add,
                              size: 15,
                            )
                          ),
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(
                              color: Colors.grey,
                              width: 2,
                            ), //permite cambiar el color del border
                            primary: Colors.black, //Cambia el color del texto del boton
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(40))
                            ),
                          ),
                        ),
                      ]
                    )
                    :
                    (
                      tipo == 0 ?
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Cantidad: ${cantSliderGlucosa.toInt()}",
                            style: TextStyle(
                              color: AppColors.blanco
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: Slider(
                              value: cantSliderGlucosa,
                              min: 20,
                              max: 200,
                              divisions: 200,
                              label: cantSliderGlucosa.round().toString(),
                              activeColor: cantSliderGlucosa < 70 ? AppColors.contentColorBlue : (cantSliderGlucosa < 180 ? const Color.fromARGB(255, 74, 202, 78) : AppColors.rojo), 
                              onChanged: (double value) {
                                setState(() {
                                  cantSliderGlucosa = value;
                                });
                              }
                            )
                            /*
                            Form (
                              key: _formKey,
                              child: TextFormField(
                                validator: MultiValidator([
                                    RequiredValidator(errorText: "La cantidad es requerida."),
                                    PatternValidator(r'[0-9]', errorText: 'La cantidad ingresada es incorrecta.')
                                  ]
                                ),
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                obscureText: false,
                                keyboardType: TextInputType.number,
                                controller: cantidadLibre,
                                style: TextStyle (
                                  color: AppColors.blanco
                                ),
                                decoration: InputDecoration (
                                  border: OutlineInputBorder (
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: BorderSide(
                                      color: AppColors.blanco
                                    )
                                  ),
                                  labelText: 'Cantidad',
                                  labelStyle: TextStyle (
                                    color: AppColors.blanco
                                  )
                                ),
                                onTap: () {
                                  setState(() {
                                    inInput = true;
                                  });
                                },
                                onTapOutside: (event) {
                                  setState(() {
                                    inInput = false;
                                  });
                                },
                              ),
                            )
                            */
                            ,
                          )
                        
                        ],
                      )
                      :
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Cantidad: ${cantSliderInsu.toInt()}",
                            style: TextStyle(
                              color: AppColors.blanco
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: Slider(
                              value: cantSliderInsu,
                              min: 1,
                              max: 200,
                              divisions: 200,
                              label: cantSliderInsu.round().toString(),
                              activeColor: AppColors.azul, 
                              onChanged: (double value) {
                                setState(() {
                                  cantSliderInsu = value;
                                });
                              }
                            )
                            ,
                          )
                        
                        ],
                      )
                    )
                    ,
                  ],
                ),
                
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Cancelar",
                    style: TextStyle(
                      color: AppColors.blanco
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    if (current != 3) {
                      if (cantSliderGlucosa > 0 || cantSliderInsu > 0) {
                        showConfirmRegistro();
                      }
                    } else {
                      showConfirmRegistro();
                    }
                  },
                  child: const Text(
                    "Registrar",
                    style: TextStyle(
                      color: AppColors.blanco
                    ),
                  ),
                ),
              ],
              backgroundColor: colors[tipo + 1],
            );
          }
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
    _idUsuario = widget.idUsuario;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.fondoColorAzul,
      body: Stack(
        children: [
          // Padding(
          //   padding: padding,
          // ),
          FadeInAnimation (
            delay: 1,
            child: AppBar (
              backgroundColor: AppColors.fondoColorAzul,
              automaticallyImplyLeading: false,
              title: Center(
                child: Text("DIABETEENS"),
              ),
              titleSpacing: 5, 
              actions: [
                IconButton(
                  onPressed: () {
                  }, 
                  icon: Image(
                    image: AssetImage("assets/images/logo-diabeteens.png"),
                  )
                )
              ],
            ),
          ),
          Container(
            width: double.infinity,
            height: double.infinity,
            margin: const EdgeInsets.only(top: 85,bottom: 5, left: 5, right: 5),
            child: Column(
              children: [
                FadeInAnimation (
                  delay: 1.3,
                  child: SizedBox (
                    width: double.infinity,
                    height: 80,
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: items.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (ctx, index) {
                        return Column (
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
                                    // ? Color.fromARGB(113, 0, 110, 255)
                                    ? Color.fromARGB(111, 104, 166, 247)
                                    : Color.fromARGB(108, 193, 216, 246),
                                    // : Color.fromARGB(111, 79, 151, 246),
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
                                        color: colors[index],
                                        // color: current == index
                                        //   ? Colors.black
                                        //   : colors[index],
                                      ),
                                      Text(
                                        items[index],
                                        style: GoogleFonts.ubuntu(
                                          fontWeight: FontWeight.w500,
                                          color: colors[index],
                                          // color: current == index
                                          //   ? Colors.black
                                          //   : colors[index],
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
                      }
                    ),
                  ),
                ),
                /// MAIN BODY
                Container (
                  margin: const EdgeInsets.only(top: 30),
                  width: double.infinity,
                  height: 500,
                  child: PageView.builder(
                    itemCount: icons.length,
                    controller: pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Column (
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FadeInAnimation (
                            delay: 1.6,
                            child: current == 0 ?
                              (Icon(
                                icons[current],
                                size: 200,
                                color: colors[current],
                              ))
                              :
                              current == 5 ?
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context, 
                                    MaterialPageRoute(
                                      builder: (context) => StartSnakePage()
                                    )
                                  );
                                },
                                child: Icon(
                                  icons[current],
                                  size: 200,
                                  color: colors[current],
                                ),
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
                          )
                          ,
                          current == 3 ?
                          // FadeInAnimation (
                          //   delay: 1.9,
                          //   child: 
                            Expanded(
                              child: FadeInAnimation (
                                delay: 1.9,
                                child: Container(
                                  margin: const EdgeInsets.only(left: 6, right: 6),
                                  width: double.infinity,
                                  height: 10,
                                  child: ListView(
                                    physics: const BouncingScrollPhysics(),
                                    scrollDirection: Axis.horizontal,
                                    children: <Widget> [
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
                            )
                          // )
                          :const SizedBox(
                            height: 0,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          FadeInAnimation (
                            delay: 2.2,
                            child: current == 1 || current == 2 ?
                              ElevatedButton (
                                onPressed: () async {
                                  setState(() {
                                    selectComida = 0;
                                  });
                                  switch (current) {
                                    case 1: showDialogSelected(0);
                                      break;
                                    case 2: showDialogSelected(2);
                                      break;
                                  }
                                },
                                style: ButtonStyle (
                                  side: const MaterialStatePropertyAll(BorderSide(color: AppColors.blanco)),
                                  shape: MaterialStatePropertyAll(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)
                                    )
                                  ),
                                  fixedSize: const MaterialStatePropertyAll(Size.fromWidth(270)),
                                  padding: const MaterialStatePropertyAll(
                                    EdgeInsets.symmetric(vertical: 5),
                                  ),
                                  backgroundColor: MaterialStatePropertyAll(colors[current]),
                                ),
                                child: FittedBox(
                                  child: Text(
                                    "Registrar ${items[current]}",
                                    style: Common().semiboldwhite,
                                  )
                                ),
                              )
                              :
                              Text(
                                // current == 0 || current == 5 ? "${items[current]}" : "Registrar ${items[current]}",
                                current == 3 ? "${tiposComida[value]}s" : "${items[current]}",
                                style: GoogleFonts.ubuntu(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 30,
                                  color: colors[current],
                                ),
                              )
                              ,
                          )
                          ,
                          const SizedBox(
                            height: 15,
                          ),
                          FadeInAnimation (
                            delay: 2.5,
                            child: Container (
                              margin: const EdgeInsets.only(left: 6, right: 6),
                              width: double.infinity,
                              height: 70,
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: (current == 1 ? 1 : (current == 2 ? listSrcMedicamento.length : (current == 3 ? listNameComidas[value].length : (current == 4 ? listSrcDeportes.length : 0))  )  ),
                                physics: const BouncingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return current == 3 || current == 4 ?
                                  Tooltip(
                                    message: 
                                      // current == 1 ? 'Glucosa'
                                      // :
                                      // current == 2 ? listNameMedicamento[index]
                                      // :
                                      current == 3 ? listNameComidas[value][index]
                                      :
                                      current == 4 ? listNameDeportes[index]
                                      :
                                      '',
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          selectComida = index;
                                        });
                                        switch (current) {
                                          // case 1: showDialogSelected(0);
                                          //   break;
                                          // case 2: showDialogSelected(2);
                                          //   break;
                                          case 3: showDialogSelected(1);
                                            break;
                                          case 4: showDialogSelected(3);
                                            break;
                                        }
                                      },
                                      child: Image(
                                        image: AssetImage(
                                          // current == 1 ? 'assets/images/glucose/medidor-de-glucosa.png'
                                          // :
                                          // current == 2 ? listSrcMedicamento[index]
                                          // :
                                          current == 3 ? listSrcComidas[value][index]
                                          :
                                          current == 4 ? listSrcDeportes[index]
                                          :
                                          ''
                                        )
                                      ),
                                    ),
                                  )
                                  :
                                  const Text("")
                                  ;
                                },
                              ),
                            )
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


