import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/db_provider.dart';
import 'package:restaurant_app/widget/bottom_navigation_bar.dart';
import 'package:restaurant_app/widget/item_restaurant.dart';

class RestaurantFavoriteScreen extends StatelessWidget {
  static const routeName = '/restaurant_favorite_screen';
  const RestaurantFavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF162B58),
      bottomNavigationBar: const CustomBottomNavigationBar(currentIndex: 1),
      appBar: AppBar(
        backgroundColor: const Color(0xFF162B58),
        title: const Text(
          'Restaraunt Favorite',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24),
        ),
      ),
      body: ChangeNotifierProvider<DbProvider>(
        create: (_) => DbProvider(),
        child: Consumer<DbProvider>(
          builder: (context, result, _) {
            result.getAllRestaurant();
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: result.restaurant.length,
              itemBuilder: (BuildContext context, index) {
                return itemRestaurant(context,
                    result.restaurant[result.restaurant.length - index - 1]);
              },
            );
          },
        ),
      ),
    );
  }
}
