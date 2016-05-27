#!/usr/bin/env ruby
# Déclarer t comme booléen égal à `true`
t = true
# Déclarer s comme string égale à `ça marche bien`
s = "ça marche bien"
puts s if t

module TakeBack

	class Wurz
		@@name = "Wurz"

		def initialize name
			@@name = name
		end

		def say_hello_to name
			"Hello #{name}, i'm #{@@name}"
		end

	end

end

wurz = TakeBack::Wurz.new 'Saucisse'	# => #<TakeBack::Wurz:0x00000001de95f8>
puts wurz.say_hello_to "David"			# => "Hello David, i'm Saucisse" 
