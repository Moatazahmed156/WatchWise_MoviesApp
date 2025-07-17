import 'package:flutter/material.dart';
import 'package:movies_app/src/app_colors.dart';

class SearchHeader extends StatelessWidget {
  final Function(String) onChanged;

  const SearchHeader({required this.onChanged, super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 220,
          decoration: BoxDecoration(
            color: AppColor.primaryColor,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
        ),
        Positioned(
          right: -70,
          top: -40,
          child: Container(
            width: 300,
            height: 300,
            decoration: BoxDecoration(
              color: const Color(0xff5e5db6),
              borderRadius: BorderRadius.circular(200),
            ),
          ),
        ),
        Positioned(
          top: 70,
          right: 0,
          left: 0,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              onChanged: onChanged,
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                hintText: 'Search...',
                hintStyle: TextStyle(color: AppColor.primaryColor),
                prefixIcon: Icon(Icons.search, color: AppColor.primaryColor),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
