class Product {
  final String id;
  final String title;
  final double price;
  final String imageUrl;
  final String description;
  final List<String>? colors;
  final String? size;
  final List<String>? stock;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.imageUrl,
    required this.description,
    this.colors,
    this.size,
    this.stock,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['_id'],
      title: json['name'],
      price: json['price'].toDouble(),
      imageUrl: json['imageUrl'],
      description: json['description'] ?? '',
      size: json['sizes'] != null ? (json['sizes'] as List).first.toString() : null,
      colors: json['colors'] != null ? List<String>.from(json['colors']) : null,
      stock: json['inStock'],
    );
  }
}