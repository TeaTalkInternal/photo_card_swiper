import 'package:flutter/material.dart';

class PhotoCard {
  final String title;
  final String description;
  final String imagePath;
  final bool isLocalImage;
  final String cardId = UniqueKey().toString();

  PhotoCard({
    this.title = "",
    this.description = "",
    this.imagePath = "",
    this.isLocalImage = true,
  });
}
