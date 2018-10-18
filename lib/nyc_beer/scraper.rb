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
      hash = {:name => '', :address => ''}
      hash[:name] = brewery.text.split(' - ')[0]
      hash[:address] = brewery.text.split(' - ')[1]
      breweries << hash
    end
    return breweries
  end

  def scrape_beers(url)
    html = open(url)
    doc = Nokogiri::HTML(html)
  end
end
