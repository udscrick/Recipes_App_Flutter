import 'package:flutter/cupertino.dart';

class FiltersModel{
  final bool isVegan;
  final bool isVegetarian;
  final bool isGlutenFree;
  final bool isLactoseFree;
  FiltersModel(
    {
      @required
      this.isVegan,
      @required
      this.isVegetarian,
      @required
      this.isGlutenFree,
      @required
      this.isLactoseFree});
}