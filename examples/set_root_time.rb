#!/usr/bin/env ruby

require 'solaris/lastlog'

io = File.open(ARGV[0], 'r')
reader = Solaris::Lastlog.new(:endian => :little)
first_record = true
while !io.eof? do
  record = reader.read(io)
  if first_record
    record.ll_time = Time.now.to_i
    first_record = false
  end
  print record.to_binary_s
end

