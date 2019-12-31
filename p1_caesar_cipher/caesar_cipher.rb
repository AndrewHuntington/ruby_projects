SKIP_CHARACTER_REGEX = /[^\w]|_/

def caesar_cipher string, num
  new_string = ""

  string.split("").map { |c|
    if c =~ SKIP_CHARACTER_REGEX
      new_string += c
    else
      num.times do 
        c.next!
      end

      if c.length == 2
        new_string += c[1]
      else
        new_string += c
      end
    end
  }

  new_string
end

caesar_cipher "What a string!", 5
