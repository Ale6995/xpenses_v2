import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:xpenses_v2/models/incomeModel.dart';
import 'package:xpenses_v2/screens/widgets/addIncomeWidget/addIncomeWidget.dart';

class IncomesScreenController extends GetxController {
  List<IncomeModel> movements = [];
  List<IncomeModel> allMovements = [];
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  double totalIncome = 0;
  bool? ready;
  loadData() async {
    movements.clear();
    firestore
        .collection("Incomes")
        .orderBy('date', descending: true)
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        var val = result.data()["Value"] ?? '0';
        val = double.tryParse(val.toString());
        allMovements.add(IncomeModel(
            description: result.data()["Description"],
            value: val,
            date: result.data()["date"].toDate()));
        if (result
            .data()["date"]
            .toDate()
            .isAfter(DateTime(DateTime.now().year, DateTime.now().month, 1))) {
          movements.add(IncomeModel(
              description: result.data()["Description"],
              value: val,
              date: result.data()["date"].toDate()));
        }
      });
      calculateTotal();
      update();
    });
  }

  addIncome() {
    Get.dialog(AddIncomeWidget()).then((value) {
      if (value != null) {
        firestore.collection("Incomes").add({
          "Description": value.description,
          "Value": value.value,
          "date": value.date,
        }).then((val) {
          movements.insert(0, value);
          allMovements.insert(0, value);
          calculateTotal();
          update();
        });
      }
    });
  }

  calculateTotal() {
    totalIncome = 0;
    movements.forEach((element) {
      totalIncome += element.value;
    });
    print("total income calculated: $totalIncome");
    ready = true;
  }

  @override
  void onInit() {
    loadData();
    super.onInit();
  }
}
