class Products {
  String? id;
  final String title;
  final String category;
  final String description;
  final double price;
  final String imageUrl;
  final String sellerId;

  Products({
     this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.price,
    required this.imageUrl,
    required this.sellerId,
  });

  Map<String, dynamic> toMap() {
    return{
      'title': title,
      'description': description,
      'category': category,
      'price': price,
      'imageUrl': imageUrl,
      'sellerId': sellerId,
    };
  }

  factory Products.fromMap(Map<String, dynamic> map, String id) {
    return Products(
      id: id,
      title: map['title'],
      description: map['description'],
      category: map['category'],
      price: (map['price'] as num).toDouble(),
      imageUrl: map['imageUrl'],
      sellerId: map['sellerId'],
      );
  }

}