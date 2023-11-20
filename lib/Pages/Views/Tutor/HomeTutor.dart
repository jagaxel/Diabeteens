import 'package:diabeteens_v2/Utils/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class HomeTutor extends StatefulWidget {
  const HomeTutor({super.key});

  List<String> get dias => const ['Dom', 'Lun', 'Mar', 'Mié', 'Jue', 'Vie', 'Sáb'];

  @override
  State<HomeTutor> createState() => _HomeTutorState();
}

class _HomeTutorState extends State<HomeTutor> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
   List<Color> gradientColors = [
    AppColors.contentColorCyan,
    AppColors.contentColorBlue,
  ];

  bool showAvg = false;

  Map<String, List<int>> glucosa = {
    "Dom": [70, 100, 60, 50, 177, 90, 120],
    "Lun": [50, 72, 98, 197, 66, 99, 20],
    "Mar": [58, 70, 40, 134, 120, 130, 89],
    "Mie": [100, 100, 63, 70, 60, 70, 68],
    "Jue": [30, 179, 140, 80, 78, 130, 120],
    "Vie": [78, 130, 67, 180, 190, 80, 143],
    "Sab": [69, 80, 45, 67, 89, 100, 120]
  };

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
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Stack(
                  children: <Widget>[
                    AspectRatio(
                      aspectRatio: 1.20, //Tamaño de la gráfica (heigth)
                      child: Padding(
                        padding: const EdgeInsets.only(
                          right: 18,
                          left: 12,
                          top: 24,
                          bottom: 12,
                        ),
                        child: LineChart(
                          showAvg ? avgData() : mainData(),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 60,
                      height: 34,
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            showAvg = !showAvg;
                          });
                        },
                        child: Text(
                          'avg',
                          style: TextStyle(
                            fontSize: 12,
                            color: showAvg ? Colors.white.withOpacity(0.5) : Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Text("Gráfica")
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
      color: Colors.white
    );
    Widget text;
    switch (value.toInt()) {
      case 3:
        text = const Text('Dom', style: style);
        break;
      case 6:
        text = const Text('Lun', style: style);
        break;
      case 9:
        text = const Text('Mar', style: style);
        break;
      case 12:
        text = const Text('Mié', style: style);
        break;
      case 15:
        text = const Text('Jue', style: style);
        break;
      case 18:
        text = const Text('Vie', style: style);
        break;
      case 21:
        text = const Text('Sáb', style: style);
        break;
      default:
        text = const Text('', style: style);
        break;
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
    glucosa.forEach((key, value) {
      double ejeX = 0;
      switch (key) {
        case "Dom": ejeX = 0;
          break;
        case "Lun": ejeX = 3;
          break;
        case "Mar": ejeX = 6;
          break;
        case "Mie": ejeX = 9;
          break;
        case "Jue": ejeX = 12;
          break;
        case "Vie": ejeX = 15;
          break;
        case "Sab": ejeX = 18;
          break;
      }
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
            strokeWidth: 1,
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
        border: Border.all(color: const Color(0xff37434d)),
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
                flSpot.x.toInt() <= 3 ? 'Domingo\n' : 
                flSpot.x.toInt() <= 6 ? 'Lunes\n' : 
                flSpot.x.toInt() <= 9 ? 'Martes\n' : 
                flSpot.x.toInt() <= 12 ? 'Miércoles\n' : 
                flSpot.x.toInt() <= 15 ? 'Jueves\n' : 
                flSpot.x.toInt() <= 18 ? 'Viernes\n' : 
                flSpot.x.toInt() <= 21 ? 'Sábado\n' : '',
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

  LineChartData avgData() {
    return LineChartData(
      lineTouchData: const LineTouchData(enabled: false),
      gridData: FlGridData(
        show: true,
        drawHorizontalLine: true,
        verticalInterval: 1,
        horizontalInterval: 1,
        getDrawingVerticalLine: (value) {
          return const FlLine(
            color: Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingHorizontalLine: (value) {
          return const FlLine(
            color: Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: bottomTitleWidgets,
            interval: 1,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 42,
            interval: 1,
          ),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: const Color(0xff37434d)),
      ),
      minX: 0,
      maxX: 11,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: const [
            FlSpot(0, 3.44),
            FlSpot(2.6, 3.44),
            FlSpot(4.9, 3.44),
            FlSpot(6.8, 3.44),
            FlSpot(8, 3.44),
            FlSpot(9.5, 3.44),
            FlSpot(11, 3.44),
          ],
          isCurved: true,
          gradient: LinearGradient(
            colors: [
              ColorTween(begin: gradientColors[0], end: gradientColors[1]).lerp(0.2)!,
              ColorTween(begin: gradientColors[0], end: gradientColors[1]).lerp(0.2)!,
            ],
          ),
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: [
                ColorTween(begin: gradientColors[0], end: gradientColors[1]).lerp(0.2)!.withOpacity(0.1),
                ColorTween(begin: gradientColors[0], end: gradientColors[1]).lerp(0.2)!.withOpacity(0.1),
              ],
            ),
          ),
        ),
      ],
    );
  }
}


