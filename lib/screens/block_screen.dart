import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BlockListScreen extends StatefulWidget {
  @override
  _BlockListScreenState createState() => _BlockListScreenState();
}

class _BlockListScreenState extends State<BlockListScreen> {
  List<String> blockedNumbers = [];

  @override
  void initState() {
    super.initState();
    _loadBlockedNumbers();
  }

  Future<void> _loadBlockedNumbers() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      blockedNumbers = prefs.getStringList('blockedNumbers') ?? [];
    });
  }

  Future<void> _blockNumber(String number) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      blockedNumbers.add(number);
    });
    await prefs.setStringList('blockedNumbers', blockedNumbers);
  }

  Future<void> _unblockNumber(String number) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      blockedNumbers.remove(number);
    });
    await prefs.setStringList('blockedNumbers', blockedNumbers);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Blocked Numbers')),
      body: ListView.builder(
        itemCount: blockedNumbers.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(blockedNumbers[index]),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => _unblockNumber(blockedNumbers[index]),
            ),
          );
        },
      ),
    );
  }
}
