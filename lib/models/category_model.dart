import 'package:flutter/material.dart';

class CategoryModel {
  final String id;
  final String title;
  final Color bgcolor;

  const CategoryModel({
    @required this.id,
    @required this.title,
    this.bgcolor = Colors.orange,
  });
}
