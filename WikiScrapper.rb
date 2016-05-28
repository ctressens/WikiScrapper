#!/usr/bin/env ruby
require 'rubygems'
require 'nokogiri'
require 'open-uri'

## INPUTS
# Input de l'URL de départ
print "URL de départ : "
starting_url = gets.chomp
while starting_url[0, 8] != "https://"
    print "URL de départ : "
    starting_url = gets.chomp
end

# Inpute de l'URL de fin
print "URL d'arrivée : "
ending_url = gets.chomp
while ending_url[0, 8] != "https://"
    print "URL d'arrivée : "
    ending_url = gets.chomp
end



## Début du script
def explorer
	starting_doc = Nokogiri::HTML(open(starting_url))
	hrefs = Array.new

	starting_doc.css('#mw-content-text a').each do |a|
		href = a.attributes["href"].value
		if href[0, 6] == "/wiki/"
			href["/wiki/"] = ""
		else
			next
		end
		if !hrefs.include? href
			hrefs[hrefs.length] = href
		end
	end
end

p hrefs
