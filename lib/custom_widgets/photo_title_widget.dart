import 'package:photo_card_swiper/models/photo_card.dart';
import 'package:flutter/material.dart';

class PhotoTitleWidget extends StatelessWidget {
  const PhotoTitleWidget({
    Key? key,
    required this.photoCard,
  }) : super(key: key);

  final PhotoCard photoCard;

  @override
  Widget build(BuildContext context) {
    return Text(
      '${photoCard.title}',
      style: TextStyle(
        fontSize: 26.0,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      textAlign: TextAlign.center,
    );
  }
}
