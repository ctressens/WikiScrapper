#!/usr/bin/env ruby
require 'rubygems'
require 'uri'
require 'open-uri'
require 'nokogiri'

module  Wiki

    class PathFinder
        def initialize starting_url, ending_url
            @starting_url = starting_url
            @ending_url = ending_url
        end

        def start_finding
            if validate_url(@starting_url) && validate_url(@ending_url)
                scan_page @starting_url
            else
                puts "Ooops, there is a problem. Please copy/paste the URLs from Wikipedia."
            end
        end

        private
            def validate_url url
                if /^https:\/\/[a-z]{2}.wikipedia.org\/wiki\/.+$/ =~ url
                    true
                else
                    false
                end
            end
            def validate_uri uri
                if /^\/wiki\/.+$/ =~ uri
                    true
                else
                    false
                end
            end

            def format_url url
                if validate_url url
                    url.sub(/^https:\/\/[a-z]{2}.wikipedia.org\/wiki\//, '')
                else
                    false
                end
            end
            def format_uri uri
                if validate_uri uri
                    uri.sub(/^\/wiki\//, '')
                else
                    false
                end
            end
            def uri_or_url urall
                if /^https:\/\/.+\..+/ =~ urall
                    "url"
                elsif /^\/wiki\/.+/ =~ urall
                    "uri"
                end
            end

            def scan_page url
                document = Nokogiri::HTML(open(url))
                list = Array.new
                document.css('#mw-content-text a').each do |a|
                    href = a.attributes["href"].value
                    if uri_or_url(href) == "uri"
                        # p format_uri(href)
                        list[list.length] = format_uri(href) if !list.include? format_uri(href)
                    end

                end
                puts list
            end
    end

end

pathfind = Wiki::PathFinder.new "https://fr.wikipedia.org/wiki/Ruby", "https://fr.wikipedia.org/wiki/Python_(langage)"
pathfind.start_finding
