import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InfoMenuCardHijo extends StatelessWidget {
  const InfoMenuCardHijo({
    super.key, 
    required this.nombre, 
    required this.tipoUsuario,
  });

  final String nombre, tipoUsuario;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.white24,
        child: Icon(
          CupertinoIcons.person,
          color: Colors.white,
        ),
      ),
      title: Text(
        nombre,
        style: TextStyle(color: Colors.white),
      ),
      subtitle: Text(
        tipoUsuario,
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}