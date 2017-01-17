module NumberNameString
  # Cardinal Numbers & Scales
  ONES = [:zero, :one, :two, :three, :four, :five, :six, :seven, :eight, 
          :nine].freeze
  TEENS = [:ten, :eleven, :twelve, :thirteen, :fourteen, :fifteen, :sixteen,
           :seventeen, :eighteen, :nineteen].freeze
  TENS = [:twenty, :thirty, :forty, :fifty, :sixty, :seventy, :eighty,
          :ninety].freeze
  SCALES = [nil, :thousand, :million, :billion, :trillion, :quadrillion,
           :quintillion, :sextillion, :septillion, :octillion, :nonillion,
           :decillion, :undecillion, :duodecillion, :tredecillion,
           :quattuordecillion, :quindecillion, :sexdecillion, :septendecillion,
           :octodecillion, :novemdecillion, :vigintillion]

  # Ordinal Numbers & Scales
  ORD_ONES = [:zeroth, :first, :second, :third, :fourth, :fifth, :sixth,
              :seventh, :eighth, :ninth].freeze
  ORD_TEENS = ([:tenth, :eleventh, :twelfth] + 
                TEENS[3..9].map { |teen| "#{teen}th".to_sym }).freeze
  ORD_TENS = TENS.map { |ten| ten.to_s.sub(/y$/, 'ieth').to_sym }.freeze
  ORD_SCALES = SCALES.map { |scale| "#{scale}th".to_sym if scale }

  SCALE_MAX = (SCALES.length - 1) * 3

  # Common mispellings
  MISPELLINGS = {
    :fourty => 40,      :fourtieth => 40,
    :fourtyone => 41,   :fourtifirst => 41,
    :fourtytwo => 42,   :fourtisecond => 42,
    :fourtythree => 43, :fourtithird => 43,
    :fourtyfour => 44,  :fourtifourth => 44,
    :fourtyfive => 45,  :fourtififth => 45,
    :fourtysix => 46,   :fourtisixth => 46,
    :fourtyseven => 47, :fourtiseventh => 47,
    :fourtyeight => 48, :fourtieighth => 48,
    :fourtynine => 49,  :fourtininth => 49,
    :hundered => 100,   :hunderedth => 100
  }
end
