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

  defp do_holiday_name(%DateTime{year: 1973, month:  4, day: 12}), do: "hurikae"

  defp do_holiday_name(%DateTime{            month: 1, day:   1}), do: "gantan"
  defp do_holiday_name(%DateTime{year: year, month: 1, day: day} = date) when year >= 2000 do
    if div(day-1, 7) == 1 and Date.weekday(date) == @mon, do: "seijin"
  end
  defp do_holiday_name(%DateTime{year: year, month: 1, day: day}) when year < 2000 and day == 15, do: "seijin"

  defp do_holiday_name(%DateTime{year: year, month: 2, day: 11}) when year >= 1967, do: "kenkoku"
  defp do_holiday_name(%DateTime{year: 1989, month: 2, day: 24}), do: "taisou"

  defp do_holiday_name(%DateTime{year: year, month: 3, day: day}) do
    if day == vernal_equinox_day(year), do: "shunbun"
  end

  defp do_holiday_name(%DateTime{year: year, month: 4, day: 29}) when year in 2007..9999, do: "showa"
  defp do_holiday_name(%DateTime{year: year, month: 4, day: 29}) when year in 1989..2006, do: "midori"
  defp do_holiday_name(%DateTime{            month: 4, day: 29}), do: "tennoh"
  defp do_holiday_name(%DateTime{year: 1959, month: 4, day: 10}), do: "akihito"

  defp do_holiday_name(%DateTime{            month: 5, day: 3}), do: "kenpoh"
  defp do_holiday_name(%DateTime{year: year, month: 5, day: 4}) when year in 2007..9999, do: "midori"
  defp do_holiday_name(%DateTime{year: year, month: 5, day: 4} = date) when year in 1986..2006 do
    if Date.weekday(date) in @tue..@sat, do: "kokumin"
  end
  defp do_holiday_name(%DateTime{            month: 5, day: 5}), do: "kodomo"
  defp do_holiday_name(%DateTime{year: year, month: 5, day: 6} = date) when year >= 2007 do
    if Date.weekday(date) in @tue..@wed, do: "hurikae"
  end

  defp do_holiday_name(%DateTime{year: 1993, month: 6, day: 9}), do: "norihito"

  defp do_holiday_name(%DateTime{year: year, month: 7, day: day} = date) when year >= 2003 do
    if Date.weekday(date) == @mon and div(day-1, 7) == 2, do: "umi"
  end
  defp do_holiday_name(%DateTime{year: year, month: 7, day: 20}) when year >= 1996, do: "umi"

  defp do_holiday_name(%DateTime{year: year, month: 8, day: 11}) when year >= 2016, do: "yama"

  defp do_holiday_name(%DateTime{year: year, month: 9, day: day} = date) do
    equinox = autumnal_equinox_day(year)
    cond do
      day  == equinox -> "shuubun"
      year >= 2003 and Date.weekday(date) == @mon and div(day-1, 7) == 2 -> "keirou"
      year >= 2003 and Date.weekday(date) == @tue and day == equinox-1 -> "kokumin"
      year >= 1966 and day == 15 -> "keirou"
      true -> nil
    end
  end

  defp do_holiday_name(%DateTime{year: year, month: 10, day: day} = date) when year >= 2000 do
    if Date.weekday(date) == @mon and div(day-1, 7) == 1, do: "taiiku"
  end
  defp do_holiday_name(%DateTime{year: year, month: 10, day: 10}) when year >= 1966, do: "taiiku"

  defp do_holiday_name(%DateTime{month: 11, day:  3}), do: "bunka"
  defp do_holiday_name(%DateTime{month: 11, day: 23}), do: "kinrou"
  defp do_holiday_name(%DateTime{year:  1990, month: 11, day: 12}), do: "sokui_no_rei"

  defp do_holiday_name(%DateTime{year: year, month: 12, day: 23}) when year >= 1989, do: "tennoh"

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
