import 'package:diabeteens_v2/Pages/Views/Tutor/HomeTutor.dart';
import 'package:flutter/material.dart';
import 'package:diabeteens_v2/Utils/DirectionIp.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

class HistoryHijo extends StatefulWidget {
  final String idHijo;
  const HistoryHijo({super.key, required this.idHijo});

  @override
  State<HistoryHijo> createState() => _HistoryHijoState();
}

class _HistoryHijoState extends State<HistoryHijo> {
  DirectionIp ip = DirectionIp();
  HomeTutorState home = HomeTutorState();
  late String _idHijo;
  List<Map<String, dynamic>> notifications = [];
  String lastFecha = "";

  Future<void> getNotifications() async {
    try {
      notifications = [];
      final response = await http.post(
        Uri.parse('http://${ip.ip}/api_diabeteens/History/getHistory.php'),
        body: {
          "idHijo": _idHijo
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
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: Text("${notification["tipoDescI"]}"),
              content: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 15,
                    ),
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
                  ],
                ),
                
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Ok"),
                ),
              ],
            );
          }
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _idHijo = widget.idHijo;
    getNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: 30,
          )
        ),
        backgroundColor: Colors.transparent,
        title: Text("Historial", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
        centerTitle: false,
      ),
      body: ListView.builder(
        itemCount: notifications.length,
        // scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          if (index != 0) {
            lastFecha = notifications[index - 1]["fecha"];
          }
          return GestureDetector(
            onTap: () {
              showDialogSelected(notifications[index]);
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  lastFecha != notifications[index]["fecha"] ?
                  Text(notifications[index]["fecha"])
                  :
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
                ],
              ),
            ),
          );
        }
      )
    );

  }

}