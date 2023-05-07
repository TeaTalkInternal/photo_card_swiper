import 'package:photo_card_swiper/models/photo_card.dart';
import 'package:flutter/material.dart';

class PhotoDescriptionWidget extends StatelessWidget {
  const PhotoDescriptionWidget({
    Key? key,
    required this.photoCard,
  }) : super(key: key);

  final PhotoCard photoCard;

  @override
  Widget build(BuildContext context) {
    return Text(
      '${photoCard.description}',
      style: TextStyle(
        fontSize: 17.0,
        fontWeight: FontWeight.normal,
        color: Colors.grey[700],
      ),
      textAlign: TextAlign.center,
    );
  }
}
