#!/usr/bin/env ruby

require 'rubygems'
require 'nokogiri'
require 'open-uri'

# ENTREES

# Début
print "URL de départ : "
starting_url = gets.chomp
while starting_url[0, 8] != "https://"
    print "URL de départ : "
    starting_url = gets.chomp
end

# Fin
print "URL d'arrivée : "
ending_url = gets.chomp
while ending_url[0, 8] != "https://"
    print "URL d'arrivée : "
    ending_url = gets.chomp
end



# Début du script putain enfin quoi c'est long putain fait chier fdp enculé.
starting_doc = Nokogiri::HTML(open(starting_url))
hrefs = Array.new

starting_doc.css('#mw-content-text p a').each do |a|
    href = a.attributes["href"].value
    if href[0, 6] == "/wiki/"
        href["/wiki/"] = ""
        hrefs[hrefs.length] = href
    end
end

p hrefs
