class CLI
  def call
    get_breweries
    list_breweries
  end

  def get_breweries
    scraper = Scraper.new
    scraper.scrape_breweries("https://www.beeradvocate.com/place/city/12/")
  end

  def list_breweries
    puts "Welcome to the breweries of New York City!"
    Brewery.all.each do |brewery|
      puts "#{brewery.number}. #{brewery.name} - #{brewery.address}"
    end
    brewery_menu
  end

  def list_beers(number)
    if number.to_i >=1  && number.to_i <= Brewery.all.length
      brewery = Brewery.find_brewery_by_number(number.to_i)
    else
    end
    scraper = Scraper.new
    scraped_beers = scraper.scrape_beers(brewery)
    beer_list = brewery.beers
    puts "Here are the beers from #{brewery.name}:"
    beer_list.each.with_index(1) do |beer, i|
      puts "#{i}. #{beer.name.ljust(50)} #{beer.style.ljust(30)} Ratings: #{sprintf("%-10.10s", beer.ratings)} Score: #{sprintf("%-5.5s", beer.score)}"
    end
    exit_menu
  end

  def exit_menu
    puts "Type 'exit' to quit, or 'back' to return to the brewery list:"
    input = gets.strip.downcase
    case input
    when "back"
      list_breweries
    when "exit"
      puts "Thanks for checking out the breweries of NYC!!"
    else
      puts "Invalid choice, try again."
      exit_menu
    end
  end

  def brewery_menu
    puts "Enter a number for more information:"
    input = gets.strip
    list_beers(input)
  end
end
