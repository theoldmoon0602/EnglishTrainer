module WordClass
  VERB = 0
  NOUN = 1
  ADJECTIVE = 2
end

class Word
  attr_accessor :id, :means, :type, :relations
  @id
  @means
  @type
  @relations
end

class EnglishTrainer
  def initialize()
    @words = {}
  end

  #save and load
  def load(fname)
    @words = Marshal.restore(File.read(fname))
  end
  def save(fname)
    File.write(fname, Marshal.dump(@words))
  end

  # editing @words
  def add(word)
    @words[word[:id]] = word
  end
  def [](key)
    @words[key]
  end

  #command
  def question
    w = @words.to_a.sample[1]
    print "please input the meaning of [#{w[:id]}]\n>"
    input =  gets.chomp
    if w[:means].include?(input) then
      puts "Congrats!"
    else
      puts "Oh, wrong..."
    end
  end
end
