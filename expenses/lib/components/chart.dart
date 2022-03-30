import 'package:expenses/components/chart_bar.dart';
import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  const Chart(this.recentTransaction, {Key? key}) : super(key: key);

  // last 7 days transactions
  final List<Transaction> recentTransaction;

  List<Map<String, Object>> get groupTransactions {
    return List.generate(7, (index) {
      // dynamic get to all days of week use with reference the current day
      final weekDay = DateTime.now().subtract(Duration(days: index));
      // get first letter of the day
      final dayChar = DateFormat.E().format(weekDay)[0];
      // total spent in day
      double totalSum = 0.0;
      for (var i = 0; i < recentTransaction.length; i++) {
        // because week day controll the last seven days we dont need to add more conditions to ensure that
        bool sameDayMonthYear =
            (recentTransaction[i].date.day == weekDay.day) &&
                (recentTransaction[i].date.month == weekDay.month) &&
                (recentTransaction[i].date.year == weekDay.year);
        if (sameDayMonthYear) {
          totalSum += recentTransaction[i].value;
        }
      }
      return {'day': dayChar, 'value': totalSum};
    }).reversed.toList();
  }

  get _weekTotalValue {
    return groupTransactions.fold(0.0, (acc, tr) {
      return (acc as double) + (tr['value'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupTransactions
              .map((tr) => Flexible(
                    fit: FlexFit.tight, // same size to all values
                    child: ChartBar(
                        tr['day'].toString(),
                        double.parse(tr['value'].toString()),
                        _weekTotalValue == 0 ? 0 : (tr['value'] as double) / _weekTotalValue),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
