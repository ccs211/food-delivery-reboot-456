class Meal
  attr_reader :name, :price
  attr_accessor :id

  def initialize(attributes = {})
    @id = attributes[:id]
    @name = attributes[:name]
    @price = attributes[:price]
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
