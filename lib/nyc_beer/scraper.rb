require 'nokogiri'
require 'open-uri'

class Scraper

  def initialize
  end

  def scrape_breweries(url)
    html = open(url)
    doc = Nokogiri::HTML(html)
    breweries = []
    brewery_list = doc.css('#ba-content').css('ul').first.css('li')
    for brewery in brewery_list
      hash = {:name => '', :address => '', :url => ''}
      hash[:name] = brewery.text.split(' - ')[0]
      hash[:address] = brewery.text.split(' - ')[1]
      hash[:url] = 'https://www.beeradvocate.com' + brewery.css('a').first['href']
      breweries << hash
    end
    return breweries
  end

  def scrape_beers(url)
    html = open(url)
    doc = Nokogiri::HTML(html)
    beers = []
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
        beers << hash
      else
        i += 1
      end
    end
    return beers
  end
end
