import 'dart:ui';

import 'package:flutter_x/common/common_colors.dart';
import 'dimens.dart';

class CommonTextStyles {
  static TextStyle listTitle = TextStyle(
    fontSize: Dimens.font_sp16,
    color: CommonColors.text_dark,
    fontWeight: FontWeight.bold,
  );
  static TextStyle listTitle2 = TextStyle(
    fontSize: Dimens.font_sp16,
    color: CommonColors.text_dark,
  );
  static TextStyle listContent = TextStyle(
    fontSize: Dimens.font_sp14,
    color: CommonColors.text_normal,
  );
  static TextStyle listContent2 = TextStyle(
    fontSize: Dimens.font_sp14,
    color: CommonColors.text_gray,
  );
  static TextStyle listExtra = TextStyle(
    fontSize: Dimens.font_sp12,
    color: CommonColors.text_gray,
  );
  static TextStyle listExtra2 = TextStyle(
    fontSize: Dimens.font_sp12,
    color: CommonColors.text_normal,
  );
}