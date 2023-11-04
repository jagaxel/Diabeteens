
import 'package:flutter/material.dart';

class TabBarHome extends StatelessWidget {
  const TabBarHome({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
      double widgetHeight =  MediaQuery.of(context).size.height ;
      double widgetWidth = MediaQuery.of(context).size.width ;
    return SingleChildScrollView(
      child: SizedBox(
        height:  widgetHeight *.09,
        child: AppBar(
          backgroundColor: Color(0xFF4c709a),
          bottom: TabBar(isScrollable: true,
            labelColor: Colors.black,
            indicatorColor: Colors.white,
            dividerColor: Colors.red,
            tabs: [
              Tab(
                child: Text("Hot Coffee", textAlign: TextAlign.center,style: TextStyle(fontSize: 12,color: Colors.white)),
              ),
              Tab(
                  child: Text(
                "Cold Coffee",style: TextStyle(fontSize: 11,color: Colors.white),
                textAlign: TextAlign.center,
              )),
              Tab(child: Text("Others", textAlign: TextAlign.center,style: TextStyle(fontSize: 12,color: Colors.white))),
           
             
            ],
          ),
        ),
      ),
    );
  }
}