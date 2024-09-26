import 'package:flutter/material.dart';

class Videoediting extends StatefulWidget {
  const Videoediting({super.key});

  @override
  State<Videoediting> createState() => _VideoeditingState();
}

class _VideoeditingState extends State<Videoediting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Video Editing"),
      ),
    );
  }
}
