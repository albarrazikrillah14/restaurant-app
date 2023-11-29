import 'package:flutter/material.dart';
import 'package:restaurant_app/data/model/restaurant_list_response.dart';
import 'package:restaurant_app/helper/database_helper.dart';

class DbProvider extends ChangeNotifier {
  List<Restaurant> _restaurant = [];
  late DatabaseHelper _dbHelper;

  List<Restaurant> get restaurant => _restaurant;

  DbProvider() {
    _dbHelper = DatabaseHelper();
    _getAllRestaurant();
  }

  Future<dynamic> getAllRestaurant() async {
    _getAllRestaurant();
  }
  void _getAllRestaurant() async {
    _restaurant = await _dbHelper.getRestaurants();
    notifyListeners();
  }

  Future<void> addRestaurant(Restaurant restaurant) async {
    await _dbHelper.insertRestaurant(restaurant);
    _getAllRestaurant();
  }

  Future<void> deleteRestaurant(String id) async {
    await _dbHelper.deleteRestaurant(id);
    _getAllRestaurant();
  }
}