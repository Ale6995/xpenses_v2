import 'package:get/get.dart';
import 'package:money2/money2.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:xpenses_v2/models/goalModel.dart';
import 'package:xpenses_v2/screens/expenses/expensesController.dart';
import 'package:xpenses_v2/screens/incomes/incomesScreenController.dart';
import 'package:xpenses_v2/screens/widgets/addGoalWidget/addGoalWidget.dart';

class GoalsController extends GetxController {
  GoalModel ourGoal =
      GoalModel(description: '', date: DateTime(1900), value: 0);
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  ExpensesController expensesController = Get.find<ExpensesController>();
  IncomesScreenController incomesController =
      Get.find<IncomesScreenController>();

  double totalIncomes = 0;
  double currentIncomes = 0;
  double totalExpenses = 0;
  double currentExpenses = 0;
  double totalSavings = 0;
  double currentSavings = 0;
  double savingsDays = 0;

  loadData() async {
    firestore
        .collection("Goals")
        .orderBy('date', descending: true)
        .get()
        .then((querySnapshot) {
      print(querySnapshot.docs[0].data().toString());
      try {
        ourGoal = GoalModel(
            description: querySnapshot.docs[0].data()['description'],
            date: querySnapshot.docs[0].data()['date'].toDate(),
            value: querySnapshot.docs[0].data()['value']);
      } catch (e) {
        print(e);
      }
      ;
      update();
    });
  }

  addGoals() {
    Get.dialog(AddGoalWidget()).then((value) {
      if (value != null) {
        firestore.collection("Goals").add({
          "description": value.description,
          "value": value.value,
          "date": value.date,
        }).then((val) {
          ourGoal = value!;
        });
        update();
      }
    });
  }

  Currency currency = Currency.create("\$", 2);
  calculateValues() {
    incomesController.addListener(() {
      if (this.totalIncomes != incomesController.totalIncome) {
        currentIncomes = incomesController.totalIncome;
        totalIncomes = 0;
        incomesController.allMovements
            .forEach((element) => this.totalIncomes += element.value);
        calculateSavings();
        update();
      }
    });
    expensesController.addListener(() {
      if (totalExpenses != expensesController.total) {
        currentExpenses = expensesController.total;
        totalExpenses = 0;
        expensesController.allMovements
            .forEach((element) => this.totalExpenses += element.value);
        calculateSavings();
        update();
      }
    });
  }

  calculateSavings() {
    totalSavings = totalIncomes - totalExpenses;
    currentSavings = currentIncomes - currentExpenses;
    int daysUntilGoalFinish = ourGoal.date.difference(DateTime.now()).inDays;
    savingsDays = (ourGoal.value - totalSavings) / daysUntilGoalFinish;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    loadData();
    calculateValues();
  }
}
