#! /usr/bin/env ruby

require "./english_trainer.rb"

trainer = EnglishTrainer.new

symbol = Word.new
symbol.means = ["シンボル", "記号", "符号", "象徴", "符丁"]
symbol.type = WordClass::NOUN
symbol.relations = [:sign, :code, :mark, :attibute, :token, :emblem]

trainer.add(symbol)
trainer.save("words.dat")
