class Order
  attr_accessor :id # read and write :id
  attr_reader :meal, :customer, :employee

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
