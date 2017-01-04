#!/usr/bin/env ruby

require_relative '../lib/number_name_string'

include NumberNameString

# Test Fixnum extension to_comma
puts "1000.to_comma: #{1000.to_comma}"
puts "\'1000\'.to_comma: #{'1000'.to_comma}"

# Test String.to_i
puts "'one hundered'.to_i: #{'one hundred'.to_i}"

# Call as a module method
puts "Module method ([]): #{NumberNameString[100]}"
puts "Module method (<<): #{NumberNameString << 100}"

# Instantiate and call
nnsc = NumberNameString::Convert.new
puts "Class method ([]): #{nnsc[100]}"
puts "Class method (<<): #{nnsc << 100}"

# Print table of test numbers
TEST_NUMBERS = [(0..22).to_a +
                (98..102).to_a +
                (999998..1000001).to_a +
                [87006200514255917]].flatten.freeze

TEST_NUMBERS.each do |num|
  rendered = NumberNameString[num]
  unrendered = NumberNameString[rendered]
  printf("%-10s -> %-10s -> \"%s\"\n",
         num.to_comma,
         NumberNameString[unrendered],
         rendered)
end
