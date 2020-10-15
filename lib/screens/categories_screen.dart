import 'package:flutter/material.dart';
import 'package:meals_app/dummydata/dummy_data.dart';
import 'package:meals_app/widgets/category_item.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return 
    //A scaffold must be specified for all screens in case it is not a part of any other parent navigation such as tab navigation
    // Scaffold(
    //   appBar: AppBar(title: const Text('Delicacies'),),
    //   body: GridView(
      GridView(
        padding: const EdgeInsets.all(25),
      gridDelegate:
          SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,//Each item will have a width of 200px. So if screen is 400x we will have 2 items, 600 then 3 items and so on
            childAspectRatio: 3/2, //eg: If width is 200 height will be 300,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20
            ),
      children: DUMMY_CATEGORIES.map((catItem) => CategoryItem(catItem.bgcolor,catItem.id, catItem.title)).toList(),
    );
  }
}
