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
    result = nil
    for brewery in @@all
      if brewery.number == number
        result = brewery
      end
    end
    if result == nil
      return "Brewery not found."
    else
      return result
    end
  end
end
