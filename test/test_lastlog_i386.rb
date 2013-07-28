
require 'test/unit'
require 'solaris/lastlog'

class TestLastlogI386 < Test::Unit::TestCase #:nodoc:

  def setup
    @reader = Solaris::Lastlog.new(:endian => :little)
    @io = File.open(File.join(File.dirname(__FILE__), 'lastlog.i386'), 'r')
    @root_entry = @reader.read(@io)
  end

  def teardown
    @io.close
  end

  def test_read
    assert_equal(1366318982, @root_entry.ll_time)
    assert_equal("console", @root_entry.ll_line)
    assert_equal("jupiter", @root_entry.ll_host)
    assert_equal(Solaris::Lastlog::RECORD_LENGTH, @root_entry.to_binary_s.length)
  end

  def test_trim_padding
    @reader = Solaris::Lastlog.new(:endian => :little, :trim_padding => false)
    @io.rewind
    @root_entry = @reader.read(@io)
    assert_equal(1366318982, @root_entry.ll_time)
    assert_equal("console\x0", @root_entry.ll_line)
    assert_equal("jupiter\x0\x0\x0\x0\x0\x0\x0\x0\x0", @root_entry.ll_host)
  end

  def test_host
    assert_equal("jupiter", @root_entry.ll_host)
    @root_entry.ll_host = "host"
    assert_equal("host", @root_entry.ll_host)
    @root_entry.ll_host = "12345678901234567" # too long
    assert_equal("1234567890123456", @root_entry.ll_host)
  end

  def test_line
    assert_equal("console", @root_entry.ll_line)
    @root_entry.ll_line = "line"
    assert_equal("line", @root_entry.ll_line)
    assert_equal("line", @root_entry.ll_line)
    @root_entry.ll_line = "123456789" # too long
    assert_equal("12345678", @root_entry.ll_line)
  end

  def test_time
    assert_equal(Time.at(1366318982).to_i, @root_entry.ll_time)
    now = Time.now.to_i
    @root_entry.ll_time = now
    assert_equal(now, @root_entry.ll_time)
  end

  def test_to_binary_s
    @io.rewind
    raw = @io.read(Solaris::Lastlog::RECORD_LENGTH)
    assert_equal(raw, @root_entry.to_binary_s)
  end

end # TestLastlogI386

