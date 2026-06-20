// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.


import 'package:flutter_test/flutter_test.dart';
import 'package:niche_gaming/models/products.dart';


void main() {

  test("Deve criar um Produto da forma correta", () {
    final products = Products(
      title: "Play Station 5 Pro", 
      description: "Novo", 
      category: "Console", 
      price: 3500.00, 
      imageUrl: "", 
      sellerId: "1");

      expect(products.title, "Play Station 5 Pro");
      expect(products.description, "Novo");
      expect(products.category, "Console");
      expect(products.price, 3500.00);
      expect(products.imageUrl, "");
      expect(products.sellerId, "1");
  });
}
