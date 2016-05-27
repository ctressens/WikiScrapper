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


wurz = Test::Wurz.new "Saucisse"		# => #<Test::Wurz:0x00000001de95f8>
puts wurz.say_hello_to "David"			# => "Hello David, i'm Saucisse"

puts "---------------------------------"

spargel = Test2::Spargel.new "Asperge"
puts spargel.say_hello_to "Jeannette"
puts spargel.stinking_pee
