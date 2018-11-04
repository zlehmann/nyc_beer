class CLI
  def call
    get_breweries
    list_breweries
  end

  def get_breweries
    Scraper.new.scrape_breweries
  end

  def list_breweries
    puts "Welcome to the breweries of New York City!"
    Brewery.all.each do |brewery|
      puts "#{brewery.number}. #{brewery.name} - #{brewery.address}"
    end
    brewery_menu
  end

  def list_beers(brewery)
    if brewery.beers.length == 0
      Scraper.new.scrape_beers(brewery)
    else
    end
    puts "Here are the beers from #{brewery.name}:"
    brewery.beers.each.with_index(1) do |beer, i|
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
    if input.to_i >=1  && input.to_i <= Brewery.all.length
      list_beers(Brewery.find_brewery_by_number(input.to_i))
    else
      puts "Invalid choice, try again."
      brewery_menu
    end
  end
end
