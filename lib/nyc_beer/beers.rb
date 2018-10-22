class Beer
  attr_accessor :number, :name, :style, :abv, :ratings, :score
  @@all = []

  def initialize(attributes)
    attributes.each {|key, value| self.send(("#{key}="), value)}
    @@all << self
  end

  def self.all
    @@all
  end

end
