require_relative "number_name_string/convert"
require_relative "number_name_string/version"

module NumberNameString
  class NumberNameStringError < ArgumentError ; end

  # Would be ideal if we could only add this functionality only if included
  class ::Fixnum
    def to_comma
      self.to_s.to_comma
    end

    def to_name
      NumberNameString[self]
    end
  end

  # Would be ideal if we could only add this functionality only if included
  class ::String
    alias_method :old_to_i, :to_i

    def to_comma
      self.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse
    end

    def to_i
      # TODO: verify output may be a string and this is necessary
      result = NumberNameString[self]
      result.is_a?(String) ? result.old_to_i : result
    end
  end

  def self.[](num)
    (instance ||= NumberNameString::Convert.new)[num]
  end
end
