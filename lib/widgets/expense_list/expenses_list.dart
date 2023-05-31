import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';
import 'expense_item.dart';

class ExpensesList extends StatelessWidget {
  ExpensesList({super.key, required this.expenses,required this.onRemoveExpense});

  final List<Expense> expenses;
  final void Function(Expense expense) onRemoveExpense; 
  @override
  Widget build(BuildContext context) {
  
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (context, index) => Dismissible(
            key: ValueKey(expenses[index]),
            background: Container(
              color: Theme.of(context).colorScheme.onPrimaryContainer.withOpacity(0.75),
              margin: Theme.of(context).cardTheme.margin,
            ),
            onDismissed: (direction) {onRemoveExpense(expenses[index]);},
            child: ExpenseItem(
              expenses[index],
            ),
          ),
    );
  }
}
