import 'package:flutter/material.dart';
import 'package:diabeteens_v2/Utils/DirectionIp.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ImagesFood {
  DirectionIp ip = DirectionIp();

  List<List<String>> listComidas = [];
  void getComida() async {
    try {
      final response = await http.post(
        Uri.parse('http://${ip.ip}/api_diabeteens/Ingesta/getComida.php'),
        body: {
          
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
          tipoComida = int.parse(respuesta[i]["idTipoIngesta"]);
          listComidas.add(comidas);
          comidas = [];
        }
        comidas.add(respuesta[i]["src"]);
      }

    } catch (e) {
      print(e);
    }
  }
}