import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/product_model.dart';
import '../services/product_api_service.dart';
import 'product_add_page.dart';
import 'product_edit_page.dart';
import 'product_detail_page.dart';
import '../models/cart_model.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Product>> _futureProducts;

  @override
  void initState() {
    super.initState();
    _futureProducts = ProductService().fetchProducts();
  }

  void _addToCart(Product product) {
    setState(() {
      final existingProduct = cart.firstWhere(
        (cartProduct) => cartProduct.id == product.id,
        orElse: () => Product(
          id: product.id,
          name: product.name,
          description: product.description,
          image: product.image,
          price: product.price,
          article: product.article,
          brand: product.brand,
          generation: product.generation,
          quantity: 0,
        ),
      );

      if (existingProduct.quantity == 0) {
        cart.add(existingProduct);
      }
      existingProduct.quantity += 1;
    });
  }

  void _deleteProduct(int id) async {
    try {
      final response = await http
          .delete(Uri.parse('http://192.162.1.70:2020/products/delete/$id'));
      if (response.statusCode == 204) {
        setState(() {
          _futureProducts = ProductService().fetchProducts();
        });
      } else {
        print('Failed to delete product: ${response.statusCode}');
      }
    } catch (e) {
      print('Failed to delete product: $e');
    }
  }

  void _navigateToAddProductPage() async {
    final products = await _futureProducts;
    final newProduct = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddProductPage(products: products),
      ),
    );

    if (newProduct != null) {
      setState(() {
        _futureProducts = ProductService().fetchProducts();
      });
    }
  }

  void _navigateToEditProductPage(Product product) async {
    final updatedProduct = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditProductPage(product: product),
      ),
    );

    if (updatedProduct != null) {
      setState(() {
        _futureProducts = ProductService().fetchProducts();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Главная',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Product>>(
        future: _futureProducts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Нет продуктов'));
          } else {
            final products = snapshot.data!;
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 2 / 3,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetailPage(product: product),
                      ),
                    );
                  },
                  child: Card(
                    color: Colors.white,
                    margin: const EdgeInsets.all(2.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Text(product.name,
                              style: Theme.of(context).textTheme.bodyLarge),
                        ),
                        Flexible(
                          child: product.image.startsWith('http')
                              ? Image.network(product.image, fit: BoxFit.cover)
                              : Image.asset(product.image, fit: BoxFit.cover),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 1.0, horizontal: 0.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: product.isFavorite
                                          ? Colors.red
                                          : Colors.grey,
                                      shape: CircleBorder(),
                                      padding: EdgeInsets.all(2),
                                    ),
                                    child: Icon(
                                      product.isFavorite
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        product.isFavorite = !product.isFavorite;
                                      });
                                    },
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.blue,
                                      shape: CircleBorder(),
                                      padding: EdgeInsets.all(2),
                                    ),
                                    child: Icon(Icons.edit, color: Colors.white),
                                    onPressed: () {
                                      _navigateToEditProductPage(product);
                                    },
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red,
                                      shape: CircleBorder(),
                                      padding: EdgeInsets.all(2),
                                    ),
                                    child:
                                    Icon(Icons.delete, color: Colors.white),
                                    onPressed: () {
                                      _deleteProduct(product.id!);
                                    },
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    '${product.price} руб.',
                                    style: Theme.of(context).textTheme.bodyLarge,
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.green,
                                      shape: CircleBorder(),
                                      padding: EdgeInsets.all(2),
                                    ),
                                    child: Icon(Icons.add_shopping_cart, color: Colors.white),
                                    onPressed: () => _addToCart(product),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToAddProductPage,
        child: Icon(Icons.add),
      ),
    );
  }
}
