import 'package:flutter/material.dart';
import 'package:meals_app/models/filters_model.dart';
import 'package:meals_app/screens/categories_screen.dart';
import 'package:meals_app/widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = '/filters';

  @override
  _FiltersScreenState createState() => _FiltersScreenState();

  Function setFilters;
  FiltersModel listFilters;
  FiltersScreen(this.setFilters,this.listFilters);
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool isGlutenFree = false;
    bool isVegan = false;
    bool isVegetarian = false;
    bool isLactoseFree = false;

    

    Widget _buildSwitchTile(String title,String description,bool value,Function onChangeSwitch){
      return SwitchListTile(title: Text(title),value: value, onChanged: onChangeSwitch,
              subtitle: Text(description),);
    }

    @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isGlutenFree = widget.listFilters.isGlutenFree;
    isVegan = widget.listFilters.isVegan;
    isVegetarian = widget.listFilters.isVegetarian;
    isLactoseFree = widget.listFilters.isLactoseFree;
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Filters'),
        actions: [IconButton(icon: Icon(Icons.save), onPressed: (){
          FiltersModel newfils = new FiltersModel(isVegan: isVegan, isVegetarian: isVegetarian, isGlutenFree: isGlutenFree, isLactoseFree: isLactoseFree);
          widget.setFilters(newfils);
          Navigator.of(context).pushReplacementNamed('/');
        })],
      ),
      body: Column(
        children: [
          Container(
            child: Text(
              'Adjust your meal selection.',
              style: Theme.of(context).textTheme.headline6,
            ),
            padding: EdgeInsets.all(20),
          ),
          Expanded(
              child: ListView(
            children: [
              _buildSwitchTile('Gluten Free','Only include gluten free dishes',isGlutenFree,(newVal){
                setState(() {
                  isGlutenFree = newVal;
                }
                );
              }
              ),
              _buildSwitchTile('Vegetarian','Only include vegetarian dishes',isVegetarian,(newVal){
                setState(() {
                  isVegetarian = newVal;
                }
                );
              }
              ),
              _buildSwitchTile('Vegan','Only include vegan dishes',isVegan,(newVal){
                setState(() {
                  isVegan = newVal;
                }
                );
              }
              ),
              _buildSwitchTile('Lactose Free','Only include lactose free dishes',isLactoseFree,(newVal){
                setState(() {
                  isLactoseFree = newVal;
                }
                );
              }
              )
            ],
          ))
        ],
      ),
      drawer: MainDrawer(),
    );
  }
}
