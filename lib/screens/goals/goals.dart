import 'package:fl_chart/fl_chart.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:money2/money2.dart';
import 'package:xpenses_v2/screens/goals/goalsController.dart';

class GoalsScreen extends StatelessWidget {
  GoalsController controller = Get.find<GoalsController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<GoalsController>(
        builder: (controller) => Column(
          children: [
            Expanded(
              child: ListView(
                shrinkWrap: true,
                children: [
                  Container(
                    margin: EdgeInsets.all(10),
                    height: 220,
                    padding: EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                        color: Theme.of(context).backgroundColor,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black38,
                              offset: Offset(0, 3),
                              blurRadius: 5,
                              spreadRadius: 5)
                        ]),
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SummaryCard(
                            tittle: "Incomes",
                            total: controller.totalIncomes,
                            current: controller.currentIncomes),
                        SummaryCard(
                            tittle: "Expenses",
                            total: controller.totalExpenses,
                            current: controller.currentExpenses),
                        SummaryCard(
                            tittle: "Savings",
                            total: controller.totalSavings,
                            current: controller.currentSavings),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                        color: Theme.of(context).backgroundColor,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black38,
                              offset: Offset(0, 3),
                              blurRadius: 5,
                              spreadRadius: 5)
                        ]),
                    child: Column(
                      children: [
                        AspectRatio(
                          aspectRatio: 1.2,
                          child: Stack(
                            children: [
                              PieChart(
                                PieChartData(
                                  sections: [
                                    PieChartSectionData(
                                      color: Theme.of(context)
                                          .secondaryHeaderColor,
                                      value: controller.totalSavings.isNegative
                                          ? 0
                                          : controller.totalSavings,
                                      title: Money.from(controller.totalSavings,
                                              code: CommonCurrencies().cad.code)
                                          .toString(),
                                      radius: 50,
                                      titlePositionPercentageOffset: 1,
                                      titleStyle: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                    PieChartSectionData(
                                      color: Theme.of(context).accentColor,
                                      value: controller.ourGoal.value == 0
                                          ? 1
                                          : controller.ourGoal.value,
                                      title: Money.from(
                                              controller.ourGoal.value,
                                              code: CommonCurrencies().cad.code)
                                          .toString(),
                                      titlePositionPercentageOffset: 1,
                                      radius: 50,
                                      titleStyle: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    )
                                  ],
                                  sectionsSpace: 0,
                                  centerSpaceRadius: 80,
                                ),
                              ),
                              Center(
                                child: AutoSizeText('GOALS ' +
                                    controller.ourGoal.value.toString()),
                              )
                            ],
                          ),
                        ),
                        ListTile(
                          leading: Bullets(),
                          title: Text('You must save ' +
                              Money.from(controller.savingsDays,
                                      code: CommonCurrencies().cad.code)
                                  .toString() +
                              ' per day.'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: SpeedDial(
        marginEnd: 18,
        marginBottom: 20,
        icon: Icons.add,
        activeIcon: Icons.remove,
        buttonSize: 56.0,
        visible: true,
        closeManually: false,
        renderOverlay: false,
        curve: Curves.bounceIn,
        overlayOpacity: 0,
        onOpen: () => print('OPENING DIAL'),
        onClose: () => print('DIAL CLOSED'),
        tooltip: 'Speed Dial',
        heroTag: 'speed-dial-hero-tag',
        backgroundColor: Colors.grey[500],
        foregroundColor: Colors.white,
        elevation: 8.0,
        shape: CircleBorder(),
        children: [
          SpeedDialChild(
            child: Container(
              margin: EdgeInsets.all(5),
              child: Image.asset(
                'images/savingsOff.png',
              ),
            ),
            backgroundColor: Colors.purple,
            label: 'Add Goals',
            labelStyle: TextStyle(fontSize: 18.0),
            onTap: () => controller.addGoals(),
          ),
          SpeedDialChild(
            child: Container(
              margin: EdgeInsets.all(5),
              child: Image.asset(
                'images/incomesOff.png',
              ),
            ),
            backgroundColor: Colors.blue,
            label: 'Add Incomes',
            labelStyle: TextStyle(fontSize: 18.0),
            onTap: () => controller.incomesController.addIncome(),
          ),
          SpeedDialChild(
            child: Container(
              margin: EdgeInsets.all(5),
              child: Image.asset(
                'images/expensesOff.png',
              ),
            ),
            backgroundColor: Colors.blue[100],
            label: 'Add Expenses',
            labelStyle: TextStyle(fontSize: 18.0),
            onTap: () => controller.expensesController.addExpense(),
          ),
        ],
      ),
    );
  }
}

class Bullets extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
      height: 20.0,
      width: 20.0,
      decoration: new BoxDecoration(
        color: Colors.blue[100],
        shape: BoxShape.circle,
      ),
    );
  }
}

class SummaryCard extends StatelessWidget {
  final double total;
  final double current;
  final String tittle;
  const SummaryCard(
      {Key? key,
      required this.tittle,
      required this.total,
      required this.current})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).backgroundColor,
      margin: EdgeInsets.all(5),
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Container(
        width: 140,
        // padding: EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
                height: 35,
                margin: EdgeInsets.only(bottom: 5),
                decoration: BoxDecoration(
                    color: Theme.of(context).highlightColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10))),
                alignment: Alignment.center,
                padding: EdgeInsets.all(5),
                child: AutoSizeText(tittle)),
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.blue[100]!,
                    ),
                    borderRadius: BorderRadius.circular(10)),
                padding: EdgeInsets.all(5),
                alignment: Alignment.center,
                child: Wrap(
                  alignment: WrapAlignment.center,
                  children: [
                    AutoSizeText(
                      'total ' + tittle.toLowerCase(),
                      maxLines: 2,
                      textAlign: TextAlign.center,
                    ),
                    AutoSizeText(
                      Money.from(total, code: CommonCurrencies().cad.code)
                          .toString(),
                      maxLines: 1,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.blue[100]!,
                    ),
                    borderRadius: BorderRadius.circular(10)),
                padding: EdgeInsets.all(5),
                alignment: Alignment.center,
                child: Wrap(
                  alignment: WrapAlignment.center,
                  children: [
                    AutoSizeText(
                      'current ' + tittle.toLowerCase(),
                      maxLines: 2,
                      textAlign: TextAlign.center,
                    ),
                    AutoSizeText(
                      Money.from(current, code: CommonCurrencies().cad.code)
                          .toString(),
                      maxLines: 1,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
