import 'package:evently/models/category_slider_model.dart';

class EventDataModel {
  String id;
  String title;
  String description;
  bool isFavourite;
  DateTime dateTime;
  CategoryValues categoryValues;
  double latitude;
  double longitude;
  String state;
  String country;

  EventDataModel({
    this.id = '',
    required this.title,
    required this.description,
    this.isFavourite = false,
    required this.dateTime,
    required this.categoryValues,
    required this.latitude,
    required this.longitude,
    required this.state,
    required this.country,
  });

  static List<EventDataModel> get dummyData => List.generate(
        8,
        (index) => EventDataModel(
            title: 'title$index',
            description: 'description$index ' * index * 2,
            isFavourite: index % 2 == 0,
            dateTime: DateTime(2025, 5, index),
            categoryValues: CategoryValues.bookClub,
            latitude: 0.0,
            longitude: 0.0,
            state: '',
            country: ''),
      );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'isFavourite': isFavourite,
      'dateTime': dateTime.millisecondsSinceEpoch,
      'categoryValues': categoryValues.toJson(),
      'latitude': latitude,
      'longitude': longitude,
      'state': state,
      'country': country
    };
  }

  static EventDataModel fromJson(Map<String, dynamic> json) {
    return EventDataModel(
        id: json['id'] ?? '',
        title: json['title'] ?? '',
        description: json['description'] ?? '',
        isFavourite: json['isFavourite'] ?? false,
        dateTime: DateTime.fromMillisecondsSinceEpoch(json['dateTime'] ?? 00),
        categoryValues: CategoryValues.fromJson(
            json['categoryValues'] ?? CategoryValues.all),
        latitude: json['latitude'] ?? 00,
        longitude: json['longitude'] ?? 00,
        state: json['state'] ?? 'unknown',
        country: json['country'] ?? 'unknown');
  }
}
