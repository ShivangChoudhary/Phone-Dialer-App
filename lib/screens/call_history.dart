import 'package:flutter/material.dart';

class CallHistoryScreen extends StatelessWidget {
  final List<String> callHistory = [
    "+91 9876543210",
    "+1 2025550123",
    "+44 7550001111"
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: callHistory.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(callHistory[index]),
          trailing: IconButton(
            icon: Icon(Icons.call),
            onPressed: () {
              print('Calling ${callHistory[index]}');
            },
          ),
        );
      },
    );
  }
}
