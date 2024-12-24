import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/product_model.dart';

class ProductService {
  Future<void> addProduct(Product product) async {
    try {
      final response = await http.post(
        Uri.parse('http://192.168.1.70:8080/products/create'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'name': product.name,
          'description': product.description,
          'image_url': product.image,
          'price': product.price,
          'article': product.article,
          'brand': product.brand,
          'generation': product.generation,
          'is_favorite': product.isFavorite,
        }),
      );

      if (response.statusCode != 201) {
        print('Failed to add product: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Failed to add product');
      } else {
        final responseData = jsonDecode(response.body);
        product.id = responseData['id'];
      }
    } catch (e) {
      print('Error adding product: $e');
      throw Exception('Failed to add product');
    }
  }
  Future<List<Product>> fetchProducts() async {
    final response = await http.get(Uri.parse('http://192.168.1.70:8080/products'));

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(utf8.decode(response.bodyBytes));
      return body.map((dynamic item) => Product.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }
  Future<void> updateProduct(Product product) async {
    try {
      final response = await http.put(
        Uri.parse('http://192.168.1.70:8080/products/update/${product.id}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(product.toJson()),
      );

      if (response.statusCode != 200) {
        print('Failed to update product: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Failed to update product');
      }
    } catch (e) {
      print('Error updating product: $e');
      throw Exception('Failed to update product');
    }
  }
}