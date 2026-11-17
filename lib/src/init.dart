import 'package:flutter/widgets.dart';

/// O'lchamlarni moslashtirish koeffitsiyentlarini saqlaydi.
///
/// Odatda to'g'ridan-to'g'ri ishlatilmaydi, [AdaptiveSizeInit] o'zi
/// yangilab turadi.
class AdaptiveSizeConfig {
  static double _heightFactor = 1;
  static double _widthFactor = 1;
  static double _arithmeticFactor = 1;
  static double _textFactor = 1;

  /// Koeffitsiyentlarni qo'lda yangilaydi. [AdaptiveSizeInit] ishlatilsa,
  /// bu metodni chaqirish shart emas.
  static void init(
    BuildContext context, {
    required double designWidth,
    required double designHeight,
  }) {
    update(MediaQuery.sizeOf(context), Size(designWidth, designHeight));
  }

  /// Ekran va dizayn o'lchamidan koeffitsiyentlarni hisoblaydi.
  static void update(Size screen, Size design) {
    assert(
      design.width > 0 && design.height > 0,
      "designSize noldan katta bo'lishi kerak",
    );
    _widthFactor = screen.width / design.width;
    _heightFactor = screen.height / design.height;
    _arithmeticFactor = (_widthFactor + _heightFactor) / 2;
    _textFactor = _widthFactor < _heightFactor ? _widthFactor : _heightFactor;
  }

  /// Balandlik koeffitsiyenti (`.h` uchun).
  static double get heightFactor => _heightFactor;

  /// Kenglik koeffitsiyenti (`.w` uchun).
  static double get widthFactor => _widthFactor;

  /// Kenglik va balandlik o'rtachasi (`.o` uchun).
  static double get arithmeticFactor => _arithmeticFactor;

  /// Shrift uchun koeffitsiyent (kenglik va balandlikdan kichigi).
  static double get textFactor => _textFactor;
}

/// Ilovani o'rab turadigan vidjet. `main.dart` da bir marta ishlatiladi:
///
/// ```dart
/// runApp(
///   AdaptiveSizeInit(
///     designSize: const Size(375, 812),
///     builder: (context, child) => MaterialApp(home: const HomePage()),
///   ),
/// );
/// ```
///
/// Ekran o'lchami o'zgarsa (telefon aylantirilsa, oyna kattalashtirilsa),
/// koeffitsiyentlar avtomatik yangilanadi va ilova qayta chiziladi.
///
/// `const` bilan yaratilgan vidjetlar ham yangilanadi. Vidjetlarning
/// holati (`State`) saqlanib qoladi, faqat ular qayta `build` qilinadi.
class AdaptiveSizeInit extends StatefulWidget {
  /// [AdaptiveSizeInit] yaratadi.
  const AdaptiveSizeInit({
    super.key,
    required this.builder,
    this.designSize = const Size(375, 812),
    this.child,
  });

  /// Dizayn (masalan, Figma) o'lchami.
  final Size designSize;

  /// Odatda `MaterialApp` qaytaradi.
  final Widget Function(BuildContext context, Widget? child) builder;

  /// Ixtiyoriy, `builder` ga uzatiladi.
  final Widget? child;

  @override
  State<AdaptiveSizeInit> createState() => _AdaptiveSizeInitState();
}

class _AdaptiveSizeInitState extends State<AdaptiveSizeInit>
    with WidgetsBindingObserver {
  Size _screenSize = Size.zero;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    // Klaviatura ochilganda ham chaqiriladi, shuning uchun faqat
    // ekran o'lchami haqiqatan o'zgargandagina qayta chizamiz.
    if (!mounted || _readScreenSize() == _screenSize) return;
    setState(() {});
    _rebuildDescendants();
  }

  @override
  void didUpdateWidget(AdaptiveSizeInit oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.designSize != widget.designSize) _rebuildDescendants();
  }

  /// `.w` kabi qiymatlar `build` paytida hisoblanadi, `const` vidjetlar esa
  /// o'zgarmagan deb hisoblanib o'tkazib yuboriladi. Shuning uchun daraxtdagi
  /// hamma vidjetni qayta `build` qilishga majburlaymiz. Bu Flutter'ning
  /// hot reload mexanizmi ishlatadigan usulning o'zi.
  void _rebuildDescendants() {
    void markDirty(Element element) {
      element.markNeedsBuild();
      element.visitChildren(markDirty);
    }

    (context as Element).visitChildren(markDirty);
  }

  /// MaterialApp'dan tepada MediaQuery yo'q, shuning uchun View'dan olamiz.
  Size _readScreenSize() => MediaQueryData.fromView(View.of(context)).size;

  @override
  Widget build(BuildContext context) {
    _screenSize = _readScreenSize();
    AdaptiveSizeConfig.update(_screenSize, widget.designSize);
    return widget.builder(context, widget.child);
  }
}
