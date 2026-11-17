## 0.2.0

* **Buzuvchi o'zgarish:** `AdaptiveSizeConfig.init` endi `BuildContext` olmaydi, `init(Size screen, Size design)` bo'ldi. Odatda uni o'zingiz chaqirmaysiz, `AdaptiveSizeInit` o'zi chaqiradi.
* Padding va margin uchun kengaytmalar: `.all`, `.horizontal`, `.vertical`, `.onlyLeft`, `.onlyRight`, `.onlyTop`, `.onlyBottom`.
* `.gw` va `.gh` olib tashlandi, hujjat shunga moslandi.

## 0.1.0

* `AdaptiveSizeInit` vidjeti qo'shildi: ilovani bir marta o'rab qo'yish kifoya.
* Ekran o'lchami o'zgarganda ilova qayta chiziladi (`const` vidjetlar ham, holati saqlanib).
* `designSize` o'zgarganda ham yangilanadi.
* Klaviatura ochilganda ortiqcha qayta chizish yo'q.
* Yangi kengaytmalar: `.sp`, `.r`.
* `ResponsiveBox` olib tashlandi (oddiy `SizedBox` bilan bir xil edi).
* `AdaptiveSizeConfig.init` parametrlari `double` bo'ldi.
* Minimal Flutter versiyasi 3.10.
* `example/` ilovasi qo'shildi.

## 0.0.1

* Birinchi versiya.
