import 'package:flutter/material.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('How to play'),
      ),
      body: const Center(
        child: Text('Culpa veniam do enim ipsum aliquip quis laboris mollit.'),
      ),
    );
  }
}
