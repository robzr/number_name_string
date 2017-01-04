require_relative "number_name_string/convert"
require_relative "number_name_string/version"

module NumberNameString
  class NumberNameStringError < ArgumentError ; end

  # Would be ideal if we could only add this functionality only if included
  class ::Fixnum
    def to_comma
      self.to_s.to_comma
    end
  end

  # Would be ideal if we could only add this functionality only if included
  class ::String
    alias_method :old_to_i, :to_i

    def to_comma
      self.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse
    end

    def to_i
      result = NumberNameString[self]
      # TODO: verify output of above may be a string
      result.is_a?(String) ? result.old_to_i : result
    end
  end

  def self.<<(num)
    self[num]
  end

  def self.[](num)
    (instance ||= NumberNameString::Convert.new)[num]
  end
end
