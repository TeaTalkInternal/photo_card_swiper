import 'package:flutter/material.dart';

class PhotoCard {
  final String title;
  final String description;
  final String imageName;
  final String cardId = UniqueKey().toString();

  PhotoCard({
    this.title = "",
    this.description = "",
    this.imageName = "",
  });

  String get imagePath => 'images/$imageName';
}
