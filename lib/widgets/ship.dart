import 'package:flutter/material.dart';

import '../models/ship_type.dart';

class Ship extends StatelessWidget {
  const Ship({super.key, required this.type, this.child});

  final ShipType type;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final radius = ((constraints.maxWidth - 2) / 2).floorToDouble() + 2;
        return Padding(
          padding: const EdgeInsets.all(2.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: type == ShipType.top ||
                        type == ShipType.left ||
                        type == ShipType.single
                    ? Radius.circular(radius)
                    : Radius.zero,
                bottomLeft: type == ShipType.bottom ||
                        type == ShipType.left ||
                        type == ShipType.single
                    ? Radius.circular(radius)
                    : Radius.zero,
                topRight: type == ShipType.top ||
                        type == ShipType.right ||
                        type == ShipType.single
                    ? Radius.circular(radius)
                    : Radius.zero,
                bottomRight: type == ShipType.bottom ||
                        type == ShipType.right ||
                        type == ShipType.single
                    ? Radius.circular(radius)
                    : Radius.zero,
              ),
              color: Colors.black,
            ),
            child: child,
          ),
        );
      },
    );
  }
}
