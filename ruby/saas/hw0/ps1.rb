=begin
Define a method sum which takes an array of integers as an argument 
and returns the sum of its elements. 
For an empty array it should return zero.
=end

def sum(array)
  return 0 unless array.any?
  return array.shift + sum(array)
end

=begin
Define a method max_2_sum which takes an array of integers as an 
argument and returns the sum of its two largest elements. 
For an empty array it should return zero. 
For an array with just one element, it should return that element.
=end

def max_2_sum(array)
	return 0 unless array.any?
	return array[0] if array.length == 1
	array.sort!
	return array[-1] + array[-2]
end

=begin
Define a method sum_to_n? which takes an array of integers 
and an additional integer, n, as arguments 
and returns true if any two distinct elements 
in the array of integers sum to n. 
An empty array or single element array should both return false.
=end

def sum_to_n?(array, n)
	return false unless array.any?
	check = array.shift
	array.each do |x|
		if x + check == n
			return true
		end
	end
	return sum_to_n?(array, n)
end