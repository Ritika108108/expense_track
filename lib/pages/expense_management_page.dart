import 'package:flutter/material.dart';
import '../models/expense.dart';

class ExpenseManagementPage extends StatefulWidget {
  @override
  _ExpenseManagementPageState createState() => _ExpenseManagementPageState();
}

class _ExpenseManagementPageState extends State<ExpenseManagementPage> {
  List<Expense> expenses = [];

  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _commentsController = TextEditingController();

  void _addExpense() {
    if (_categoryController.text.isEmpty || _amountController.text.isEmpty) {
      return; // Validation check
    }

    setState(() {
      expenses.add(
        Expense(
          category: _categoryController.text,
          amount: double.parse(_amountController.text),
          comments: _commentsController.text,
        ),
      );
    });

    // Clear the input fields
    _categoryController.clear();
    _amountController.clear();
    _commentsController.clear();
  }

  void _editExpense(int index) {
    Expense expense = expenses[index];

    _categoryController.text = expense.category;
    _amountController.text = expense.amount.toString();
    _commentsController.text = expense.comments;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Expense'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _categoryController,
                decoration: InputDecoration(labelText: 'Category'),
              ),
              TextField(
                controller: _amountController,
                decoration: InputDecoration(labelText: 'Amount'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: _commentsController,
                decoration: InputDecoration(labelText: 'Comments'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  expenses[index] = Expense(
                    category: _categoryController.text,
                    amount: double.parse(_amountController.text),
                    comments: _commentsController.text,
                  );
                });
                Navigator.pop(context);
              },
              child: Text('Save'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void _deleteExpense(int index) {
    setState(() {
      expenses.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Expense Management')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: _categoryController,
                  decoration: InputDecoration(labelText: 'Category'),
                ),
                TextField(
                  controller: _amountController,
                  decoration: InputDecoration(labelText: 'Amount'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: _commentsController,
                  decoration: InputDecoration(labelText: 'Comments'),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _addExpense,
                  child: Text('Add Expense'),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: expenses.length,
              itemBuilder: (context, index) {
                Expense expense = expenses[index];
                return Card(
                  child: ListTile(
                    title: Text('${expense.category} - \$${expense.amount}'),
                    subtitle: Text(
                        'Comments: ${expense.comments}\nCreated at: ${expense.createdAt}\nUpdated at: ${expense.updatedAt}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () => _editExpense(index),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () => _deleteExpense(index),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
