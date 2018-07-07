require 'test_helper'

class LineParseTest < Minitest::Test
  def test_parse
    result = Crntb.parse_line('* * * * * foo.sh')
    assert_equal result, "every day on every hour on every minute\n  run command foo.sh"
  end

  def test_minute_parse
    result = Crntb.parse_line('10 * * * * foo.sh')
    assert_equal result, "every day on every hour when minute equals 10\n  run command foo.sh"

    result = Crntb.parse_line('*/10 * * * * foo.sh')
    assert_equal result, "every day on every hour when minute equals one of (00, 10, 20, 30, 40, 50)\n  run command foo.sh"

    result = Crntb.parse_line('5-10 * * * * foo.sh')
    assert_equal result, "every day on every hour when minute equals one of (05, 06, 07, 08, 09, 10)\n  run command foo.sh"

    result = Crntb.parse_line('5,10 * * * * foo.sh')
    assert_equal result, "every day on every hour when minute equals one of (05, 10)\n  run command foo.sh"
  end

  def test_hour_parse
    result = Crntb.parse_line('* 10 * * * foo.sh')
    assert_equal result, "every day on every minute when hour is (10)\n  run command foo.sh"

    result = Crntb.parse_line('* */10 * * * foo.sh')
    assert_equal result, "every day on every minute when hour is (00, 10, 20)\n  run command foo.sh"

    result = Crntb.parse_line('* 5-10 * * * foo.sh')
    assert_equal result, "every day on every minute when hour is (05, 06, 07, 08, 09, 10)\n  run command foo.sh"

    result = Crntb.parse_line('* 5,10 * * * foo.sh')
    assert_equal result, "every day on every minute when hour is (05, 10)\n  run command foo.sh"
  end

  def test_day_of_month_test; end
  def test_month_test; end
  def test_day_of_week_test; end
end