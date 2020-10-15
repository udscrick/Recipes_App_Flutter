import 'package:flutter/material.dart';
import 'package:meals_app/dummydata/dummy_meals.dart';
import 'package:meals_app/models/meal_model.dart';
import 'package:meals_app/widgets/meal_item.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const routeName = '/category-meals';

final List<MealModel> filteredList;
final Function toggleFav;
final List<MealModel> favouriteMeals;
CategoryMealsScreen(this.filteredList,this.toggleFav,this.favouriteMeals);
  @override
  _CategoryMealsScreenState createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  String categoryTitle;
  List<MealModel> mealsincategory;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
  }
  
   _hideMeal(String mealid){
    setState(() {
      mealsincategory.removeWhere((element) => element.id==mealid);
    });
  }


  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    //We need to do this here and not in init state as init state does not allow us to use 'context' as 'context' is not yet available to init state
     final routeArgs = ModalRoute.of(context).settings.arguments as Map<String,String>;
    categoryTitle = routeArgs['title'];
    final categoryId = routeArgs['id'];
    mealsincategory = widget.filteredList.where((element) => element.categories.contains(categoryId)).toList();
  }
  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      appBar: AppBar(title: Text(categoryTitle),),
      body:Container(
      child: ListView.builder(itemBuilder: (ctx,index){
        return MealItem(mealsincategory[index],_hideMeal,widget.toggleFav,widget.favouriteMeals);
      },
      itemCount: mealsincategory.length,)
    ) ,
    );
  }
}