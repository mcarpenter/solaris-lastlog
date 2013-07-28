
require 'bindata'

module Solaris

  # See "struct lastlog" in /usr/include/lastlog.h:
  #
  #     struct lastlog {
  #     #ifdef _LP64
  #         time32_t ll_time;
  #     #else
  #         time_t  ll_time;
  #     #endif
  #         char    ll_line[8];
  #         char    ll_host[16];        /* same as in utmp */
  #     };
  #
  class Lastlog

    # The (anonymous) class of generated records.
    attr_reader :record_class

    # Length of a raw lastlog record in bytes.
    RECORD_LENGTH = 28

    # Create a new Lastlog factory object. Options are:
    # * :endian -- mandatory, set to :big (SPARC) or :little (i386)
    # * :trim_padding -- trim terminating nulls from read strings
    # This will generate objects of an anonymous class that is a subclass
    # of BinData::Record.
    def initialize(opts)

      endianism = nil
      trim_padding = true
      opts.each do |key, value|
        case key
        when :endian
          endianism = value
        when :trim_padding
          trim_padding = value
        else
          raise ArgumentError, "Unknown option #{key.inspect}"
        end
      end

      @record_class = Class.new(BinData::Record) do

        endian endianism

        uint32 :ll_time
        string :ll_line, :length => 8, :trim_padding => trim_padding
        string :ll_host, :length => 16, :trim_padding => trim_padding

        # Return the timestamp of this record as a Time object in the local TZ.
        def localtime          
          Time.at(self.ll_time)
        end                    

      end

    end

    # Create a new record. Option keys are:
    # * :ll_time
    # * :ll_line
    # * :ll_host
    def create(opts={})
      # BinData silently discards unknown fields so we check.
      unknown_fields = opts.keys - self.record_class.fields.fields.map(&:name)
      raise ArgumentError, "Unknown fields #{unknown_fields.inspect}" unless unknown_fields.empty?
      @record_class.new(opts)
    end

    # Read a lastlog record from the given IO object.
    def read(io)
      @record_class.read(io)
    end

  end # Lastlog

end # Solaris

