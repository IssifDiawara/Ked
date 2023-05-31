import 'package:flutter/widgets.dart';

double getHeight({required BuildContext context, int? percentage}) {
  double height = MediaQuery.of(context).size.height;
  if (percentage != null && percentage >= 1 && percentage <= 100) {
    height = height * (percentage / 100);
  }
  return height;
}

double getWidth({required BuildContext context, int? percentage}) {
  double width = MediaQuery.of(context).size.width;
  if (percentage != null && percentage >= 1 && percentage <= 100) {
    width = width * (percentage / 100);
  }
  return width;
}
