#!/usr/bin/env ruby

require_relative '../lib/number_name_string'

include NumberNameString

nnsc = NumberNameString::Convert.new

# Test various syntaxes
{ '1000.to_comma' => "1,000",
  '"1000".to_comma' => "1,000",
  '"one hundred".to_i' => 100,
  'NumberNameString[100]' => 'one hundred',
  'NumberNameString["one hundred"]' => 100,
  'nnsc[100]' => 'one hundred',
  'nnsc["one hundred"]' => 100,
  'nnsc["fourteen hundred"]' => 1400,
  'nnsc["fourteen hundred ninetysix"]' => 1496,
}.each do |statement, result|
  eval_result = eval statement
  unless eval_result == result
    puts "ERROR(0): '#{statement}' == '#{eval_result}' instead of '#{result}'"
  end
end

# Generate numbers, convert to string and back to number, compare results
[(0..22).to_a +
 (98..102).to_a +
 (999998..1000001).to_a +
 [87006200514255917]].flatten.each do |num|
  unless num.to_comma == NumberNameString[num].to_comma
    print "ERROR(1): "
    printf("%s -> \"%s\" -> %s -> %s\n",
           num.to_comma,
           NumberNameString[num],
           NumberNameString[num].to_i,
           NumberNameString[num].to_comma)
  end
end

# Compare series of strings to numbers
{ 'zero' => 0, 
  'six' => 6,
  'fiftytwo' => 52,
  'six hundred' => 600,
  'seven hundred fortytwo' => 742,
  'six hundred thousand' => 600000,
  'six hundred fourteen thousand two hundred sixtytwo' => 614262
}.each do |name, num|
  unless num.to_name == name
    puts "ERROR(2): \"#{name}\".to_i -> #{num} -> #{num.to_name}"
  end
end
