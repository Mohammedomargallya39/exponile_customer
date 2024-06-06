class ProductFeatureModel {
  final String productSlug;
  final int feature;
  final String image;
  final double price;
  final double oldPrice;
  final String isGet;

  ProductFeatureModel({
    required this.productSlug,
    required this.feature,
    required this.image,
    required this.price,
    required this.oldPrice,
    required this.isGet,
  });
}