import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:restaurant_app/data/model/restaurant_add_review_request.dart';
import 'package:restaurant_app/data/model/restaurant_add_review_response.dart';
import 'package:restaurant_app/data/model/restaurant_detail_response.dart';
import 'package:restaurant_app/data/model/restaurant_list_response.dart';

class ApiService {
  final http.Client client;
  static const String _baseUrl = 'https://restaurant-api.dicoding.dev/';

  ApiService(this.client);
  
  Future<RestaurantListResponse> getRestaurantList() async {
    final response = await http.get(Uri.parse('${_baseUrl}list'));

    if (response.statusCode == 200) {
      return RestaurantListResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Fail to load restaurant list');
    }
  }

  Future<RestaurantDetailResponse> getRestaurantDetail(String id) async {
    final response = await http.get(Uri.parse('${_baseUrl}detail/$id'));

    if (response.statusCode == 200) {
      return RestaurantDetailResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Fail to Load restaurant detail');
    }
  }

  Future<RestaurantAddReviewResponse> postReview(
      RestaurantAddReviewRequest request) async {
    final Map<String, dynamic> requestBody = {
      'id': request.id,
      'name': request.name,
      'review': request.review,
    };

    final response = await http.post(
      Uri.parse('${_baseUrl}review'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(requestBody),
    );
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return RestaurantAddReviewResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to add review');
    }
  }

  Future<RestaurantListResponse> getSearch({String query = ''}) async {
    final response = await http.get(Uri.parse('${_baseUrl}search?q=$query'),
        headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      return RestaurantListResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Data tidak ditemukan');
    }
  }
}
