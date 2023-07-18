import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat.yMd(); //intl package
const uuid = Uuid();

// ignore: constant_identifier_names
enum Category { Food, Travel, Leisure, Work }

const categoryIcons = {
  Category.Food: Icons.lunch_dining,
  Category.Travel: Icons.flight_takeoff,
  Category.Work: Icons.work,
  Category.Leisure: Icons.movie,
};

//this class wouldnot be a widget so we wouldont set statefull or stateless widget in it.
class Expense {
  Expense({
    //constructor function
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid.v4(); //we use V4 which generate unique string Id and assign
  //it as an initial value to the ID property we donot add id as a argument beacuse we want to build such a
  // unique ID dynamically whenever a new expense object is created. And to do that, we'll use a third party package,the UUID package,
  //which can install into Flutter project in terminal by command on pub.dev installing UUid
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category; //catogory of expenses

  String get formattedDate {
//formatting date manually in dart is quite cumbersome and for that reason we will use Intl package it is quite powerful package that can help with the
//localization also and date formatting
    return formatter.format(date);
  }
}

class ExpenseBucket {
  const ExpenseBucket({
    required this.category,
    required this.expenses,
  });

  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category)
      : expenses = allExpenses
            .where((expense) => expense.category == category)
            .toList(); //adding additional consrtuctor function
  //where function that allow to filter a list it takes a function as an argument

  final Category category;
  final List<Expense> expenses;

  double get totalExpense {
    double sum = 0;

    for (final expense in expenses) {
      sum += expense.amount;
    }
    return sum;
  }
}
