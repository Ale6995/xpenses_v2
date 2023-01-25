import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xpenses_v2/models/incomeModel.dart';

class AddIncomeWidgetController extends GetxController {
  TextEditingController descriptionController = TextEditingController();
  TextEditingController valueController = TextEditingController();
  final addIncomeKey = GlobalKey<FormState>();

  close() {
    descriptionController.clear();
    valueController.clear();
    Get.back();
  }

  add() {
    if (addIncomeKey.currentState!.validate()) {
      Get.back(
          result: IncomeModel(
              description: descriptionController.text,
              value: double.parse(valueController.text),
              date: DateTime.now()));
      descriptionController.clear();
      valueController.clear();
    }
  }

  String? validateDescription(String? value) {
    if (value!.length > 20)
      return 'Description must be less than 20 characters';
    else if (value.isEmpty || value.trim() == "")
      return 'Description can not be empty';
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
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    descriptionController.clear();
    valueController.clear();
  }
}
