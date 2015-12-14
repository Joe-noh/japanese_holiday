defmodule JapaneseHolidayTest do
  use ExUnit.Case

  test "basic" do
    use Timex

    jan_1st = Date.from({2014, 1, 1}, Timezone.get("Asia/Tokyo"))
    jan_2nd = Date.from({2014, 1, 2}, Timezone.get("Asia/Tokyo"))

    assert JapaneseHoliday.holiday_name(jan_1st) == "元日"
    assert JapaneseHoliday.holiday_name(jan_2nd) == nil
    assert JapaneseHoliday.holiday_name(2014, 1, 1) == "元日"
    assert JapaneseHoliday.holiday_name(2014, 1, 2) == nil
  end

  # 祝日法施行前
  test "1947" do
    for month <- [1, 3, 5, 7, 8, 10, 12], day <- 1 .. 31 do
      assert JapaneseHoliday.holiday_name(1947, month, day) == nil
    end

    for month <- [4, 6, 9, 11], day <- 1 .. 30 do
      assert JapaneseHoliday.holiday_name(1947, month, day) == nil
    end

    for month <- [2], day <- 1 .. 28 do
      assert JapaneseHoliday.holiday_name(1947, month, day) == nil
    end
  end

  # 祝日法施行後
  test "1948" do
    for month <- [1, 3, 5, 7, 8, 10, 12], day <- 1 .. 31 do
      assert JapaneseHoliday.holiday_name(1948, month, day) == nil
    end

    for month <- [4, 6, 9, 11], day <- 1 .. 30 do
      result = JapaneseHoliday.holiday_name(1948, month, day)
      assert result == (case {month, day} do
        { 9, 23} -> "秋分の日"
        {11,  3} -> "文化の日"
        {11, 23} -> "勤労感謝の日"
        _ -> nil
      end)
    end

    for month <- [2], day <- 1 .. 28 do
      assert JapaneseHoliday.holiday_name(1948, month, day) == nil
    end
  end

  test "2008" do
    for month <- [1, 3, 5, 7, 8, 10, 12], day <- 1 .. 31 do
      result = JapaneseHoliday.holiday_name(2008, month, day)
      assert result == (case {month, day} do
        { 1,  1} -> "元日"
        { 1, 14} -> "成人の日"
        { 3, 20} -> "春分の日"
        { 5,  3} -> "憲法記念日"
        { 5,  4} -> "みどりの日"
        { 5,  5} -> "こどもの日"
        { 5,  6} -> "振替休日"  # 火曜日に振替休日
        { 7, 21} -> "海の日"
        {10, 13} -> "体育の日"
        {12, 23} -> "天皇誕生日"
        _ -> nil
      end)
    end

    for month <- [4, 6, 9, 11], day <- 1 .. 30 do
      result = JapaneseHoliday.holiday_name(2008, month, day)
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
      result = JapaneseHoliday.holiday_name(2008, month, day)
      assert result == (case {month, day} do
        {2, 11} -> "建国記念の日"
        _ -> nil
      end)
    end
  end

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

  test "2030" do
    for month <- [1, 3, 5, 7, 8, 10, 12], day <- 1 .. 31 do
      result = JapaneseHoliday.holiday_name(2030, month, day)
      assert result == (case {month, day} do
        { 1,  1} -> "元日"
        { 1, 14} -> "成人の日"
        { 3, 20} -> "春分の日"
        { 5,  3} -> "憲法記念日"
        { 5,  4} -> "みどりの日"
        { 5,  5} -> "こどもの日"
        { 5,  6} -> "振替休日"
        { 7, 15} -> "海の日"
        { 8, 11} -> "山の日"
        { 8, 12} -> "振替休日"
        {10, 14} -> "体育の日"
        {12, 23} -> "天皇誕生日"
        _ -> nil
      end)
    end

    for month <- [4, 6, 9, 11], day <- 1 .. 30 do
      result = JapaneseHoliday.holiday_name(2030, month, day)
      assert result == (case {month, day} do
        { 4, 29} -> "昭和の日"
        { 9, 16} -> "敬老の日"
        { 9, 23} -> "秋分の日"
        {11,  3} -> "文化の日"
        {11,  4} -> "振替休日"
        {11, 23} -> "勤労感謝の日"
        _ -> nil
      end)
    end

    for month <- [2], day <- 1 .. 28 do
      result = JapaneseHoliday.holiday_name(2030, month, day)
      assert result == (case {month, day} do
        {2, 11} -> "建国記念の日"
        _ -> nil
      end)
    end
  end
end
