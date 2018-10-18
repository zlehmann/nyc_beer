class Brewery
  attr_accessor :name, :address
  @@all = []

  def initialize(name, address)
    @name = name
    @address = address
    @@all << self
  end

  def self.all
    @@all
  end
end
