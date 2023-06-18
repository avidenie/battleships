import 'package:flutter/material.dart';

import 'board.dart';

class Game extends StatelessWidget {
  const Game({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Battleships')),
      body: const Padding(
        padding: EdgeInsets.only(top: 16.0),
        child: Align(
          alignment: Alignment.topCenter,
          child: Board(),
        ),
      ),
    );
  }
}
