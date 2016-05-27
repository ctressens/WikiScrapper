#!/usr/bin/env ruby

module Test
	class Wurz
		def initialize name = "Wurz"
			@@name = name
		end

		def say_hello_to name
			"Hello #{name}, I'm #{@@name}"
		end
	end
end

module Test2
	class Spargel < Test::Wurz
		def stinking_pee
			"I'll make you do a stinking pee"
		end
	end
end


wurz = Test::Wurz.new "Saucisse"			# => #<Test::Wurz:0x00000001601278>
puts wurz.say_hello_to "David"				# => "Hello David, I'm Saucisse"

puts "---------------------------------"

spargel = Test2::Spargel.new "Asperge"		# => #<Test2::Spargel:0x000000012d32e0>
puts spargel.say_hello_to "Jeannette"		# => "Hello Jeannette, I'm Asperge"
puts spargel.stinking_pee					# => "I'll make you do a stinking pee"
