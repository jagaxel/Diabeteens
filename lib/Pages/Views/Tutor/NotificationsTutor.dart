import 'package:diabeteens_v2/Pages/Views/Tutor/EntryPointTutor.dart';
import 'package:diabeteens_v2/Pages/Views/Tutor/HomeTutor.dart';
import 'package:diabeteens_v2/Utils/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:diabeteens_v2/Utils/DirectionIp.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

class NotificationsTutor extends StatefulWidget {
  final int idUsuario;
  final int idTutor;
  final int idPersona;
  final String usuario;
  final String nombreCompleto;
  final String idHijos;
  final int cantHijos;
  const NotificationsTutor({super.key, required this.idUsuario, required this.idTutor, required this.idPersona, required this.usuario, required this.nombreCompleto, required this.idHijos, required this.cantHijos});

  @override
  State<NotificationsTutor> createState() => _NotificationsTutorState();
}

class _NotificationsTutorState extends State<NotificationsTutor> {
  DirectionIp ip = DirectionIp();
  HomeTutorState home = HomeTutorState();
  late int _idUsuario;
  late int _idTutor;
  late int _idPersona;
  late String _usuario;
  late String _nombreCompleto;
  late String _idHijos;
  late int _cantHijos;
  List<Map<String, dynamic>> notifications = [];

  Future<void> getNotifications() async {
    try {
      notifications = [];
      final response = await http.post(
        Uri.parse('http://${ip.ip}/api_diabeteens/Notifications/getNotifications.php'),
        body: {
          "idHijo": _idHijos.toString()
        }
      );
      var respuesta = jsonDecode(response.body);
      for (int i = 0; i < respuesta.length; i++) {
        setState(() {
          notifications.add(respuesta[i]);
        });
      }
    } catch (e) {
      print(e);
    }
  }

  void showDialogSelected(notification) async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        int cantidad = int.parse(notification["cantidad"]);
        final cantidadLibre = TextEditingController();
        bool inInput = false;
        bool validar = false;

