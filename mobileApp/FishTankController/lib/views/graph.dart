import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class Graph extends StatelessWidget {
  final String heading;
  final List seriesList;
  final String param;

  const Graph(
      {@required this.heading,
      @required this.seriesList,
      @required this.param});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: size.height * 0.2,
        ),
        Text(
          this.heading,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 1,
        ),
        Expanded(
            child: charts.TimeSeriesChart(
          this.seriesList,
          animate: true,
          animationDuration: Duration(seconds: 1),
          defaultRenderer:
              charts.LineRendererConfig(includeArea: true, stacked: true),
          behaviors: [
            charts.ChartTitle(this.param,
                behaviorPosition: charts.BehaviorPosition.start,
                titleOutsideJustification:
                    charts.OutsideJustification.middleDrawArea),
            charts.ChartTitle("TIME",
                behaviorPosition: charts.BehaviorPosition.bottom,
                titleOutsideJustification:
                    charts.OutsideJustification.middleDrawArea)
          ],
        )),
        SizedBox(
          height: 10,
        ),
        RaisedButton(
          elevation: 10.0,
          padding:
              EdgeInsets.symmetric(horizontal: size.width * 0.3, vertical: 10),
          color: Colors.black,
          onPressed: () => Navigator.of(context).pop(true),
          child: Text(
            "BACK",
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        )
      ],
    );
  }
}
