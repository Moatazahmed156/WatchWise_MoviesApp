import 'package:flutter/material.dart';
import 'package:movies_app/src/app_colors.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({super.key, required this.name, required this.onTap, required this.isSelected});
  final String name;
  final VoidCallback onTap;
  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 5 , horizontal: 30),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: isSelected?AppColor.primaryColor :Colors.grey[300]
        ),
        child: Center(child: Text(name ,style: TextStyle(fontWeight: FontWeight.bold , color: isSelected? Colors.grey[300]:AppColor.primaryColor , fontSize: 17),)),
      ),
    );
  }
}
