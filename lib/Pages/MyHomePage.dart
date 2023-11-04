import 'package:diabeteens_v2/Elements/TabBarHome.dart';
import 'package:diabeteens_v2/Pages/LoginPage.dart';
import 'package:diabeteens_v2/Pages/RegisterTutor/RegisterNamePage.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key});

  @override
  State<MyHomePage> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<MyHomePage> {
  
  Future<void> _showDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          // title: Text('Choose an Option'),
          content: SingleChildScrollView(
            child: ListView(
              shrinkWrap: true, // Ensure the dialog size matches the content
              children: <Widget>[
                ListTile(
                  title: const Text('Create Account'),
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => RegisterNamePage()));
                  },
                ),
                ListTile(
                  title: const Text('Login'),
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const LoginPage()));
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double widgetHeight = MediaQuery.of(context).size.height;
    double widgetWidth = MediaQuery.of(context).size.width;
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(elevation: 0,
          leading: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Icon(Icons.menu, color: Color(0xFFd4b0a0)),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: IconButton(
                icon: const Icon(Icons.person),
                color: Color(0xFFd4b0a0),
                onPressed: () {
                  _showDialog(context); // Now you can call _showDialog
                },
              ),
            ),
          ],
          centerTitle: true,
          backgroundColor: Color(0xFF4c709a),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(widgetHeight * .15),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: TextField(
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(50.0),
                    ),
                    borderSide: const BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                    //borderSide: .none,
                  ),
                  filled: true,
                  prefixIcon: Icon(
                    Icons.search,
                    color: Color(0xff7b7b7b),
                  ),
                  fillColor: Colors.white,
                  suffixIcon: Icon(
                    Icons.sort,
                    color: Color(0xff7b7b7b),
                  ),
                  //  hintStyle: new TextStyle(color: Color(0xFFd0cece), fontSize: 18),
                  hintText: "Search Flavor",
                  hintStyle: TextStyle(
                    color: Color(0xFFd0cece),
                    fontWeight: FontWeight.w300,
                    fontSize: 15
                  )
                ),
              ),  
            ),
          ),
        ),
        body: const Center(
          child: Column(
            children: [
              TabBarHome(),
            ],
          ),
        ),
      ),
    );
  }
}