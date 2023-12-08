import 'package:diabeteens_v2/Utils/AppColors.dart';
import 'package:diabeteens_v2/Utils/Indicator.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:diabeteens_v2/Utils/DirectionIp.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class HomeTutor extends StatefulWidget {
  final int idHijo;
  const HomeTutor({super.key, required this.idHijo});

  // List<String> get dias => const ['Dom', 'Lun', 'Mar', 'Mié', 'Jue', 'Vie', 'Sáb'];

  @override
  State<HomeTutor> createState() => HomeTutorState();
}

class HomeTutorState extends State<HomeTutor> {
  DirectionIp ip = DirectionIp();

  List<Color> gradientColors = [
    AppColors.contentColorCyan,
    AppColors.contentColorBlue,
  ];

  // Map<String, List<int>> glucosa = {
  //   "Dom": [70, 100, 60, 50, 177, 90, 120],
  //   "Lun": [50, 72, 98, 197, 66, 99, 20],
  //   "Mar": [58, 70, 40, 134, 120, 130, 89],
  //   "Mie": [100, 100, 63, 70, 60, 70, 68],
  //   "Jue": [30, 179, 140, 80, 78, 130, 120],
  //   "Vie": [78, 130, 67, 180, 190, 80, 143],
  //   "Sab": [69, 80, 45, 67, 89, 100, 120]
  // };

  int touchedIndex = -1;

  List<String> listNameDays = [];
  void getNameGraph() async {
    try {
      final response = await http.post(
        Uri.parse('http://${ip.ip}/api_diabeteens/Graphics/getNameDays.php'),
        body: {
          "idHijo": "6",
        }
      );
      var respuesta = jsonDecode(response.body);
      for (int i = 0; i < respuesta.length; i++) {
        setState(() {
          listNameDays.add(respuesta[i]["tituloDias"]);
        });
      }
    } catch (e) {
      print(e);
    }
  }
  
  List<List<int>> listCantGlucosa = [];
  void getDataGlucosa() async {
    try {
      final response = await http.post(
        Uri.parse('http://${ip.ip}/api_diabeteens/Graphics/getDataGlucosa.php'),
        body: {
          "idHijo": "6",
        }
      );
      var respuesta = jsonDecode(response.body);
      List<int> cantGlucosa = [];
      String fecha = "";
      for (int i = 0; i < respuesta.length; i++) {
        setState(() {
          if (fecha == "") {
            fecha = respuesta[i]["fecha"];
          } else if (respuesta[i]["fecha"] != fecha) {
            listCantGlucosa.add(cantGlucosa);
            fecha = respuesta[i]["fecha"];
            cantGlucosa = [];
          }
          cantGlucosa.add(int.parse(respuesta[i]["cantidad"]));
          if ((i + 1) >= respuesta.length) {
            listCantGlucosa.add(cantGlucosa);
          }
        });
      }
    } catch (e) {
      print(e);
    }
  }

  Map<String, List<int>> dataGraph = {};
  void getDataGrafica() async {
    getNameGraph();
    getDataGlucosa();
    await Future.delayed(Duration(seconds: 1));
    for (int i = 0; i < listNameDays.length; i++) {
      setState(() {
        dataGraph[listNameDays[i]] = listCantGlucosa[i];
      });
    }
  }

