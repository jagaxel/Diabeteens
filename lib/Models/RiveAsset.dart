import 'package:rive/rive.dart';

class RiveAsset {
  final String artboard, stateMachineName, title, src;
  late SMIBool? input;

  RiveAsset(
    this.src,
    {
      required this.artboard,
      required this.stateMachineName,
      required this.title,
      this.input
    }
  );

  set setInput(SMIBool status) {
    this.input = status;
  }

}

List<RiveAsset> bottomNavs = [
  RiveAsset(
    "assets/riveAssets/iconosAnimados.riv",
    artboard: "CHAT",
    stateMachineName: "CHAT_Interactivity",
    title: "Chat"
  ),
  RiveAsset(
    "assets/riveAssets/iconosAnimados.riv",
    artboard: "SEARCH",
    stateMachineName: "SEARCH_Interactivity",
    title: "Búsqueda"
  ),
  RiveAsset(
    "assets/riveAssets/iconosAnimados.riv",
    artboard: "TIMER",
    stateMachineName: "TIMER_Interactivity",
    title: "Tiempo"
  ),
  RiveAsset(
    "assets/riveAssets/iconosAnimados.riv",
    artboard: "BELL",
    stateMachineName: "BELL_Interactivity",
    title: "Notificaciones"
  ),
  RiveAsset(
    "assets/riveAssets/iconosAnimados.riv",
    artboard: "USER",
    stateMachineName: "USER_Interactivity",
    title: "Usuario"
  ),
  RiveAsset(
    "assets/riveAssets/iconosAnimados.riv",
    artboard: "LIKE/STAR",
    stateMachineName: "STAR_Interactivity",
    title: "Favoritos"
  ),
];

List<RiveAsset> sideMenus = [
  RiveAsset(
    "assets/riveAssets/iconosAnimados.riv",
    artboard: "HOME",
    stateMachineName: "HOME_interactivity",
    title: "Inicio"
  ),
  RiveAsset(
    "assets/riveAssets/iconosAnimados.riv",
    artboard: "SEARCH",
    stateMachineName: "SEARCH_Interactivity",
    title: "Búsqueda"
  ),
  RiveAsset(
    "assets/riveAssets/iconosAnimados.riv",
    artboard: "BELL",
    stateMachineName: "BELL_Interactivity",
    title: "Notificaciones"
  ),
  RiveAsset(
    "assets/riveAssets/iconosAnimados.riv",
    artboard: "USER",
    stateMachineName: "USER_Interactivity",
    title: "Usuario"
  )
];