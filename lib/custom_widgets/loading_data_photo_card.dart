import 'package:photo_card_swiper/custom_widgets/shimmer_loading_widget.dart';
import 'package:flutter/material.dart';
import '../animations/shimmer.dart';

const _shimmerGradient = LinearGradient(
  colors: [
    Color(0xFFEBEBF4),
    Color(0xFFF4F4F4),
    Color(0xFFEBEBF4),
  ],
  stops: [
    0.1,
    0.3,
    0.4,
  ],
  begin: Alignment(-1.0, -0.3),
  end: Alignment(1.0, 0.3),
  tileMode: TileMode.clamp,
);

class LoadingDataPhotoCardWidget extends StatelessWidget {
  final double cardHeight;
  final double cardWidth;
  final bool isLoading;
  final bool hideCenterButton;

  LoadingDataPhotoCardWidget({
    required this.cardHeight,
    required this.cardWidth,
    required this.isLoading,
    required this.hideCenterButton,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      linearGradient: _shimmerGradient,
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
              child: DefaultPhotoContainerWidget(
                isLoading: isLoading,
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
                      ClipOval(
                        child: Material(
                          color: Colors.grey[200],
                          child: DefaultLeftButtonContainerWidget(
                            isLoading: isLoading,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20.0,
                      ),
                      hideCenterButton
                          ? Container()
                          : ClipOval(
                              child: Material(
                                color: Colors.grey[200],
                                child: DefaultCenterButtonContainerWidget(
                                  isLoading: isLoading,
                                ),
                              ),
                            ),
                      SizedBox(
                        width: 20.0,
                      ),
                      ClipOval(
                        child: Material(
                          color: Colors.grey[200],
                          child: DefaultRightButtonContainerWidget(
                            isLoading: isLoading,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  DefaultTitleContainerWidget(
                    isLoading: isLoading,
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  DefaultDescriptionContainerWidget(
                    isLoading: isLoading,
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

//All Sub widgtes which are defaulted to grey color
class DefaultDescriptionContainerWidget extends StatelessWidget {
  const DefaultDescriptionContainerWidget({
    Key? key,
    required this.isLoading,
  }) : super(key: key);
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return ShimmerLoading(
      isLoading: isLoading,
      child: Container(
        width: 200.0,
        height: 17.0,
        color: Colors.grey[200],
      ),
    );
  }
}

class DefaultTitleContainerWidget extends StatelessWidget {
  const DefaultTitleContainerWidget({
    Key? key,
    required this.isLoading,
  }) : super(key: key);
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return ShimmerLoading(
      isLoading: isLoading,
      child: Container(
        height: 36.0,
        width: 150.0,
        color: Colors.grey[200],
      ),
    );
  }
}

class DefaultRightButtonContainerWidget extends StatelessWidget {
  const DefaultRightButtonContainerWidget({
    Key? key,
    required this.isLoading,
  }) : super(key: key);
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return ShimmerLoading(
      isLoading: isLoading,
      child: Container(
        color: Colors.grey[200],
        width: 65,
        height: 65,
      ),
    );
  }
}

class DefaultCenterButtonContainerWidget extends StatelessWidget {
  const DefaultCenterButtonContainerWidget({
    Key? key,
    required this.isLoading,
  }) : super(key: key);
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return ShimmerLoading(
      isLoading: isLoading,
      child: Container(
        color: Colors.grey[200],
        width: 85,
        height: 85,
      ),
    );
  }
}

class DefaultLeftButtonContainerWidget extends StatelessWidget {
  const DefaultLeftButtonContainerWidget({
    Key? key,
    required this.isLoading,
  }) : super(key: key);
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return ShimmerLoading(
      isLoading: isLoading,
      child: Container(
        color: Colors.grey[200],
        width: 65,
        height: 65,
      ),
    );
  }
}

class DefaultPhotoContainerWidget extends StatelessWidget {
  const DefaultPhotoContainerWidget({
    Key? key,
    required this.isLoading,
  }) : super(key: key);
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return ShimmerLoading(
      isLoading: isLoading,
      child: Container(
        child: Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25.0),
            color: Colors.grey[200],
          ),
          margin: const EdgeInsets.all(10.0),
        ),
      ),
    );
  }
}
