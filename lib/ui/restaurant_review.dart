import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/customer_review.dart';
import 'package:restaurant_app/provider/RestaurantProvider.dart';
import 'package:restaurant_app/widget/restaurant_add_review.dart';
import 'package:http/http.dart' as http;

class RestaurantReview extends StatelessWidget {
  static const routeName = '/restaurant_review';
  final String id;
  const RestaurantReview({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RestaurantDetailProvider>(
      create: (_) => RestaurantDetailProvider(apiService: ApiService(http.Client()), id: id),
      child: Scaffold(
        backgroundColor: const Color(0xFF162B58),
        appBar: AppBar(
          backgroundColor: const Color(0xFF162B58),
          title: const Text(
            'Restaurant Review',
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
          ),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: [
            IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AddReviewCard(id: id);
                      });
                },
                icon: const Icon(
                  Icons.add_circle,
                  color: Colors.white,
                ))
          ],
        ),
        body: Consumer<RestaurantDetailProvider>(
          builder: (context, state, _) {
            if (state.state == ResultState.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state.state == ResultState.hasData) {
              List<CustomerReview> reviews = state.reviews;
              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: reviews.length,
                itemBuilder: (context, index) {
                  final review = state.restaurantDetail.restaurant
                      .customerReviews[reviews.length - index - 1];
                  final name = review.name.length > 20
                      ? '${review.name.substring(0, 20)}..'
                      : review.name;
                  return Card(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Row(
                            children: [
                              Text(name),
                              const Spacer(),
                              Text(review.date)
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 16, right: 16, bottom: 16),
                          child: Text('"${review.review}"',
                              style: const TextStyle(
                                  fontStyle: FontStyle.italic,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black)),
                        ),
                      ],
                    ),
                  );
                },
              );
            } else {
              return const Center(
                child: Text(
                  'Review Belum ada',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
