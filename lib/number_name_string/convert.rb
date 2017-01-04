module NumberNameString
  class Convert
    #
    # TODO: convert to arrays for multiple spellings
    #  - [forty, fourty]
    #  - [hundred, hundered]
    #
    ONES = %W{ #{} one two three four five six seven eight nine }
    ONES_ZERO = %W{ zero one two three four five six seven eight nine }
    TEENS = %w{ ten eleven twelve thirteen fourteen fifteen sixteen
                seventeen eighteen nineteen } 
    TENS = %W{ #{} #{} twenty thirty forty fifty sixty seventy eighty ninety }
    SCALE = %W{ #{} thousand million billion trillion quadrillion quintillion
      sextillion septillion octillion nonillion decillion undecillion duodecillion
      tredecillion quattuordecillion quindecillion sexdecillion septendecillion
      octodecillion novemdecillion vigintillion }
    SCALE_MAX = (SCALE.length - 1) * 3

    def [](arg)
      if arg.is_a? Fixnum
        to_s arg
      elsif arg.is_a? String 
        to_i arg
      else
        raise NumberNameStringError.new("Invalid arg type: #{arg.class.name}")
      end
    end

    alias << []

    def to_i(arg)
      num = 0
      words = arg.downcase.gsub('-', '').split(/\s+/)
      while word = words.shift
        accum = 0
        # (sub_hundred | ones(false) hundred [sub_hundred] )[scale]]
        if sub_hundred?(word)
          if ones?(word, false) && hundred?(words[0])
            accum += ones?(word) * 100
            words.shift
            word = words.shift
          else
            accum += sub_hundred?(word)
          end
          word = words.shift
          if scale? word      
            accum *= scale? word
          end
        end
#        puts "accum: #{accum}"
        num += accum
      end
      num
    end

    def to_s(num, include_zero = true)
      case digits = num.to_s.length
      when 1
        include_zero ? ONES_ZERO[num] : ONES[num]
      when 2
        num < 20 ? TEENS[num - 10] : "#{TENS[num / 10]}#{ONES[num % 10]}"
      when 3
        "#{ONES[num / 100]} hundred#{space_pad(to_s(num % 100, false))}"
      when (4..SCALE_MAX)
        zeros = 10 ** (((digits - 1) / 3) * 3)
        "%s%s%s" % [to_s(num / zeros, false),
                    space_pad(SCALE[(digits - 1) / 3]),
                    space_pad(to_s(num % zeros, false))]
      else
        raise NumberNameStringError.new('Number out of range')
      end
    end

    private

    # ONES = %W{ #{} one two three four five six seven eight nine }
    # ONES_ZERO = %W{ zero one two three four five six seven eight nine }
    # TEENS = %w{ ten eleven twelve thirteen fourteen fifteen sixteen
    #   seventeen eighteen nineteen }
    # TENS = %W{ #{} #{} twenty thirty fourty fifty sixty seventy eighty ninety }
    # SCALE = %W{ #{} thousand million billion trillion quadrillion quintillion
    
    def hundred?(word)
      word == 'hundred' && 100
    end

    def number?(word)
      ones?(word) || teens?(word) || tens?(word) || hundred?(word)
    end

    def ones?(word, with_zero = true)
      if with_zero
        ONES_ZERO.find_index word
      else
        ONES.find_index word
      end
    end

    def scale?(word)
      _ = SCALE.find_index word
      10 ** (_ * 3) if _ 
    end

    def space_pad(arg)
      if arg.is_a?(NilClass) || arg == ''
        ''
      elsif arg =~ /^\s/
        arg
      else
        " #{arg}"
      end
    end

    def sub_hundred?(word)
      ones?(word) || teens?(word) || tens?(word)
    end

    def teens?(word)
      _ = TEENS.find_index word
      _ + 10 if _
    end

    def tens?(word)
      if TENS.find_index(word)
        TENS.find_index(word) * 10
      elsif tens_prefix?(word)
        prefix = tens_prefix?(word)
        suffix = word.slice(prefix.length, 100)
        if ones?(suffix, false)
          TENS.find_index(prefix) * 10 + ones?(suffix, false)
        end
      end
    end

    def tens_prefix?(word)
      TENS.select { |prefix| prefix != "" && word =~ /^#{prefix}/ }.first
    end
  end
end
