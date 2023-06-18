import 'package:flutter/material.dart';

class Legend extends StatelessWidget {
  const Legend({super.key, required this.boardWidth});

  final double boardWidth;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: boardWidth,
      child: const Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _Ship(type: ShipType.left, count: 1),
              _Ship(type: ShipType.middle),
              _Ship(type: ShipType.right),
              _Found(found: false)
            ],
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _Ship(type: ShipType.left, count: 2),
              _Ship(type: ShipType.right),
              _Found(found: true),
              _Found(found: false)
            ],
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _Ship(type: ShipType.circle, count: 3),
              _Found(found: false),
              _Found(found: false),
              _Found(found: true)
            ],
          ),
        ],
      ),
    );
  }
}

enum ShipType { left, right, middle, circle }

class _Ship extends StatelessWidget {
  const _Ship({required this.type, this.count});

  final ShipType type;
  final int? count;

  @override
  Widget build(BuildContext context) {
    const radius = 20.0;
    return SizedBox(
      width: 40.0,
      height: 40.0,
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: type == ShipType.left || type == ShipType.circle
                  ? const Radius.circular(radius)
                  : Radius.zero,
              bottomLeft: type == ShipType.left || type == ShipType.circle
                  ? const Radius.circular(radius)
                  : Radius.zero,
              topRight: type == ShipType.right || type == ShipType.circle
                  ? const Radius.circular(radius)
                  : Radius.zero,
              bottomRight: type == ShipType.right || type == ShipType.circle
                  ? const Radius.circular(radius)
                  : Radius.zero,
            ),
            color: Colors.black,
          ),
          child: count != null && count! > 0
              ? Align(
                  alignment: Alignment.center,
                  child: Text(
                    count.toString(),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary),
                  ),
                )
              : null,
        ),
      ),
    ); // Handle your onTap
  }
}

class _Found extends StatelessWidget {
  const _Found({required this.found});

  final bool found;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: SizedBox(
        width: 32.0,
        height: 32.0,
        child: Padding(
          padding: const EdgeInsets.all(1.0),
          child: Container(
            decoration: BoxDecoration(border: Border.all(width: 1.0)),
          ),
        ),
      ),
    ); // Handle your onTap
  }
}
