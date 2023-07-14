import 'package:expense_tracker/widgets/expense_item.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/new_expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _dummyExpenses = [
    Expense(
      title: 'Flutter Course',
      amount: 19.99,
      date: DateTime.now(),
      category: Category.work,
    ),
    Expense(
      title: 'Cinema',
      amount: 15.69,
      date: DateTime.now(),
      category: Category.leisure,
    ),
  ];

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      isScrollControlled:
          true, // when input value, the pop up screen will occupied whole screen
      context: context,
      builder: (ctx) => NewExpense(
        onAddExepense: _addExpense,
      ),
    );
    // context 是 Expense widget 的 context (metadata of the widget and the position in the widget tree)
    // ctx 是 bottomsheet的context
  }

  void _addExpense(Expense expense) {
    setState(() {
      _dummyExpenses.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    setState(() {
      _dummyExpenses.remove(expense);
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent =
        const Center(child: Text('No expense found. Start adding some!'));

    if (_dummyExpenses.isNotEmpty) {
      ListView.builder(
        itemCount: _dummyExpenses.length,
        itemBuilder: ((context, index) => Dismissible(
            //key: make the widget uniquely identifiable
            key: ValueKey(_dummyExpenses[index]),
            // onDismissed make sure the internal data also removed, instead of visually
            onDismissed: (direction) {
              _removeExpense(_dummyExpenses[index]);
            },
            child: ExpenseItem(_dummyExpenses[index]))),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Expense Tracker'),
        actions: [
          IconButton(onPressed: _openAddExpenseOverlay, icon: Icon(Icons.add)),
        ],
      ),
      body: Column(
        children: [
          const Text('chart'),
          // ListView is scrollable by default, normally used in unknown length list
          // ListView.builder create the list item on demand instead of create all the list item at once (Column)
          // function of the itemBuilder will be called for each widget create
          Expanded(
            // use Expanded to solve the list inside a column problem)
            child: mainContent,
          ),
        ],
      ),
    );
  }
}
