import 'package:flutter/material.dart';
import 'package:movies_app/components/bottom_navigation.dart';
import 'package:movies_app/screens/other/get_started.dart';
import 'package:movies_app/screens/other/login.dart';
import 'package:movies_app/src/app_colors.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ProfileDialog extends StatelessWidget {
  ProfileDialog({super.key});
  var box = Hive.box("MyData");
  @override
  Widget build(BuildContext context) {
    final String? name = box.get('name');
    final String? email = box.get('email');
    final bool isLoggedIn = name != null && email != null;
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 20),
                const CircleAvatar(
                  radius: 35,
                  backgroundColor: Colors.grey,
                  child: Icon(Icons.person, size: 60, color: Colors.white),
                ),
                const SizedBox(height: 12),
                Text(
                  name ?? "No Name",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(email ?? "No Email", style: TextStyle(color: Colors.grey)),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.primaryColor,
                    minimumSize: const Size(double.infinity, 45),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BottomNavigation(currentIndex: 2),
                      ),
                    );
                  },
                  icon: const Icon(Icons.favorite, color: Colors.white),
                  label: const Text(
                    "Go to My Fav",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(height: 10),
                isLoggedIn
                    ? ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        minimumSize: const Size(double.infinity, 45),
                      ),
                      onPressed: () {
                        box.delete('name');
                        box.delete('email');
                        box.delete('id');
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => GetStarted()),
                        );
                      },
                      icon: const Icon(Icons.logout, color: Colors.white),
                      label: const Text(
                        "Logout",
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                    : ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        minimumSize: const Size(double.infinity, 45),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Login()),
                        );
                      },
                      icon: const Icon(Icons.login, color: Colors.white),
                      label: const Text(
                        "Login",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
              ],
            ),
          ),
          Positioned(
            right: 10,
            top: 10,
            child: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: const Icon(Icons.close, color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}
