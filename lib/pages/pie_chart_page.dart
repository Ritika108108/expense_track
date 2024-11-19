import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class PieChartPage extends StatelessWidget {
  final List<charts.Series> seriesList = [
    charts.Series(
      id: 'Expenses',
      domainFn: (expense, _) => expense.category,
      measureFn: (expense, _) => expense.amount,
      data: [
        Expense('Food', 200),
        Expense('Transport', 150),
        Expense('Entertainment', 100),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Pie Chart")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: charts.PieChart(seriesList),
      ),
    );
  }
}

class Expense {
  final String category;
  final int amount;

  Expense(this.category, this.amount);
}
