class CompleteMe

  attr_reader :word_counter

  def initialize
    @tree_root = Hash.new{ |hash, key| hash[key]=Hash.new(&hash.default_proc) }
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
    return true if result == {}
    return false if result != {}
  end

  def count
    @word_counter
  end

  def populate(dictionary)
    dictionary.each_line do |word|
      insert(word.strip)
    end
  end

  def suggest(word)
  # Suggest needs to traverse the branches off of root breadth-first
    current_node = @tree_root
    search_string = ""
    suggest_array = []
    words = word.split("")
    until current_node == true
    words.each do |letter|
        if current_node.keys[0] == letter
          search_string << letter
          current_node = current_node.fetch(letter)
        else
          current_node = @tree_root
        end
      end
    end
    suggest_array << search_string
    suggest_array
  end

  #  def suggest_deeper(letter)
  #    until current.dig(letter) != true
  #      suggest_deeper(letter)
  #    end
  #    return letter
  #  end
end
