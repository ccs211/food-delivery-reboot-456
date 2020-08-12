class Employee
  attr_reader :username, :password, :role

  attr_accessor :id

   # This CLASS METHOD (note the self.csv_headers)
  # is REFERENCED/CALLED in BaseRepository.
  #
  # It needs to be defined in here because the Meal
  # Customer, Employee, and Order differ in their headers.
  #
  # It makes sense that the class would know
  # what CSV headers are needed to persist
  # instances of itself.
  #
  def self.csv_headers
    %i[id username password]
  end

  def initialize(attributes = {})
    @id = attributes[:id]
    @username = attributes[:username]
    @password = attributes[:password]
    @role = attributes[:role]
  end

  def manager?
    @role == "manager"
  end

  def delivery_guy?
    @role == "delivery_guy"
  end

  def to_s
    "Username: #{username}"
  end
end
