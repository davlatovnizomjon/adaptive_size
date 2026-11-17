import 'package:flutter/material.dart';
import 'package:adaptive_size/adaptive_size.dart';

void main() {
  runApp(
    AdaptiveSizeInit(
      designSize: const Size(375, 812),
      builder: (context, child) => MaterialApp(
        title: 'adaptive_size example',
        theme: ThemeData(colorSchemeSeed: Colors.indigo, useMaterial3: true),
        home: const HomePage(),
      ),
    ),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('adaptive_size', style: TextStyle(fontSize: 20.sp)),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 200.w,
              height: 100.h,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(12.r),
              ),
              alignment: Alignment.center,
              child: Text('200.w x 100.h', style: TextStyle(fontSize: 16.sp)),
            ),
            16.gapY,
            Text(
              'Ekran: ${context.screenWidth.toStringAsFixed(0)} x '
              '${context.screenHeight.toStringAsFixed(0)}',
            ),
            8.gapY,
            Container(
              width: 0.5.sw(context),
              height: 40.h,
              color: Theme.of(context).colorScheme.secondaryContainer,
              alignment: Alignment.center,
              child: const Text('Ekran kengligining 50%'),
            ),
          ],
        ),
      ),
    );
  }
}
