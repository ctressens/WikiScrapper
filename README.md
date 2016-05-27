# WikiScrapper
## I - Presentation
### What is this?
This is a script and it discover a path to win at the **Wikipedia_Race** challenge.
### How it works?
Just give a first keyword (or its URL), and an end keyword, wait a second (or an hour, depending of your shitty computer), and it will show you the path from the starting keyword to the ending keyword.

## II - Running
### Installing Ruby and dependencies
This script uses **Ruby** *(2.3.0 recommended)*. We recommend to use *UNIX* or *GNU* OS. *Windows* and *Ruby* are not friends
You just have to install the dependencies by running `bundle install`. If *bundle* is not recognized, run `(sudo) gem install bundler`, and restart `bundle install`.
### Run the script
Move into the directory and start
```
ruby WikiScrapper.rb
```
Just paste your starting keyword (or starting URL) and paste your ending keyword. Let the script search for you.

## III - Recommandations
1. Use RVM to install Ruby.
2. Have a great connection. It will run many HTTP requests.
3. It can take a lot of RAM. Please do not try this on you Masterrace computer (Raspberry PI).
