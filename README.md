## JapaneseHoliday

The original idea is [http://www.h3.dion.ne.jp/~sakatsu/holiday_logic.htm]

### Usage

```
JapaneseHoliday.holiday_name(1990, 1,  1)  #=> "元日"
JapaneseHoliday.holiday_name(2016, 8, 11)  #=> "山の日"

use Timex

jan_1st = Date.from({2014, 1, 1}, Date.timezone("JST"))
JapaneseHoliday.holiday_name(jan_1st) #=> "元日"
```

### Copyright

```
_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/
_/
_/　CopyRight(C) K.Tsunoda(AddinBox) 2001 All Rights Reserved.
_/　( http://www.h3.dion.ne.jp/~sakatsu/index.htm )
_/
_/　　この祝日マクロは『kt関数アドイン』で使用しているものです。
_/　　このロジックは、レスポンスを第一義として、可能な限り少ない
_/　  【条件判定の実行】で結果を出せるように設計してあります。
_/　　この関数では、２０１６年施行の改正祝日法(山の日)までを
_/　  サポートしています。
_/
_/　(*1)このマクロを引用するに当たっては、必ずこのコメントも
_/　　　一緒に引用する事とします。
_/　(*2)他サイト上で本マクロを直接引用する事は、ご遠慮願います。
_/　　　【 http://www.h3.dion.ne.jp/~sakatsu/holiday_logic.htm 】
_/　　　へのリンクによる紹介で対応して下さい。
_/　(*3)[ktHolidayName]という関数名そのものは、各自の環境に
_/　　　おける命名規則に沿って変更しても構いません。
_/　
_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/
```

### TODO

- Some more test
