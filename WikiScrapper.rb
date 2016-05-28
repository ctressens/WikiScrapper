#!/usr/bin/env ruby

# ENTREES

# Début
print "URL de départ : "
url_depart = gets.chomp
while url_depart[0, 8] != "https://"
    print "URL de départ : "
    url_depart = gets.chomp
end

# Fin
print "URL d'arrivée : "
url_arrivee = gets.chomp
while url_arrivee[0, 8] != "https://"
    print "URL d'arrivée : "
    url_arrivee = gets.chomp
end
