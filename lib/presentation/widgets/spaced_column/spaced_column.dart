import 'package:flutter/material.dart';

class SpacedColumn extends StatelessWidget {
  final List<Widget> children;
  final double gap;
  const SpacedColumn({super.key, required this.children, this.gap = 12});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: children
          .map(
            (w) => Padding(
              padding: EdgeInsets.only(bottom: gap),
              child: w,
            ),
          )
          .toList(),
    );
  }
}
