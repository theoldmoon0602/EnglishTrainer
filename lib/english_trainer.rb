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

  def edit(w)
    @win.clear
    @win << <<"EDIT"
About "#{w[:id]}"
 Word Type #{w[:types]}
 Means #{w[:means]}
 Relations #{w[:relations]}

Commands
 ct or change type [type] => Change Types to [type]
  Type Usage: Verb = V, Noun = N, Adjective = A, Adverb = D, Preposition = P, Conjunction = C, Interjection = I, Others = _
  Setting Usage: ct VN # Change Types to (Verb | Noun)

 am or add mean with [mean] => Add [mean] to Meanings
 cm or chagne mean with [n] [mean] => Change [n]th Meaning to [mean]
 dm or delete mean with [n] => Delete [n]th Meaning From Meanings

 ar or add relation [relation] => Add [relation] to Relations
 cr or change relation with [n] [relation]  => Change [n]th Relations to [relation]
 dr or delete relation with [n] => Delete [n]th relation From Relations

 delete => Delete This word

 q or Return with no command => Finish this Editing Mode
EDIT
  @win.refresh

  cmd = @win.getstr.chomp
  @win.clear
  case cmd
  when /^ct .+$/, /^change type .+$/ then
    w[:types] = cmd.match(/change type (.+)$/)[1]    
  end
  
  inquire_next_command(w)
  end

  def is_correct(s, w) 
    if w[:means].include?(s) then
      @win << "Cogratulations!\n"
    else
      @win << "Wrong! Its means are #{w[:means]}...\n"
    end
    @win.refresh
  end

  def inquire_next_command(w)
    @win << <<"CMDS"
What Do You Want to Do Next? Type Command...
 Return with no commands or invalid command=> Qestion About Next Word Associated with the "#{w[:id]}"
 e or edit => Edit About "#{w[:id]}"
 q or exit => Exit This App 
CMDS
    @win << ">"
    @win.refresh

    case @win.getstr.chomp.downcase
    when "q", "quit", "exit" then
      @win.close
      exit
    when "e", "edit" then
      return edit(w)
    else
      return question(next_word(w))
    end
  end

end
