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
            get_links
            puts "true" if @layer.include? format_url(@ending)
        end

        private
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
            def format_url url
                if url[0, 4] = "http"
                    url[0, (url.index('/wiki/') + 6)] = ""
                end
                url
            end
    end
end

explor = WikiScrapper::Explorer.new 'https://fr.wikipedia.org/wiki/Ruby', 'https://fr.wikipedia.org/wiki/Python_(langage)'
explor.find_path
