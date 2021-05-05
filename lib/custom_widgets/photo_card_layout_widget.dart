import 'dart:ui';

import 'package:photo_card_swiper/custom_widgets/photo_description_widget.dart';
import 'package:photo_card_swiper/custom_widgets/photo_title_widget.dart';
import 'package:photo_card_swiper/models/photo_card.dart';
import 'package:flutter/material.dart';

class PhotoCardLayoutWidget extends StatefulWidget {
  final PhotoCard photoCard;
  final double cardHeight;
  final double cardWidth;
  final bool hideCenterButton;
  final bool isLeftOverlayShown;
  final bool isCenterOverlayShown;
  final bool isRightOverlayShown;
  final IconData? leftButtonIcon;
  final IconData? centerButtonIcon;
  final IconData? rightButtonIcon;
  final Color? leftButtonIconColor;
  final Color? leftButtonBackgroundColor;
  final Color? centerButtonIconColor;
  final Color? centerButtonBackgroundColor;
  final Color? rightButtonIconColor;
  final Color? rightButtonBackgroundColor;
  final Function? leftButtonAction;
  final Function? centerButtonAction;
  final Function? rightButtonAction;
  final Function? onCardTap;
  final int photoIndex;

  PhotoCardLayoutWidget({
    required this.photoCard,
    required this.cardHeight,
    required this.cardWidth,
    required this.hideCenterButton,
    required this.isLeftOverlayShown,
    required this.isCenterOverlayShown,
    required this.isRightOverlayShown,
    required this.photoIndex,
    this.leftButtonIcon,
    this.centerButtonIcon,
    this.rightButtonIcon,
    this.leftButtonIconColor,
    this.leftButtonBackgroundColor,
    this.centerButtonIconColor,
    this.centerButtonBackgroundColor,
    this.rightButtonIconColor,
    this.rightButtonBackgroundColor,
    this.leftButtonAction,
    this.centerButtonAction,
    this.rightButtonAction,
    this.onCardTap,
    Key? key,
  }) : super(key: key);

  @override
  _PhotoCardLayoutWidgetState createState() => _PhotoCardLayoutWidgetState();
}

class _PhotoCardLayoutWidgetState extends State<PhotoCardLayoutWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.onCardTap != null) {
          widget.onCardTap!(widget.photoIndex);
        }
      },
      child: Container(
        height: widget.cardHeight,
        width: widget.cardWidth,
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
                    image: DecorationImage(
                      image: AssetImage(
                        widget.photoCard.imagePath,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                  margin: const EdgeInsets.all(10.0),
                  child: Stack(
                    children: [
                      CardActionSpecifcOverlayWidget(
                        key: UniqueKey(),
                        buttonIconColor: widget.leftButtonIconColor,
                        buttonIcon: widget.leftButtonIcon ?? Icons.close,
                        isVisible: widget.isLeftOverlayShown,
                      ),
                      CardActionSpecifcOverlayWidget(
                        key: UniqueKey(),
                        buttonIconColor: widget.centerButtonIconColor,
                        buttonIcon: widget.centerButtonIcon ?? Icons.favorite,
                        isVisible: widget.isCenterOverlayShown,
                      ),
                      CardActionSpecifcOverlayWidget(
                        key: UniqueKey(),
                        buttonIconColor: widget.rightButtonIconColor,
                        buttonIcon: widget.rightButtonIcon ?? Icons.check,
                        isVisible: widget.isRightOverlayShown,
                      ),
                    ],
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
                        leftButtonBackgroundColor:
                            widget.leftButtonBackgroundColor,
                        leftButtonIconColor: widget.leftButtonIconColor,
                        leftButtonAction: widget.leftButtonAction,
                      ),
                      SizedBox(
                        width: 20.0,
                      ),
                      widget.hideCenterButton
                          ? Container()
                          : CenterButtonWidget(
                              centerButtonBackgroundColor:
                                  widget.centerButtonBackgroundColor,
                              centerButtonIconColor:
                                  widget.centerButtonIconColor,
                              centerButtonAction: widget.centerButtonAction,
                            ),
                      SizedBox(
                        width: 20.0,
                      ),
                      RightButtonWidget(
                        rightButtonBackgroundColor:
                            widget.rightButtonBackgroundColor,
                        rightButtonIconColor: widget.rightButtonIconColor,
                        rightButtonAction: widget.rightButtonAction,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  PhotoTitleWidget(photoCard: widget.photoCard),
                  SizedBox(
                    height: 5.0,
                  ),
                  PhotoDescriptionWidget(photoCard: widget.photoCard),
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
      duration: Duration(milliseconds: 500),
      curve: Curves.elasticOut,
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
    required this.centerButtonAction,
  }) : super(key: key);

  final Color? centerButtonBackgroundColor;
  final Color? centerButtonIconColor;
  final Function? centerButtonAction;

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
                Icons.favorite,
                color: centerButtonIconColor ?? Colors.lightBlue[600],
                size: 50,
              )),
          onTap: () {
            if (centerButtonAction != null) {
              centerButtonAction!();
            }
          },
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
    required this.rightButtonAction,
  }) : super(key: key);

  final Color? rightButtonBackgroundColor;
  final Color? rightButtonIconColor;
  final Function? rightButtonAction;

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
                Icons.check,
                color: rightButtonIconColor ?? Colors.lightGreen[700],
                size: 50,
              )),
          onTap: () {
            if (rightButtonAction != null) {
              rightButtonAction!();
            }
          },
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
    required this.leftButtonAction,
  }) : super(key: key);

  final Color? leftButtonBackgroundColor;
  final Color? leftButtonIconColor;
  final Function? leftButtonAction;

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
                Icons.close,
                color: leftButtonIconColor ?? Colors.red[800],
                size: 50,
              )),
          onTap: () {
            if (leftButtonAction != null) {
              leftButtonAction!();
            }
          },
        ),
      ),
    );
  }
}
