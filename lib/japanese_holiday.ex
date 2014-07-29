defmodule JapaneseHoliday do
  @moduledoc """
      CopyRight(C) K.Tsunoda(AddinBox) 2001 All Rights Reserved.
      ( http://www.h3.dion.ne.jp/~sakatsu/index.htm )

      この祝日判定コードは『Excel:kt関数アドイン』で使用している
      ＶＢＡマクロをElixirに移植したものです。
      この関数では、２０１６年施行の改正祝日法(山の日)までを
      サポートしています。

      (*1)このコードを引用するに当たっては、必ずこのコメントも
          一緒に引用する事とします。
      (*2)他サイト上で本マクロを直接引用する事は、ご遠慮願います。
          【 http://www.h3.dion.ne.jp/~sakatsu/holiday_logic.htm 】
          へのリンクによる紹介で対応して下さい。
      (*3)[ktHolidayName]という関数名そのものは、各自の環境に
          おける命名規則に沿って変更しても構いません。
  """

  use Timex

  @mon 1
  @tue 2
  @wed 3
  @thu 4
  @fri 5
  @sat 6
  @sun 7
  @jst Date.timezone("JST")
  @national_holiday_enforcement   Date.from({1948, 7, 20}, @jst)
  @substitute_holiday_enforcement Date.from({1973, 4, 12}, @jst)

  def holiday_name(year, month, day) do
    date = Date.from({year, month, day}, @jst)
    case holiday_name(date) do
      nil  -> if substitute_holiday?(date), do: "hurikae"
      name -> name
    end
  end

  def holiday_name(date) do
    case Date.compare(@national_holiday_enforcement, date) do
      -1 -> nil
      _  -> do_holiday_name(date)
    end
  end

  defp substitute_holiday?(date) do
    Date.weekday(date) == @mon and
    Date.compare(@substitute_holiday_enforcement, date) >= 0 and
    is_binary(holiday_name Date.subtract date, {0, 3600, 0})
  end

  defp do_holiday_name(%DateTime{            month: 1, day:   1}), do: "元日"
  defp do_holiday_name(%DateTime{year: year, month: 1, day: day} = date) when year >= 2000 do
    if div(day-1, 7) == 1 and Date.weekday(date) == @mon, do: "成人の日"
  end
  defp do_holiday_name(%DateTime{year: year, month: 1, day: day}) when year < 2000 and day == 15, do: "成人の日"

  defp do_holiday_name(%DateTime{year: year, month: 2, day: 11}) when year >= 1967, do: "建国記念の日"
  defp do_holiday_name(%DateTime{year: 1989, month: 2, day: 24}), do: "昭和天皇の大喪の礼"

  defp do_holiday_name(%DateTime{year: year, month: 3, day: day}) do
    if day == vernal_equinox_day(year), do: "春分の日"
  end

  defp do_holiday_name(%DateTime{year: year, month: 4, day: 29}) when year in 2007..9999, do: "昭和の日"
  defp do_holiday_name(%DateTime{year: year, month: 4, day: 29}) when year in 1989..2006, do: "みどりの日"
  defp do_holiday_name(%DateTime{            month: 4, day: 29}), do: "天皇誕生日"
  defp do_holiday_name(%DateTime{year: 1959, month: 4, day: 10}), do: "皇太子明仁親王の結婚の儀"

  defp do_holiday_name(%DateTime{            month: 5, day: 3}), do: "憲法記念日"
  defp do_holiday_name(%DateTime{year: year, month: 5, day: 4}) when year in 2007..9999, do: "みどりの日"
  defp do_holiday_name(%DateTime{year: year, month: 5, day: 4} = date) when year in 1986..2006 do
    if Date.weekday(date) in @tue..@sat, do: "国民の休日"
  end
  defp do_holiday_name(%DateTime{            month: 5, day: 5}), do: "こどもの日"
  defp do_holiday_name(%DateTime{year: year, month: 5, day: 6} = date) when year >= 2007 do
    if Date.weekday(date) in @tue..@wed, do: "振替休日"
  end

  defp do_holiday_name(%DateTime{year: 1993, month: 6, day: 9}), do: "皇太子徳仁親王の結婚の儀"

  defp do_holiday_name(%DateTime{year: year, month: 7, day: day} = date) when year >= 2003 do
    if Date.weekday(date) == @mon and div(day-1, 7) == 2, do: "海の日"
  end
  defp do_holiday_name(%DateTime{year: year, month: 7, day: 20}) when year >= 1996, do: "海の日"

  defp do_holiday_name(%DateTime{year: year, month: 8, day: 11}) when year >= 2016, do: "山の日"

  defp do_holiday_name(%DateTime{year: year, month: 9, day: day} = date) do
    equinox = autumnal_equinox_day(year)
    cond do
      day  == equinox -> "秋分の日"
      year >= 2003 and Date.weekday(date) == @mon and div(day-1, 7) == 2 -> "敬老の日"
      year >= 2003 and Date.weekday(date) == @tue and day == equinox-1 -> "国民の休日"
      year >= 1966 and day == 15 -> "敬老の日"
      true -> nil
    end
  end

  defp do_holiday_name(%DateTime{year: year, month: 10, day: day} = date) when year >= 2000 do
    if Date.weekday(date) == @mon and div(day-1, 7) == 1, do: "体育の日"
  end
  defp do_holiday_name(%DateTime{year: year, month: 10, day: 10}) when year >= 1966, do: "体育の日"

  defp do_holiday_name(%DateTime{            month: 11, day:  3}), do: "文化の日"
  defp do_holiday_name(%DateTime{            month: 11, day: 23}), do: "勤労感謝の日"
  defp do_holiday_name(%DateTime{year: 1990, month: 11, day: 12}), do: "即位礼正殿の儀"

  defp do_holiday_name(%DateTime{year: year, month: 12, day: 23}) when year >= 1989, do: "天皇誕生日"

  defp do_holiday_name(%DateTime{}), do: nil

  defp vernal_equinox_day(year) do
    a = 0.242194*(year-1980) - Float.floor(year-1980 / 4)
    cond do
      year in 1851 .. 1899 -> Float.floor(19.8277 + a)
      year in 1900 .. 1979 -> Float.floor(20.8357 + a)
      year in 1980 .. 2099 -> Float.floor(20.8431 + a)
      year in 2100 .. 2150 -> Float.floor(21.8510 + a)
    end
  end

  defp autumnal_equinox_day(year) do
    a = 0.242194*(year-1980) - Float.floor(year-1980 / 4)
    cond do
      year in 1851 .. 1899 -> Float.floor(22.2588 + a)
      year in 1900 .. 1979 -> Float.floor(23.2588 + a)
      year in 1980 .. 2099 -> Float.floor(23.2488 + a)
      year in 2100 .. 2150 -> Float.floor(24.2488 + a)
    end
  end
end
