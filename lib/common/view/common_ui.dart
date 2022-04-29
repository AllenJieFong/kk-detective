import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../theme/app_colors.dart';

class CommonUI {
  static Widget commonText(String text,
      {double size = 14.0,
      Color color = AppColors.defaultTextColor,
      TextAlign textAlign = TextAlign.left,
      FontWeight fontWeight = FontWeight.w600,
      TextDecoration decoration = TextDecoration.none,
      int maxLines = 2,
      isSelectable = false}) {
    TextStyle textStyle = TextStyle(
        fontSize: size,
        color: color,
        fontWeight: fontWeight,
        decoration: decoration);
    return isSelectable
        ? SelectableText(text,
            textAlign: textAlign, maxLines: maxLines, style: textStyle)
        : Text(text,
            textAlign: textAlign, maxLines: maxLines, style: textStyle);
  }

  static void copyToClipboard({required String text}) {
    Clipboard.setData(ClipboardData(text: text));
  }
}
