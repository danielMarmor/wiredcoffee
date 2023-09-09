class ProductModel {
  final String id;
  final String imageSrc;
  final String name;
  final double price;

  ProductModel(
      {required this.id,
      required this.imageSrc,
      required this.name,
      required this.price});
}

class ProductSearchResult {
  final String id;
  final String imageSrc;
  final String name;
  final double price;
  final String categoryId;

  ProductSearchResult(
      {required this.id,
      required this.imageSrc,
      required this.name,
      required this.price,
      required this.categoryId});
}
