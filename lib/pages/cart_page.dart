import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../models/cart_model.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  void _updateQuantity(Product product, int change) {
    setState(() {
      product.quantity += change;
      if (product.quantity <= 0) {
        cart.remove(product);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: ListView.builder(
        itemCount: cart.length,
        itemBuilder: (context, index) {
          final product = cart[index];
          return ListTile(
            title: Text(product.name),
            subtitle: Text('${product.price} рублей x ${product.quantity}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.remove_circle),
                  onPressed: () => _updateQuantity(product, -1),
                ),
                IconButton(
                  icon: const Icon(Icons.add_circle),
                  onPressed: () => _updateQuantity(product, 1),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}