import '../../domain/entities/best_selling_products_entity.dart';

class BestSellingProductsModel extends BestSellingProductsEntity {
  const BestSellingProductsModel({
    required super.category,
    required super.products,
  });

  factory BestSellingProductsModel.fromJson(Map<String, dynamic> json) {
    return BestSellingProductsModel(
      category: json["category"] == null ? null : Category.fromJson(json["category"]),
      products: json["products"] == null ? [] : List<Product>.from(json["products"]!.map((x) => Product.fromJson(x))),
    );
  }
}
