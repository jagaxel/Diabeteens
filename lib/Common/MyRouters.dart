import 'package:diabeteens_v2/Pages/LoginPage.dart';
import 'package:diabeteens_v2/Pages/MyHomePage.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

const String ROUTE_LOGIN = "/login";
const String ROUTE_HOME = "/home";


class MyRouters {
  static Route<dynamic>generateRoute(RouteSettings settings) {
    switch(settings.name) {
      case "/home":
        return PageTransition(
          child: MyHomePage(), //En child se pone la página a la que se va a acceder
          type: PageTransitionType.scale, //EL tipo de transición
          settings: settings, //Se comparte el settings que se está recibiendo del método
          alignment: Alignment.center //El aliniamiento
        );
      case "/login":
        return MaterialPageRoute(builder: (_) => LoginPage());
      default:
        return MaterialPageRoute(builder: (_) => LoginPage());
    }
  }
}