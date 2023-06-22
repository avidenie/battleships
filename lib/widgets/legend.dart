import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/ship_type.dart';
import '../providers/level_settings.dart';
import 'ship.dart';

class Legend extends ConsumerWidget {
  const Legend({super.key, required this.boardWidth});

  final double boardWidth;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final levelSettings = ref.watch(levelSettingsProvider);
    final (maxShipSize, maxShipCount) =
        LevelSettings.shipSizes[levelSettings.size]?[0] ?? (0, 0);
    final tileCount = maxShipSize + maxShipCount;
    final minWidth = switch (levelSettings.size) {
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
          ...List.generate(
              LevelSettings.shipSizes[levelSettings.size]?.length ?? 0,
              (index) =>
                  LevelSettings.shipSizes[levelSettings.size]?[index]).map(
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
