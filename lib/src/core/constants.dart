import 'package:casino_test/src/core/util/color_util.dart';
import 'package:flutter/material.dart';

const BASE_URL = 'https://rickandmortyapi.com/api';

class Sizing {
  static const kItemElevation = 1.0;
  static const kMaxItemHeight = 200.0;
  static const kMaxSubItemPadding = 30.0;
  static const kBorderRadius = 4.0;
  static const kItemBorderRadius = 10.0;
  static const kItemSpacerUnit = 8.0;
}

// creating a theme would be an overkill
class ColorTheme {
  static final kSubtitleTextColor = Colors.grey;
  static final kBackgroundColor = ColorUtil.colorFromHex('#FFf2f5fb');
}
