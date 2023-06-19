import 'package:flutter/material.dart';

import '../routing/routes.dart';

class ChooseScreen extends StatelessWidget {
  const ChooseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Choose ...')),
      body: ConstrainedBox(
        constraints: const BoxConstraints.expand(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Size', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8.0),
            ChoiceChip(
              label: const Text('6x6'),
              selected: true,
              onSelected: (bool selected) {
                // todo
              },
            ),
            ChoiceChip(
              label: const Text('8x8'),
              selected: false,
              onSelected: (bool selected) {
                // todo
              },
            ),
            ChoiceChip(
              label: const Text('10x10'),
              selected: false,
              onSelected: (bool selected) {
                // todo
              },
            ),
            ChoiceChip(
              label: const Text('12x12'),
              selected: false,
              onSelected: (bool selected) {
                // todo
              },
            ),
            ChoiceChip(
              label: const Text('15x15'),
              selected: false,
              onSelected: (bool selected) {
                // todo
              },
            ),
            const SizedBox(height: 16.0),
            Text('Difficulty', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8.0),
            ChoiceChip(
              label: const Text('Normal'),
              selected: true,
              onSelected: (bool selected) {
                // todo
              },
            ),
            ChoiceChip(
              label: const Text('Hard'),
              selected: false,
              onSelected: (bool selected) {
                // todo
              },
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                const GameRoute().go(context);
              },
              child: const Text('Play'),
            )
          ],
        ),
      ),
    );
  }
}
