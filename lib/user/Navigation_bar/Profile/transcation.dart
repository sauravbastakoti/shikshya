import 'package:flutter/material.dart';

class Transaction_history extends StatefulWidget {
  const Transaction_history({super.key});

  @override
  State<Transaction_history> createState() => _Transaction_historyState();
}

class _Transaction_historyState extends State<Transaction_history> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Transaction History"),
      ),
    );
  }
}
