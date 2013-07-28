#!/usr/bin/env ruby

require 'solaris/lastlog'

io = File.open(ARGV[0], 'r')
reader = Solaris::Lastlog.new(:endian => :little)
uid = 0
while !io.eof? do
  record = reader.read(io)
  unless record.ll_time.zero?
    time = Time.at(record.ll_time)
    puts "%-5s %s %-16s %-8s" % [uid, time, record.ll_host, record.ll_line]
  end
  uid += 1
end

