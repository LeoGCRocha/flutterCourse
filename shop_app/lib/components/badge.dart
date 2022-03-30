// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

class Badge extends StatelessWidget {
  final Widget child;
  final String value;
  final Color? color;

  const Badge({required this.child, required this.value, this.color});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        child,
        Positioned(
          child: Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: color ?? Colors.black26,
            ),
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 10,
              ),
            ),
          ),
          top: 8,
          right: 8,
        )
      ],
    );
  }
}
