import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/restaurant_list_response.dart';
import 'package:restaurant_app/provider/RestaurantProvider.dart';
import 'package:restaurant_app/provider/db_provider.dart';
import 'package:restaurant_app/ui/restaurant_review.dart';
import 'package:http/http.dart' as http;


class DetailRestaurantScreen extends StatelessWidget {
  static const routeName = '/detail_restaurant';
  final String id;

  const DetailRestaurantScreen({Key? key, required this.id}) : super(key: key);

  Widget _buildList(BuildContext context) {
    return ChangeNotifierProvider<RestaurantDetailProvider>(
      create: (_) => RestaurantDetailProvider(apiService: ApiService(http.Client()), id: id),
      child: Consumer<RestaurantDetailProvider>(
        builder: (context, result, _) {
          if (result.state == ResultState.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (result.state == ResultState.hasData) {
            Restaurant restaurant = Restaurant(
                id: result.restaurantDetail.restaurant.id,
                name: result.restaurantDetail.restaurant.name,
                description: result.restaurantDetail.restaurant.description,
                pictureId: result.restaurantDetail.restaurant.pictureId,
                city: result.restaurantDetail.restaurant.city,
                rating: result.restaurantDetail.restaurant.rating);
            return Scaffold(
              backgroundColor: const Color(0xFF162B58),
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.only(left: 16, right: 16),
                        child: Row(
                          children: <Widget>[
                            IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              result.restaurantDetail.restaurant.name,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const Spacer(),
                            FavoriteButton(
                              restaurant: restaurant,
                            ),
                            IconButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, RestaurantReview.routeName,
                                    arguments: id);
                              },
                              icon: const Icon(
                                Icons.reviews,
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16),
                          ),
                          color: Color(0xFF264085),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: Image.network(
                                  'https://restaurant-api.dicoding.dev/images/large/${result.restaurantDetail.restaurant.pictureId}',
                                ),
                              ),
                              const SizedBox(height: 16),
                              Row(
                                children: <Widget>[
                                  Text(
                                    result.restaurantDetail.restaurant.name,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const Spacer(),
                                  const Icon(
                                    Icons.star,
                                    color: Colors.yellow,
                                    size: 32,
                                  ),
                                  Text(
                                    '${result.restaurantDetail.restaurant.rating}',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    result.restaurantDetail.restaurant.city,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  Text(
                                    result.restaurantDetail.restaurant.address,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              Text(
                                result.restaurantDetail.restaurant.description,
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.justify,
                              ),
                              const SizedBox(height: 20),
                              const Text(
                                'Menu',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                'Makanan',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                              const SizedBox(height: 8),
                              SizedBox(
                                height: 100,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: result.restaurantDetail.restaurant
                                      .menus.foods.length,
                                  itemBuilder: (context, index) {
                                    return Card(
                                      color: Colors.white,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            'assets/ramen.gif',
                                            height: 60,
                                          ),
                                          Text(
                                            '  ${result.restaurantDetail.restaurant.menus.foods[index].name}  ',
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                'Minuman',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                              const SizedBox(height: 8),
                              SizedBox(
                                height: 100,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: result.restaurantDetail.restaurant
                                      .menus.drinks.length,
                                  itemBuilder: (context, index) {
                                    return Card(
                                      color: Colors.white,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            'assets/cocktail.gif',
                                            height: 60,
                                          ),
                                          Text(
                                            '  ${result.restaurantDetail.restaurant.menus.drinks[index].name}  ',
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return Scaffold(
              backgroundColor: const Color(0xFF162B58),
              appBar: AppBar(
                backgroundColor: const Color(0xFF162B58),
                title: const Text('Restaurant Detail', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),),
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white,),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(Icons.error, color: Colors.amber, size: 64,),
                    Text(result.message, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24),),
                  ],
                ),
              ),
            );
          } 
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildList(context);
  }
}

class FavoriteButton extends StatefulWidget {
  final Restaurant restaurant;
  const FavoriteButton({Key? key, required this.restaurant}) : super(key: key);

  @override
  State<FavoriteButton> createState() => _FavoriteButton();
}

class _FavoriteButton extends State<FavoriteButton> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DbProvider>(
      create: (_) => DbProvider(),
      child: Consumer<DbProvider>(
        builder: (context, result, _) {
          List<Restaurant> data = result.restaurant;
          bool isFavorite =
              data.any((restaurant) => restaurant.id == widget.restaurant.id);
          return IconButton(
            onPressed: () {
              if (isFavorite) {
                result.deleteRestaurant(widget.restaurant.id);
              } else {
                result.addRestaurant(widget.restaurant);
              }
            },
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? Colors.red : Colors.white,
            ),
          );
        },
      ),
    );
  }
}
