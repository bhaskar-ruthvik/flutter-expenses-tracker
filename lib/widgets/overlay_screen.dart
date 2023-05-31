import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';

class OverlayScreen extends StatefulWidget {
  const OverlayScreen(this.addExpense,{super.key});
  final void Function(Expense expense) addExpense;
  @override
  State<OverlayScreen> createState() {
    return _OverlayScreenState();
  }
}

class _OverlayScreenState extends State<OverlayScreen> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _pickedDate;
  Category selectedCategory = Category.leisure;
  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _datePickerFunc() async {
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1100),
      lastDate: DateTime.now(),
    );
    setState(() {
      _pickedDate = selectedDate;
    });
  }

  void _saveExpense() {
    final amount = double.tryParse(_amountController.text);
    final amountIsNull = amount == null || amount <= 0;

    if (_titleController.text.trim().isEmpty ||
        amountIsNull ||
        _pickedDate == null) {
      showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              title: const Text('Attention'),
              content: const Text(
                  'Please ensure that you enter a valid date, title and amount'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(ctx);
                  },
                  child: const Text('Okay'),
                )
              ],
            );
          });
      return;
    }
    else{
      Expense toSave = Expense(amount: amount,title: _titleController.text, category: selectedCategory, date: _pickedDate!);
      widget.addExpense(toSave);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16,40,16,20),
      child: Column(
        children: [
          TextField(
            controller: _titleController,
            maxLength: 50,
            decoration: const InputDecoration(
              label: Text('Title'),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    prefixText: 'Rs.',
                    label: Text('Amount'),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(_pickedDate == null
                        ? 'Selected Date'
                        : formatter.format(_pickedDate!).toString()),
                    IconButton(
                        onPressed: _datePickerFunc,
                        icon: const Icon(Icons.calendar_month))
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          Row(
            children: [
              DropdownMenu(
                initialSelection: selectedCategory,
                onSelected: (value) {
                  if (value == null) {
                    return;
                  } else {
                    setState(() {
                      selectedCategory = value;
                    });
                  }
                },
                dropdownMenuEntries: Category.values
                    .map(
                      (e) => DropdownMenuEntry(
                        value: e,
                        label: e.name.toUpperCase(),
                      ),
                    )
                    .toList(),
              ),
              const Spacer(),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                  onPressed: (){
              _saveExpense();
              Navigator.pop(context);
                  }, child: const Text('Save Expense')),
            ],
          )
        ],
      ),
    );
  }
}
