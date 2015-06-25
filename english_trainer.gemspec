Gem::Specification.new do |gem|
	gem.name = "english_trainer"
	gem.version = "0.0.0" # This is the current version. Some people use a seperate file to store the version.
	gem.author = "furusuki"
	gem.email = "theoldmoon0602@gmail.com"
	gem.files = Dir['*.rb'] + "words.dat"
	gem.summary = "A tool for learning english"
	gem.license = "MIT"
	gem.add_runtime_dependency "curses"
	gem.executables = "english_trainer"
end
