import 'package:flutter/material.dart';

class Remaining extends StatelessWidget {
  const Remaining(this.remaining, {super.key, required this.size});

  final int remaining;
  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Align(
        alignment: Alignment.center,
        child: Builder(
          builder: (context) {
            if (remaining == 0) {
              return const FittedBox(
                child: Icon(
                  Icons.check_rounded,
                  size: 16.0,
                  color: Colors.green,
                ),
              );
            }
            if (remaining < 0) {
              return const FittedBox(
                child: Icon(
                  Icons.close,
                  size: 16.0,
                  color: Colors.red,
                ),
              );
            }
            return FittedBox(
              child: Text(
                remaining.toString(),
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: remaining >= 0
                        ? Theme.of(context)
                            .textTheme
                            .titleSmall
                            ?.color
                            ?.withAlpha(200)
                        : Colors.red),
              ),
            );
          },
        ),
      ),
    );
  }
}
