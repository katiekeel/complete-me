class CompleteMe

  attr_reader :word_counter

   def initialize
      @tree_root = Hash.new{ |h,k| h[k]=Hash.new(&h.default_proc) }
      @word_counter = 0
   end

   def insert(word)
     letters = word.split("")
     current = @tree_root
     letters[0..-2].each do |letter|
       current = current[letter]
     end
     current = current[letters.last][true]
     @word_counter += 1
   end


  def have?(word)
    letters = word.split("")
    current = @tree_root
    letters.each do |letter|
      current = current.fetch(letter, nil) rescue nil
    end
    result = current.fetch(true, nil) rescue nil
    if result == {}
      return true
    else
      return false
    end
  end

  def count
   @word_counter
  end

  def populate(dictionary)
    dictionary.each_line do |word|
        insert(word.strip)
    end
  end

end
