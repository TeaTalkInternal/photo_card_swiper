import 'package:flutter/material.dart';
import 'package:photo_card_swiper/models/photo_card.dart';
import 'package:photo_card_swiper/photo_card_swiper.dart';

class ExamplePageWidget extends StatefulWidget {
  List<PhotoCard> _photos = [
    PhotoCard(
      title: 'Sonu Sood',
      description: 'A man with million hearts.',
      imageName: 'pic_0',
    ),
    PhotoCard(
      title: 'Dr APJ Abdul Kalam',
      description: 'An inspiration to many.',
      imageName: 'pic_2',
    ),
    PhotoCard(
      title: 'Anand Kumar',
      description: 'An mathematics pioneer.',
      imageName: 'pic_4',
    ),
  ];

  @override
  _ExamplePageWidgetState createState() => _ExamplePageWidgetState();
}

class _ExamplePageWidgetState extends State<ExamplePageWidget> {
  @override
  void initState() {
    super.initState();
  }

  //Simple Demo UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DiscoverAppBarWidget(),
            Expanded(
              child: Stack(
                children: [
                  NoMoreDataWidget(),
                  //Call PhotoCardSwiper widget here
                  PhotoCardSwiper(
                    photos: widget._photos,
                    cardSwiped: _cardSwiped,
                    showLoading: true,
                    hideCenterButton: false,
                    leftButtonIcon: Icons.close,
                    rightButtonIcon: Icons.check,
                    centerButtonIcon: Icons.favorite,
                    leftButtonBackgroundColor: Colors.red[100],
                    leftButtonIconColor: Colors.red[600],
                    centerButtonBackgroundColor: Colors.lightBlue[50],
                    centerButtonIconColor: Colors.lightBlue[600],
                    rightButtonBackgroundColor: Colors.lightGreen[100],
                    rightButtonIconColor: Colors.lightGreen[700],
                    leftButtonAction: _leftButtonClicked,
                    centerButtonAction: _centerButtonClicked,
                    rightButtonAction: _rightButtonClicked,
                    onCardTap: _onCardTap,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20.0,
            )
          ],
        ),
      ),
    );
  }

//Example method to load more photos asynchronously
  void _loadMorePhotos() {
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        widget._photos = [
          PhotoCard(
            title: 'Salumarada Thimmakka',
            description: 'A inspiring  environmentalist.',
            imageName: 'pic_1',
          ),
          PhotoCard(
            title: 'Kareem Bhai',
            description: 'An Unsung hero.',
            imageName: 'pic_3',
          ),
        ];
      });
    });
  }

//Callbacks from  SwipeCardsLayoutWidget
  void _onCardTap(int _index) {
    print('Card with index $_index is Tapped.');
    //Here you can navigate to detail screen or so.
  }

  void _cardSwiped(CardActionDirection _direction, int _index) {
    print('Swiped Direction ${_direction.toString()} Index $_index');
    //This is just an example to show how one can load more cards.
    //you can skip using this method if you have predefined list of photos array.
    if (_index == (widget._photos.length - 1)) {
      _loadMorePhotos();
    }
  }

  void _leftButtonClicked() {
    print('Left button clicked');
  }

  void _centerButtonClicked() {
    print('Center button clicked');
  }

  void _rightButtonClicked() {
    print('Right button clicked');
  }
}

//Secondary Widgets
class NoMoreDataWidget extends StatelessWidget {
  const NoMoreDataWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 150,
        child: Column(
          children: [
            Icon(
              Icons.error,
              size: 60.0,
              color: Colors.grey,
            ),
            Text(
              'No more data found.',
              style: TextStyle(
                fontSize: 17.0,
                color: Colors.grey[400],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class DiscoverAppBarWidget extends StatelessWidget {
  const DiscoverAppBarWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 60.0,
        left: 20.0,
        bottom: 10.0,
      ),
      child: Text(
        'Unsung Heros',
        style: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 32.0,
            color: Colors.grey[850]),
      ),
    );
  }
}