  double cantHiper = 0;
  double cantNormal = 0;
  double cantHipo = 0;
  void getPorcentajePastel() async {
    try {
      final response = await http.post(
        Uri.parse('http://${ip.ip}/api_diabeteens/Graphics/getCantPorcentaje.php'),
        body: {
          "idHijo": "6",
        }
      );
      var respuesta = jsonDecode(response.body);
      print(respuesta);
      int hiper = int.parse(respuesta["cantHiper"]);
      int normal = int.parse(respuesta["cantNormal"]);
      int hipo = int.parse(respuesta["cantHipo"]);
      int total = hiper + normal + hipo;

      setState(() {
        cantHiper = double.parse(((hiper / total) * 100).toStringAsFixed(2));
        cantNormal = double.parse(((normal / total) * 100).toStringAsFixed(2));
        cantHipo = double.parse(((hipo / total) * 100).toStringAsFixed(2));
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getDataGrafica();
    getPorcentajePastel();
    // _idUsuario = widget.idUsuario;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF4c709a),
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 70,
              ),
              const Align(
                alignment: Alignment.topCenter,
                child: Text(
                  'Glucosa',
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(0),
                child: Stack(
                  children: <Widget>[
                    AspectRatio(
                      aspectRatio: 1.20, //Tamaño de la gráfica (heigth)
                      child: Padding(
                        padding: const EdgeInsets.only(
                          right: 18,
                          left: 12,
                          top: 15,
                          bottom: 12,
                        ),
                        child: LineChart(
                          mainData(),
                        ),
                      ),
                    ),
                    // SizedBox(
                    //   width: 65,
                    //   height: 38,
                    //   child: Text(
                    //     'Glucosa',
                    //     style: TextStyle(
                    //       fontSize: 18,
                    //       color: Colors.white,
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
              AspectRatio(
                aspectRatio: 1.3,
                child: Column(
                  children: <Widget>[
                    const SizedBox(
                      height: 18,
                    ),
                    Expanded(
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: PieChart(
                          PieChartData(
                            pieTouchData: PieTouchData(
                              touchCallback: (FlTouchEvent event, pieTouchResponse) {
                                setState(() {
                                  if (!event.isInterestedForInteractions ||
                                      pieTouchResponse == null ||
                                      pieTouchResponse.touchedSection == null) {
                                    touchedIndex = -1;
                                    return;
                                  }
                                  touchedIndex = pieTouchResponse
                                      .touchedSection!.touchedSectionIndex;
                                });
                              },
                            ),
                            borderData: FlBorderData(
                              show: false,
                            ),
                            sectionsSpace: 0,
                            centerSpaceRadius: 40,
                            sections: showingSections(),
                          ),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: Column(
                        children: <Widget>[
                          Indicator(
                            color: AppColors.contentColorRed,
                            text: 'Hiperglucemia (+180)',
                            isSquare: true,
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Indicator(
                            color: Color.fromARGB(255, 74, 202, 78),
                            text: 'Normal',
                            isSquare: true,
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Indicator(
                            color: AppColors.contentColorBlue,
                            text: 'Hipóglucemia (-70)',
                            isSquare: true,
                          ),
                          SizedBox(
                            height: 18,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 28,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 12,
      color: Colors.white,
    );
    Widget text;
    int cantDias = listNameDays.length;
    if (cantDias > 0) {
      switch (value.toInt()) {
        case 3:
          text = Text(listNameDays[0], style: style);
          break;
        case 6:
          text = Text(cantDias >= 2 ? listNameDays[1] : '', style: style);
          break;
        case 9:
          text = Text(cantDias >= 3 ? listNameDays[2] : '', style: style);
          break;
        case 12:
          text = Text(cantDias >= 4 ? listNameDays[3] : '', style: style);
          break;
        case 15:
          text = Text(cantDias >= 5 ? listNameDays[4] : '', style: style);
          break;
        case 18:
          text = Text(cantDias >= 6 ? listNameDays[5] : '', style: style);
          break;
        case 21:
          text = Text(cantDias >= 7 ? listNameDays[6] : '', style: style);
          break;
        default:
          text = Text('', style: style);
          break;
      }
    } else {
      text = Text('', style: style);
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 15,
      color: Colors.white
    );
    String text;
    switch (value.toInt()) {
      case 70:
        text = '70';
        break;
      case 180:
        text = '180';
        break;
      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.left);
  }

  LineChartData mainData() {
    List<FlSpot> puntosCoord = [];
    List<Color> colorsLinea = [];
    double ejeXGlobal = -3;
    dataGraph.forEach((key, value) {
      double ejeX = 0;
      // switch (key) {
      //   case "Dom": ejeX = 0;
      //     break;
      //   case "Lun": ejeX = 3;
      //     break;
      //   case "Mar": ejeX = 6;
      //     break;
      //   case "Mie": ejeX = 9;
      //     break;
      //   case "Jue": ejeX = 12;
      //     break;
      //   case "Vie": ejeX = 15;
      //     break;
      //   case "Sab": ejeX = 18;
      //     break;
      // }
      ejeXGlobal += 3;
      ejeX = ejeXGlobal;
      int separacion = 30 ~/ value.length;
      for (int ejeY in value) {
        ejeX += double.parse(((separacion / 100) * 10).toStringAsFixed(2));
        puntosCoord.add(FlSpot(ejeX, ejeY.toDouble()));
        if (ejeY < 70 || ejeY > 180) {
          colorsLinea.add(Colors.red);
        } else {
          colorsLinea.add(AppColors.contentColorCyan);
        }
      }
    });

    return LineChartData(
      gridData: FlGridData(
        show: false,
        drawVerticalLine: false,
        drawHorizontalLine: false,
        horizontalInterval: 1,
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return const FlLine(
            color: AppColors.mainGridLineColor,
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return const FlLine(
            color: AppColors.mainGridLineColor,
            strokeWidth: 3,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 22,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 42,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true, //Para mostrar los border de la gráfica
        border: Border.all(color: Color.fromARGB(255, 4, 5, 6)),
      ),
      minX: 0,
      maxX: 24,
      minY: 0,
      maxY: 250,
      lineBarsData: [
        LineChartBarData(
          spots: puntosCoord
          ,
          isCurved: true,
          // gradient: LinearGradient(
          //   colors: colorsLinea
          // ),
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: false, //Rellena de color lo que está por debajo de la línea de la gráfica
            // gradient: LinearGradient(

            // )
          ),
        ),
      ],
      lineTouchData: LineTouchData(
        getTouchedSpotIndicator: (LineChartBarData barData, List<int> spotIndexes) {
          return spotIndexes.map((spotIndex) {
            final spot = barData.spots[spotIndex];
            return TouchedSpotIndicatorData(
              FlLine(
                color: AppColors.contentColorCyan,
                strokeWidth: 4,
              ),
              FlDotData(
                getDotPainter: (spot, percent, barData, index) {
                  return FlDotCirclePainter(
                    radius: 8,
                    color: Colors.white,
                    strokeWidth: 5,
                    strokeColor: AppColors.contentColorCyan,
                  );
                },
              ),
            );
          }).toList();
        },
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Color.fromARGB(113, 0, 110, 255),
          getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
            return touchedBarSpots.map((barSpot) {
              final flSpot = barSpot;
              TextAlign textAlign;
              switch (flSpot.x.toInt()) {
                case 1:
                  textAlign = TextAlign.left;
                  break;
                case 5:
                  textAlign = TextAlign.right;
                  break;
                default:
                  textAlign = TextAlign.center;
              }

              return LineTooltipItem(
                flSpot.x.toInt() <= 3 ? listNameDays.length > 0 ? "${listNameDays[0]}\n" : "" : 
                flSpot.x.toInt() <= 6 ? listNameDays.length >= 1 ? "${listNameDays[1]}\n" : "" : 
                flSpot.x.toInt() <= 9 ? listNameDays.length >= 2 ? "${listNameDays[2]}\n" : "" : 
                flSpot.x.toInt() <= 12 ? listNameDays.length >= 3 ? "${listNameDays[3]}\n" : "" : 
                flSpot.x.toInt() <= 15 ? listNameDays.length >= 4 ? "${listNameDays[4]}\n" : "" : 
                flSpot.x.toInt() <= 18 ? listNameDays.length >= 5 ? "${listNameDays[5]}\n" : "" : 
                flSpot.x.toInt() <= 21 ? listNameDays.length >= 6 ? "${listNameDays[6]}\n" : "" : '',
                TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                children: [
                  TextSpan(
                    text: flSpot.y.toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const TextSpan(
                    text: ' Glucosa',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.white
                    ),
                  ),
                ],
                textAlign: textAlign,
              );
            }).toList();
          },
        )
      ),
      extraLinesData: ExtraLinesData(
        horizontalLines: [
          HorizontalLine(
            y: 70,
            color: Colors.green,
            strokeWidth: 3,
            dashArray: [20, 10],
          ),
          HorizontalLine(
            y: 180,
            color: Colors.green,
            strokeWidth: 3,
            dashArray: [20, 10],
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(3, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: AppColors.contentColorRed,
            value: cantHiper,
            title: '$cantHiper%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: AppColors.mainTextColor1,
              shadows: shadows,
            ),
          );
        case 1:
          return PieChartSectionData(
            color: Color.fromARGB(255, 74, 202, 78),
            value: cantNormal,
            title: '$cantNormal%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: AppColors.mainTextColor1,
              shadows: shadows,
            ),
          );
        case 2:
          return PieChartSectionData(
            color: AppColors.contentColorBlue,
            value: cantHipo,
            title: '$cantHipo%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: AppColors.mainTextColor1,
              shadows: shadows,
            ),
          );
        default:
          throw Error();
      }
    });
  }
}