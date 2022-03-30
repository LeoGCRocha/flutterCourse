import 'package:flutter/material.dart';
import '../models/transaction.dart';
import './transaction_item.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final void Function(String id) onRemove;

  const TransactionList(this.transactions, this.onRemove, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: sized_box_for_whitespace
    return transactions.isEmpty
        // add image if dont have any transaction
        ? LayoutBuilder(builder: (context, constraints) {
            return Column(
              children: [
                const SizedBox(height: 20),
                Text(
                  'Nenhuma transação cadastrada.',
                  style: Theme.of(context).textTheme.headline6,
                ),
                const SizedBox(
                  height: 20,
                ),
                // ignore: sized_box_for_whitespace
                Container(
                  height: constraints.maxHeight * 0.6,
                  child: Image.asset(
                    'assets/images/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            );
          })
        : ListView(
            children: transactions.map((tr) {
            return TransactionItem(
              tr: tr,
              onRemove: onRemove,
              key: ValueKey(tr.id), // TO SOLVE PROBLEM WITH LIST
            );
          }).toList());
    // : ListView.builder(
    //     itemCount: transactions.length,
    //     itemBuilder: (ctx, index) {
    //       final tr = transactions[index];
    //       return TransactionItem(tr: tr, onRemove: onRemove, key: GlobalObjecttKey(tr),); // NOT EFFICIENTE SEARCH FOR ALL TREE
    //     },
    //   );
  }
}
