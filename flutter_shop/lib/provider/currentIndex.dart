import 'package:flutter/material.dart';

class CurrentIndexNotifier with ChangeNotifier {
  int currentIndex = 0;
  changeIndex(index){
    currentIndex = index;
    notifyListeners();
  }
}