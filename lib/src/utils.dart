import 'package:flutter/widgets.dart';

/// `BuildContext` orqali ekran o'lchamlarini olish uchun qisqa yo'llar.
extension MediaQuerySizeExtension on BuildContext {
  /// Ekran o'lchami.
  Size get screenSize => MediaQuery.sizeOf(this);

  /// Ekran kengligi.
  double get screenWidth => screenSize.width;

  /// Ekran balandligi.
  double get screenHeight => screenSize.height;

  /// Ekranning qisqa tomoni.
  double get screenShortestSide => screenSize.shortestSide;

  /// Ekranning uzun tomoni.
  double get screenLongestSide => screenSize.longestSide;
}
