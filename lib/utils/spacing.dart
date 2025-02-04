import 'package:flutter/material.dart';

class Spacing {
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 16;
  static const double lg = 32;
  static const double xxl = 50;

  static Widget vertical(double height) => SizedBox(height: height);
  static Widget horizontal(double width) => SizedBox(width: width);

  static Widget get smallVertical => vertical(sm);
  static Widget get mediumVertical => vertical(md);
  static Widget get largeVertical => vertical(lg);
  static Widget get extraLargeVertical => vertical(xxl);

  static Widget get smallHorizontal => horizontal(sm);
  static Widget get mediumHorizontal => horizontal(md);
  static Widget get largeHorizontal => horizontal(lg);
  static Widget get extraLargeHorizontal => horizontal(xxl);
}
