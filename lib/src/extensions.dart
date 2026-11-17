import 'package:flutter/widgets.dart';
import 'init.dart';

/// Raqamni ekranga moslashtiradigan kengaytmalar.
extension AdaptiveSize on num {
  /// Kenglik bo'yicha moslashtiradi.
  double get w => this * AdaptiveSizeConfig.widthFactor;

  /// Balandlik bo'yicha moslashtiradi.
  double get h => this * AdaptiveSizeConfig.heightFactor;

  /// Kenglik va balandlik koeffitsiyentlarining o'rtachasi bo'yicha
  /// moslashtiradi (kvadrat va aylana shakllar uchun qulay).
  double get o => this * AdaptiveSizeConfig.arithmeticFactor;

  /// Shrift o'lchami uchun (kenglik va balandlikdan kichigi bo'yicha).
  double get sp => this * AdaptiveSizeConfig.textFactor;

  /// Radius va ikonka o'lchami uchun. Hozircha [sp] bilan bir xil.
  double get r => this * AdaptiveSizeConfig.textFactor;
}

/// Bo'sh joy (`SizedBox`) va ekran ulushi uchun kengaytmalar.
extension GapExt on num {
  /// Moslashtirilmagan gorizontal bo'sh joy.
  SizedBox get gapX => SizedBox(width: toDouble());

  /// Moslashtirilmagan vertikal bo'sh joy.
  SizedBox get gapY => SizedBox(height: toDouble());

  /// Ekran kengligining ulushi: `0.5.sw(context)`.
  double sw(BuildContext context) => this * MediaQuery.sizeOf(context).width;

  /// Ekran balandligining ulushi: `0.3.sh(context)`.
  double sh(BuildContext context) => this * MediaQuery.sizeOf(context).height;
}
