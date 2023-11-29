import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/preferences_provider.dart';
import 'package:restaurant_app/widget/bottom_navigation_bar.dart';
import 'package:restaurant_app/widget/custom_dialog.dart';

import '../provider/scheduling_provider.dart';

class RestaurantSettingScreen extends StatelessWidget {
  static const String routeName = '/restaurant_settings';

  const RestaurantSettingScreen({Key? key}) : super(key: key);

  Widget _buildList(BuildContext context) {
    return Consumer<PreferencesProvider>(
      builder: (context, provider, _) {
        return Scaffold(
          backgroundColor: const Color(0xFF162B58),
          bottomNavigationBar: const CustomBottomNavigationBar(currentIndex: 2,),
          appBar: AppBar(
          backgroundColor: const Color(0xFF162B58),
            title: const Text('Setting', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),),
          ),
          body: Consumer<SchedulingProvider> (
            builder: (context, scheduled, _) {
              return ListTile(
                title: const Text('Restaraunt Setting', style: TextStyle(color: Colors.white),),
                trailing: Switch.adaptive(
                  value: provider.isDailyRestaurantActive, 
                  onChanged: (value) async {
                    if(Platform.isIOS) {
                      customDialog(context);
                    } else {
                      scheduled.scheduledRestaurants(value);
                      provider.enableDailyRestaurant(value);
                    }
                  }
                  ),
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildList(context);
  }
}