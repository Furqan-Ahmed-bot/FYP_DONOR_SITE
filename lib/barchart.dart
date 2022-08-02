// import 'package:chartapp/network/network_helper.dart';
// import 'package:chartapp/src/Bar_Chart/bar_model.dart';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'models/donationsModel.dart';
import 'package:http/http.dart' as http;

class BarChartAPI extends StatefulWidget {
  int donorId;
  BarChartAPI(this.donorId);

  @override
  State<BarChartAPI> createState() => _BarChartAPIState();
}

var _tooltipBehavior;

class _BarChartAPIState extends State<BarChartAPI> {
  List<Donations> genders = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    getData();
    _tooltipBehavior = TooltipBehavior(enable: true);
  }

  void getData() async {
    const String url =
        'https://edonations.000webhostapp.com/api-donationhistory.php';
    var data = {'user_id': widget.donorId};

    var result = await http.post(Uri.parse(url), body: jsonEncode(data));

    List<Donations> tempdata = donationsFromJson(result.body);
    setState(() {
      genders = tempdata;
      loading = false;
    });
  }

  _createSampleData() {
    return SfCartesianChart(
        tooltipBehavior: _tooltipBehavior,
        primaryXAxis: CategoryAxis(),
        series: <ChartSeries>[
          LineSeries<Donations, String>(
              enableTooltip: true,
              dataSource: genders,
              xValueMapper: (Donations sales, _) => sales.date.toString(),
              yValueMapper: (Donations sales, _) =>
                  double.parse(sales.quantity))
        ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: loading
            ? CircularProgressIndicator()
            : Container(
                height: 300,
                child: _createSampleData(),
              ),
      ),
    );
  }
}
