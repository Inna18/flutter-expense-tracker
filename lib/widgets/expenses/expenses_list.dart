import 'package:expense_tracker/widgets/expenses/expense_item.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList(this.expensesList, this.onRemoveExpense, {super.key});

  final void Function(Expense removeExpense) onRemoveExpense;

  final List<Expense> expensesList;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expensesList.length,
      itemBuilder: (context, index) => Dismissible(
          background: Container(
            color: Theme.of(context).colorScheme.error.withOpacity(0.5),
            margin: EdgeInsets.symmetric(
                horizontal: Theme.of(context).cardTheme.margin!.horizontal,
                vertical: 8),
          ),
          key: ValueKey(expensesList[index]),
          onDismissed: (direction) => onRemoveExpense(expensesList[index]),
          direction: DismissDirection.endToStart,
          child: ExpenseItem(expensesList[index])),
    );
  }
}
