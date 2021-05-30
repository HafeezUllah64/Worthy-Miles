import 'package:flutter/material.dart';

class PageData {
  final String title;
  final String image;
  final Color bgColor;
  final Color textColor;

  PageData({
    this.title,
    this.image,
    this.bgColor = Colors.white,
    this.textColor = Colors.black,
  });
}