import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:xpenses_v2/models/ExpensesModel.dart';
import 'package:xpenses_v2/models/categoriesModel.dart';

class AddExpenseWidgetController extends GetxController {
  List<CategoryModel> expenceCategories = [];
  TextEditingController descriptionController = TextEditingController();
  TextEditingController valueController = TextEditingController();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final addExpenseKey = GlobalKey<FormState>();
  String? value;
  close() {
    descriptionController.clear();
    valueController.clear();
    value = null;
    Get.back();
  }

  add() {
    if (addExpenseKey.currentState!.validate() && value != null) {
      Get.back(
          result: ExpenseModel(
              description: descriptionController.text,
              category: value!,
              value: double.parse(valueController.text),
              date: DateTime.now()));
      descriptionController.clear();
      valueController.clear();
      value = null;
    }
  }

  saveDropDownValue(String? value) {
    this.value = value;
    update();
  }

  loadcategories() {
    expenceCategories.clear();
    firestore.collection("ExpenseCategories").get().then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        print(result.data());
        var val = result.data()["Value"] ?? '0';
        val = double.tryParse(val.toString());
        expenceCategories.add(CategoryModel(
            alert: result.data()["Alert"],
            category: result.data()["Category"]));
        update();
      });
    });
  }

  String? validateDescription(String? value) {
    if (value!.length > 20)
      return 'Description must be less than 20 characters';
    else if (value.isEmpty || value.trim() == "")
      return 'Description can not be empty';
    else
      return null;
  }

  String? validateCategory(String? value) {
    if (value == null || value == "")
      return 'Category can not be empty';
    else
      return null;
  }

  String? validateValue(dynamic val) {
    if (val == '')
      return 'Value can not be empty';
    else if (val!.length > 9)
      return 'Value must be less than \$ 999999.99';
    else
      return null;
  }

  @override
  void onInit() {
    super.onInit();
    loadcategories();
  }

  @override
  void onClose() {
    super.onClose();
    descriptionController.clear();
    valueController.clear();
    value = null;
  }
}
