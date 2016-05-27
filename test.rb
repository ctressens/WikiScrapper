#!/usr/bin/env ruby

module Test
	class Wurz
		def initialize name = "Wurz"
			@@name = name
		end

		def say_hello_to name
			"Hello #{name}, i'm #{@@name}"
		end
	end

end

wurz = Test::Wurz.new "Saucisse"		# => #<TakeBack::Wurz:0x00000001de95f8>
puts wurz.say_hello_to "David"			# => "Hello David, i'm Saucisse"
