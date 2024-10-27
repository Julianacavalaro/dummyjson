class ProdutoModel {
  final String title;
  final String description;
  final String category;
  final double price;
  final double discountPercentage;
  final double rating;
  final int stock;
  final List<String> tags;
  final List<String> images;
    final String thumbnail;


  ProdutoModel(
      {required this.title,
      required this.description,
      required this.category,
      required this.price,
      required this.discountPercentage,
      required this.rating,
      required this.stock,
      required this.tags,
      required this.images,
      required this.thumbnail});

  factory ProdutoModel.fromMap(Map<String, dynamic> map) {
    return ProdutoModel(
        title: map['title'],
        description: map['description'],
        category: map['category'],
        price: map['price'] * 1.0,
        discountPercentage: map['discountPercentage']* 1.0,
        rating: map['rating'] * 1.0,
        stock: map['stock'],
        tags: List<String>.from((map['tags'] as List)),
        images: List<String>.from((map['images'] as List)),
        thumbnail: map['thumbnail']);
  }
}
