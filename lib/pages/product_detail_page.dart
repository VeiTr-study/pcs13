import 'package:flutter/material.dart';
import '../models/product_model.dart';

class ProductDetailPage extends StatelessWidget {
  final Product product;

  const ProductDetailPage({super.key, required this.product});

  final textFont = const TextStyle(fontSize: 20);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(product.name),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            product.image.startsWith('http')
                ? Image.network(
                    product.image,
                    fit: BoxFit.contain,
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.25,
                  )
                : Image.asset(
                    product.image,
                    fit: BoxFit.contain,
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.25,
                  ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                product.description,
                style: textFont,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Цена: ${product.price} рублей',
                style: textFont,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Артикул: ${product.article}',
                style: textFont,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Бренд: ${product.brand}',
                style: textFont,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Поколение: ${product.generation}',
                style: textFont,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
