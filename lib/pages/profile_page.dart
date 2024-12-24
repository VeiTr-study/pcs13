import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('ФИО: Мальцев Иван'),
            SizedBox(height: 8),
            Text('Почта: ivan@example.com'),
            SizedBox(height: 8),
            Text('Номер телефона: +7 123 456 7890'),
          ],
        ),
      ),
    );
  }
}