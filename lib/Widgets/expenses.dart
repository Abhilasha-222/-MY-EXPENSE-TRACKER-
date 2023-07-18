import 'package:flutter/material.dart';

import 'package:expense_tracker/Widgets/expenses_list/expenses_list.dart';
import 'package:expense_tracker/Widgets/new_expense.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/Widgets/charts/chart.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
        title: 'College',
        amount: 205.0,
        date: DateTime.now(),
        category: Category.Work),
    Expense(
        title: 'Hotel',
        amount: 150.0,
        date: DateTime.now(),
        category: Category.Food),
    Expense(
        title: 'Country',
        amount: 20.0,
        date: DateTime.now(),
        category: Category.Travel),
  ];

  void _addExpense() {
    showModalBottomSheet(
      useSafeArea: true,
      /*built in feacture in flutter that makes sure that we stay away 
      from devices features like camera that might affecting our UI 
       and the widget like scaffold use this safe area concept automatically that
        why when we create first page it automatically safe from that */
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpense(onAddExpense: _addNewExpense),
    );
  }

  void _addNewExpense(Expense expense) {
    setState(
      () {
        _registeredExpenses.add(expense);
      },
    );
  }

  void _removeExpense(Expense expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);
    setState(
      () {
        _registeredExpenses.remove(expense);
      },
    );
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text('Expense deleted.'),
        action: SnackBarAction(
            label: 'Undo',
            onPressed: () {
              setState(() {
                _registeredExpenses.insert(expenseIndex, expense);
              });
            }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    Widget mainContent = const Center(
      child: Text('No expenses found. Start adding some!'),
    );

    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: _registeredExpenses,
        onRemoveExpense: _removeExpense,
      );
    }

    return Scaffold(
      //Toolbar with the add button '+' => Row()
      appBar: AppBar(title: const Text('Flutter Expense Tracker'), actions: [
        IconButton(onPressed: _addExpense, icon: const Icon(Icons.add))
      ]),
      body: width < 600
          ? Column(
              children: [
                Chart(expenses: _registeredExpenses),
                Expanded(
                  child: mainContent,
                ),
              ],
            )
          : Row(children: [
              Expanded(
                child: Chart(expenses: _registeredExpenses),
              ),
              Expanded(
                child: mainContent,
              ),
            ]),
    );
  }
}
