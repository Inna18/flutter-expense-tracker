import 'package:expense_tracker/widgets/expenses/expenses_list.dart';
import 'package:expense_tracker/widgets/expenses/new_expenses.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';

class Expenses extends StatefulWidget {
  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  List<Expense> expenses = [];

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => NewExpenses(onAddExpense: _addNewExpense),
    );
  }

  void _addNewExpense(Expense newExpense) {
    setState(() {
      expenses.add(newExpense);
    });
  }

  void _removeExpense(Expense removeExpense) {
    final indexOfExpense = expenses.indexOf(removeExpense);

    setState(() {
      expenses.remove(removeExpense);
    });

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(seconds: 3),
      content: const Text("Expense deleted."),
      action: SnackBarAction(
        label: "Undo",
        onPressed: () {
          setState(() {
            expenses.insert(indexOfExpense, removeExpense);
          });
        },
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent =
        const Center(child: Text("Expense list is empty. Start adding some!"));

    if (expenses.isNotEmpty) {
      mainContent = ExpensesList(expenses, _removeExpense);
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Expenses Tracker'),
          actions: [
            IconButton(
                onPressed: _openAddExpenseOverlay, icon: const Icon(Icons.add))
          ],
        ),
        body: Column(
          children: [
            const Text('Expenses Chart'),
            Expanded(child: mainContent)
          ],
        ));
  }
}
