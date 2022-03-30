import 'package:flutter/material.dart';
import 'package:meals/components/main_drawer.dart';
import 'package:meals/models/meal.dart';
import 'categories_screen.dart';
import 'favorite_screen.dart';

class TabsScreen extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const TabsScreen(this.favoriteMeals);

  final List<Meal> favoriteMeals;

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedScreenIndex = 0;
  List<Widget> screens = [];
  final List<String> titles = const ['Lista de Categorias', 'Meus favoritos'];

  @override
  void initState() {
    super.initState();
    screens = [const CategorysScreen(), FavoriteScreen(widget.favoriteMeals)];
  }

  void _selectString(int index) {
    setState(() {
      _selectedScreenIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text(titles[_selectedScreenIndex]),
          ),
          drawer: const MainDrawer(),
          body: screens[_selectedScreenIndex],
          bottomNavigationBar: BottomNavigationBar(
            unselectedItemColor: Colors.white,
            selectedItemColor: Theme.of(context).secondaryHeaderColor,
            onTap: _selectString,
            backgroundColor: Theme.of(context).primaryColor,
            currentIndex: _selectedScreenIndex,
            type: BottomNavigationBarType.shifting,
            items: [
              BottomNavigationBarItem(
                icon: const Icon(Icons.category),
                backgroundColor: Theme.of(context).primaryColor,
                label: 'Categorias',
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.star),
                backgroundColor: Theme.of(context).primaryColor,
                label: 'Favoritos',
              )
            ],
          ),
        ));
  }
}
