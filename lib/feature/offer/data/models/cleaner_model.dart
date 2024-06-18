// lib/feature/offer/data/models/cleaner_model.dart

class Cleaner {
  final String name;
  final String image;
  final String imageProfile;
  // final String description;
  // final double rating;
  // final int reviews;
  // final String location;
  // final String price;

  Cleaner({
    required this.name,
    required this.image,
    required this.imageProfile,
    // required this.description,
    // required this.rating,
    // required this.reviews,
    // required this.location,
    // required this.price,
  });

  factory Cleaner.fromJson(Map<String, dynamic> json) {
    return Cleaner(
      name: json['name'],
      image: json['image'],
      imageProfile: json['imageProfile'],
      // description: json['description'],
      // rating: json['rating'],
      // reviews: json['reviews'],
      // location: json['location'],
      // price: json['price'],
    );
  }
}
