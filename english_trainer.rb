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

require 'rubygems'
require 'curses'

class EnglishTrainer
  # start and stop 
  
  def initialize()
    @words = {}
    @win = Curses::Window.new(640, 480, 0, 0);
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
    @win <<  "please input the meaning of [#{w[:id]}]\n>"
    @win.refresh
    input = @win.getstr.chomp
    @win.refresh
    if w[:means].include?(input) then
      @win << "Congrats!"
    else
      @win << "Oh, wrong..."
    end
    @win.refresh
  end
end
