import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/provider/RestaurantProvider.dart';
import 'package:restaurant_app/widget/item_restaurant.dart';
import 'package:restaurant_app/widget/bottom_navigation_bar.dart';
import 'package:http/http.dart' as http;


class RestaurantListScreen extends StatefulWidget {
  static const routeName = '/restaurant_list';

  const RestaurantListScreen({Key? key}) : super(key: key);

  @override
  State<RestaurantListScreen> createState() => _RestaurantListScreenState();
}

class _RestaurantListScreenState extends State<RestaurantListScreen> {
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Widget _buildList(BuildContext context) {
    return ChangeNotifierProvider<RestaurantListProvider>(
      create: (_) => RestaurantListProvider(apiService: ApiService(http.Client())),
      child: Consumer<RestaurantListProvider>(
        builder: (context, state, _) {
          return ChangeNotifierProvider(
            create: (_) => SearchProvider(),
            child: Consumer<SearchProvider>(
              builder: (context, searchProvider, _) {
                return Scaffold(
                  bottomNavigationBar: const CustomBottomNavigationBar(
                    currentIndex: 0,
                  ),
                  backgroundColor: const Color(0xFF162B58),
                  appBar: AppBar(
                    title: searchProvider.isSearch
                        ? TextField(
                            controller: _searchController,
                            style: const TextStyle(color: Colors.white),
                            decoration: const InputDecoration(
                              hintText: 'Cari Restaurant...',
                              hintStyle: TextStyle(color: Colors.white),
                              border: InputBorder.none,
                            ),
                            onSubmitted: (value) {
                              final provider =
                                  Provider.of<RestaurantListProvider>(context,
                                      listen: false);
                              if (value.isNotEmpty) {
                                provider.setQuery(value);
                              }
                            },
                          )
                        : const Text(
                            'Restaurant App',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                    actions: [
                      IconButton(
                        onPressed: () {
                          searchProvider.toggleSearch();
                          if (!searchProvider.isSearch) {
                            _searchController.clear();
                            final provider =
                                Provider.of<RestaurantListProvider>(
                              context,
                              listen: false,
                            );
                            provider.setQuery('');
                          }
                        },
                        icon: Icon(
                          searchProvider.isSearch ? Icons.close : Icons.search,
                          color: Colors.white,
                        ),
                      ),
                    ],
                    backgroundColor: const Color(0xFF162B58),
                  ),
                  body: _buildBody(context, state),
                );
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildBody(BuildContext context, RestaurantListProvider state) {
    if (state.state == ResultState.loading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (state.state == ResultState.hasData) {
      return _buildGridView(context, state);
    } else if (state.state == ResultState.noData) {
      return Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/empty-data.png',
            color: Colors.amber,
            height: 128,
            width: 128,
          ),
          Text(
            state.message,
            style: const TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      ));
    } else if (state.state == ResultState.error) {
      return Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/no-internet.png',
            color: Colors.amber,
            height: 128,
            width: 128,
          ),
          Text(
            state.message,
            style: const TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      ));
    } else {
      return const Center(
        child: Material(
          child: Text(''),
        ),
      );
    }
  }

  Widget _buildGridView(BuildContext context, RestaurantListProvider state) {
    return GridView.count(
      crossAxisCount: 2,
      childAspectRatio: 0.9,
      children: List.generate(
        state.restaurantList.restaurants.length,
        (index) {
          return itemRestaurant(
            context,
            state.restaurantList.restaurants[index],
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildList(context);
  }
}
