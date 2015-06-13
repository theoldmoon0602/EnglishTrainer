#! /usr/bin/env ruby

require "./english_trainer.rb"

trainer = EnglishTrainer.new
trainer.load("words.dat")

trainer.question

