class Scraper
  def scrape_breweries(url)
    html = open(url)
    puts "*****Scraping breweries"
    doc = Nokogiri::HTML(html)
    brewery_list = doc.css('#ba-content').css('ul').first.css('li')
    brewery_list.each.with_index(1) do |brewery, i|
      new_brewery = Brewery.new
      new_brewery.number = i
      new_brewery.name = brewery.text.split(' - ')[0].strip
      new_brewery.address = brewery.text.split(' - ')[1]
      new_brewery.url = 'https://www.beeradvocate.com' + brewery.css('a').first['href']
    end
  end

  def scrape_beers(brewery)
    html = open(brewery.url)
    puts "*******Scraping beers"
    doc = Nokogiri::HTML(html)
    beer_list = doc.css('table')[2].css('tr')
    beer_list.drop(1).each do |beer|
      hash = {:brewery => '', :name => '', :style => '', :abv => '', :ratings => '', :score => ''}
      hash[:brewery] = brewery
      hash[:name] = beer.css('td')[0].css('a').text
      hash[:style] = beer.css('td')[1].css('a').text
      hash[:abv] = beer.css('td')[2].css('span').text
      hash[:ratings] = beer.css('td')[3].css('b').text
      hash[:score] = beer.css('td')[4].css('b').text
      new_beer = Beer.new(hash)
      brewery.beers << new_beer
    end
    #return beers
  end
end
