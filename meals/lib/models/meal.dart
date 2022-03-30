// ignore_for_file: constant_identifier_names
enum Complexity { Simple, Medium, Difficult }
enum Cost { Cheap, Fair, Expensive }

class Meal {
  final String id;
  final List<String> categories; // categories : id
  final String title, imageUrl;
  final List<String> ingredients;
  final List<String> steps;
  final int duration;
  final bool isGlutenFree;
  final bool isLactoseFree;
  final bool isVegan;
  final bool isVegetarian;
  final Cost cost;
  final Complexity complexity;

  const Meal({
    required this.id,
    required this.categories,
    required this.title,
    required this.imageUrl,
    required this.ingredients,
    required this.duration,
    required this.isGlutenFree,
    required this.steps,
    required this.isLactoseFree,
    required this.isVegan,
    required this.isVegetarian,
    required this.cost,
    required this.complexity,
  });

  String get complexityText {
    switch (complexity) {
      case Complexity.Simple:
        return 'Simples';
      case Complexity.Medium:
        return 'Médio';
      case Complexity.Difficult:
        return 'Difícil';
      default:
        return 'Desconhecida';
    }
  }

  String get costText {
    switch (cost) {
      case Cost.Cheap:
        return "Barato";
      case Cost.Fair:
        return "Justo";
      case Cost.Expensive:
        return "Caro";
      default:
        return "Desconhecido";
    }
  }
}
