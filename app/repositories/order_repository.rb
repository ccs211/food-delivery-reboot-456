require_relative 'base_repository'
require_relative 'meal_repository'
require_relative 'employee_repository'
require_relative 'customer_repository'
require_relative '../models/order'

class OrderRepository < BaseRepository
  def initialize(orders_csv_path, meal_repository, customer_repository, employee_repository)
    @meal_repository = meal_repository
    @employee_repository = employee_repository
    @customer_repository = customer_repository
    super(orders_csv_path)
  end

  def undelivered_orders
    orders.reject { |order| order.delivered? }
  end

  private

  def orders
    @elements
  end

  # This private method is REFERENCED/CALLED in
  # BaseRepository.
  #
  # It needs to be defined here because MealRepository
  # and OrderRepository differs in the type of elements
  # they are trying to create an Order
  #
  def build_element(row)
    # Convert String to a REAL boolean value
    row[:delivered] = row[:delivered] == "true"

    # Order needs to receive INSTANCES of these classes
    # and NOT their ids. We use the respective repos to
    # find the correct instances and update row with
    # the keys neded for Order.new
    row[:meal] = @meal_repository.find(row[:meal_id].to_i)
    row[:customer] = @customer_repository.find(row[:customer_id].to_i)
    row[:employee] = @employee_repository.find(row[:employee_id].to_i)

    Order.new(row) # returns an Order instance
  end
end
