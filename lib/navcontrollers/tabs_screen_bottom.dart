import 'package:flutter/material.dart';
import 'package:meals_app/models/meal_model.dart';
import 'package:meals_app/screens/categories_screen.dart';
import 'package:meals_app/screens/favourites_screen.dart';

class TabsScreenBottom extends StatefulWidget {
  @override
  _TabsScreenBottomState createState() => _TabsScreenBottomState();

  List<MealModel> favouritesList;
  TabsScreenBottom(this.favouritesList);
}

class _TabsScreenBottomState extends State<TabsScreenBottom> {

List<Map<String,Object>> _pages; 

  int selectedPageIndex = 0;

  void _selectPage(int index){
    setState(() {
      selectedPageIndex = index;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pages = [
   {'page': CategoriesScreen(),'title':'Categories'},
    {'page': FavouritesScreen(widget.favouritesList,(){}),'title':'Favourites'},
  ];
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pages[selectedPageIndex]['title']),
      ),
      body: _pages[selectedPageIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,//Triggered whenever an item on the tab is selected
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white,
        selectedItemColor: Theme.of(context).accentColor,
        currentIndex: selectedPageIndex,
        type: BottomNavigationBarType.shifting,
        items: [
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,//Needed when using type as shifting, otherwise it is unecessary
              icon: Icon(Icons.category), title: Text('Categories')),
              BottomNavigationBarItem(
                backgroundColor: Theme.of(context).primaryColor,
              icon: Icon(Icons.star), title: Text('Favourites')),
        ],
      ),
    );
  }
}
