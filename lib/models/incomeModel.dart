// import 'package:cloud_firestore/cloud_firestore.dart';

class IncomeModel {
  final String description;
  final double value;
  final DateTime date;

  const IncomeModel({
    required this.description,
    required this.date,
    required this.value,
  }) : super();
}
