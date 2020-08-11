class Customer
  attr_reader :name, :address
  attr_accessor :id

  def self.headers
    ["id", "name", "address"]
  end

  def initialize(attributes = {})
    @id = attributes[:id]
    @name = attributes[:name]
    @address = attributes[:address]
  end

  def to_csv_row
    [id, name, address]
  end
end
