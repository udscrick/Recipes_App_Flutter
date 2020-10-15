import 'package:flutter/material.dart';
import 'package:meals_app/models/meal_model.dart';
import 'package:meals_app/screens/meal_details_screen.dart';

class MealItem extends StatefulWidget {
  final MealModel mealItem;
  final Function hideMeal;
  final Function toggleFavourite;
  final List<MealModel> favouriteMeals;
  MealItem(this.mealItem, this.hideMeal,this.toggleFavourite,this.favouriteMeals);

  @override
  _MealItemState createState() => _MealItemState();
}

class _MealItemState extends State<MealItem> {
  void _selectMealItem(BuildContext ctx) {
    Navigator.of(ctx)
        .pushNamed(MealDetailsScreen.routeName, arguments: widget.mealItem)
        .then(
            //THis will be called once the page that is routed to is no longer the currently visible page, i.e. no longer on top of the stack(eg:when the page is popped or back is pressed)
            (result) {
      print("Rsult of then: $result");
      if (result != null) {
        widget.hideMeal(result);
      }

      //In our case the value of result will be the 'id' in case the hide button is pressed or 'null' in case the back button is pressed
    });
  }

  String get complexityText {
    switch (widget.mealItem.complexity) {
      case Complexity.Simple:
        return 'Simple';
        break;
      case Complexity.Challenging:
        return 'Challenging';
        break;
      case Complexity.Hard:
        return 'Hard';
        break; //Not necessary,just good practice
      default:
        return 'Unknown';
    }
  }

  String get affodabilityText {
    switch (widget.mealItem.affordability) {
      case Affordability.Affordable:
        return 'Affordable';
        break;
      case Affordability.Luxurious:
        return 'Luxurious';
        break;
      case Affordability.Pricey:
        return 'Pricey';
        break; //Not necessary,just good practice
      default:
        return 'Unknown';
    }
  }
  

  bool isItemFavourite ;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isItemFavourite = widget.favouriteMeals.indexWhere((meal) => meal.id==widget.mealItem.id)>=0;
  }

  @override
  Widget build(BuildContext context) {
    print('Meal Item: ${widget.mealItem.imageUrl}');
    return InkWell(
      onTap: () => _selectMealItem(context),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  //THis widget is used to clip the image on the top left and right so that it does not overlap over the rounded borders of the card
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  child: Image.network(
                    widget.mealItem.imageUrl,
                    height: 250,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  //Works only inside stack, allows us to place an element in an absolute poisition
                  bottom: 20,
                  right: 10,
                  child: Container(
                    //We are using this here in order to prevent the text from overflowing
                    width:
                        300, //Deliberately setting it to be a bit smaller than the image
                    color: Colors.black54,
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                    child: Text(
                      widget.mealItem.title,
                      style: TextStyle(fontSize: 26, color: Colors.white),
                      softWrap: true,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                ),
                Positioned(
                  top:10,
                  right:10,
                  child: IconButton(icon: Icon(isItemFavourite? Icons.star:Icons.star_border,color:  Colors.amber,size: 30,), onPressed: () {
                   bool isFav = widget.toggleFavourite(widget.mealItem.id);
                    setState(() {
                      isItemFavourite = isFav;
                    });
                  }),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Row(
                        children: [
                          Icon(
                            Icons.schedule,
                          ),
                          SizedBox(width: 6),
                          Text('${widget.mealItem.duration} mins')
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Row(
                        children: [
                          Icon(Icons.work),
                          SizedBox(width: 6),
                          Text('$complexityText')
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Row(
                        children: [
                          Icon(Icons.attach_money),
                          SizedBox(width: 6),
                          Text('$affodabilityText')
                        ],
                      ),
                    ),
                  ]),
            )
          ],
        ),
        elevation: 4,
        margin: const EdgeInsets.all(10),
      ),
    );
  }
}
