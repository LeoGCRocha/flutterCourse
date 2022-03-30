import 'package:flutter/material.dart';

class Category {
  final String id;
  final String title;
  final Color color;

  const Category({
    Key? key,
    required this.id,
    required this.title,
    required this.color,
  });
}
