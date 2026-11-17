# adaptive_size

Flutter ilovalarida o'lchamlarni turli ekranlarga moslashtirish uchun oddiy va yengil paket. Figma'dagi dizayn o'lchamini bir marta berasiz, qolganini paket o'zi hisoblaydi.

## Imkoniyatlar

- `num` uchun `.w`, `.h`, `.o`, `.sp`, `.r` kengaytmalari: kenglik, balandlik, o'rtacha koeffitsiyent, shrift va radius bo'yicha moslashtirish
- Padding va margin uchun `16.horizontal`, `8.onlyTop` kabi qisqa yozuv
- `10.gapX` va `10.gapY` orqali tez bo'sh joy (`SizedBox`) qo'yish
- `BuildContext` orqali ekran o'lchamlarini olish (`context.screenWidth`, `context.screenHeight` va hokazo)

## O'rnatish

```bash
flutter pub add adaptive_size
```

yoki `pubspec.yaml` ga qo'lda yozing:

```yaml
dependencies:
  adaptive_size: ^0.1.0
```

## Ishlatish

### 1. Boshlang'ich sozlash

`main.dart` da ilovani `AdaptiveSizeInit` bilan o'rab qo'ying va dizayningiz o'lchamini bering (masalan, Figma'da 375x812). Shu bilan tamom, boshqa joyda `init` chaqirish shart emas:

```dart
import 'package:flutter/material.dart';
import 'package:adaptive_size/adaptive_size.dart';

void main() {
  runApp(
    AdaptiveSizeInit(
      designSize: const Size(375, 812),
      builder: (context, child) => MaterialApp(
        home: const HomePage(),
      ),
    ),
  );
}
```

Ekran o'lchami o'zgarsa (telefon aylantirilsa, oyna kattalashtirilsa), qiymatlar o'zi yangilanadi.

### 2. O'lchamlarni moslashtirish

Endi butun loyihada, `context`siz ishlatishingiz mumkin:

```dart
Container(
  width: 200.w,
  height: 100.h,
  padding: EdgeInsets.all(16.o),
  decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.r)),
  child: Text('Salom', style: TextStyle(fontSize: 14.sp)),
)
```

Qaysi birini tanlash kerak:

- `.w` — kenglik, chap-o'ng padding kabi gorizontal o'lchamlar
- `.h` — balandlik, tepa-past padding kabi vertikal o'lchamlar
- `.o` — kenglik va balandlik o'rtachasi bo'yicha
- `.sp` — shrift o'lchami
- `.r` — border radius va ikonka kabi tomonlari teng narsalar

### 3. Bo'sh joy qo'yish

```dart
Column(
  children: [
    Text('Salom'),
    20.gapY,
    Text('Dunyo'),
  ],
)
```

`gapX` va `gapY` qiymatni moslashtirmaydi. Moslashtirish kerak bo'lsa: `20.h.gapY` yoki `10.w.gapX`.

### 4. Padding va margin

Padding ham, margin ham `EdgeInsets`, shuning uchun bir xil nomlar ikkalasiga ishlaydi. Chap-o'ng qiymatlar `.w`, tepa-past qiymatlar `.h` bo'yicha moslashadi:

```dart
Container(
  padding: 16.horizontal,       // chap va o'ng
  margin: 8.onlyTop,            // faqat tepa
  child: ...,
)

Padding(padding: 12.all, child: ...)
Padding(padding: 16.horizontal + 8.vertical, child: ...)
```

| Nomi | Natija |
|---|---|
| `.all` | hamma tomondan |
| `.horizontal` | chap va o'ng |
| `.vertical` | tepa va past |
| `.onlyLeft`, `.onlyRight` | faqat chap, faqat o'ng |
| `.onlyTop`, `.onlyBottom` | faqat tepa, faqat past |

### 5. Ekran ulushi bo'yicha o'lcham

```dart
Container(
  width: 0.5.sw(context),   // ekran kengligining yarmi
  height: 0.3.sh(context),  // ekran balandligining 30 foizi
)
```

### 6. Ekran o'lchamlarini olish

```dart
final width = context.screenWidth;
final height = context.screenHeight;
final short = context.screenShortestSide;
final long = context.screenLongestSide;
```

## Namuna

To'liq ishlaydigan namuna `example/` papkasida: `cd example && flutter run`.

## Eslatmalar

- Ekran o'lchami o'zgarganda butun ilova qayta `build` qilinadi (`const` vidjetlar ham), lekin ularning holati (`State`) saqlanadi.
- `AdaptiveSizeInit` ishlatilmasa, barcha koeffitsiyentlar 1 bo'ladi va o'lchamlar o'zgarmaydi.
- Kamida Flutter 3.10 kerak.

## Litsenziya

MIT. Batafsil ma'lumot uchun [LICENSE](LICENSE) faylini ko'ring.
