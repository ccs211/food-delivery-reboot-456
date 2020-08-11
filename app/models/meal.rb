class Meal
  attr_reader :name, :price
  attr_accessor :id

  def self.headers
    ["id", "name", "price"]
  end

  def initialize(attributes = {})
    @id = attributes[:id]
    @name = attributes[:name]
    @price = attributes[:price]
  end

  def to_csv_row
    [id, name, price]
  end

  # # READER
  # def id
  #   @id
  # end

  # # WRITER
  # def id=(id)
  #   @id = id
  # end
end
