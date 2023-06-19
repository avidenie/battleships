import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/game.dart';
import '../providers/level.dart';
import 'ship.dart';

class Legend extends ConsumerWidget {
  const Legend({super.key, required this.boardWidth});

  final double boardWidth;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameData = ref.watch(gameProvider);
    final level = ref.watch(levelProvider);
    final (maxShipSize, maxShipCount) =
        gameData.shipSizes[level.size]?[0] ?? (0, 0);
    final tileCount = maxShipSize + maxShipCount;
    final minWidth = switch (level.size) {
      15 => 30.0,
      12 => 30.0,
      10 => 30.0,
      _ => 40.0,
    };
    final tileWidth = min(minWidth, boardWidth / tileCount);

    return SizedBox(
      width: tileWidth * tileCount,
      child: Column(
        children: [
          ...List.generate(gameData.shipSizes[level.size]?.length ?? 0,
              (index) => gameData.shipSizes[level.size]?[index]).map(
            (shipSize) => shipSize != null
                ? Padding(
                    padding: const EdgeInsets.only(bottom: 4.0),
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ...List.generate(
                          shipSize.$1,
                          (index) => SizedBox(
                            width: tileWidth,
                            height: tileWidth,
                            child: Ship(
                              type: index == 0
                                  ? (shipSize.$1 == 1
                                      ? ShipType.single
                                      : ShipType.left)
                                  : index == shipSize.$1 - 1
                                      ? ShipType.right
                                      : (shipSize.$1 == 1
                                          ? ShipType.single
                                          : ShipType.middle),
                              child: index == 0
                                  ? Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        shipSize.$2.toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall
                                            ?.copyWith(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onPrimary),
                                      ),
                                    )
                                  : null,
                            ),
                          ),
                        ),
                        ...List.generate(
                          shipSize.$2,
                          (index) => _Found(
                            found: false,
                            size: tileWidth,
                          ),
                        )
                      ],
                    ),
                  )
                : const SizedBox(),
          ),
        ],
      ),
    );
  }
}

class _Found extends StatelessWidget {
  const _Found({required this.found, required this.size});

  final bool found;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: SizedBox(
        width: size - 8.0,
        height: size - 8.0,
        child: Padding(
          padding: const EdgeInsets.all(1.0),
          child: Container(
            decoration: BoxDecoration(border: Border.all(width: 1.0)),
            child: found
                ? const Icon(
                    Icons.check_rounded,
                    size: 20.0,
                    color: Colors.green,
                  )
                : null,
          ),
        ),
      ),
    );
  }
}
