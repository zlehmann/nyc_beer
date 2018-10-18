class CLI

  def call
    list_breweries
    menu
  end

  def list_breweries
    puts "Welcome to the breweries of New York City!"
    puts "here is a numbered list of breweries"
    #wl breweries.all.length list to populate the menu with
  end

  def menu
    puts "Enter the number of the brewery who's beer list you'd like to view:"
    input = gets.strip

  end
end
