import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../models/cart_model.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final Function onDelete;
  final Function onToggleFavorite;
  final bool isLeftColumn;

  const ProductCard({
    super.key,
    required this.product,
    required this.onDelete,
    required this.onToggleFavorite,
    required this.isLeftColumn,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(product.id.toString()),
      direction: isLeftColumn ? DismissDirection.endToStart : DismissDirection.startToEnd,
      onDismissed: (direction) {
        onDelete();
      },
      background: Container(color: Colors.red),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey),
          ),
          width: double.infinity,
          height: 600,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: Center(
                  child: product.image.startsWith('http')
                      ? Image.network(
                    product.image,
                    height: 100,
                  )
                      : Image.asset(
                    product.image,
                    height: 100,
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            product.name,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Center(
                          child: Text(
                            '${product.price} рублей',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                            textAlign: TextAlign.center,
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Center(
                          child: ElevatedButton(
                            onPressed: () {
                              cart.add(product);
                            },
                            child: const Text('Добавить в корзину'),
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            product.isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: product.isFavorite ? Colors.red : null,
                          ),
                          onPressed: () {
                            onToggleFavorite();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
