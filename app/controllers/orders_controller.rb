require_relative 'base_controller'
require_relative '../views/orders_view'

require 'pry-byebug'

class OrdersController < BaseController
  def initialize(meal_repository, customer_repository, employee_repository, order_repository)
     # We need to override the BaseController#initialize
    # so that we can instantiate a View which is specific
    # to this Controller.
    #
    # Also, the OrdersController has more arguments than the other Controllers.
    # As such, we call super to run the BaseController#initialize, which only
    # takes 1 argument - the main repo (in this case, OrderRepository).
    #
    # We can super with the repo, so that the BaseController
    # can do the setup that is common for all controllers
    super(order_repository)

    # After calling super, we store the other 3 repos in their own instance variables
    @meal_repository = meal_repository
    @employee_repository = employee_repository
    @customer_repository = customer_repository
    @view = OrdersView.new
  end

  # rubocop:disable Metrics/MethodLength
  def add
    # ask user for the meal id
    meals = @meal_repository.all
    @view.display_elements(meals)
    meal_id = @view.ask_for(:id, :meal).to_i
    meal = @meal_repository.find(meal_id)
    # ask user for the customer id
    customers = @customer_repository.all
    @view.display_elements(customers)
    customer_id = @view.ask_for(:id, :customer).to_i
    customer = @customer_repository.find(customer_id)
    # ask user for the employee index
    employee = @employee_repository.all_delivery_guys
    @view.display_elements(employee)
    employee_index = @view.ask_for(:index, :employee).to_i
    employee = @employee_repository.find_by_index(employee_index)
    # create an Order instance
    order = Order.new(meal: meal, customer: customer, employee: employee)
    # save the meal instance
    @repository.add(order)
  end
  # rubocop:enable Metrics/MethodLength

  def list_undelivered_orders
    orders = @repository.undelivered_orders
    @view.display_elements(orders)
  end

  def list_my_orders(employee)
    orders = @repository.undelivered_orders.select do |order|
      order.employee.username == employee.username
    end
    @view.display_elements(orders)
  end

  def mark_as_delivered(employee)
    orders = @repository.undelivered_orders.select do |order|
      order.employee.username == employee.username
    end
    @view.display_elements(orders)
    index = @view.ask_for(:index, :order).to_i - 1
    order = orders[index]
    order.deliver!
    @repository.save
  end
end
