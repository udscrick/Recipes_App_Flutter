import 'package:flutter/material.dart';
import 'package:meals_app/dummydata/dummy_meals.dart';
import 'package:meals_app/models/filters_model.dart';
import 'package:meals_app/models/meal_model.dart';
import 'package:meals_app/navcontrollers/tabs_screen.dart';
import 'package:meals_app/navcontrollers/tabs_screen_bottom.dart';
import 'package:meals_app/navcontrollers/tabs_with_drawer.dart';
import 'package:meals_app/screens/categories_screen.dart';
import 'package:meals_app/screens/category_meals_screen.dart';
import 'package:meals_app/screens/filters_screen.dart';
import 'package:meals_app/screens/meal_details_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  FiltersModel _listfilters = new FiltersModel(isVegan: false, isVegetarian: false, isGlutenFree: false, isLactoseFree: false);
  List<MealModel> filteredList = DUMMY_MEALS;
  List<MealModel> favouriteMeals = [];
  void _setFilters(FiltersModel newfilters){
    setState(() {
      _listfilters = newfilters;
      filteredList = DUMMY_MEALS.where((meal){
        if(_listfilters.isVegan&&!meal.isVegan){
          return false;
        }
        if(_listfilters.isVegetarian&&!meal.isVegetarian){
          return false;
        }
        if(_listfilters.isLactoseFree&&!meal.isLactoseFree){
          return false;
        }
        if(_listfilters.isGlutenFree&&!meal.isGlutenFree){
          return false;
        }
        return true;
      }).toList();
    });
  }

  bool _toggleFavourites(String mealId){
    final existingIndex = favouriteMeals.indexWhere((meal) => meal.id==mealId);
    if(existingIndex>=0){
      setState(() {
         favouriteMeals.removeAt(existingIndex);
      });
      return false;
     
    }
    else{
      setState(() {
        favouriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id==mealId));
      });
      return true;
    }
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
            bodyText1: TextStyle(
              color: Color.fromRGBO(20, 51, 51, 1),
            ),
            bodyText2: TextStyle(
              color: Color.fromRGBO(20, 51, 51, 1),
            ),
            headline6: TextStyle(
                fontSize: 20,
                fontFamily: 'RobotoCondensed',
                fontWeight: FontWeight.bold
            )
            ),
      ),
      // home: CategoriesScreen(),//Not needed if we specify it within the routes
      initialRoute: '/', //By default '/' is the default route. But, we can change this using initialRoute
      routes: {
        // '/':(ctx)=>TabsScreen(), //Top Tabs
        //  '/':(ctx)=>TabsScreenBottom(),   //BottomTabs
         '/':(ctx)=>TabsWithDrawer(favouriteMeals,_toggleFavourites), //BottomTabs+Drawer
        // '/category-meals': (ctx)=> CategoryMealsScreen(),//Instead of this method we can use the below method by providing a static property in the class so we wont forget the route names
        CategoryMealsScreen.routeName: (ctx)=>CategoryMealsScreen(filteredList,_toggleFavourites,favouriteMeals),
        MealDetailsScreen.routeName: (ctx)=>MealDetailsScreen(),
        FiltersScreen.routeName: (ctx)=>FiltersScreen(_setFilters,_listfilters)
      },
      onGenerateRoute: (settings){//In case no matching named route is present, this method will be called by default
      //It gives us access to the settings of the route, so we get things like route name, arguments etc.
      //Based on settings we can do advanced things like use dynamically generated route names to return a page etc.
      //and other things on the basis of the route data
        return MaterialPageRoute(builder: (ctx)=>CategoriesScreen());
      },
      onUnknownRoute: (settings){//First flutter will check the available routes, if nothing is found, then it will go to ongenerate route, if there also nothing
      //is dound, onUnknownROute will be called as a fallback page
      //Its like the 404 fallback page on the web
        return MaterialPageRoute(builder: (ctx)=>CategoriesScreen());
      },
    );
  }
}
