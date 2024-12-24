class Product {
  int? id;
  final String name;
  final String description;
  final String image;
  final double price;
  final int article;
  final String brand;
  final String generation;
  bool isFavorite;
  int quantity;

  Product({
    this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.price,
    required this.article,
    required this.brand,
    required this.generation,
    this.isFavorite = false,
    this.quantity = 1,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      image: json['image'],
      price: (json['price'] as num).toDouble(),
      article: json['article'],
      brand: json['brand'],
      generation: json['generation'],
      isFavorite: json['is_favorite'] ?? false,
      quantity: 1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'image_url': image,
      'price': price,
      'article': article,
      'brand': brand,
      'generation': generation,
      'is_favorite': isFavorite,
    };
  }
}