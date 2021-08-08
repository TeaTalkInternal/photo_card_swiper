library photo_card_swiper;

import 'package:flutter/material.dart';
import 'package:photo_card_swiper/custom_widgets/feedback_photo_card_widget.dart';
import 'package:photo_card_swiper/custom_widgets/loading_data_photo_card.dart';
import 'package:photo_card_swiper/custom_widgets/photo_card_layout_widget.dart';
import 'package:photo_card_swiper/models/photo_card.dart';
import 'package:photo_card_swiper/notifiers/feedback_photo_card_value_notifier.dart';

//State of card movement
enum CardActionDirection {
  cardRightAction,
  cardLeftAction,
  cardCenterAction,
  cardActionNone
}

const String _stackViewKey = 'photo_card_stack_view';

class PhotoCardSwiper extends StatefulWidget {
  final List<PhotoCard> photos;
  final Function? cardSwiped;
  final bool showLoading;
  final bool hideCenterButton;
  final bool hideTitleText;
  final bool hideDescriptionText;
  final BoxFit imageScaleType;
  final Color? imageBackgroundColor;
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

  PhotoCardSwiper({
    required this.photos,
    this.cardSwiped,
    this.showLoading = true,
    this.imageScaleType = BoxFit.cover,
    this.imageBackgroundColor = Colors.black87,
    this.hideCenterButton = false,
    this.hideTitleText = false,
    this.hideDescriptionText = false,
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
  });
  @override
  _PhotoCardSwiperState createState() => _PhotoCardSwiperState();
}

class _PhotoCardSwiperState extends State<PhotoCardSwiper> {
  final double _topPadding = 10.0;
  final double _bottomPadding = 35.0;
  final double _offset = 6.0;
  final double _leftPadding = 15.0;
  final double _rightPadding = 15.0;
  List<PhotoCard> _updatedPhotos = [];
  List<PhotoCard> _reversedPhotos = [];

  //States for photo card layout widget
  bool _isPhotoCardLeftOverlayShown = false;
  bool _isPhotoCardRightOverlayShown = false;
  bool _isPhotoCardCenterOverlayShown = false;

  FeedbackPhotoCardValueNotifier _feedbackPhotoCardValueNotifier =
      FeedbackPhotoCardValueNotifier();

  @override
  void initState() {
    super.initState();
    _reversedPhotos = widget.photos.reversed.toList();
    _updatedPhotos = _reversedPhotos;
  }

