import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expense/models/transcations.dart';
import 'char_bar.dart';

class Chart extends StatelessWidget {
  Chart(this.recentTranscations);

  final List<Transcations> recentTranscations;

  List<Map<String, Object>> get chartTranscation {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      var totalSum = 0.0;
      for (var i = 0; i < recentTranscations.length; i++) {
        if (recentTranscations[i].dateTime.day == weekDay.day &&
            recentTranscations[i].dateTime.month == weekDay.month &&
            recentTranscations[i].dateTime.year == weekDay.year) {
          totalSum += recentTranscations[i].amount;
        }
        print(DateFormat.E().format(weekDay));
        print(totalSum);
      }
      return {
        'day': DateFormat.E().format(weekDay).substring(0, 3),
        'amount': totalSum
      };
    }).reversed.toList();
  }

  double get totalSpending {
    return chartTranscation.fold(0.0, (sum, item) => sum + item['amount']);
  }

  @override
  Widget build(BuildContext context) {
    print(chartTranscation);
    return Card(
        elevation: 6.0,
        margin: EdgeInsets.all(20.0),
        child: Container(
          padding: EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: chartTranscation.map((e) {
              return Flexible(
                fit: FlexFit.tight,
                child: ChartBar(
                  e['day'],
                  e['amount'],
                  totalSpending == 0.0
                      ? 0.0
                      : (e['amount'] as double) / totalSpending,
                ),
              );
            }).toList(),
          ),
        ));
  }
}
