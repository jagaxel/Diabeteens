import 'package:flutter/material.dart';
import 'package:diabeteens_v2/Utils/AppColors.dart';

class Common {
  Color maincolor = const Color(0xFF35C2C1);
  Color white = const Color(0xFFF5F5F5);
  Color black = const Color(0xFF1E232C);

  TextStyle titelTheme = const TextStyle(
    fontSize: 30,
    fontFamily: "Roboto",
    fontWeight: FontWeight.bold,
    // color: Colors.white
  );

  TextStyle mediumTheme = const TextStyle(
    fontSize: 15,
    fontFamily: "Roboto",
    fontWeight: FontWeight.bold,
    color: Color.fromARGB(255, 72, 151, 151)
  );

  TextStyle shortTheme = const TextStyle(
    fontSize: 18,
    fontFamily: "GFSNeohellenic",
    fontWeight: FontWeight.bold,
    // color: Color.fromARGB(255, 72, 151, 151)
  );

  TextStyle mediumThemeblack = const TextStyle(
    fontSize: 16,
    fontFamily: "GFSNeohellenic",
    fontWeight: FontWeight.w300,
    color: Colors.grey
  );

  TextStyle semiboldwhite = const TextStyle(
    fontSize: 18,
    fontFamily: "GFSNeohellenic",
    fontWeight: FontWeight.bold,
    color: Colors.white
  );
  TextStyle semiboldblack = const TextStyle(
    fontSize: 15, fontFamily: "GFSNeohellenic",
    //  color: Colors.white
  );

  TextStyle hinttext = const TextStyle(
    fontSize: 20, 
    fontFamily: 'GFSNeohellenic', 
    color: Color.fromARGB(255, 42, 42, 43),
  );

  ButtonStyle styleBtnLite = ButtonStyle(
    side: const MaterialStatePropertyAll(BorderSide(color: AppColors.azulLite)),
    shape: MaterialStatePropertyAll(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20)
      )
    ),
    fixedSize: const MaterialStatePropertyAll(Size.fromWidth(270)),
    padding: const MaterialStatePropertyAll(
      EdgeInsets.symmetric(vertical: 5),
    ),
    backgroundColor: MaterialStatePropertyAll(AppColors.azulLite)
  );

  ButtonStyle styleBtn = ButtonStyle(
    side: const MaterialStatePropertyAll(BorderSide(color: AppColors.azul)),
    shape: MaterialStatePropertyAll(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20)
      )
    ),
    fixedSize: const MaterialStatePropertyAll(Size.fromWidth(270)),
    padding: const MaterialStatePropertyAll(
      EdgeInsets.symmetric(vertical: 5),
    ),
    backgroundColor: MaterialStatePropertyAll(AppColors.azul)
  );

  ButtonStyle styleBtnWhite = ButtonStyle(
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
    backgroundColor: MaterialStatePropertyAll(AppColors.blanco),
  );
}