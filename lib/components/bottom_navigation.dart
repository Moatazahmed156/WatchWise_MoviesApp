import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // 👈 Import this
import 'package:movies_app/screens/tabs/saved.dart';
import 'package:movies_app/src/app_colors.dart';

import '../screens/tabs/home.dart';
import '../screens/tabs/search.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key, required this.currentIndex});
  final int currentIndex;

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  late int selectedIndex = 0;

  final List<Widget> screens = [
    Home(),
    Search(),
    Saved(),
  ];

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.currentIndex;

    // 👇 This hides the system bars (bottom nav + status bar)
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[selectedIndex],
      bottomNavigationBar: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 0),
          decoration: BoxDecoration(
            color: AppColor.primaryColor.withOpacity(0.8),
            borderRadius: BorderRadius.circular(50),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: BottomNavigationBar(
              currentIndex: selectedIndex,
              onTap: (index) {
                setState(() {
                  selectedIndex = index;
                });
              },
              backgroundColor: Colors.transparent,
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.grey[500],
              type: BottomNavigationBarType.fixed,
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
                BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
                BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favourite'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
