import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../services/product_api_service.dart';

class EditProductPage extends StatelessWidget {
  final Product product;
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _imageController = TextEditingController();
  final _priceController = TextEditingController();
  final _articleController = TextEditingController();
  final _brandController = TextEditingController();
  final _generationController = TextEditingController();

  EditProductPage({required this.product}) {
    _nameController.text = product.name;
    _descriptionController.text = product.description;
    _imageController.text = product.image;
    _priceController.text = product.price.toString();
    _articleController.text = product.article.toString();
    _brandController.text = product.brand;
    _generationController.text = product.generation;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Редактировать продукт'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _buildTextFormField(_nameController, 'Название'),
                _buildTextFormField(_descriptionController, 'Описание'),
                _buildTextFormField(_imageController, 'URL изображения'),
                _buildTextFormField(_priceController, 'Цена',
                    keyboardType: TextInputType.number),
                _buildTextFormField(_articleController, 'Артикул',
                    keyboardType: TextInputType.number),
                _buildTextFormField(_brandController, 'Бренд'),
                _buildTextFormField(_generationController, 'Поколение'),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final updatedProduct = Product(
                        id: product.id,
                        name: _nameController.text,
                        description: _descriptionController.text,
                        image: _imageController.text,
                        price: double.parse(_priceController.text),
                        article: int.parse(_articleController.text),
                        brand: _brandController.text,
                        generation: _generationController.text,
                        isFavorite: product.isFavorite,
                        quantity: product.quantity,
                      );

                      await ProductService().updateProduct(updatedProduct);
                      Navigator.pop(context, updatedProduct);
                    }
                  },
                  child: const Text('Сохранить',
                      style: TextStyle(color: Colors.black)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextFormField(TextEditingController controller, String label,
      {TextInputType keyboardType = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
        ),
        keyboardType: keyboardType,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Пожалуйста, введите $label';
          }
          return null;
        },
      ),
    );
  }
}
