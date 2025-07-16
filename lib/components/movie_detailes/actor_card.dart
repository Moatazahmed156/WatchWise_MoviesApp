import 'package:flutter/material.dart';
import 'package:movies_app/src/app_colors.dart';

class ActorCard extends StatelessWidget {
  const ActorCard({super.key, required this.name, required this.profilePath, required this.character});
  final String name;
  final String profilePath;
  final String character;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      decoration: BoxDecoration(
        color: AppColor.primaryColor,
        borderRadius: BorderRadius.circular(15),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          Image.network(
            (profilePath.isNotEmpty && profilePath != 'null')
                ? "https://image.tmdb.org/t/p/w500$profilePath"
                : "https://upload.wikimedia.org/wikipedia/commons/1/14/No_Image_Available.jpg",
            height: 180,
            width: double.infinity,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Image.network(
              "https://upload.wikimedia.org/wikipedia/commons/1/14/No_Image_Available.jpg",
              height: 180,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  name,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  character,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white60,
                    fontSize: 15,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}