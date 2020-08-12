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
  # and CustomerRepository differ in the type of elements
  # they are trying to create o(Meal and Customer)
  #
  def build_element(row)
    row[:delivered] = row[:delivered] == "true"
    row[:meal] = @meal_repository.find(row[:meal_id].to_i)
    row[:customer] = @customer_repository.find(row[:customer_id].to_i)
    row[:employee] = @employee_repository.find(row[:employee_id].to_i)

    Order.new(row) # returns a Customer instance
  end
end
