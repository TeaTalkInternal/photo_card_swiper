# photo_card_swiper

- [photo_card_swiper](#photo_card_swiper)
- [How to use it.](#how-to-use-it)
- [parameters](#parameters)

Language: [English](README.md)

A simple flutter package for creating a swiping card layout for list of photos.

photo_card_swiper is a photo slider resembling card stack. Card comprises options to reflect like, dislike and favorite feature. The card elements are highly customisable. This layout is quite common in social media apps like Instagram, tinder etc.


# Technical Notes:
The layout for pages is built using stack of draggable widgets using LayoutBuilder.  This package supports cards to be tapped too.
Dev have options show 2 or 3 buttons, change the color, icon name and icon color of those buttons too.

![](https://github.com/TeaTalkInternal/github_assets/blob/master/gifs/photo_card_swiper.gif)

#  How to use it.

the usage is very simple, just use the following code for default rendering of photos. Default values for Icons and Colors are taken care for easy usage.

```dart
PhotoCardSwiper(
     photos: widget._photos,
     showLoading: false,
 ),
```
or use the following with customizations
```dart
 PhotoCardSwiper(
     photos: widget._photos,
     showLoading: true,
     hideCenterButton: false,
     leftButtonIcon: Icons.close,
     rightButtonIcon: Icons.check,
     centerButtonIcon: Icons.favorite,
     leftButtonBackgroundColor: Colors.red[100],
     rightButtonBackgroundColor: Colors.lightGreen[100],
     centerButtonBackgroundColor: Colors.lightBlue[50],
     leftButtonIconColor: Colors.red[600],
     rightButtonIconColor: Colors.lightGreen[700],
     centerButtonIconColor: Colors.lightBlue[600],
     leftButtonAction: _leftButtonClicked,
     rightButtonAction: _rightButtonClicked,
     centerButtonAction: _centerButtonClicked,
     onCardTap: _onCardTap,
     cardSwiped: _cardSwiped,
 ),
```

## Parameters for photo_card_swiper

| parameter                  | description                                                                           | value                                                                                                                                                                               |
| -------------------------- | ------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| photos                        | Array of Photo data to be rendered as cards, Use PhotoCard object to group card details.                                                                   |     \[PhotoCard]()                                                                                                                                                                              |
| showLoading          | Toggle the value to show/hide loading card                                            | This is a optional parameter. value cane be true/false                                                                                                                                                    |                                                    |
| hideCenterButton          | Use this to have only 2 action buttons.                                            | This is a optional parameter. Pass either true/false                                                                                                                                                    |
| leftButtonIcon          | Left button Icon                                            | This is a optional parameter. Pass IconData type value                                                                                                                                                    |
| rightButtonIcon          | Right button Icon                                            | This is a optional parameter. Pass IconData type value                                                                                                                                                    |
| centerButtonIcon          | Center button Icon                                            | This is a optional parameter. Pass IconData type value                                                                                                                                                                |
| leftButtonBackgroundColor          | Left button Background Color                                            | This is a optional parameter. Pass Color type value                                                                                                                                                               |
| rightButtonBackgroundColor          | Right button Background Color                                            | This is a optional parameter. Pass Color type value                                                                                                                                                                |
| centerButtonBackgroundColor          | Center button Background Color                                            | This is a optional parameter. Pass Color type value                                                                                                                                                                |
| leftButtonIconColor          | Left button Icon Color                                            | This is a optional parameter. Pass Color type value                                                                                                                                                                |
| rightButtonIconColor          | Right button Icon Color                                            | This is a optional parameter. Pass Color type value                                                                                                                                                               |
| centerButtonIconColor          | Center button Icon Color                                            | This is a optional parameter. Pass Color type value                                                                                                                                                                |
| leftButtonAction          | Left button click handler                                            | This is a optional parameter.  Pass method to be called on click.                                                                                  |
| rightButtonAction          | Right button click handler                                            | This is a optional parameter.   Pass method to be called on click.                                                                                                                                                                 |
| centerButtonAction          | Center button click handler                                            | This is a optional parameter.  Pass method to be called on click.                                                                                  |
| onCardTap          | Background color of Tabbar                                            | This is a optional parameter. Example pass method with completion handler. (int _index) { }                                                                                                                                                                 |
| cardSwiped          | Background color of Tabbar                                            | This is a optional parameter. Example pass method with completion handler. (CardActionDirection _direction, int _index) { }                                                                                                                                               |

## Attributes/Properties of PhotoCard

| parameter                  | description                                                                           | default                                                                                                                                                                               |
| -------------------------- | ------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| title          | String to be displayed in title Text widget                                          | empty string                                                                                                                                                    |
| description          | String to be displayed in description Text widget                                            | empty string                                                                                                                                                    |
| imagePath          | Image path of image, either local assets folder image or http image path                                            | empty string                                                                                                                                                    |
| isLocalImage          | Value is true if imagePath is local assets folder image, Value is true if imagePath is http image path                                             | true                                                                                                                                                    |
Please note try to load max of 10 photos at one time. This helps stack to be neat. To show more photos load them on pagination basis using cardSwiped method. 

The usage is well described in the example code.

[git repo here](https://github.com/TeaTalkInternal/photo_card_swiper)

Made with ❤ and dedicated with respect to the Saviour  [Sonu Sood](https://twitter.com/SonuSood)
