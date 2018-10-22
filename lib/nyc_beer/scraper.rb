require 'nokogiri'
require 'open-uri'
require_relative './breweries'
require_relative './beers'

class Scraper

  def initialize
  end

  def scrape_breweries(url)
    html = open(url)
    doc = Nokogiri::HTML(html)
    brewery_list = doc.css('#ba-content').css('ul').first.css('li')
    i = 1
    for brewery in brewery_list
      new_brewery = Brewery.new
      new_brewery.number = i
      new_brewery.name = brewery.text.split(' - ')[0].strip
      new_brewery.address = brewery.text.split(' - ')[1]
      new_brewery.url = 'https://www.beeradvocate.com' + brewery.css('a').first['href']
      i += 1
    end
  end

  def scrape_beers(url)
    html = open(url)
    doc = Nokogiri::HTML(html)
    beer_list = doc.css('table')[2].css('tr')
    i = 0
    for beer in beer_list
      if i != 0
        hash = {:name => '', :style => '', :abv => '', :ratings => '', :score => ''}
        hash[:name] = beer.css('td')[0].css('a').text
        hash[:style] = beer.css('td')[1].css('a').text
        hash[:abv] = beer.css('td')[2].css('span').text
        hash[:ratings] = beer.css('td')[3].css('b').text
        hash[:score] = beer.css('td')[4].css('b').text
        new_beer = Beer.new(hash)
      else
        i += 1
      end
    end
    #return beers
  end
end
