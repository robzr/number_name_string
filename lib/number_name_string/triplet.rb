module NumberNameString
  # Accumulates and totals a 3 digit number (with an optional scale)
  # Used internally only.
  class Triplet
    attr_accessor :hundreds, :tens, :scale

    def initialize(num = 0)
      reset num
    end

    def <<(num)
      @hundreds = @tens if @tens > 0
      @tens = num % 100
    end

    def to_i
      (@hundreds * 100 + @tens) * @scale 
    end

    def reset(num = 0)
      @hundreds = 0
      @tens = num
      @scale = 1
    end
  end
end

