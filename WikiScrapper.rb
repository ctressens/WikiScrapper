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
            if valid_url?(@starting_url) && valid_url?(@ending_url) && valid_url_couple?(@starting_url, @ending_url)
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
            def valid_url? url
                if /^https:\/\/[a-z]{2}.wikipedia.org\/wiki\/.+$/ =~ url
                    true
                else
                    false
                end
            end
            def valid_uri? uri
                if /^\/wiki\/.+$/ =~ uri
                    true
                else
                    false
                end
            end
            def valid_url_couple? url1, url2
                if url1[8, 2] === url2[8, 2]
                    true
                else
                    false
                end
            end

            def scan? url
                if(/^.+#.+$/ =~ format_url(url))
                    url = url.split('#')[0]
                end
                if !(/^.+:.+$/ =~ format_url(url)) and !@scanned.include? format_url(url)
                    true
                else
                    false
                end
            end

            def format_url url
                if valid_url? url
                    url.sub(/^https:\/\/[a-z]{2}.wikipedia.org\/wiki\//, '')
                else
                    false
                end
            end
            def format_uri uri
                if valid_uri? uri
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
                if scan?(url)
                    if(/^.+#.+$/ =~ format_url(url))
                        url = url.split('#')[0]
                    end
                    time = Time.now
                    print "Scanning: #{url}"
                    document = Nokogiri::HTML(open(url))
                    list = Array.new

                    document.css('#mw-content-text a').each do |a|
                        href = a.attributes["href"].value
                        if uri_or_url(href) == "uri"
                            list.push format_uri(href) if !list.include? format_uri(href)
                        end
                    end
                    @scanned.push format_url(url)
                    @layers.push list.sort

                    puts "#{" " * (150 - url.length).to_i} done (#{time_diff(time, Time.now).ceil}ms)"

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
 
