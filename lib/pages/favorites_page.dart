import 'package:flutter/material.dart';
import 'package:shop/pages/product_detail_page.dart';
import '../models/product_model.dart';

class FavoritesPage extends StatefulWidget {
  final List<Product> favoriteProducts;

  FavoritesPage({Key? key, required this.favoriteProducts}) : super(key: key);

  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Избранные', style: TextStyle(color: Colors.black))),
      ),
      body: widget.favoriteProducts.isEmpty
          ? Center(child: Text('Нет избранных товаров'))
          : ListView.builder(
        itemCount: widget.favoriteProducts.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(widget.favoriteProducts[index].name),
            subtitle: Text('${widget.favoriteProducts[index].price} рублей'),
            trailing: IconButton(
              icon: const Icon(Icons.remove_circle),
              onPressed: () {
                setState(() {
                  widget.favoriteProducts[index].isFavorite = false;
                  widget.favoriteProducts.removeAt(index);
                });
              },
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetailPage(product: widget.favoriteProducts[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}