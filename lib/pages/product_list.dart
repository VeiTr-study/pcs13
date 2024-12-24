import 'package:flutter/material.dart';
import 'package:pcs8/pages/product_detail_page.dart';

import '../components/item.dart';
import '../models/product_model.dart';

class ProductList extends StatelessWidget {
  final List<Product> products;
  final Function(Product) onDelete;
  final Function(Product) onToggleFavorite;

  const ProductList({
    Key? key,
    required this.products,
    required this.onDelete,
    required this.onToggleFavorite,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 4,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductDetailPage(product: products[index]),
              ),
            );
          },
          child: ProductCard(
            product: products[index],
            onDelete: () => onDelete(products[index]),
            onToggleFavorite: () => onToggleFavorite(products[index]),
            isLeftColumn: index % 2 == 0,
          ),
        );
      },
    );
  }
}