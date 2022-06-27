class FoodRecommendationItem {
  String? name;
  double? calories;
  int? servingSizeG;
  double? carbs;
  double? protein;
  double? fats;

  FoodRecommendationItem(
      {this.name,
      this.calories,
      this.servingSizeG,
      this.carbs,
      this.protein,
      this.fats});

  FoodRecommendationItem.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    calories = json['calories'];
    servingSizeG = json['serving_size_g'];
    calories = double.parse(calories!.toStringAsFixed(2));
   
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = name;
    data['calories'] = calories;
    data['serving_size_g'] = servingSizeG;

    return data;
  }
}
