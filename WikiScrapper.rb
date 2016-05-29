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

            @links = Array.new
        end
        def find_path

        end
        def get_links url = @starting
            doc = Nokogiri::HTML(open(url))
            @layer = Array.new
            # @layers[@layers.length] = Array.new     # => Will be `lay`


            doc.css('#mw-content-text a').each do |a|
                href = a.attributes["href"].value
                if href[0, 6] === "/wiki/"
                    href["/wiki/"] = ""
                else
                    next
                end
                @layer[@layer.length] = href if !@layer.include? href
                @links[@links.length] = href if !@links.include? href
            end
        end

        private

            def format_url url
                if url[0, 4] = "http"

                end
            end
    end
end

explor = WikiScrapper::Explorer.new 'https://fr.wikipedia.org/wiki/Ruby', 'https://fr.wikipedia.org/wiki/Python_(language)'
explor.get_links
