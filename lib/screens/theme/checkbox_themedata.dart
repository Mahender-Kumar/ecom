import 'package:ecom/constants.dart';
import 'package:flutter/material.dart';

 

CheckboxThemeData checkboxThemeData = const CheckboxThemeData(
  checkColor: WidgetStatePropertyAll(Colors.white),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(defaultBorderRadious / 2),
    ),
  ),
  side: BorderSide(color: whileColor40),
);
