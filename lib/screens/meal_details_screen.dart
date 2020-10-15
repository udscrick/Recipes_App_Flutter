import 'package:flutter/material.dart';
import 'package:meals_app/models/meal_model.dart';

class MealDetailsScreen extends StatelessWidget {
  static const routeName = '/meal-details';
  Widget buildSectionTitle(BuildContext context, String title) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }

  Widget buildSectionContainer(Widget child) {
    return Container(
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(10)),
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(10),
        height: 150,
        width: 300,
        child: child);
  }

  @override
  Widget build(BuildContext context) {
    final mealInfo = ModalRoute.of(context).settings.arguments as MealModel;
    // print('Meal info: ${mealInfo.title}');
    return Scaffold(
      appBar: AppBar(
        title: Text(mealInfo.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                mealInfo.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            buildSectionTitle(context, "Ingredients"),
            buildSectionContainer(ListView.builder(
              itemBuilder: (ctx, index) {
                return Card(
                  color: Theme.of(context).accentColor,
                  child: Text(mealInfo.ingredients[index]),
                );
              },
              itemCount: mealInfo.ingredients.length,
            )),
            buildSectionTitle(context, "Steps:"),
            buildSectionContainer(ListView.builder(
              itemBuilder: (ctx, index) {
                return Column(children: [
                  ListTile(
                    leading: CircleAvatar(
                      child: Text("#${(index + 1)}"),
                    ),
                    title: Text(mealInfo.steps[index]),
                  ),
                  Divider()
                ]);
              },
              itemCount: mealInfo.steps.length,
            ))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: "Hide from List",
        child: 
            Icon(Icons.flip_to_back),
          
        onPressed: (){
          Navigator.of(context).pop(mealInfo.id);
        },
      ),
    );
  }
}
