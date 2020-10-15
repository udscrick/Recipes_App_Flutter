import 'package:flutter/material.dart';
import 'package:meals_app/models/meal_model.dart';
import 'package:meals_app/widgets/meal_item.dart';

class FavouritesScreen extends StatefulWidget {
  List<MealModel> favourites;
  final Function toggleFav;
  FavouritesScreen(this.favourites,this.toggleFav);

  @override
  _FavouritesScreenState createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends State<FavouritesScreen> {
  @override
  Widget build(BuildContext context) {
    return widget.favourites.length == 0
        ? Center(
            child: Text("No favourites yet!"),
          )
        : Container(
          width: double.infinity,
          height: double.infinity,
          child: ListView.builder(itemBuilder: (ctx,index){
          return MealItem(widget.favourites[index],(){},widget.toggleFav,widget.favourites);
        },itemCount: widget.favourites.length,));
  }
}
