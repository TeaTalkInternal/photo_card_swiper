import 'dart:ui';

import 'package:photo_card_swiper/custom_widgets/photo_description_widget.dart';
import 'package:photo_card_swiper/custom_widgets/photo_title_widget.dart';
import 'package:photo_card_swiper/notifiers/feedback_photo_card_value_notifier.dart';
import 'package:photo_card_swiper/models/photo_card.dart';
import 'package:photo_card_swiper/photo_card_swiper.dart';
import 'package:flutter/material.dart';

class FeedbackPhotoCardWidget extends StatelessWidget {
  final PhotoCard photoCard;
  final double cardHeight;
  final double cardWidth;
  final bool hideCenterButton;
  final bool hideTitleText;
  final bool hideDescriptionText;
  final BoxFit imageScaleType;
  final Color? imageBackgroundColor;
  final FeedbackPhotoCardValueNotifier feedbackPhotoCardValueNotifier;
  final IconData? leftButtonIcon;
  final IconData? centerButtonIcon;
  final IconData? rightButtonIcon;
  final Color? leftButtonIconColor;
  final Color? leftButtonBackgroundColor;
  final Color? centerButtonIconColor;
  final Color? centerButtonBackgroundColor;
  final Color? rightButtonIconColor;
  final Color? rightButtonBackgroundColor;

  FeedbackPhotoCardWidget({
    required this.photoCard,
    required this.cardHeight,
    required this.cardWidth,
    required this.hideCenterButton,
    required this.hideTitleText,
    required this.hideDescriptionText,
    required this.imageScaleType,
    required this.imageBackgroundColor,
    required this.feedbackPhotoCardValueNotifier,
    this.leftButtonIcon,
    this.centerButtonIcon,
    this.rightButtonIcon,
    this.leftButtonIconColor,
    this.leftButtonBackgroundColor,
    this.centerButtonIconColor,
    this.centerButtonBackgroundColor,
    this.rightButtonIconColor,
    this.rightButtonBackgroundColor,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        height: cardHeight,
        width: cardWidth,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey[350] ?? Colors.black,
                blurRadius: 7.0,
                spreadRadius: 3.0,
                offset: Offset(2, 3),
              ),
            ]),
        child: Column(
          children: [
            Expanded(
              child: Container(
                child: Container(
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.0),
                    color: imageBackgroundColor,
                    image: photoCard.isLocalImage
                        ? DecorationImage(
                            image: AssetImage(
                              photoCard.imagePath,
                            ),
                            fit: imageScaleType,
                          )
                        : DecorationImage(
                            image: NetworkImage(
                              photoCard.imagePath,
                            ),
                            fit: imageScaleType,
                          ),
                  ),
                  margin: const EdgeInsets.all(10.0),
                  child: ValueListenableBuilder(
                    valueListenable: feedbackPhotoCardValueNotifier
                        .swipeDirectionValueNotifier,
                    builder: (_, CardActionDirection _cardActionDirection, __) {
                      switch (_cardActionDirection) {
                        case CardActionDirection.cardLeftAction:
                          return CardActionSpecifcOverlayWidget(
                            key: UniqueKey(),
                            buttonIconColor:
                                leftButtonIconColor ?? Colors.red[800],
                            buttonIcon: leftButtonIcon ?? Icons.close,
                            isVisible: true,
                          );
                        case CardActionDirection.cardCenterAction:
                          return CardActionSpecifcOverlayWidget(
                            key: UniqueKey(),
                            buttonIconColor:
                                centerButtonIconColor ?? Colors.lightBlue[600],
                            buttonIcon: centerButtonIcon ?? Icons.favorite,
                            isVisible: true,
                          );
                        case CardActionDirection.cardRightAction:
                          return CardActionSpecifcOverlayWidget(
                            key: UniqueKey(),
                            buttonIconColor:
                                rightButtonIconColor ?? Colors.lightGreen[700],
                            buttonIcon: rightButtonIcon ?? Icons.check,
                            isVisible: true,
                          );
                        default:
                          return Container();
                      }
                    },
                  ),
                ),
              ),
            ),
            Container(
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      LeftButtonWidget(
                        leftButtonBackgroundColor: leftButtonBackgroundColor,
                        leftButtonIconColor: leftButtonIconColor,
                        leftButtonIcon: leftButtonIcon,
                      ),
                      SizedBox(
                        width: 20.0,
                      ),
                      hideCenterButton
                          ? Container()
                          : CenterButtonWidget(
                              centerButtonBackgroundColor:
                                  centerButtonBackgroundColor,
                              centerButtonIconColor: centerButtonIconColor,
                              centerButtonIcon: centerButtonIcon,
                            ),
                      SizedBox(
                        width: 20.0,
                      ),
                      RightButtonWidget(
                        rightButtonBackgroundColor: rightButtonBackgroundColor,
                        rightButtonIconColor: rightButtonIconColor,
                        rightButtonIcon: rightButtonIcon,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Visibility(
                    visible: !hideTitleText,
                    child: PhotoTitleWidget(photoCard: photoCard),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Visibility(
                    visible: !hideDescriptionText,
                    child: PhotoDescriptionWidget(photoCard: photoCard),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//Sub-Widgets
class CardActionSpecifcOverlayWidget extends StatelessWidget {
  const CardActionSpecifcOverlayWidget({
    Key? key,
    required this.buttonIconColor,
    required this.buttonIcon,
    required this.isVisible,
  }) : super(key: key);

  final Color? buttonIconColor;
  final IconData buttonIcon;
  final bool isVisible;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: isVisible ? 1 : 0,
      duration: Duration(milliseconds: 5000),
      curve: Curves.easeOutBack,
      onEnd: () {},
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 2.0,
          sigmaY: 2.0,
        ),
        child: Container(
          color: Colors.white.withOpacity(0.3),
          child: Center(
              child: ClipOval(
            child: Container(
              width: 95,
              height: 95,
              color: Colors.white.withOpacity(0.7),
              child: Center(
                child: Icon(
                  buttonIcon,
                  color: buttonIconColor ?? Colors.red[800],
                  size: 55.0,
                ),
              ),
            ),
          )),
        ),
      ),
    );
  }
}