  @override
  void didUpdateWidget(covariant PhotoCardSwiper oldWidget) {
    super.didUpdateWidget(oldWidget);
    _reversedPhotos = widget.photos.reversed.toList();
    setState(() {
      _updatedPhotos = _reversedPhotos;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double _maxHeight = constraints.maxHeight;
        final double _maxWidth = constraints.maxWidth;
        final int _totalPhotos = _updatedPhotos.length;
        final double _extraOffset = _totalPhotos * _offset;
        final double _cardHeight =
            _maxHeight - (_topPadding + _bottomPadding + _extraOffset);
        final double _cardWidth = _maxWidth - (_leftPadding + _rightPadding);

        return Container(
          padding: EdgeInsets.only(
              left: 15.0,
              bottom: _bottomPadding,
              top: _topPadding,
              right: 15.0),
          child: (_updatedPhotos.length == 0 && widget.showLoading)
              ? LoadingDataPhotoCardWidget(
                  cardHeight: _cardHeight,
                  cardWidth: _cardWidth,
                  hideCenterButton: widget.hideCenterButton,
                  isLoading: true)
              : Stack(
                  key: Key(_stackViewKey),
                  children: _updatedPhotos.map(
                    (_updatedPhoto) {
                      final _index = _reversedPhotos.indexWhere((_photo) {
                        return _photo.cardId.toLowerCase() ==
                            _updatedPhoto.cardId.toLowerCase();
                      });

                      final _reverseOffset =
                          (_updatedPhotos.length - 1) - _index;
                      final _topOffsetForCard = _offset * _reverseOffset;

                      final _updatedCardHeight =
                          _cardHeight - (_offset * (_index));

                      final _tapIndex = (widget.photos.length - 1) - _index;

                      return Positioned(
                        top: _topOffsetForCard,
                        child: Draggable(
                          axis: Axis.horizontal,
                          childWhenDragging: Container(),
                          maxSimultaneousDrags: 1,
                          onDragCompleted: () {
                            _hideAllPhotoCardOverlayWidgets();
                          },
                          onDragStarted: () {},
                          onDragEnd: (details) {
                            _hideAllPhotoCardOverlayWidgets();
                            if (details.offset.dx > 150.0) {
                              _updatedPhotos.removeAt(_index);
                              _likeCard(forIndex: _index);
                            } else if (details.offset.dx < -150.0) {
                              _updatedPhotos.removeAt(_index);
                              _unlikeCard(forIndex: _index);
                            }
                          },
                          onDragUpdate: (DragUpdateDetails details) {
                            if (details.delta.dx < -3) {
                              _feedbackPhotoCardValueNotifier
                                  .updateCardSwipeActionValue(
                                      value:
                                          CardActionDirection.cardLeftAction);
                            } else if (details.delta.dx > 3) {
                              _feedbackPhotoCardValueNotifier
                                  .updateCardSwipeActionValue(
                                      value:
                                          CardActionDirection.cardRightAction);
                            }
                          },
                          feedback: FeedbackPhotoCardWidget(
                            cardHeight: _updatedCardHeight,
                            cardWidth: _cardWidth,
                            photoCard: _updatedPhoto,
                            leftButtonIcon: widget.leftButtonIcon,
                            rightButtonIcon: widget.rightButtonIcon,
                            centerButtonIcon: widget.centerButtonIcon,
                            hideCenterButton: widget.hideCenterButton,
                            hideTitleText: widget.hideTitleText,
                            hideDescriptionText: widget.hideDescriptionText,
                            imageScaleType: widget.imageScaleType,
                            imageBackgroundColor: widget.imageBackgroundColor,
                            feedbackPhotoCardValueNotifier:
                                _feedbackPhotoCardValueNotifier,
                            leftButtonIconColor: widget.leftButtonIconColor,
                            leftButtonBackgroundColor:
                                widget.leftButtonBackgroundColor,
                            centerButtonBackgroundColor:
                                widget.centerButtonBackgroundColor,
                            centerButtonIconColor: widget.centerButtonIconColor,
                            rightButtonBackgroundColor:
                                widget.rightButtonBackgroundColor,
                            rightButtonIconColor: widget.rightButtonIconColor,
                          ),
                          child: PhotoCardLayoutWidget(
                            cardHeight: _updatedCardHeight,
                            cardWidth: _cardWidth,
                            imageScaleType: widget.imageScaleType,
                            imageBackgroundColor: widget.imageBackgroundColor,
                            hideCenterButton: widget.hideCenterButton,
                            hideTitleText: widget.hideTitleText,
                            hideDescriptionText: widget.hideDescriptionText,
                            photoCard: _updatedPhoto,
                            leftButtonIcon: widget.leftButtonIcon,
                            rightButtonIcon: widget.rightButtonIcon,
                            centerButtonIcon: widget.centerButtonIcon,
                            isLeftOverlayShown: _isPhotoCardLeftOverlayShown,
                            isCenterOverlayShown:
                                _isPhotoCardCenterOverlayShown,
                            isRightOverlayShown: _isPhotoCardRightOverlayShown,
                            leftButtonIconColor: widget.leftButtonIconColor,
                            leftButtonBackgroundColor:
                                widget.leftButtonBackgroundColor,
                            centerButtonBackgroundColor:
                                widget.centerButtonBackgroundColor,
                            centerButtonIconColor: widget.centerButtonIconColor,
                            rightButtonBackgroundColor:
                                widget.rightButtonBackgroundColor,
                            rightButtonIconColor: widget.rightButtonIconColor,
                            onCardTap: widget.onCardTap,
                            photoIndex: _tapIndex,
                            leftButtonAction: () {
                              setState(() {
                                _showLeftPhotoCardOverlayWidget();
                              });
                              Future.delayed(Duration(milliseconds: 500), () {
                                _updatedPhotos.removeAt(_index);
                                _unlikeCard(forIndex: _index);
                                _hideAllPhotoCardOverlayWidgets();
                                if (widget.leftButtonAction != null) {
                                  widget.leftButtonAction!();
                                }
                              });
                            },
                            centerButtonAction: () {
                              setState(() {
                                _showCenterPhotoCardOverlayWidget();
                              });
                              Future.delayed(Duration(milliseconds: 500), () {
                                _updatedPhotos.removeAt(_index);
                                _favoriteCard(forIndex: _index);

                                _hideAllPhotoCardOverlayWidgets();
                                if (widget.centerButtonAction != null) {
                                  widget.centerButtonAction!();
                                }
                              });
                            },
                            rightButtonAction: () {
                              setState(() {
                                _showRightPhotoCardOverlayWidget();
                              });
                              Future.delayed(Duration(milliseconds: 500), () {
                                _updatedPhotos.removeAt(_index);
                                _likeCard(forIndex: _index);
                                _hideAllPhotoCardOverlayWidgets();
                                if (widget.rightButtonAction != null) {
                                  widget.rightButtonAction!();
                                }
                              });
                            },
                          ),
                        ),
                      );
                    },
                  ).toList(),
                ),
        );
      },
    );
  }

//Hide show overlay widgets
  void _hideAllPhotoCardOverlayWidgets() {
    _isPhotoCardCenterOverlayShown = false;
    _isPhotoCardRightOverlayShown = false;
    _isPhotoCardLeftOverlayShown = false;
  }

  void _showLeftPhotoCardOverlayWidget() {
    _isPhotoCardCenterOverlayShown = false;
    _isPhotoCardRightOverlayShown = false;
    _isPhotoCardLeftOverlayShown = true;
  }

  void _showRightPhotoCardOverlayWidget() {
    _isPhotoCardCenterOverlayShown = false;
    _isPhotoCardRightOverlayShown = true;
    _isPhotoCardLeftOverlayShown = false;
  }

  void _showCenterPhotoCardOverlayWidget() {
    _isPhotoCardCenterOverlayShown = true;
    _isPhotoCardRightOverlayShown = false;
    _isPhotoCardLeftOverlayShown = false;
  }

  void _unlikeCard({required int forIndex}) {
    setState(() {
      if (widget.cardSwiped != null) {
        final _reverseOffset = (widget.photos.length - 1) - forIndex;
        widget.cardSwiped!(CardActionDirection.cardLeftAction, _reverseOffset);
      }
    });
  }

  void _likeCard({required int forIndex}) {
    setState(() {
      if (widget.cardSwiped != null) {
        final _reverseOffset = (widget.photos.length - 1) - forIndex;
        widget.cardSwiped!(CardActionDirection.cardRightAction, _reverseOffset);
      }
    });
  }

  void _favoriteCard({required int forIndex}) {
    setState(() {
      if (widget.cardSwiped != null) {
        final _reverseOffset = (widget.photos.length - 1) - forIndex;
        widget.cardSwiped!(
            CardActionDirection.cardCenterAction, _reverseOffset);
      }
    });
  }
}
