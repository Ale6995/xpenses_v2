import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:xpenses_v2/models/goalModel.dart';

class AddGoalWidgetController extends GetxController {
  TextEditingController descriptionController = TextEditingController();
  TextEditingController valueController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  String? value;
  close() {
    descriptionController.clear();
    valueController.clear();

    Get.back();
  }

  add() {
    Get.back(
      result: GoalModel(
        description: descriptionController.text,
        value: double.parse(valueController.text),
        date: selectedDate,
      ),
    );
    descriptionController.clear();
    valueController.clear();
  }

  selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate, // Refer step 1
        firstDate: DateTime(2000),
        lastDate: DateTime(2025),
        helpText: 'Select date for goal');
    if (picked != null && picked != selectedDate) selectedDate = picked;
    update();
  }

  saveDropDownValue(String? value) {
    this.value = value;
    update();
  }

  @override
  void onInit() {
    super.onInit();
  }
}
