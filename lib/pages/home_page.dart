import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home")),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Handle any logic you want to add here
            print("Navigating to Expenses List");
          },
          child: Text('Go to Expenses'),
        ),
      ),
    );
  }
}
