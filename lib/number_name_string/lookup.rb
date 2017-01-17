module NumberNameString
  # Singleton class which generates translation tables on demand
  # Converts a single name into a number or a 0-100 into a name
  class Lookup
    require 'pp'
    require 'singleton'
    include Singleton

    # Lookup cardinal number name (ex: two)
    #
    # @param[Fixnum] number to convert (between 0-100)
    # @return[String] 
    def cardinal(number)
      lookup_cardinal[number]
    end

    # Lookup single word, return number or scale
    # @return[Fixnum, Symbol] 
    def number(name)
      if _ = lookup_name[name]
        [_, :number]
      elsif _ = lookup_scale[name]
        [_, :scale]
      else
        raise NumberNameParseError.new("Parse error on: #{name}")
      end
    end

    # Lookup ordinal number name (ex: second)
    #
    # @param[Fixnum] number to convert (between 0-100)
    # @return[String] 
    def ordinal(number)
      lookup_ordinal[number]
    end

    private

    def generate_cardinal_table
      ONES + TEENS + TENS.map do |prefix|
        [prefix] + ONES[1..9].map { |suffix| "#{prefix}#{suffix}".to_sym }
      end.flatten
    end

    def generate_name_table
      table = {}
      (ONES + TEENS).each.with_index { |name, number| table[name] = number }
      TENS.each.with_index do |prefix, number|
        number = (number + 2) * 10
        table[prefix] = number 
        ONES[1..9].each do |suffix|
          number += 1
          table["#{prefix}#{suffix}".to_sym] = number
        end
      end
      table.merge({ :hundred => 100}).merge MISPELLINGS
    end

    def generate_ordinal_table
      ORD_ONES + ORD_TEENS + TENS.map do |prefix|
        [prefix] + ORD_ONES[1..9].map { |suffix| "#{prefix}#{suffix}".to_sym }
      end.flatten
    end

    def generate_scale_table
      table = {}
      SCALES.each.with_index do |scale, index|
        size = 10 ** (index * 3)
        table[scale] = size if scale
      end
      table
    end

    def lookup_cardinal
      @lookup_cardinal ||= generate_cardinal_table
    end

    def lookup_name
      @lookup_name ||= generate_name_table
    end

    def lookup_ordinal
      @lookup_ordinal ||= generate_ordinal_table
    end

    def lookup_scale
      @lookup_scale ||= generate_scale_table
    end
  end
end
