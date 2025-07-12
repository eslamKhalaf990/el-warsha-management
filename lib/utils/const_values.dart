import 'package:flutter/cupertino.dart';
class Constants {

  //animation
  static const ANIMATION_DURATION = Duration(milliseconds: 250);

  //api call time out
  static const TIMEOUT = 100;

  //opacity
  static int get OPACITY_05 => (0.5 * 255).toInt();
  static int get OPACITY_08 => (0.8 * 255).toInt();
  static int get OPACITY_01 => (0.1 * 255).toInt();
  static int get OPACITY_03 => (0.3 * 255).toInt();

  //borders
  static BorderRadius get BORDER_RADIUS_15 => BorderRadius.circular(15);
  static BorderRadius get BORDER_RADIUS_50 => BorderRadius.circular(50);
  static BorderRadius get BORDER_RADIUS_100 => BorderRadius.circular(100);
  static BorderRadius get BORDER_RADIUS_8 => BorderRadius.circular(8);
  static BorderRadius get BORDER_RADIUS_20 => BorderRadius.circular(20);
  static BorderRadius get BORDER_RADIUS_25 => BorderRadius.circular(25);
  static BorderRadius get BORDER_RADIUS_10 => BorderRadius.circular(10);

  static const int NAV_BAR_HOME = 0;
  static const int NAV_CHECK_IN = 1;
  static const int PROFILE = 2;
}