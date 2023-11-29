import 'package:flutter/material.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/customer_review.dart';
import 'package:restaurant_app/data/model/restaurant_add_review_request.dart';
import 'package:restaurant_app/data/model/restaurant_detail_response.dart';
import 'package:restaurant_app/data/model/restaurant_list_response.dart';

enum ResultState { loading, noData, hasData, error }

class SearchProvider extends ChangeNotifier {
  bool _isSearch = false;

  bool get isSearch => _isSearch;

  void toggleSearch() {
    _isSearch = !isSearch;
    notifyListeners();
  }
}

class RestaurantListProvider extends ChangeNotifier {
  final ApiService apiService;
  String? query;

  RestaurantListProvider({required this.apiService, this.query = ''}) {
    _fetchAllRestaurant();
    if (query!.isNotEmpty) {
      _fetchAllRestaurantByQuery();
    }
  }

  late RestaurantListResponse _restaurantList;
  late ResultState _state;
  String _message = '';

  String get message => _message;

  RestaurantListResponse get restaurantList => _restaurantList;
  ResultState get state => _state;

  void setQuery(String q) {
    query = q;
    _fetchAllRestaurantByQuery();
  }

  Future<void> _fetchAllRestaurant() async {
    try {
      _state = ResultState.loading;
      notifyListeners();

      final list = await apiService.getRestaurantList();

      if (list.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        _restaurantList = list;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      _message = 'Terjadi kesalahan Internet';
    }
  }

  Future<dynamic> _fetchAllRestaurantByQuery() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final list = await apiService.getSearch(query: query!);
      if (list.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurantList = list;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Terjadi kesalahan Internet';
    }
  }
}

class RestaurantDetailProvider extends ChangeNotifier {
  final ApiService apiService;
  final String id;

  RestaurantDetailProvider({required this.apiService, required this.id}) {
    _fetchDetailRestaurant();
  }

  late RestaurantDetailResponse _restaurantDetail;
  late List<CustomerReview> _reviews;
  late ResultState _state;
  String _message = '';

  String get message => _message;

  RestaurantDetailResponse get restaurantDetail => _restaurantDetail;
  ResultState get state => _state;

  List<CustomerReview> get reviews => _reviews;

  late String _name;
  late String _review;

  Future<void> _fetchDetailRestaurant() async {
    try {
      _state = ResultState.loading;
      notifyListeners();

      final detail = await apiService.getRestaurantDetail(id);

      if (detail.restaurant.id.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        _restaurantDetail = detail;
        _reviews = detail.restaurant.customerReviews;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      _message = 'Terjadi kesalahan Internet';
    }
  }

  void _postReview(RestaurantAddReviewRequest request) async {
    try {
      _state = ResultState.loading;
      notifyListeners();

      final list = await apiService.postReview(request);

      if (list.customerReviews.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        _reviews = list.customerReviews;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      _message = 'Terjadi kesalahan Internet';
    }
  }

  void postReview() {
    RestaurantAddReviewRequest request =
        RestaurantAddReviewRequest(id: id, name: _name, review: _review);
    _postReview(request);
    notifyListeners();
  }

  void setName(String name) {
    _name = name;
  }

  void setReview(String review) {
    _review = review;
  }
}
