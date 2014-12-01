module FunWithStrings
  def palindrome?   
    word = self.downcase.gsub(/[^a-z\s]/i, '').gsub(/\p{Space}/,'')
    return word == word.reverse
  end

	def count_words
		words = self.downcase.gsub(/[^a-z\s]/i, '').split(" ")
		dictionary = Hash.new
	    
    words.each do |w|
      if dictionary.has_key?(w)
        dictionary[w] += 1
      else
				dictionary[w] = 1
			end 
		end
    return dictionary
  end

  def anagram_groups
    words = self.downcase.gsub(/[^a-z\s]/i, '')
		anagrams = []

  end
end

# make all the above functions available as instance methods on Strings:

class String
  include FunWithStrings
end
