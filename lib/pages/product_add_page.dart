import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../services/product_api_service.dart';

class AddProductPage extends StatelessWidget {
  final List<Product> products;
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _imageController = TextEditingController();
  final _priceController = TextEditingController();
  final _articleController = TextEditingController();
  final _brandController = TextEditingController();
  final _generationController = TextEditingController();

  AddProductPage({required this.products});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Добавить продукт'),
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
                      final newProduct = Product(
                        name: _nameController.text,
                        description: _descriptionController.text,
                        image: _imageController.text,
                        price: double.parse(_priceController.text),
                        article: int.parse(_articleController.text),
                        brand: _brandController.text,
                        generation: _generationController.text,
                      );

                      await ProductService().addProduct(newProduct);
                      Navigator.pop(context, newProduct);
                    }
                  },
                  child: const Text('Добавить',
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
