import 'package:flutter/material.dart';
import 'package:movies_app/src/app_colors.dart';

class MovieCategoryCard extends StatelessWidget {
  const MovieCategoryCard({super.key, required this.name});
  final String name;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10 , right: 5),
      padding: EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(15),
      ),
      child: Text(name , style: TextStyle(fontSize: 12 , color: Colors.black),),
    );
  }
}
