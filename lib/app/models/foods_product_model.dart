import 'dart:convert';

class FoodsProductModel {
  List<Meal>? meals;

  FoodsProductModel({
    this.meals,
  });

  factory FoodsProductModel.fromRawJson(String str) =>
      FoodsProductModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory FoodsProductModel.fromJson(Map<String, dynamic> json) =>
      FoodsProductModel(
        meals: json["meals"] == null
            ? []
            : List<Meal>.from(json["meals"]!.map((x) => Meal.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "meals": meals == null
            ? []
            : List<dynamic>.from(meals!.map((x) => x.toJson())),
      };
}

class Meal {
  String? strMeal;
  String? strMealThumb;
  String? idMeal;

  Meal({
    this.strMeal,
    this.strMealThumb,
    this.idMeal,
  });

  factory Meal.fromRawJson(String str) => Meal.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Meal.fromJson(Map<String, dynamic> json) => Meal(
        strMeal: json["strMeal"],
        strMealThumb: json["strMealThumb"],
        idMeal: json["idMeal"],
      );

  Map<String, dynamic> toJson() => {
        "strMeal": strMeal,
        "strMealThumb": strMealThumb,
        "idMeal": idMeal,
      };
}
