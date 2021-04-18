import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Color checkColorIcon(String icon) {
  switch (icon) {
    case "icon-diamond":
      {
        return Colors.blueAccent;
      }
    case "icon-heart":
      {
        return Colors.red;
      }
    case "icon-star":
      {
        return Colors.yellow;
      }
    case "icon-music-note":
      {
        return Colors.orangeAccent;
      }
    case "icon-briefcase":
      {
        return Colors.brown;
      }
    case "icon-gift":
      {
        return Colors.pink;
      }
    case "icon-exit":
      {
        return Colors.black;
      }
    case "icon-store":
      {
        return Colors.purple;
      }
    default:
      {
        return Colors.black54;
      }
  }
}
