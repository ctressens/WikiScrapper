#!/usr/bin/env ruby
require 'rubygems'
require 'uri'
require 'open-uri'
require 'nokogiri'

module WikiScrapper
    class Explorer
        def initialize starting, ending
            @starting = starting
            @ending = ending

            @layers = Array.new
            @links = Array.new
		end
		def get_links url = @starting
			doc = Nokogiri::HTML(open(url))
			@layers[@layers.length] = Array.new
			doc.css('#mw-content-text a').each do |a|
				href = a.attributes["href"].value
				if href[0, 6] === "/wiki/"
					href["/wiki/"] = ""
				else
					next
				end
				p href
			end
		end
	end
end

explor = WikiScrapper::Explorer.new 'https://fr.wikipedia.org/wiki/Ruby', 'https://fr.wikipedia.org/wiki/Python'
explor.get_links
