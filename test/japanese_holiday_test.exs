defmodule JapaneseHolidayTest do
  use ExUnit.Case

  test "2009" do
    for month <- [1, 3, 5, 7, 8, 10, 12], day <- 1 .. 31 do
      result = JapaneseHoliday.holiday_name(2009, month, day)
      assert result == (case {month, day} do
        { 1,  1} -> "元日"
        { 1, 12} -> "成人の日"
        { 3, 20} -> "春分の日"
        { 5,  3} -> "憲法記念日"
        { 5,  4} -> "みどりの日"
        { 5,  5} -> "こどもの日"
        { 5,  6} -> "振替休日"
        { 7, 20} -> "海の日"
        {10, 12} -> "体育の日"
        {12, 23} -> "天皇誕生日"
        _ -> nil
      end)
    end

    for month <- [4, 6, 9, 11], day <- 1 .. 30 do
      result = JapaneseHoliday.holiday_name(2009, month, day)
      assert result == (case {month, day} do
        { 4, 29} -> "昭和の日"
        { 9, 21} -> "敬老の日"
        { 9, 22} -> "国民の休日"
        { 9, 23} -> "秋分の日"
        {11,  3} -> "文化の日"
        {11, 23} -> "勤労感謝の日"
        _ -> nil
      end)
    end

    for month <- [2], day <- 1 .. 28 do
      result = JapaneseHoliday.holiday_name(2009, month, day)
      assert result == (case {month, day} do
        {2, 11} -> "建国記念の日"
        _ -> nil
      end)
    end
  end

  test "2014" do
    for month <- [1, 3, 5, 7, 8, 10, 12], day <- 1 .. 31 do
      result = JapaneseHoliday.holiday_name(2014, month, day)
      assert result == (case {month, day} do
        { 1,  1} -> "元日"
        { 1, 13} -> "成人の日"
        { 3, 21} -> "春分の日"
        { 5,  3} -> "憲法記念日"
        { 5,  4} -> "みどりの日"
        { 5,  5} -> "こどもの日"
        { 5,  6} -> "振替休日"
        { 7, 21} -> "海の日"
        {10, 13} -> "体育の日"
        {12, 23} -> "天皇誕生日"
        _ -> nil
      end)
    end

    for month <- [4, 6, 9, 11], day <- 1 .. 30 do
      result = JapaneseHoliday.holiday_name(2014, month, day)
      assert result == (case {month, day} do
        { 4, 29} -> "昭和の日"
        { 9, 15} -> "敬老の日"
        { 9, 23} -> "秋分の日"
        {11,  3} -> "文化の日"
        {11, 23} -> "勤労感謝の日"
        {11, 24} -> "振替休日"
        _ -> nil
      end)
    end

    for month <- [2], day <- 1 .. 28 do
      result = JapaneseHoliday.holiday_name(2014, month, day)
      assert result == (case {month, day} do
        {2, 11} -> "建国記念の日"
        _ -> nil
      end)
    end
  end
end
