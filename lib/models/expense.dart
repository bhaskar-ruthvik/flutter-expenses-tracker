import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat.yMd();

const uuid = Uuid();

enum Category {food,work,travel,leisure}

final categoryIcons = {
  Category.food : Icons.dinner_dining_rounded,
  Category.work: Icons.work_rounded,
  Category.leisure: Icons.pool_rounded,
  Category.travel: Icons.airplanemode_active_rounded,
};

class Expense {
  Expense({required this.title,required this.amount, required this.date,required this.category}): id = uuid.v4();
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  get formattedDate {
    return formatter.format(date);
  }
}