
require 'test/unit'
require 'solaris/lastlog'

class TestCreate < Test::Unit::TestCase #:nodoc:

  def test_create
    lastlog = Solaris::Lastlog.new(:endian => :big)
    record = lastlog.create(:ll_time => 1375010633, :ll_host => "neptune", :ll_line => "pts/1")
    assert_equal(1375010633, record.ll_time)
    assert_equal("neptune", record.ll_host)
    assert_equal("pts/1", record.ll_line)
  end

  def test_create_with_padding
    lastlog = Solaris::Lastlog.new(:endian => :big, :trim_padding => false)
    record = lastlog.create(:ll_time => 1375010633, :ll_host => "neptune", :ll_line => "pts/1")
    assert_equal(1375010633, record.ll_time)
    assert_equal("neptune\x00\x00\x00\x00\x00\x00\x00\x00\x00", record.ll_host)
    assert_equal("pts/1\x00\x00\x00", record.ll_line)
  end

  def test_create_invalid_fields
    lastlog = Solaris::Lastlog.new(:endian => :big)
    assert_raise(ArgumentError) do
      lastlog.create(:quack => :boom)
    end
  end

end # TestCreate

