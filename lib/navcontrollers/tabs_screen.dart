import 'package:flutter/material.dart';
import 'package:meals_app/models/meal_model.dart';
import 'package:meals_app/screens/categories_screen.dart';
import 'package:meals_app/screens/favourites_screen.dart';

class TabsScreen extends StatefulWidget {
  @override
  _TabsScreenState createState() => _TabsScreenState();
  List<MealModel> favouritesList;
  TabsScreen(favouritesList);
}

class _TabsScreenState extends State<TabsScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,//0 by default
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Delicacies'),
            bottom: TabBar(
              tabs: [
                Tab(
                  icon: Icon(Icons.category),
                  text: 'Categories',
                ),
                Tab(
                  icon: Icon(Icons.star),
                  text:'Favourites'
                )
              ],
            ),
            
          ),
          body: TabBarView(children: [
            CategoriesScreen(),
            FavouritesScreen(widget.favouritesList,(){})
          ],),
        ),
        
        );
  }
}
