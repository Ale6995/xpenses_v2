import 'package:flutter/material.dart';
import 'package:money2/money2.dart';
import 'package:xpenses_v2/models/ExpensesModel.dart';

class ExpensesCard extends StatelessWidget {
  final ExpenseModel expense;

  const ExpensesCard({
    Key? key,
    required this.expense,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).cardColor,
      child: ListTile(
        title: Text(
            "${expense.description}: ${Money.from(expense.value, code: CommonCurrencies().cad.code)} ${expense.category}"),
        leading: Icon(Icons.credit_card),
      ),
    );
  }
}
