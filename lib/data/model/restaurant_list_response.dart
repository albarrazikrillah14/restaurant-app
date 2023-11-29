class RestaurantListResponse {
  bool error;
  String message;
  int count;
  List<Restaurant> restaurants;

  RestaurantListResponse({
    required this.error,
    required this.message,
    required this.count,
    required this.restaurants,
  });

  factory RestaurantListResponse.fromJson(Map<String, dynamic> json) {
    List<Restaurant> restaurantList = [];

    if (json['restaurants'] != null) {
      restaurantList = List<Restaurant>.from(
        json['restaurants'].map((restaurantJson) => Restaurant.fromJson(restaurantJson)),
      );
    }

    return RestaurantListResponse(
      error: json["error"] ?? false,
      message: json["message"] ?? "",
      count: json["count"] ?? 0,
      restaurants: restaurantList,
    );
  }

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "count": count,
        "restaurants": List<dynamic>.from(restaurants.map((x) => x.toJson())),
      };
}

class Restaurant {
  String id;
  String name;
  String description;
  String pictureId;
  String city;
  double rating;

  Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      id: json["id"] ?? "",
      name: json["name"] ?? "",
      description: json["description"] ?? "",
      pictureId: json["pictureId"] ?? "",
      city: json["city"] ?? "",
      rating: json["rating"]?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "pictureId": pictureId,
        "city": city,
        "rating": rating,
      };
}
