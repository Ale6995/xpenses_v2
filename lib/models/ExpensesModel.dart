// import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String value;
  final int priority;

  const Message({required this.value, this.priority = -1}) : super();
}

class ExpenseModel {
  final String description;
  final double value;
  final DateTime date;
  final String category;

  const ExpenseModel({
    required this.description,
    required this.date,
    required this.value,
    required this.category,
  }) : super();
}
