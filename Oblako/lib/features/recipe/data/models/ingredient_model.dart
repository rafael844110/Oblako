class IngredientModel {
  final String name;
  final double quantity;
  final String unit;

  IngredientModel({
    required this.name,
    required this.quantity,
    required this.unit,
  });

  factory IngredientModel.fromJson(Map<String, dynamic> json) {
    return IngredientModel(
      name: json['name'] as String,
      quantity: json['quantity'] as double,
      unit: json['unit'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'quantity': quantity,
      'unit': unit,
    };
  }
}
