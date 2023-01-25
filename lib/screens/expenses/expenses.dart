import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money2/money2.dart';
import 'package:xpenses_v2/screens/expenses/expensesController.dart';
import 'package:xpenses_v2/screens/widgets/expenseCard.dart';

class Expenses extends StatelessWidget {
  ExpensesController controller = Get.find<ExpensesController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<ExpensesController>(
        builder: (controller) => Column(
            // alignment: Alignment.center,

            children: [
              controller.movements.length == 0
                  ? Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        child: AutoSizeText(
                          "No expenses reported",
                          style:
                              TextStyle(color: Colors.grey[800], fontSize: 30),
                        ),
                      ),
                    )
                  : Expanded(
                      child: RefreshIndicator(
                        onRefresh: () => controller.loadData(),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 5),
                          child: ListView.builder(
                              itemCount: controller.movements.length,
                              itemBuilder: (context, index) {
                                return ExpensesCard(
                                  expense: controller.movements[index],
                                );
                              }),
                        ),
                      ),
                    ),
              Container(
                height: 45,
                color: Theme.of(context).highlightColor,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                alignment: Alignment.centerLeft,
                child: AutoSizeText(
                  'Total Expenses: ${Money.from(controller.total, code: CommonCurrencies().cad.code)}',
                  style: TextStyle(fontSize: 18),
                ),
              )
            ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.addExpense();
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.grey[500],
      ),
    );
  }
}
