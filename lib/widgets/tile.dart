import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/tile_controller.dart';
import '../models/tile_state.dart';
import '../providers/level.dart';

class Tile extends ConsumerWidget {
  const Tile({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tileState = ref.watch(tileControllerProvider(index: index));

    return Material(
      color:
          tileState.current != TileType.none ? Colors.lightBlue : Colors.white,
      child: tileState.isClue
          ? _TileContent(index: index)
          : InkWell(
              splashFactory: tileState.current == TileType.none
                  ? InkSplash.splashFactory
                  : NoSplash.splashFactory,
              splashColor: Colors.lightBlue,
              onTap: () {
                Future.delayed(const Duration(milliseconds: 50), () {
                  ref
                      .read(tileControllerProvider(index: index).notifier)
                      .onTap();
                });
              },
              onLongPress: () {
                ref
                    .read(tileControllerProvider(index: index).notifier)
                    .onLongPress();
              },
              child: _TileContent(index: index),
            ),
    );
  }
}

class _TileContent extends ConsumerWidget {
  const _TileContent({required this.index});

  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final level = ref.watch(levelProvider);
    final tileState = ref.watch(tileControllerProvider(index: index));

    final row = (index / level.size).floor();
    final column = index % level.size;

    final topIndex = row > 0 ? (row - 1) * level.size + column : -1;
    final bottomIndex =
        row < level.size - 1 ? (row + 1) * level.size + column : -1;
    final leftIndex = column > 0 ? row * level.size + column - 1 : -1;
    final rightIndex =
        column < level.size - 1 ? row * level.size + column + 1 : -1;

    final top = topIndex > -1
        ? ref.watch(tileControllerProvider(index: topIndex))
        : null;
    final bottom = bottomIndex > -1
        ? ref.watch(tileControllerProvider(index: bottomIndex))
        : null;
    final left = leftIndex > -1
        ? ref.watch(tileControllerProvider(index: leftIndex))
        : null;
    final right = rightIndex > -1
        ? ref.watch(tileControllerProvider(index: rightIndex))
        : null;

    return LayoutBuilder(
      builder: (context, constraints) {
        final radius = ((constraints.maxWidth - 2) / 2).floorToDouble();
        return Padding(
          padding: const EdgeInsets.all(2.0),
          child: tileState.current == TileType.ship
              ? Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: top?.current == TileType.ship ||
                              left?.current == TileType.ship ||
                              (bottom?.current == TileType.ship &&
                                  right?.current == TileType.ship)
                          ? Radius.zero
                          : Radius.circular(radius),
                      topRight: top?.current == TileType.ship ||
                              right?.current == TileType.ship ||
                              (bottom?.current == TileType.ship &&
                                  left?.current == TileType.ship)
                          ? Radius.zero
                          : Radius.circular(radius),
                      bottomLeft: bottom?.current == TileType.ship ||
                              left?.current == TileType.ship ||
                              (top?.current == TileType.ship &&
                                  right?.current == TileType.ship)
                          ? Radius.zero
                          : Radius.circular(radius),
                      bottomRight: bottom?.current == TileType.ship ||
                              right?.current == TileType.ship ||
                              (top?.current == TileType.ship &&
                                  left?.current == TileType.ship)
                          ? Radius.zero
                          : Radius.circular(radius),
                    ),
                    color: Colors.black,
                  ),
                )
              : null,
        );
      },
    ); // Handle your onTap
  }
}