import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

enum CardStatus { like, dislike, superLike }

class CardProvider extends ChangeNotifier {
  // int _index = 0;
  // int get index => _index;

  // void setIndex(int index){
  //   _index = index;
  //   notifyListeners();
  // }
  List<String> _imagesUrl = [];
  List<String> get imagesUrl => _imagesUrl;

  Offset _positiion = Offset.zero;
  Offset get position => _positiion;

  bool _isDragging = false;
  bool get isDragging => _isDragging;

  Size _screenSize = Size.zero;

  double _angle = 0;
  double get angle => _angle;

  CardProvider() {
    resetUser();
  }

  void startPosition(DragStartDetails details) {
    _isDragging = true;
    print(details.globalPosition);
  }

  void updatePosition(DragUpdateDetails details) {
    _positiion += details.delta;
    final x = _positiion.dx;
    // rotate the card based on the position
    _angle = 10 * x / _screenSize.width;
    notifyListeners();
  }

  void endPosition(DragEndDetails details) {
    _isDragging = false;
    notifyListeners();
    final status = getStatus();

    if (status != null) {
      Fluttertoast.cancel();
      Fluttertoast.showToast(
        msg: status.toString().split('.').last.toUpperCase(),
        // toastLength: Toast.LENGTH_SHORT,
        // gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        fontSize: 36,
      );
    }
    switch (status) {
      case CardStatus.like:
        like();
        break;
      case CardStatus.dislike:
        dislike();
        break;
      case CardStatus.superLike:
        superLike();
        break;
      default:
        resetPosition();
    }
  }

  void setScreenSize(Size size) {
    _screenSize = size;
  }

  void resetPosition() {
    _isDragging = false;
    _positiion = Offset.zero;
    _angle = 0;
    notifyListeners();
  }

  CardStatus? getStatus() {
    final x = _positiion.dx;
    final y = _positiion.dy;
    final forceSuperLike = x.abs() < 20;
    final delta = 100;
    if (x >= delta) {
      return CardStatus.like;
    } else if (x <= -delta) {
      return CardStatus.dislike;
    } else if (y <= -delta / 2 && forceSuperLike) {
      return CardStatus.superLike;
    }
  }

  void like() {
    _angle = 20;
    _positiion += Offset(2 * _screenSize.width, 0);
    _nextCard();
    notifyListeners();
  }

  void dislike() {
    _angle = -20;
    _positiion -= Offset(2 * _screenSize.width, 0);
    _nextCard();
    notifyListeners();
  }

  void superLike() {
    _angle = 0;
    _positiion -= Offset(0, _screenSize.height);
    _nextCard();
    notifyListeners();
  }

  Future _nextCard() async {
    if (_imagesUrl.isEmpty) return;

    await Future.delayed(const Duration(milliseconds: 200));
    _imagesUrl.removeLast();

    // notifyListeners();
    resetPosition();
  }

  void resetUser() {
    _imagesUrl = <String>[
      'https://images.unsplash.com/photo-1583275478661-1c31970669fa?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=4587&q=80',
      'https://images.unsplash.com/photo-1614743758466-e569f4791116?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1250&q=80',
      'https://images.unsplash.com/photo-1605395630162-1c7cc7a34590?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1287&q=80',
      'https://plus.unsplash.com/premium_photo-1671586881901-2fca21a508da?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1287&q=80',
      'https://images.unsplash.com/photo-1595435934249-5df7ed86e1c0?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2944&q=80'
    ].reversed.toList();

    notifyListeners();
  }
}
