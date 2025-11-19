import 'package:flutter/material.dart';

class TagList extends StatelessWidget {
  final List<String> tags;
  const TagList({super.key, required this.tags});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 6,
      children: tags.map((t) => Chip(label: Text(t))).toList(),
    );
  }
}
