module NumberNameString
  # Handles conversion logic, takes full number (string or numeric), parses
  # and accumulates results from lookup tables
  class Convert
    def initialize(num = nil)
      @lookup = Lookup.instance
      @num = num
      @num_struct = Struct.new(:word, :type, :number) 
    end

    def [](arg = @num)
      if arg.is_a? Fixnum
        num_to_string arg
      elsif arg.is_a? String 
        string_to_num arg
      elsif arg.is_a? Symbol 
        string_to_num arg.to_s
      else
        raise NumberNameStringError.new("Invalid arg type: #{arg.class.name}")
      end
    end

    alias << []

    # Converts a string to a number
    #
    # @param arg [String] number to convert
    # @returns [Integer] number
    def string_to_num(arg = @num)
      total = 0
      triplet = Triplet.new
      words = num_string_to_array arg
      marker = words.length
      while marker > 0 
        marker -= 1
        word = words[marker]
        if word.type == :number
          triplet << word.number
        end
        if word.type == :scale || marker == 0
          triplet.scale = word.number if word.type == :scale
          total += triplet.to_i
          triplet.reset
        end
      end
      total
    end

    # Converts a number to a string
    #
    # @param num [Integer] number to convert
    # @param type [Symbol] convert to type :cardinal or :ordinal
    # @returns [String] name of number
    def num_to_string(num = @num, type = :cardinal)
      name = ''
      num_to_triplets(num).each_with_index.reverse_each do |triplet, index| 
        name += " #{name_triplet triplet} #{SCALES[index]}" if triplet > 0
      end 
      name == '' ? 'zero' : name.sub(/^\s*/, '').sub(/\s*$/, '')
    end

    private

    # Cleans and splits string
    #
    # @param arg [String] string to split & convert
    # @returns [Array] array of symbols
    def clean_and_split(arg)
      arg.downcase
        .gsub('-', '')
        .gsub(/\band\b/, '')
        .split(/\s+/)
        .map { |word| word.to_sym }
    end

    # Converts a triplet (1-3 digit number) to a string
    #
    # @param arg [Integer] number to convert
    # @param type [Symbol] :cardinal or :ordinal
    # @returns [String] name of number
    def name_triplet(num, type = :cardinal)
      if num >= 100
        name = "#{@lookup.cardinal(num / 100)} hundred"
        name += " #{@lookup.cardinal(num % 100)}" unless num % 100 == 0
        name
      else
        @lookup.cardinal num
      end
    end

    def num_to_triplets(num = @num)
      str = num.to_s
      if str.length % 3 == 0
        str
      else
        str.rjust((3 - str.length % 3) + str.length, '0')
      end.scan(/\d{3}/)
        .map(&:to_i)
        .reverse
    end

    def num_string_to_array(arg)
      clean_and_split(arg).reverse.map do |word| 
        number, type = @lookup.number word
        @num_struct.new(word, type, number)
      end
    end
  end
end
