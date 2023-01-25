import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:money2/money2.dart';
import 'package:xpenses_v2/screens/incomes/incomesScreenController.dart';
import 'package:xpenses_v2/screens/widgets/IncomeCard.dart';

class IncomesScreen extends StatelessWidget {
  IncomesScreenController controller = Get.find<IncomesScreenController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<IncomesScreenController>(
        builder: (controller) => Column(
            // alignment: Alignment.center,
            children: [
              controller.movements.length == 0
                  ? Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        child: AutoSizeText(
                          "No incomes reported",
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
                                return IncomeCard(
                                  income: controller.movements[index],
                                );
                              }),
                        ),
                      ),
                    ),
              Container(
                height: 45,
                color: Colors.blue[100],
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                alignment: Alignment.centerLeft,
                child: AutoSizeText(
                  'Total Incomes: ' +
                      Money.from(controller.totalIncome,
                              code: CommonCurrencies().cad.code)
                          .toString(),
                  style: TextStyle(fontSize: 18),
                ),
              )
            ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.addIncome();
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.grey[500],
      ),
    );
  }
}
