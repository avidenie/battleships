import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/level.dart';
import 'board.dart';
import 'legend.dart';

class Game extends ConsumerWidget {
  const Game({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final boardWidth = max(
        220.0,
        min((MediaQuery.of(context).size.shortestSide * 0.8).floorToDouble(),
            470.0));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Battleships'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.help),
          )
        ],
      ),
      body: ListView(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Board(boardWidth: boardWidth),
          ),
          const SizedBox(height: 16.0),
          Align(
            alignment: Alignment.topCenter,
            child: Legend(boardWidth: boardWidth),
          ),
          const SizedBox(height: 32.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.ad_units_outlined),
                label: const Text('Show mistakes'),
              ),
              const SizedBox(width: 8.0),
              ElevatedButton(
                onPressed: () {
                  ref.read(levelProvider.notifier).reset();
                },
                child: const Text('Reset'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
