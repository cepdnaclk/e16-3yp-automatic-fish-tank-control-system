import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import '../background/background.dart';
import '../models/graphmodel.dart';
import '../views/graph.dart';

class GraphView extends StatefulWidget {
  final List<TimeSeriesPh> phDataArray;
  final List<TimeSeriesTemp> tempDataArray;

  const GraphView({@required  this.phDataArray,@required this.tempDataArray});
  @override
  _GraphViewState createState() => _GraphViewState();
}

class _GraphViewState extends State<GraphView> {
  List<charts.Series<TimeSeriesPh, DateTime>> phseriesList;
  List<charts.Series<TimeSeriesTemp, DateTime>> tempseriesList;
  bool floatClicked = true;

  

  @override
  void initState() {
    // TODO: implement initState
    this.phseriesList = List<charts.Series<TimeSeriesPh, DateTime>>();
    this.phseriesList.add(charts.Series(
        data: widget.phDataArray,
        domainFn: (datum, index) => datum.time,
        measureFn: (datum, index) => datum.ph,
        colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
        id: "Daily PH"));
    this.tempseriesList = List<charts.Series<TimeSeriesTemp, DateTime>>();
    this.tempseriesList.add(charts.Series(
        data: widget.tempDataArray,
        domainFn: (datum, index) => datum.time,
        measureFn: (datum, index) => datum.temp,
        colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
        id: "Daily PH"));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        elevation: 10,
        onPressed: () {
          setState(() {
            this.floatClicked = !this.floatClicked;
          });
        },
        child: Text(this.floatClicked ? "TEMP" : "PH"),
        backgroundColor: Colors.black,
        splashColor: Colors.white,
        materialTapTargetSize: MaterialTapTargetSize.padded,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndTop,
      body: Background(
          child: Padding(
        padding: EdgeInsets.all(8.8),
        child: Container(
          child: Center(
            child: Graph(
              heading: this.floatClicked
                  ? "PH VALUE WEEKLY STATUS"
                  : "TEMP WEEKLY STATUS",
              param: this.floatClicked ? "PH" : "TEMP",
              seriesList: this.phseriesList,
            ),
          ),
        ),
      )),
    );
  }
}
