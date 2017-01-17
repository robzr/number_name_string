require_relative 'number_name_string/convert'
require_relative 'number_name_string/constants'
require_relative 'number_name_string/lookup'
require_relative 'number_name_string/triplet'
require_relative 'number_name_string/version'

module NumberNameString

  class NumberNameStringError < ArgumentError ; end

  class NumberNameParseError < ArgumentError ; end

  # Extends Fixnum class with to_comma and to_name
  class ::Fixnum
    def to_comma
      self.to_s.add_commas
    end

    def to_name
      NumberNameString[self]
    end
  end

  # Extends String class with to_comma and updated to_i
  class ::String
    alias_method :old_to_i, :to_i

    def to_comma
      self.to_i.to_comma
    end

    def add_commas
      self.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse
    end

    def to_i
      if self =~ /^\d+$/
        old_to_i
      else
        NumberNameString[self]
      end
    end
  end

  def self.[](num)
    (@instance ||= NumberNameString::Convert.new)[num]
  end
end
