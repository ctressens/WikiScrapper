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

            @scanned = Array.new
            @layers = Array.new
        end

        def start_finding
            if validate_url(@starting_url) && validate_url(@ending_url)
                scan_page @starting_url
                while !@layers.last.include? format_url(@ending_url)
                    @layers.last.each do |layer|
                        scan_page @starting_url[0, 30] + layer
                    end
                end
            else
                puts "Ooops, there is a problem. Please copy/paste the URLs from Wikipedia."
            end
            # return @layers
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

            def time_diff start, finish
                (finish - start) * 1000.0
            end

            def scan_page url
                if !@scanned.include? format_url(url)
                    time = Time.now
                    print "Scanning: #{url}"
                    # puts time.methods
                    document = Nokogiri::HTML(open(url))
                    list = Array.new
                    document.css('#mw-content-text a').each do |a|
                        href = a.attributes["href"].value
                        if uri_or_url(href) == "uri"
                            # p format_uri(href)
                            list.push format_uri(href) if !list.include? format_uri(href)
                        end
                    end
                    @scanned.push format_url(url)
                    @layers.push list.sort
                    puts "#{" " * (150 - url.length).to_i} done (#{time_diff(time, Time.now).ceil}ms)"
                    # puts "@layers.length = #{@layers.length}"

                elsif url == @starting_url
                    puts "Retour à la case départ !"
                else
                    puts "Encore un d'évité ! (#{url} non scannée)"
                end
            end
    end

end

pathfind = Wiki::PathFinder.new "https://fr.wikipedia.org/wiki/Ruby", "https://fr.wikipedia.org/wiki/Organisation_mondiale_du_commerce"
pathfind.start_finding
