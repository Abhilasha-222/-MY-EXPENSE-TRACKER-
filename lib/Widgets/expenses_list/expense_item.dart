import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem(this.expense, {super.key});

  final Expense expense;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      child: Card(
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 10, right: 10),
            child: Text(
              expense.title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 10, bottom: 15),
                child: Text('\$${expense.amount.toStringAsFixed(2)}'),
              ),
              //12.3433 => 12.34 this is done by toStringAsfixed function
              //\$ backward slash dollar won't print the only $ sign will be
              //print there beacuse we want to get print of that before amount
              const Spacer(),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15, bottom: 15),
                    child: Icon(categoryIcons[expense.category]),
                  ),
                  const SizedBox(width: 20),
                  Padding(
                    padding: const EdgeInsets.only(right: 15, bottom: 15),
                    child: Text(expense.formattedDate),
                  ),
                ],
              ),
            ],
          )
        ]),
      ),
    );
  }
}
