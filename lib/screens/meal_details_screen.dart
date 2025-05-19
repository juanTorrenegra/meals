import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';

class MealsDetailsScreen extends StatelessWidget {
  const MealsDetailsScreen({
    super.key,
    required this.title,
    required this.imageUrl,
  });

  final String title;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Column(
        children: [
          FadeInImage(
            placeholder: NetworkImage(imageUrl),
            image: NetworkImage(imageUrl),
          ),
        ],
      ),
    );
  }
}
