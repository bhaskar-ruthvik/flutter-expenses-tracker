import 'package:expense_tracker/widgets/expense_list/expenses_list.dart';
import 'package:expense_tracker/widgets/overlay_screen.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
        title: 'Flutter Course',
        amount: 399,
        date: DateTime.now(),
        category: Category.work),
    Expense(
        title: 'Spiderman: Across the Spiderverse',
        amount: 328.56,
        date: DateTime.now(),
        category: Category.leisure),
  ];
  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).showSnackBar(
       SnackBar(
        content: const Text('Expense Deleted'),
        action: SnackBarAction(label: 'Undo', onPressed: (){
          setState(() {
            _registeredExpenses.insert(expenseIndex, expense);
          });
        })
      ),
    );
  }

  void _respondToClick() {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (ctx) => OverlayScreen(_addExpense));
  }

  @override
  Widget build(context) {
    Widget mainContent = const Padding(
      padding: EdgeInsets.all(40),
      child: Center(
        child: Text(
          'Sorry, no expense data as of now. Click on the + button to add expenses',
          textAlign: TextAlign.center,
        ),
      ),
    );
    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: _registeredExpenses,
        onRemoveExpense: _removeExpense,
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Expenses Tracker'),
        actions: [
          IconButton(
            onPressed: _respondToClick,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            const Text('Expenses Graph'),
            Expanded(child: mainContent),
          ],
        ),
      ),
    );
  }
}
