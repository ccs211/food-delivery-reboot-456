class Order
  attr_accessor :id # read and write :id
  attr_reader :meal, :customer, :employee

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
    %i[id delivered meal_id employee_id customer_id]
  end

  # Order.new({})
  def initialize(attributes = {})
    # Set initial instance
    @id = attributes[:id]
    @meal = attributes[:meal]
    @customer = attributes[:customer]
    @employee = attributes[:employee]
    @delivered = attributes[:delivered] || false
  end

  def to_array
    [@id, delivered?, @meal.id, @employee.id, @customer.id]
  end

  def to_s
    "Meal: #{meal.name} | Customer: #{customer.name} | Employee: #{employee.username}"
  end

  def delivered?
    @delivered
  end

  def deliver!
    @delivered = true
  end
end
