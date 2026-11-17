import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:adaptive_size/adaptive_size.dart';

class _Stateful extends StatefulWidget {
  const _Stateful();

  @override
  State<_Stateful> createState() => _StatefulState();
}

int _initCount = 0;

class _StatefulState extends State<_Stateful> {
  @override
  void initState() {
    super.initState();
    _initCount++;
  }

  @override
  Widget build(BuildContext context) =>
      Text('${100.w}', textDirection: TextDirection.ltr);
}

class _Probe extends StatelessWidget {
  const _Probe();

  @override
  Widget build(BuildContext context) =>
      Text('${100.w}', textDirection: TextDirection.ltr);
}

void main() {
  testWidgets('const vidjet ekran o\'zgarganda yangilanadi', (tester) async {
    tester.view.physicalSize = const Size(375, 812);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(
      AdaptiveSizeInit(
        designSize: const Size(375, 812),
        builder: (context, child) => const MaterialApp(home: _Probe()),
      ),
    );
    expect(find.text('100.0'), findsOneWidget);

    tester.view.physicalSize = const Size(750, 1624);
    await tester.pump();
    expect(find.text('200.0'), findsOneWidget);
  });

  testWidgets('klaviatura ochilganda qayta build bo\'lmaydi', (tester) async {
    tester.view.physicalSize = const Size(375, 812);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    var builds = 0;
    await tester.pumpWidget(
      AdaptiveSizeInit(
        designSize: const Size(375, 812),
        builder: (context, child) {
          builds++;
          return const MaterialApp(home: _Probe());
        },
      ),
    );
    final before = builds;

    tester.view.viewInsets = const FakeViewPadding(bottom: 300);
    addTearDown(tester.view.resetViewInsets);
    await tester.pump();

    expect(builds, before);
  });

  group('koeffitsiyentlar', () {
    setUp(() {
      AdaptiveSizeConfig.update(const Size(750, 812), const Size(375, 812));
    });

    test('.w, .h, .o, .sp, .r', () {
      expect(10.w, 20);
      expect(10.h, 10);
      expect(10.o, 15);
      expect(10.sp, 10);
      expect(10.r, 10);
    });

    test('gw va gh moslashadi, gapX va gapY moslashmaydi', () {
      expect(10.gapX.width, 10);
      expect(10.gapY.height, 10);
    });

    test('noldan kichik dizayn o\'lchami xato beradi', () {
      expect(
        () => AdaptiveSizeConfig.update(const Size(100, 100), Size.zero),
        throwsAssertionError,
      );
    });
  });

  testWidgets('designSize o\'zgarsa const vidjet yangilanadi', (tester) async {
    tester.view.physicalSize = const Size(375, 812);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    Widget app(Size design) => AdaptiveSizeInit(
          designSize: design,
          builder: (context, child) => const MaterialApp(home: _Probe()),
        );

    await tester.pumpWidget(app(const Size(375, 812)));
    expect(find.text('100.0'), findsOneWidget);

    await tester.pumpWidget(app(const Size(750, 1624)));
    expect(find.text('50.0'), findsOneWidget);
  });

  testWidgets('eski init usuli ishlaydi', (tester) async {
    tester.view.physicalSize = const Size(750, 812);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (context) {
            AdaptiveSizeConfig.init(
              context,
              designWidth: 375,
              designHeight: 812,
            );
            return const _Probe();
          },
        ),
      ),
    );
    expect(find.text('200.0'), findsOneWidget);
  });

  testWidgets('qayta build qilinganda State saqlanadi', (tester) async {
    tester.view.physicalSize = const Size(375, 812);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    _initCount = 0;

    await tester.pumpWidget(
      AdaptiveSizeInit(
        builder: (context, child) => const MaterialApp(home: _Stateful()),
      ),
    );
    tester.view.physicalSize = const Size(750, 1624);
    await tester.pump();

    expect(find.text('200.0'), findsOneWidget);
    expect(_initCount, 1);
  });
}
