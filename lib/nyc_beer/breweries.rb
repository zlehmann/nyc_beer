class Brewery
  attr_accessor :number, :name, :address, :url, :beers
  @@all = []

  def initialize(number = 1, name = "", address = "", url = "")
    @number = number
    @name = name
    @address = address
    @url = url
    @beers = []
    @@all << self
  end

  def self.all
    @@all
  end

  def self.find_brewery_by_number(number)
    Brewery.all.find {|brewery| brewery.number == number}
  end

  def self.find_brewery_by_url(url)
    Brewery.all.find {|brewery| brewery.url == url}
  end
end
