import 'package:flutter/material.dart';

class Destination {
  final String label;
  final IconData icon;
  final Widget Function(BuildContext) builder;

  const Destination({
    required this.label,
    required this.icon,
    required this.builder,
  });
}
