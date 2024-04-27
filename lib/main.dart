import 'package:diabeteens_v2/Pages/LoginPage.dart';
import 'package:diabeteens_v2/Pages/RegisterHijo/RegisterPasswordHijo.dart';
import 'package:diabeteens_v2/VistaInicial.dart';
import 'package:flutter/material.dart';
import 'package:diabeteens_v2/Pages/Videojuego/start_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Diabeteens',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const StartPage(),
      //home: const MyHomePage(title: ''),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Diabeteens',
      debugShowCheckedModeBanner: false,
      // onGenerateRoute: MyRouters.generateRoute,
      // initialRoute: ROUTE_LOGIN,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF4c709a)),
        useMaterial3: true,
      ),
      home: LoginPage()
      // home: RegisterPasswordHijoPage(edad: 20, fechaNacimiento: '2000-03-16', idTutor: 3, nombre: "Jairo", peso: "34", primerAp: "Garcia", segundoAp: "Alcala", sexo: "H", telefono: "44534",)
    );

    // return Scaffold(
    //   appBar: AppBar(
    //     backgroundColor: Theme.of(context).colorScheme.inversePrimary,
    //     title: Text(widget.title),
    //   ),
    //   body: Center(
    //     child: Column(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: <Widget>[
    //         const Text(
    //           'You have pushed the button this many times:',
    //         ),
    //         Text(
    //           '$_counter',
    //           style: Theme.of(context).textTheme.headlineMedium,
    //         ),
    //       ],
    //     ),
    //   ),
    //   floatingActionButton: FloatingActionButton(
    //     onPressed: _incrementCounter,
    //     tooltip: 'Increment',
    //     child: const Icon(Icons.add),
    //   ), // This trailing comma makes auto-formatting nicer for build methods.
    // );
  }
}
