import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';

class NewExpenses extends StatefulWidget {
  const NewExpenses({super.key, required this.onAddExpense});

  final void Function(Expense newExpense) onAddExpense;

  @override
  State<StatefulWidget> createState() {
    return _NewExpensesState();
  }
}

class _NewExpensesState extends State<NewExpenses> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.leisure;

  void _presentDatePicker() async {
    var now = DateTime.now();
    final pickedDate = await showDatePicker(
        context: context,
        firstDate: DateTime(now.year, now.month - 1, now.day),
        lastDate: now);

    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _saveExpense() {
    final enteredAmount = double.tryParse(_amountController.text);
    final amountIsInvalid = enteredAmount == null || enteredAmount < 0;

    if (_titleController.text.trim().isEmpty ||
        amountIsInvalid ||
        _selectedDate == null) {
      showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: const Text("Invalid Input"),
                content: const Text(
                    "Please make sure a valid title, amount, category and date were entered..."),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.pop(ctx),
                      child: const Text("Ok"))
                ],
              ));
      return;
    } else {
      final newExpense = Expense(
          title: _titleController.text,
          amount: double.parse(_amountController.text),
          category: _selectedCategory,
          date: _selectedDate!);
      widget.onAddExpense(newExpense);
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  "Add Expense",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              )
            ],
          ),
          TextField(
            maxLength: 50,
            decoration: const InputDecoration(
              label: Text("Title"),
            ),
            controller: _titleController,
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      prefixText: "\$ ", label: Text("Amount")),
                  controller: _amountController,
                ),
              ),
              Expanded(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(_selectedDate == null
                      ? "Selected Date"
                      : formatter.format(_selectedDate!)),
                  IconButton(
                      onPressed: _presentDatePicker,
                      icon: const Icon(Icons.calendar_month))
                ],
              ))
            ],
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: DropdownButton(
                    value: _selectedCategory,
                    items: Category.values
                        .map((category) => DropdownMenuItem(
                              value: category,
                              child: Text(
                                  '${category.name[0].toUpperCase()}${category.name.substring(1)}'),
                            ))
                        .toList(),
                    onChanged: (value) {
                      if (value == null) {
                        return;
                      } else {
                        setState(() {
                          _selectedCategory = value;
                        });
                      }
                    }),
              ),
            ],
          ),
          Row(
            children: [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text("Cancel")),
              const Spacer(flex: 1),
              ElevatedButton(
                  onPressed: _saveExpense, child: Text("Save Expense")),
            ],
          )
        ],
      ),
    );
  }
}
