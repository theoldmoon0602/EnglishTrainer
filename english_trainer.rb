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
  
  def initialize
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
  def question(w = nil)
    if w == nil then
      w = @words.to_a.sample[1]
    end

    @win <<  "please input the meaning of [#{w[:id]}]\n>"
    @win.refresh

    input = @win.getstr.chomp
    @win.refresh

    is_correct(input, w)

    inquire_next_command(w)
  end

  private
  #utils
  def next_word(w)
    w[w[:relations].sample]
  end

  def is_correct(s, w) 
    if w[:means].include?(s) then
      @win << "Cogratulations!"
    else
      @win << "Wrong! Its means are #{w[:means]}..."
    end
    @win.refresh
  end

  def inquire_next_command(w)
    @win << <<CMDS
What Do You Want to Do Next? Type Command...
 Return with no commands or invalid command=> Qestion About Next Word Associated with the #{w[:id]}
 q or exit => Exit This App 
CMDS
    @win << ">"
    @win.refresh

    case @win.getstr.chomp.downcase
    when "q", "quit", "exit" then
      @win.close
      exit
    else
      return question(next_word(w))
    end
  end

end
