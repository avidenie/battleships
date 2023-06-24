import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/level_settings.dart';
import '../providers/tile_controller.dart';
import '../providers/tile_width.dart';
import 'column_remaining.dart';
import 'column_sums.dart';
import 'row_remaining.dart';
import 'row_sums.dart';
import 'tile.dart';

class Board extends ConsumerStatefulWidget {
  const Board({super.key, required this.boardWidth});

  final double boardWidth;

  @override
  ConsumerState<Board> createState() => _BoardState();
}

class _BoardState extends ConsumerState<Board> {
  final Set<int> selectedIndexes = <int>{};
  final key = GlobalKey();
  final Set<SelectableTileRenderObject> _trackTaped =
      <SelectableTileRenderObject>{};

  @override
  Widget build(BuildContext context) {
    final levelSettings = ref.watch(levelSettingsProvider);
    final tileWidth = ref.watch(tileWidthProvider(widget.boardWidth));

    return SizedBox(
      width: widget.boardWidth + 2 * tileWidth,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ColumnSums(boardWidth: widget.boardWidth),
          Row(
            children: [
              RowSums(boardWidth: widget.boardWidth),
              SizedBox(
                width: widget.boardWidth,
                height: widget.boardWidth,
                child: Container(
                  color: Colors.black,
                  child: Listener(
                    // onPointerDown: _detectTapedItem,
                    onPointerMove: _detectTapedItem,
                    onPointerUp: _clearSelection,
                    child: GridView.count(
                      key: key,
                      primary: false,
                      padding: const EdgeInsets.all(4.0),
                      crossAxisSpacing: levelSettings.size == 15 ? 0.5 : 1,
                      mainAxisSpacing: levelSettings.size == 15 ? 0.5 : 1,
                      crossAxisCount: levelSettings.size,
                      children: List.generate(
                          levelSettings.size * levelSettings.size, (index) {
                        return SelectableTile(
                          index: index,
                          child: Tile(index: index),
                        );
                      }),
                    ),
                  ),
                ),
              ),
              RowRemaining(boardWidth: widget.boardWidth),
            ],
          ),
          ColumnRemaining(boardWidth: widget.boardWidth)
        ],
      ),
    );
  }

  _detectTapedItem(PointerEvent event) {
    final obj = key.currentContext?.findRenderObject();
    if (obj != null) {
      final box = obj as RenderBox;
      final result = BoxHitTestResult();
      final local = box.globalToLocal(event.position);
      if (box.hitTest(result, position: local)) {
        for (final hit in result.path) {
          final target = hit.target;
          if (target is SelectableTileRenderObject &&
              !_trackTaped.contains(target)) {
            _trackTaped.add(target);
            _selectIndex(target.index);
          }
        }
      }
    }
  }

  _selectIndex(int index) {
    ref.read(tileControllerProvider(index: index).notifier).onDrag();
    setState(() {
      selectedIndexes.add(index);
    });
  }

  void _clearSelection(PointerUpEvent event) {
    _trackTaped.clear();
    setState(() {
      selectedIndexes.clear();
    });
  }
}

class SelectableTile extends SingleChildRenderObjectWidget {
  final int index;

  const SelectableTile({super.key, super.child, required this.index});

  @override
  SelectableTileRenderObject createRenderObject(BuildContext context) {
    return SelectableTileRenderObject()..index = index;
  }

  @override
  void updateRenderObject(
      BuildContext context, SelectableTileRenderObject renderObject) {
    renderObject.index = index;
  }
}

class SelectableTileRenderObject extends RenderProxyBox {
  late int index;
}
