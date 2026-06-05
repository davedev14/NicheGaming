class Task {

  String? id;
  String title;
  final String category;
  final double price;
  final String image;
  final double rating;
  String userId;

  Task({
    this.id,
    required this.title,
    required this.category,
    required this.image,
    required this.price,
    required this.rating,
    required this.userId,

    });
    // converter para json
  Map<String, dynamic> toMap(){
    return{
      'title': title,
      'category' : category,
      'image' : image,
      'price' : price,
      'rating' : rating,
      'userId': userId};
  }
  // Converte Json em um objeto
  factory Task.fromMap(
    Map<String, dynamic> map,
    String id,
  ){
    return Task(
      id: id,
      title: map['title'] ??'',
      category: map['category'] ?? '',
      image: map['image'] ?? '',
      price: (map['price'] ?? 0).toDouble(),
      rating: (map['rating'] ?? 0).toDouble(),
      userId: map['userId'] ?? ''
    );
  }
}