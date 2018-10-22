require 'pry'
class CLI
  require_relative './scraper'
  require_relative './beers'
  require_relative './breweries'

  def call
    list_breweries
  end

  def list_breweries
    puts "Welcome to the breweries of New York City!"
    scraper = Scraper.new
    scraper.scrape_breweries("https://www.beeradvocate.com/place/city/12/")
    brewery_list = Brewery.all
    for brewery in brewery_list
      puts "#{brewery.number}. #{brewery.name} - #{brewery.address}"
    end
    brewery_menu
  end

  def list_beers(number)
    brewery = Brewery.find_brewery_by_number(number.to_i)
    scraper = Scraper.new
    scraped_beers = scraper.scrape_beers(brewery.url)
    beer_list = brewery.beers
    puts "Here are the beers from #{brewery.name}:"
    beer_list.each do |beer|
      puts "#{beer.number}. #{beer.name}: #{beer.style} Ratings: #{beer.ratings}, Score: #{beer.score}"
    end
  end

  def brewery_menu
    puts "Enter a number for more information:"
    input = gets.strip
    list_beers(input)
  end
end
