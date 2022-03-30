import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';
import '../components/meal_item.dart';

class FavoriteScreen extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const FavoriteScreen(this.favoriteMeals);

  final List<Meal> favoriteMeals;

  @override
  Widget build(BuildContext context) {
    if (favoriteMeals.isEmpty) {
      return const Center(
          child: Text('Nenhuma refeição foi marcada como favorita'));
    } else {
      return ListView.builder(
        itemCount: favoriteMeals.length,
        itemBuilder: (ctx, index) {
          return MealItem(meal: favoriteMeals[index]);
        },
      );
    }
  }
}
