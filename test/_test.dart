import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_app/data/model/restaurant_detail_response.dart';
import 'package:restaurant_app/data/model/restaurant_list_response.dart';

void main() {
  var dummyList = {
    "error": false,
    "message": "success",
    "count": 3,
    "restaurants": [
      {
        "id": "abc123",
        "name": "Cafe XYZ",
        "description": "Some description here.",
        "pictureId": "10",
        "city": "Jakarta",
        "rating": 4.2
      },
      {
        "id": "def456",
        "name": "Restaurant ABC",
        "description": "Another description.",
        "pictureId": "20",
        "city": "Bandung",
        "rating": 4.8
      },
      {
        "id": "ghi789",
        "name": "Food Haven",
        "description": "Lorem ipsum dolor sit amet.",
        "pictureId": "30",
        "city": "Surakarta",
        "rating": 4.5
      },
    ]
  };

  var dummyDetail = {
    "error": false,
    "message": "success",
    "restaurant": {
      "id": "abc123",
      "name": "Cafe XYZ",
      "description": "Some description here.",
      "city": "Jakarta",
      "address": "Some Address, Jakarta",
      "pictureId": "10",
      "categories": [
        {"name": "Western"},
        {"name": "Indonesian"}
      ],
      "menus": {
        "foods": [
          {"name": "Steak"},
          {"name": "Pasta"},
          {"name": "Burger"},
        ],
        "drinks": [
          {"name": "Coffee"},
          {"name": "Juice"},
          {"name": "Tea"},
        ]
      },
      "rating": 4.2,
    }
  };

  group('Restaurant Test', () {
    test('Parsing List Result JSON', () async {
      var result = RestaurantListResponse.fromJson(dummyList);

      expect(result.error, false);
      expect(result.message, "success");
      expect(result.count, 3);
      expect(result.restaurants[0].id, "abc123");
      expect(result.restaurants[1].id, "def456");
      expect(result.restaurants[2].id, "ghi789");
      expect(result.restaurants.length, 3);
    });

    test('Parsing Detail Result JSON', () async {
      var result = RestaurantDetailResponse.fromJson(dummyDetail);

      expect(result.error, false);
      expect(result.message, "success");
      expect(result.restaurant.id, "abc123");
      expect(result.restaurant.name, 'Cafe XYZ');
    });
  });
}
