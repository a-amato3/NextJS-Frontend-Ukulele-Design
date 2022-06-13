import 'package:flutter/material.dart';
import 'dart:async';

class UkeProvider extends ChangeNotifier {
int chosenUke= 0;
double x = 50;
double y = 50;

void chooseUke(int ukeNum){
  chosenUke = ukeNum;
  notifyListeners();
}

void updatePosition(double newX, double newY){
  x = newX;
  y = newY-7;
  notifyListeners();
}

}
