import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:medecin_warehouse/core/constant/colors.dart';
import 'package:medecin_warehouse/view/screen/favorite.dart';
import 'package:medecin_warehouse/view/screen/home.dart';
import 'package:medecin_warehouse/view/screen/orders_screen.dart';
import 'package:medecin_warehouse/view/screen/setting_screen.dart';

class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _selectedIndex = 0;

  final _screens = [
    // Home Screen
    HomeScreen(),
    // Favorite Screen
    FavoriteScreen(),
    // Buy  Screen
    OrdersScreen(),
    // Profile Screen
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    double navBarHeight = screenWidth > 600 ? 70 : 60;

    double iconSize = screenWidth > 600 ? 30 : 24;
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: CurvedNavigationBar(
        color: AppColors.primary,
        height: navBarHeight,
        backgroundColor: AppColors.background,
        buttonBackgroundColor: AppColors.darkerGreen,
        index: _selectedIndex,
        items: [
          Icon(
            Icons.home_filled,
            color: Colors.white,
            size: iconSize,
          ),
          Icon(
            Icons.favorite,
            color: Colors.white,
            size: iconSize,
          ),
          Icon(
            Icons.calendar_month,
            color: Colors.white,
            size: iconSize,
          ),
          Icon(
            Icons.settings,
            color: Colors.white,
            size: iconSize,
          ),
        ],
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
