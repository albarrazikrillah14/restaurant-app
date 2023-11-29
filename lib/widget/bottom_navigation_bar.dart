import 'package:flutter/material.dart';
import 'package:restaurant_app/ui/restaurant_favorite.dart';
import 'package:restaurant_app/ui/restaurant_list.dart';
import 'package:restaurant_app/ui/restaurant_setting.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({Key? key, required this.currentIndex})
      : super(key: key);

  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      backgroundColor: const Color(0xFF162B58),
      selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
      selectedItemColor: Colors.amber,
      unselectedItemColor: Colors.white,
      onTap: (value) {
        switch (value) {
          case 0:
            if (currentIndex != 0) {
              Navigator.pushReplacementNamed(
                  context, RestaurantListScreen.routeName);
            }
            break;
          case 1:
            if (currentIndex != 1) {
              Navigator.pushReplacementNamed(
                  context, RestaurantFavoriteScreen.routeName);
            }
            break;
          case 2:
            if (currentIndex != 2) {
              Navigator.pushReplacementNamed(
                  context, RestaurantSettingScreen.routeName);
            }
            break;
        }
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite),
          label: 'Favorite',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Settings',
        )
      ],
    );
  }
}
