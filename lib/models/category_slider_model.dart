import 'package:evently/common/app_assets.dart';
import 'package:flutter/material.dart';

class CategorySliderModel {
  CategoryValues categoryValues;
  String title;
  IconData icon;

  CategorySliderModel(
      {required this.categoryValues, required this.title, required this.icon});

  static List<CategorySliderModel> get homeTabCategory => [
        CategorySliderModel(
            categoryValues: CategoryValues.all,
            title: CategoryValues.all.name,
            icon: Icons.explore_outlined),
        CategorySliderModel(
            categoryValues: CategoryValues.sport,
            title: CategoryValues.sport.name,
            icon: Icons.directions_bike_outlined),
        CategorySliderModel(
            categoryValues: CategoryValues.birthday,
            title: CategoryValues.birthday.name,
            icon: Icons.cake_outlined),
        CategorySliderModel(
            categoryValues: CategoryValues.bookClub,
            title: CategoryValues.bookClub.name,
            icon: Icons.menu_book_outlined),
        CategorySliderModel(
            categoryValues: CategoryValues.meeting,
            title: CategoryValues.meeting.name,
            icon: Icons.meeting_room_outlined),
        CategorySliderModel(
            categoryValues: CategoryValues.gaming,
            title: CategoryValues.gaming.name,
            icon: Icons.videogame_asset_outlined),
        CategorySliderModel(
            categoryValues: CategoryValues.eating,
            title: CategoryValues.eating.name,
            icon: Icons.fastfood_outlined),
        CategorySliderModel(
            categoryValues: CategoryValues.holiday,
            title: CategoryValues.holiday.name,
            icon: Icons.family_restroom_outlined),
        CategorySliderModel(
            categoryValues: CategoryValues.exhibition,
            title: CategoryValues.exhibition.name,
            icon: Icons.chair_outlined),
        CategorySliderModel(
            categoryValues: CategoryValues.workshop,
            title: CategoryValues.workshop.name,
            icon: Icons.carpenter_outlined),
      ];

  static List<CategorySliderModel> get createEventScreenCategory => [
        CategorySliderModel(
            categoryValues: CategoryValues.bookClub,
            title: CategoryValues.bookClub.name,
            icon: Icons.menu_book_outlined),
        CategorySliderModel(
            categoryValues: CategoryValues.sport,
            title: CategoryValues.sport.name,
            icon: Icons.directions_bike_outlined),
        CategorySliderModel(
            categoryValues: CategoryValues.birthday,
            title: CategoryValues.birthday.name,
            icon: Icons.cake_outlined),
        CategorySliderModel(
            categoryValues: CategoryValues.meeting,
            title: CategoryValues.meeting.name,
            icon: Icons.meeting_room_outlined),
        CategorySliderModel(
            categoryValues: CategoryValues.gaming,
            title: CategoryValues.gaming.name,
            icon: Icons.videogame_asset_outlined),
        CategorySliderModel(
            categoryValues: CategoryValues.eating,
            title: CategoryValues.eating.name,
            icon: Icons.fastfood_outlined),
        CategorySliderModel(
            categoryValues: CategoryValues.holiday,
            title: CategoryValues.holiday.name,
            icon: Icons.family_restroom_outlined),
        CategorySliderModel(
            categoryValues: CategoryValues.exhibition,
            title: CategoryValues.exhibition.name,
            icon: Icons.chair_outlined),
        CategorySliderModel(
            categoryValues: CategoryValues.workshop,
            title: CategoryValues.workshop.name,
            icon: Icons.carpenter_outlined),
        CategorySliderModel(
            categoryValues: CategoryValues.all,
            title: CategoryValues.all.name,
            icon: Icons.explore_outlined),
      ];
}

enum CategoryValues {
  all,
  sport,
  birthday,
  bookClub,
  meeting,
  gaming,
  eating,
  holiday,
  exhibition,
  workshop;

  String toTitle() {
    return name[0].toUpperCase() + name.substring(1);
  }

  String getImage(bool? isDark) {
    switch (this) {
      case CategoryValues.all:
        return isDark == true
            ? AppImages.allImageDark
            : AppImages.allImageLight;
      case CategoryValues.sport:
        return isDark == true
            ? AppImages.sportImageDark
            : AppImages.sportImageLight;
      case CategoryValues.birthday:
        return isDark == true
            ? AppImages.birthdayImageDark
            : AppImages.birthdayImageLight;
      case CategoryValues.bookClub:
        return isDark == true
            ? AppImages.bookClubImageDark
            : AppImages.bookClubImageLight;
      //
      case CategoryValues.meeting:
        return isDark == true
            ? AppImages.meetingImageDark
            : AppImages.meetingImageLight;
      case CategoryValues.gaming:
        return isDark == true
            ? AppImages.gamingImageDark
            : AppImages.gamingImageLight;
      case CategoryValues.eating:
        return isDark == true
            ? AppImages.eatingImageDark
            : AppImages.eatingImageLight;
      case CategoryValues.holiday:
        return isDark == true
            ? AppImages.holidayImageDark
            : AppImages.holidayImageLight;
      case CategoryValues.exhibition:
        return isDark == true
            ? AppImages.exhibitionImageDark
            : AppImages.exhibitionImageLight;
      case CategoryValues.workshop:
        return isDark == true
            ? AppImages.workshopImageDark
            : AppImages.workshopImageLight;
    }
  }

  String getName(isEnglish) {
    if (isEnglish) {
      return toTitle();
    } else if (name == all.name) {
      return 'الكل';
    } else if (name == sport.name) {
      return 'رياضة';
    } else if (name == birthday.name) {
      return 'عيد ميلاد';
    } else if (name == bookClub.name) {
      return 'نادي الكتاب';
    } else if (name == meeting.name) {
      return 'مقابلة';
    } else if (name == gaming.name) {
      return 'الألعاب';
    } else if (name == eating.name) {
      return 'الأكل';
    } else if (name == holiday.name) {
      return 'عطلة';
    } else if (name == exhibition.name) {
      return 'معرض';
    } else {
      return 'ورشة عمل';
    }
  }

  String toJson() {
    return name;
  }

  static CategoryValues fromJson(String json) {
    if (json == sport.name) {
      return sport;
    } else if (json == birthday.name) {
      return birthday;
    } else if (json == bookClub.name) {
      return bookClub;
    } else if (json == meeting.name) {
      return meeting;
    } else if (json == gaming.name) {
      return gaming;
    } else if (json == eating.name) {
      return eating;
    } else if (json == holiday.name) {
      return holiday;
    } else if (json == exhibition.name) {
      return exhibition;
    } else if (json == workshop.name) {
      return workshop;
    } else {
      return all;
    }
  }
}
