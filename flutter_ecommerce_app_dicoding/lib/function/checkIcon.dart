import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

final List<IconData> iconData = [
  FontAwesomeIcons.solidGem,
  FontAwesomeIcons.solidHeart,
  FontAwesomeIcons.solidStar,
  FontAwesomeIcons.music,
  FontAwesomeIcons.briefcase,
  FontAwesomeIcons.gift,
  FontAwesomeIcons.running,
  FontAwesomeIcons.store,
];

IconData checkIcon(String icon) {
  switch (icon) {
    case "icon-diamond":
      {
        return iconData[0];
      }
    case "icon-heart":
      {
        return iconData[1];
      }
    case "icon-star":
      {
        return iconData[2];
      }
    case "icon-music-note":
      {
        return iconData[3];
      }
    case "icon-briefcase":
      {
        return iconData[4];
      }
    case "icon-gift":
      {
        return iconData[5];
      }
    case "icon-exit":
      {
        return iconData[6];
      }
    case "icon-store":
      {
        return iconData[7];
      }
    default:
      {
        return iconData[2];
      }
  }
}
