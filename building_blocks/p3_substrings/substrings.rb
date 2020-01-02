dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own",
      "part","partner","sit"]

def substrings word, dictionary
  word = word.downcase.split(" ")
  substrings_found = Hash.new(0)

  dictionary.each { |dictionary_word|
    x = 0

    while x < word.length
      if word[x].include? dictionary_word
        substrings_found[dictionary_word] = substrings_found[dictionary_word]+1
      end

      x += 1
    end
  }

  substrings_found
end

#  one word test
# substrings("below", dictionary)

# multi-word test
substrings("Howdy partner, sit down! How's it going?", dictionary)