        void addIngesta() async {
          try {
            final response = await http.post(
              Uri.parse('http://${ip.ip}/api_diabeteens/Ingesta/confirmIngesta.php'),
              body: {
                "idSeguimiento": notification["id"].toString(),
                "cantidad": cantidad.toString(),
              }
            );
            var respuesta = jsonDecode(response.body);
            // print(respuesta);
            if (respuesta["accion"]) {
              if (int.parse(notification["tipoI"]) == 10) {
                home.getDataGrafica();
                home.getPorcentajePastel();
              }
              Fluttertoast.showToast(
                msg: "Registro validado",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.TOP,
                timeInSecForIosWeb: 2,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16.0
              );
              getNotifications();
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
                title: Text("Confirmación"),
                content: Text(
                  "¿Confirmar validación?",
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
              );
            },
          );
        }

        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: Text("Validar ${notification["tipoDescI"]}"),
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
                      image: AssetImage(notification["srcI"])
                    )
                    :
                    Image(
                      image: AssetImage(notification["srcI"])
                    )
                    ,SizedBox(
                      height: 10,
                    ),
                    Text(
                      notification["nombreI"],
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text("Cantidad registrada: ${notification["cantidad"]}"),
                    SizedBox(
                      height: 15,
                    ),
                    !validar ?
                    OutlinedButton(
                      onPressed: () {
                        setState(() {
                          validar = true;
                        });
                      }, 
                      child: Text("Corregir", style: TextStyle(color: Color.fromARGB(255, 6, 114, 10)),),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(
                          color: Color.fromARGB(255, 37, 140, 40),
                          width: 2,
                        ), //permite cambiar el color del border
                        primary: Colors.black, //Cambia el color del texto del boton
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(40))
                        ),
                      ),
                    )
                    :
                    int.parse(notification["tipoI"]) != 5 && int.parse(notification["tipoI"]) != 7 && int.parse(notification["tipoI"]) != 10 ?
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
                    Container(
                      width: 300,
                      child: TextField(
                        obscureText: false,
                        keyboardType: TextInputType.number,
                        controller: cantidadLibre,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5)
                          ),
                          labelText: 'Cantidad'
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
                  
                  ],
                ),
                
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
                    // Navigator.pop(context);
                    // addIngesta();
                    showConfirmRegistro();
                  },
                  child: const Text("Confirmar"),
                ),
              ],
            );
          }
        );
      },
    );
  }

  void fastConfirm(notification) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirmación"),
          content: Text(
            "¿Confirmar registro?",
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
              onPressed: () async {
                try {
                  final response = await http.post(
                    Uri.parse('http://${ip.ip}/api_diabeteens/Ingesta/confirmIngesta.php'),
                    body: {
                      "idSeguimiento": notification["id"].toString(),
                      "cantidad": notification["cantidad"].toString(),
                    }
                  );
                  var respuesta = jsonDecode(response.body);
                  // print(respuesta);
                  if (respuesta["accion"]) {
                    Fluttertoast.showToast(
                      msg: "Registro validado",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.TOP,
                      timeInSecForIosWeb: 2,
                      backgroundColor: Colors.green,
                      textColor: Colors.white,
                      fontSize: 16.0
                    );
                    getNotifications();
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
              },
              child: const Text("Confirmar"),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _idUsuario = widget.idUsuario;
    _idTutor = widget.idTutor;
    _idPersona = widget.idPersona;
    _usuario = widget.usuario;
    _nombreCompleto = widget.nombreCompleto;
    _idHijos = widget.idHijos;
    _cantHijos = widget.cantHijos;
    getNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.pushReplacement(
              context, 
              MaterialPageRoute(
                builder: (context) => EntryPointTutor(cantHijos: _cantHijos, idHijos: _idHijos, idPersona: _idPersona, idTutor: _idTutor, idUsuario: _idUsuario, nombreCompleto: _nombreCompleto, usuario: _usuario,)
              )
            );
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: 30,
          )
        ),
        backgroundColor: Colors.transparent,
        title: Text("Notificaciones", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
        centerTitle: false,
      ),
      body: ListView.builder(
        itemCount: notifications.length,
        // scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return Slidable(
            actionPane: SlidableDrawerActionPane(),
            actionExtentRatio: 0.25,
            secondaryActions: <Widget>[
              // Container(
              //   height: 60,
              //   color: Colors.grey.shade500,
              //   child: Icon(Icons.info_outline, color: Colors.white,)
              // ),
              GestureDetector(
                onTap: () {
                  fastConfirm(notifications[index]);
                },
                child: Tooltip(
                  message: "Confirmación rápida",
                  child: Container(
                    height: 60,
                    color: Color.fromARGB(255, 41, 152, 45),
                    child: Icon(Icons.save_as_outlined, color: Colors.white,)
                  ),
                )
              )
            ],
            child: GestureDetector(
              onTap: () {
                showDialogSelected(notifications[index]);
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.grey.shade300, width: 1)
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Image.asset(notifications[index]["srcI"])
                            ),
                          ),
                          SizedBox(width: 10,),
                          Flexible(
                            child: RichText(text: TextSpan(
                              children: [
                                TextSpan(text: "${notifications[index]["tipoDescI"]}: ", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold), ),
                                TextSpan(text: "${notifications[index]["nombreI"]} ", style: TextStyle(color: Colors.black)),
                                TextSpan(text: notifications[index]["cantidad"], style: TextStyle(color: Colors.grey.shade500),)
                              ]
                            )),
                          )
                        ],
                      ),
                    ),
                    OutlinedButton(
                      onPressed: () {
                        showDialogSelected(notifications[index]);
                      }, 
                      child: Text("Validar", style: TextStyle(color: const Color.fromARGB(255, 8, 68, 118)),),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(
                          color: Color.fromARGB(255, 11, 103, 178),
                          width: 2,
                        ), //permite cambiar el color del border
                        primary: Colors.black, //Cambia el color del texto del boton
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          );
        }
      )
    );

  }

}