class CenterButtonWidget extends StatelessWidget {
  const CenterButtonWidget({
    Key? key,
    required this.centerButtonBackgroundColor,
    required this.centerButtonIconColor,
    required this.centerButtonIcon,
  }) : super(key: key);

  final Color? centerButtonBackgroundColor;
  final Color? centerButtonIconColor;
  final IconData? centerButtonIcon;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Material(
        shape: RoundedRectangleBorder(
          side: BorderSide(
              color: Colors.grey[200] ?? Colors.grey,
              width: 6,
              style: BorderStyle.solid),
          borderRadius: BorderRadius.circular(50),
        ),
        color: centerButtonBackgroundColor ?? Colors.lightBlue[50],
        child: InkWell(
          splashColor: Colors.white,
          child: SizedBox(
              width: 85,
              height: 85,
              child: Icon(
                centerButtonIcon ?? Icons.favorite,
                color: centerButtonIconColor ?? Colors.lightBlue[600],
                size: 50,
              )),
          onTap: () {},
        ),
      ),
    );
  }
}

class RightButtonWidget extends StatelessWidget {
  const RightButtonWidget({
    Key? key,
    required this.rightButtonBackgroundColor,
    required this.rightButtonIconColor,
    required this.rightButtonIcon,
  }) : super(key: key);

  final Color? rightButtonBackgroundColor;
  final Color? rightButtonIconColor;
  final IconData? rightButtonIcon;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Material(
        shape: RoundedRectangleBorder(
          side: BorderSide(
              color: Colors.grey[200] ?? Colors.grey,
              width: 6,
              style: BorderStyle.solid),
          borderRadius: BorderRadius.circular(50),
        ),
        color: rightButtonBackgroundColor ?? Colors.lightGreen[100],
        child: InkWell(
          splashColor: Colors.white,
          child: SizedBox(
              width: 65,
              height: 65,
              child: Icon(
                rightButtonIcon ?? Icons.check,
                color: rightButtonIconColor ?? Colors.lightGreen[700],
                size: 50,
              )),
          onTap: () {},
        ),
      ),
    );
  }
}

class LeftButtonWidget extends StatelessWidget {
  const LeftButtonWidget({
    Key? key,
    required this.leftButtonBackgroundColor,
    required this.leftButtonIconColor,
    required this.leftButtonIcon,
  }) : super(key: key);

  final Color? leftButtonBackgroundColor;
  final Color? leftButtonIconColor;
  final IconData? leftButtonIcon;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Material(
        shape: RoundedRectangleBorder(
          side: BorderSide(
              color: Colors.grey[200] ?? Colors.grey,
              width: 6,
              style: BorderStyle.solid),
          borderRadius: BorderRadius.circular(50),
        ),
        color: leftButtonBackgroundColor ?? Colors.red[100],
        child: InkWell(
          splashColor: Colors.white,
          child: SizedBox(
              width: 65,
              height: 65,
              child: Icon(
                leftButtonIcon ?? Icons.close,
                color: leftButtonIconColor ?? Colors.red[800],
                size: 50,
              )),
          onTap: () {},
        ),
      ),
    );
  }
}
