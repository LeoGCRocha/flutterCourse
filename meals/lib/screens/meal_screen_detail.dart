import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';

class MealDetailScreen extends StatelessWidget {
  const MealDetailScreen(this._toggleFavorite, this._isFavorite);

  final Function(Meal meal) _toggleFavorite;

  final bool Function(Meal meal) _isFavorite;

  Widget _createSectionTitle(BuildContext context, String title) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }

  Widget _createSectionContainer(BuildContext context, Widget child) {
    return Container(
      width: 300,
      height: 200,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(15),
      ),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final meal = ModalRoute.of(context)!.settings.arguments as Meal;

    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 300,
              width: double.infinity,
              child: Image.network(
                meal.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            _createSectionTitle(context, 'Ingredients'),
            _createSectionContainer(
              context,
              ListView.builder(
                  itemCount: meal.steps.length,
                  itemBuilder: (context, index) {
                    return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: Text(meal.steps[index]),
                        ),
                        color: Theme.of(context).secondaryHeaderColor);
                  }),
            ),
            _createSectionTitle(context, 'Passos'),
            _createSectionContainer(
              context,
              ListView.builder(
                  itemCount: meal.ingredients.length,
                  itemBuilder: (ctx, index) {
                    return Column(
                      children: [
                        ListTile(
                          title: Text(meal.steps[index]),
                          leading: CircleAvatar(
                            child: Text('${index + 1}'),
                          ),
                        ),
                        const Divider()
                      ],
                    );
                  }),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).secondaryHeaderColor,
        onPressed: () => _toggleFavorite(meal),
        child: Icon(_isFavorite(meal) ? Icons.star : Icons.star_border),
      ),
    );
  }
}
