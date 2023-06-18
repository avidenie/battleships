import 'package:flutter/material.dart';

class Sum extends StatelessWidget {
  const Sum({
    super.key,
    required this.sum,
    required this.remaining,
    required this.size,
    this.onTap,
  });

  final int sum;
  final int remaining;
  final double size;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.titleMedium;

    return Material(
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: Ink(
          width: size,
          height: size,
          child: Align(
            alignment: Alignment.center,
            child: FittedBox(
              child: Text(
                sum.toString(),
                style:
                    remaining >= 0 ? style : style?.copyWith(color: Colors.red),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
