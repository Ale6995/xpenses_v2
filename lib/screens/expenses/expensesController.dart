import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:xpenses_v2/models/ExpensesModel.dart';
import 'package:xpenses_v2/screens/widgets/addExpenseWidget/addExpenseWidget.dart';

class ExpensesController extends GetxController {
  List<ExpenseModel> movements = [];
  List<ExpenseModel> allMovements = [];
  late double total;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  loadData() async {
    movements.clear();
    firestore
        .collection("Expenses")
        // .where("date",
        //     isGreaterThan: Timestamp.fromDate(
        //         DateTime(DateTime.now().year, DateTime.now().month, 1)))
        .orderBy('date', descending: true)
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        print(result.data());
        var val = result.data()["Value"] ?? '0';
        val = double.tryParse(val.toString());
        allMovements.add(ExpenseModel(
            description: result.data()["Description"],
            value: val,
            category: result.data()["Category"],
            date: result.data()["date"].toDate()));

        if (result
            .data()["date"]
            .toDate()
            .isAfter(DateTime(DateTime.now().year, DateTime.now().month, 1))) {
          movements.add(ExpenseModel(
              description: result.data()["Description"],
              value: val,
              category: result.data()["Category"],
              date: result.data()["date"].toDate()));
        }
      });
      totalExpenses();
      update();
    });
  }

  addExpense() {
    Get.dialog(AddExpenseWidget()).then((value) {
      if (value != null) {
        firestore.collection("Expenses").add({
          "Description": value.description,
          "Value": value.value,
          "Category": value.category,
          "date": DateTime.now(),
        }).then((val) {
          movements.insert(0, value);
          allMovements.insert(0, value);
          totalExpenses();
          update();
        });
      }
    });
  }

  totalExpenses() {
    total = 0;
    movements.forEach((element) {
      total += element.value;
    });
  }

  @override
  void onInit() {
    loadData();
    super.onInit();
  }
}
