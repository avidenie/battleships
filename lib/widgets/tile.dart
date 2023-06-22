import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/ship_type.dart';
import '../models/tile_model.dart';
import '../providers/level_settings.dart';
import '../providers/tile_controller.dart';
import 'ship.dart';

class Tile extends ConsumerWidget {
  const Tile({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tileState = ref.watch(tileControllerProvider(index: index));

    return Material(
      color:
          tileState.current != TileType.none ? Colors.lightBlue : Colors.white,
      child: tileState.revealed
          ? (tileState.current == TileType.water
              ? const _Revealed()
              : _Ship(index: index, source: _TileSource.initial))
          : InkWell(
              splashFactory: tileState.current == TileType.none
                  ? InkSplash.splashFactory
                  : NoSplash.splashFactory,
              splashColor:
                  tileState.current == TileType.none ? Colors.lightBlue : null,
              onTap: () {
                ref.read(tileControllerProvider(index: index).notifier).onTap();
              },
              onLongPress: () {
                ref
                    .read(tileControllerProvider(index: index).notifier)
                    .onLongPress();
              },
              child: _Ship(index: index, source: _TileSource.current),
            ),
    );
  }
}

enum _TileSource { initial, current }

class _Ship extends ConsumerWidget {
  const _Ship({required this.index, required this.source});

  final int index;
  final _TileSource source;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tileState = ref.watch(tileControllerProvider(index: index));
    if (tileState.current != TileType.ship) {
      return const SizedBox();
    }

    final levelSettings = ref.watch(levelSettingsProvider);
    final row = (index / levelSettings.size).floor();
    final column = index % levelSettings.size;

    final topIndex = row > 0 ? (row - 1) * levelSettings.size + column : -1;
    final bottomIndex = row < levelSettings.size - 1
        ? (row + 1) * levelSettings.size + column
        : -1;
    final leftIndex = column > 0 ? row * levelSettings.size + column - 1 : -1;
    final rightIndex = column < levelSettings.size - 1
        ? row * levelSettings.size + column + 1
        : -1;

    final top = topIndex > -1
        ? _getType(ref.watch(tileControllerProvider(index: topIndex)))
        : null;
    final bottom = bottomIndex > -1
        ? _getType(ref.watch(tileControllerProvider(index: bottomIndex)))
        : null;
    final left = leftIndex > -1
        ? _getType(ref.watch(tileControllerProvider(index: leftIndex)))
        : null;
    final right = rightIndex > -1
        ? _getType(ref.watch(tileControllerProvider(index: rightIndex)))
        : null;

    final child = source == _TileSource.initial ? const _Revealed() : null;

    if (left != TileType.ship &&
        right != TileType.ship &&
        top != TileType.ship &&
        bottom != TileType.ship) {
      return Ship(type: ShipType.single, child: child);
    }

    if (left != TileType.ship &&
        top != TileType.ship &&
        bottom != TileType.ship) {
      return Ship(type: ShipType.left, child: child);
    }

    if (right != TileType.ship &&
        top != TileType.ship &&
        bottom != TileType.ship) {
      return Ship(type: ShipType.right, child: child);
    }

    if (top != TileType.ship &&
        left != TileType.ship &&
        right != TileType.ship) {
      return Ship(type: ShipType.top, child: child);
    }

    if (bottom != TileType.ship &&
        left != TileType.ship &&
        right != TileType.ship) {
      return Ship(type: ShipType.bottom, child: child);
    }

    return Ship(type: ShipType.middle, child: child);
  }

  TileType? _getType(TileModel? tile) {
    return switch (source) {
      _TileSource.initial => tile?.initial,
      _TileSource.current => tile?.current,
    };
  }
}

class _Revealed extends StatelessWidget {
  const _Revealed();

  @override
  Widget build(BuildContext context) {
    return Align(
      child: Container(
        width: 2.0,
        height: 2.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(1.0),
          color: Colors.white,
        ),
      ),
    );
  }
}
