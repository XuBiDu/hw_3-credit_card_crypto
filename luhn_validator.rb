# Validates credit card number using Luhn Algorithm
# arguments: none
# assumes: a local String called 'number' exists
# returns: true/false whether last digit is correct
module LuhnValidator
  def validate_checksum
    nums_a = number.to_s.chars.map(&:to_i).reverse
    sum = nums_a.each_with_index.map { |d, i| double_even(d, i) }.inject(:+)
    (sum % 10).zero?
  end

  def double_even(digit, index)
    return digit if index.even?

    digit *= 2
    digit > 9 ? digit - 9 : digit
  end
end
